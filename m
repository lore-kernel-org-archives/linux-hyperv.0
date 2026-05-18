Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6432F317167
	for <linux-hyperv@vger.kernel.org>; Mon, 18 May 2026 11:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779104308; cv=none; b=pYmo9QGSjiPXrh+UpNkqV0wZ5NjuFDv9gAyzcHJau1SHv2V0z1eqFPgJRUre0E8q8nF0WGYKwv+nqj0SMGhTQPHgKsYKyoqHWhJKXGruEr0yjyQfcwbJj56r2sA/7SnYWaKbfSEkjkAL5A0oJpr8wJDWbMbOeLt/G64v+EDRkIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779104308; c=relaxed/simple;
	bh=chdSCtbVfInZYvPJkzAapWfmnJSLqRMMGTqXYftcVbo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=grccMpE7QpmYwP7BVBGCK40JyxWP8rBFJf8HhOoftSgwbwID9ILjkyjCijxvjy6gOQYyal1CTp2whU6/KM4lvMqljilB090l19WVJ/Ly4b/4vbIZS+N4gbVX2hwIaAJJGNnM8baRXrCqbiUmp/oxiViG6P8Icr9GaHqTZZQ2iFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=OQoHgmNM; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="OQoHgmNM"
Received: by linux.microsoft.com (Postfix, from userid 1173)
	id DFF8520B7167; Mon, 18 May 2026 04:38:12 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com DFF8520B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1779104292;
	bh=DP3jPyPMmswezf9I4U3QaN0kkZSRi9AVTCzoJYEsGb0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OQoHgmNMfE7N1+yB6cGL9w6VqaF+8ZZpQN94TEZqnLA9mQ1MiqLMKA1C7vFlLtKld
	 F1sdPqQkcYZT6cC1bRcq2wyDougMNeQGihlmbMhZzEwoRr4VPznCXzQAz4q+Ab0A+4
	 dWhh22qrjwI0p8ybGfXAOkQxHQt+0+pVv1Alhmpo=
Date: Mon, 18 May 2026 04:38:12 -0700
From: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
To: sashiko-reviews@lists.linux.dev
Cc: linux-hyperv@vger.kernel.org
Subject: Re: [PATCH net] net: mana: Fix TOCTOU double-fetch of hwc_msg_id
 from DMA buffer
Message-ID: <agr6JHeGNw5FnK+5@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20260514194156.466823-1-ernis@linux.microsoft.com>
 <20260515194427.52CACC2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260515194427.52CACC2BCB0@smtp.kernel.org>

 
> > @@ -269,13 +268,17 @@ static void mana_hwc_rx_event_handler(void *ctx, u32 gdma_rxq_id,
> >  	rx_req = &hwc_rxq->msg_buf->reqs[rx_req_idx];
> 
> Since this patch addresses host-controlled DMA memory vulnerabilities in
> Confidential VMs, could there be another out-of-bounds access just before
> the msg_id check?
> 
> Looking at how rx_req_idx is calculated earlier in this function:
> 
> 	sge = (struct gdma_sge *)(wqe + 8 + dma_oob->inline_oob_size_div4 * 4);
> 	rq_base_addr = hwc_rxq->msg_buf->mem_info.dma_handle;
> 	rx_req_idx = (sge->address - rq_base_addr) / hwc->max_req_msg_size;
> 
> Because sge->address is read directly from the untrusted DMA queue, a malicious
> host could provide an arbitrary value, resulting in an out-of-bounds
> rx_req_idx.
> 
> Using this unvalidated index to access hwc_rxq->msg_buf->reqs[rx_req_idx]
> yields an attacker-controlled rx_req pointer. When this corrupted rx_req is
> subsequently passed to mana_hwc_post_rx_wqe(), the driver writes to req->sge
> and req->wqe_req, which could allow arbitrary writes to guest kernel memory.
> 
> Should rx_req_idx be bounds-checked against the size of the reqs array
> before it is used to index the array?
> 
> >  	resp = (struct gdma_resp_hdr *)rx_req->buf_va;
> >  
> > -	if (resp->response.hwc_msg_id >= hwc->num_inflight_msg) {
> > -		dev_err(hwc->dev, "HWC RX: wrong msg_id=%u\n",
> > -			resp->response.hwc_msg_id);
> > +	/* Read msg_id once from DMA buffer to prevent TOCTOU:
> > +	 * DMA memory is shared/unencrypted in CVMs - host can
> > +	 * modify it between reads.
> > +	 */
> > +	msg_id = READ_ONCE(resp->response.hwc_msg_id);
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260514194156.466823-1-ernis@linux.microsoft.com?part=1

This issue is already addressed in a separate patch by Aditya Garg
<gargaditya@linux.microsoft.com>, which is currently under internal
review.

- Vennela

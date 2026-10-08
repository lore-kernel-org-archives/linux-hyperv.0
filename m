Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9293395276
	for <linux-hyperv@vger.kernel.org>; Thu,  8 Oct 2026 19:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791486579; cv=none; b=ZAgbefop4jE5vJWlgu0gIR4ivGSZOKMQMAYBYUBZqmbMTZYHT3868nAnEp3bUugRQv7ALI6bFIentM75qFsZHgRsNXuZwWKBdlb3JcamJ5qyWFVkmJw5QcyLR2dhzllqpkBx5OsCQiewxucbn2pUUSJ3gczOkw7hlNA64+u7+Hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791486579; c=relaxed/simple;
	bh=7r9QJlR6bMx8Q4e7HCEBqkbv4vgj8ZE0+SBwfkoI1zQ=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=PnVw23vvJZDomQ57NY//13iS1BB4oDGjbaTgAYPFJATgLz4Fuq3HrzLM8njFQTYXEzt70mgAB1tTnPaF6fJscua/NelEah6VEWTWYAMegPluGxhh6c8T45IYD/uRhhYaUGvHWehQG4SL4eLjpBipgcQC/grvq4AIksglMOlMlVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NZuIOO/E; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NZuIOO/E"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7188A1F00898;
	Thu,  8 Oct 2026 19:09:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791486578;
	bh=H85Z+EdVy6wb14oGyqROD7LG+10DjUDfmV1mNgSM/4w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NZuIOO/EuyQZEU1BrR0/hFI5OoycGlLlgNiuun4VERp/d4pkxkWN12ZOGZEHkwAMN
	 L+vGQejyiIJe1I7BK5jah4N1tW3rGllIIWl3E0bDIe5O+XJvowG+I3R2PlTaZGo36C
	 N177Oq6/i0rVCFlFN9JSNvYaJo+8YWYTl21A6JZM8jxP0+Qk6fOzm8rSe6nfe5t4QM
	 9f8aeU4iLWzx8gl9fbBSxO5Spdc/zjgisIRNIKYtzScDgJ/9+zd4ol5GL+BsKTMBSJ
	 O55vTL3rut+wq9mt60XkCI+b7+JQSf6jpHpp5J5ZjWjsmNLyUUmDsyXrTR4OCsyFtK
	 THZHH7RPeaodA==
Message-ID: <sashiko-outbox-164502@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 14/14] hv: netvsc: use kvzalloc for device state
Reply-To: sashiko-reviews@lists.linux.dev
To: "Emerson Busson" <emersonbusson@gmail.com>
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <20261007190752.336426-15-emersonbusson@gmail.com>
References: <20261007190752.336426-1-emersonbusson@gmail.com>
 <20261007190752.336426-15-emersonbusson@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 08 Oct 2026 19:09:38 +0000
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] netvsc: unconditional xdp_rxq_info_unreg() on uninitialized stru=
cts triggers WARN
--

commit 961e2b6c1ed96f0ba554ff4b714af09658ea0cc8
Author: Emerson Busson <emersonbusson@gmail.com>

hv: netvsc: use kvzalloc for device state

This commit modifies alloc_net_device() to use kvzalloc_obj() instead of
kzalloc_obj() for allocating the netvsc_device. It updates the cleanup path
in __free_netvsc_device() to use kvfree() for releasing the memory, allowing
allocations to safely fall back to vmalloc.

> diff --git a/drivers/net/hyperv/netvsc.c b/drivers/net/hyperv/netvsc.c
> index 0d017f836b9eb..8ea7c993baac0 100644
> --- a/drivers/net/hyperv/netvsc.c
> +++ b/drivers/net/hyperv/netvsc.c
> @@ -140,8 +140,8 @@ static void __free_netvsc_device(struct netvsc_device=
 *nvdev)
>  	for (i =3D 0; i < VRSS_CHANNEL_MAX; i++) {
>  		xdp_rxq_info_unreg(&nvdev->chan_table[i].xdp_rxq);

[Severity: Medium]
Does this loop unconditionally call xdp_rxq_info_unreg() on uninitialized
structs during error cleanup, triggering a warning splat?

If channel setup fails after alloc_net_device() zero-initializes the device,
__free_netvsc_device() loops over all channels and calls xdp_rxq_info_unreg=
().

Because the uninitialized structs have a state of REG_STATE_NEW (0), passing
them to xdp_rxq_info_unreg() bypasses the registered state check and trigge=
rs
the following warning in xdp_rxq_info_unreg_mem_model() in net/core/xdp.c:

WARN(1, "Missing register, driver bug");

>  		kfree(nvdev->chan_table[i].recv_buf);
>  		vfree(nvdev->chan_table[i].mrc.slots);
>  	}
> =20
> -	kfree(nvdev);
> +	kvfree(nvdev);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261007190752.3364=
26-1-emersonbusson@gmail.com?part=3D14

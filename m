Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792779795;
	b=2B4GKnIyExGjtUYPrhSpGYskWcZBzpABbfgw8T+q3Qr+wXDVNlR3eA357xW7jJB+gBbv
	 jSG15ZlSWi0Alw5iSNqq58nSfZp5A4G2/u6O0Q+ERXw8Pw5xri4ub7aGn92I3cDOBnYFZ
	 qY0FK9W8u5A3XQ7E7QdoNXXKeWKBFvnBz9UyNogBBm17PNc+48n5tbZ0bWM6Q2fJxZ5i0
	 cNje3OLwHd5VpdRmflmc3rv6r08VI8VhWcHoCGfw4yjczIgUBqBG0mqFD976Tah1H25z+
	 m+65TaXN6G+N/XuWjbBX3An3vZGDgjbuwyoiopXnOTFC0p6sK0wHKkT8eJd+oNHKJOQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792779795;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=S8Q9NS04qLtTkf7TWNPkkhniIW2aieZgQ7tV7biAQBg=;
	b=Wf1xHSBpdmroZLhP3c9Z9N0geBqdepI6+ueHXXdefFbT8qY6jqk51bOn4J8DiMFHn9mc
	 EOyIhyUtoL4xCOnzLefs/tzojI/RWKM6MaAebS9pKz0sU1qVN27e9RC6C59RxgoUaghC8
	 9Cmn9q/PUCnhgKaVVOM75ite3/8gQzflessV5dtbQnmfv85q1mchlJ7b5e7RoEI1zI8Un
	 EAg8TNxWSWeHnMVBoL/HvMv1V2x7CnJFY0MVoycd7xVGnhT9z8BJv6FH1CRcTucn1wSCT
	 XERblH2XFdRvN0OK3If7rR7DxJ9UZd2s9/fsX/evh4cFYPUSSyQQWF6jLqN8DTBswLA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=TKo2Kbxu;
	arc=none smtp.remote-ip=209.85.210.180
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A699606A31E
	for <linux-hyperv@vger.kernel.org>; Fri, 23 Oct 2026 18:23:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4A699606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=TKo2Kbxu
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-89f639ba307so488515b3a.3
        for <linux-hyperv@vger.kernel.org>; Fri, 23 Oct 2026 11:23:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792779794; x=1793384594; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=S8Q9NS04qLtTkf7TWNPkkhniIW2aieZgQ7tV7biAQBg=;
        b=TKo2KbxuRmSutF9rShpMagljlVsMPFu4Xlwyn2VTuQmRvKYQFBwxN0MeDYHrp3yq5/
         ojbLLAjnYGMbsHWu9ypkjowJaEdfcPGDC/tf5UvdyaeWc6c57lU1IKC6eJviHa0BcfFb
         RZvZ00H5iTxNccfW7wN/7TrLMhlJ/B6L4y8VAtHbRcLuMAh9zMRd1hXeTNATbnmiPdch
         n/ubuZrny5I6HPAUUsRMJEY92nCDgIJvMswl3VHY94VrnXjoiLIx69EeASE/lS27x0zD
         lMtNEC3uN0RE8OsnthfZYzmx1o6GwvXmq/FAHFl6fwTQzcHR9dTXWqaAj9eh/T4XUHbL
         WF2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792779795; x=1793384595;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=S8Q9NS04qLtTkf7TWNPkkhniIW2aieZgQ7tV7biAQBg=;
        b=aF0v8EU6aZhIRn4+4VnFL+vkU4ZgLGl0/fFnLxl2k1LnWbONfS1mQfgKSY+9Hv/RE/
         pfHm2ItR2nrkmmR3V5wmMA4gCQBaZV7aJMm2hdc6kQFPdqstUlSwpsqPr6Cm/JiqRWy3
         u9kfQR868TVy3L5NwUg/HuR8wpdWx72KRaeV/XAsp5jFpqoi/WEhh1wVIMRkmycOlmRE
         b1uFeEQ5u/pa21Sir5gu0Px0GhpMi1Hf/bw3ulxTzDoHxuX/ICdGkAJ1hvGUQTsb/ZLr
         YxrSpNeg5JjFsPfxUSmrpis/v5IIPCWeKrGdoOmUJVVtm72Dy320EEm5Gj/dnWw3QWaZ
         uYGQ==
X-Forwarded-Encrypted: i=1; AKwUvBxdWl4cueNFX8ux/YMor+cnUkSljfCsqNpcRu7P93WGDMhyC+Myghq8cBzjnsD22xa1VSBZ0BHb11NNl+U=@vger.kernel.org
X-Gm-Message-State: AFq9FYLy3TQ8x1wRe6+XZ8cbESqyiyX/Tnmmxqx9MGdtxXIXDNiCX2Qo
	OXAaBXULqN9GmL6IB43soCYkLVPqtDkf30uko/JSnpR7FtjTmH5/s2Dp
X-Gm-Gg: AYBFou142iIRSRfEdIrpI9Y+LQdJdsomi8UqEoulTkNQdIAOodw6P/csvQWqWo8jAOZ
	codRHGh79ER54GuPaiO9taCaJ1VtKcrqndGV5bIv2VXXux7Vx8o+zumr8xELE8BOxaxCEfvhPL5
	Jaigl2cH2uyVwZ65kjzo/aXWPLoqa8i0xGHwg8GJU2VsqF3oxmBR0dQwauB+wvS8u5fjrWWE2Vu
	O8S/Hu8cbCXsBKdfGictML7sXFGeWQROqCqLCJS3xOFQGEUQy58sxy8jHeTeVNgfq2sQFcHTOq8
	SDuqjetoF/PlDx+f0/hHfbC9Tybju6O8REmSFh8NY8sP3AetJ7dzjxTUldOEaozYg046omi4mfC
	P/09KZA7Ucsdr0VZnoMR2IswO5B13Er09Hzt2isv054dEss9Sr7rlw19scJOYxCMQD5H9Ht7aCl
	C5a0bJnqviSOXvy9rZ9/gKkbK4Sd2Pok+OSKRKJ9ACoOqztrqVOQUvmfh+UYKZwKGMGugcVW2Ru
	6lT1mxaOUX0ut+1sxJftba8O//j/O+LcGWU4yFMDruTiQWScIYm/b17OIqCpupiVIfEOWXCJefe
	kcnvEiqu2IXlvwqzolrTh3+dWkfM/o/GN0lLC/zMiiGssd5mpeulyWG2SCThuPucB9lhLppPP7g
	SVRwhpTML0AcI22YJ51nWvd6I/YWpaubU
X-Received: by 2002:a05:6a00:b4c:b0:882:2b16:c314 with SMTP id d2e1a72fcca58-8a367a2f8famr67193b3a.52.1792779794464;
        Fri, 23 Oct 2026 11:23:14 -0700 (PDT)
Received: from mitchelllevy.localdomain ([131.107.1.234])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8a36c0fefa3sm32030b3a.51.2026.10.23.11.23.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 11:23:14 -0700 (PDT)
Date: Fri, 23 Oct 2026 11:23:12 -0700
From: Mitchell Levy <levymitchell0@gmail.com>
To: Kameron Carr <kameroncarr@linux.microsoft.com>
Cc: Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Michael Kelley <mhklinux@outlook.com>, linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/5] Drivers: hv: vmbus: Harden the ring buffer
 against a malicious host
Message-ID: <20261023182312.2znaexe6rspsonod@mitchelllevy.localdomain>
References: <20261019230950.1573677-1-kameroncarr@linux.microsoft.com>
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Post: <mailto:linux-hyperv@vger.kernel.org>
List-Help: <mailto:linux-hyperv+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hyperv+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261019230950.1573677-1-kameroncarr@linux.microsoft.com>

On Mon, Oct 19, 2026 at 04:09:45PM -0700, Kameron Carr wrote:
> In a CoCo VM the host is untrusted. Since the VMBus ring buffer read and
> write indices live in shared memory, the guest has to treat both as
> potentially malicious and as changing at any time. This patch series
> adds bounds checking and reuses the validated indices instead of
> re-accessing them.
> 
> Patch 1 contains the minimum security fix, and is the only patch in the
> series intended to be backported. hv_ringbuffer_write() copies into the
> ring at the write index, so a malicious host can make the guest write to
> memory outside the ring buffer. This is reachable on any channel a CoCo
> VM accepts.
> 
> Patches 2 and 3 add READ/WRITE_ONCE annotations and refactor the helper
> functions to allow the caller to work with a consistent snapshot of the
> ring buffer indices.
> 
> Patch 4 adds the rest of the bounds checking. The memcopy() in
> hv_pkt_iter_avail() can only result in an out-of-bounds read if
> rbi->pkt_buffer_size exceeds the ring's data size. KVP is the only
> in-tree channel whose max_pkt_size exceeds its ring's data size (16K vs
> 12K on a 4K page guest). CoCo VMs reject the KVP channel, so this bug is
> currently unreachable on CoCo VMs. The other paths patch 4 checks can't
> cause a bad access, only a nonsense byte count or a wrong signaling
> decision.

Thanks for the fix! For the series,

Reviewed-by: Mitchell Levy (Microsoft) <levymitchell0@gmail.com>


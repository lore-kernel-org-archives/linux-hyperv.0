Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4D6433C18E
	for <linux-hyperv@vger.kernel.org>; Mon, 31 Aug 2026 12:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788178184; cv=none; b=pub45P6YIHcL56d7IrDgG9pn+gb2ubZ+OxRqGUcdGTvbMAMOGKCFSnBGWFI404bek9el88Ru8MD+UOwazYLgaUOOny+Awd7K8JhDAHQNad7i3wUz05ydBgQUzxPS6KWICCguZbHmfiyvahHaxAhq97Fff+LdmDznnHD8j2MNMAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788178184; c=relaxed/simple;
	bh=TzJcACtoE7soFQoW1KO1g5rfuvOtJexL8ruqTwtGN5E=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ozeU1MdQIlYP2z/sEc6ePUUnT92I/u3St6MVgMPPAmyzj/LfNyafjxIUXzFhOCJ2MedSErinXS1D1oVKL5fz+fTx8wOu3tnUHNAUdIXwbi/18kPm5euUV15xARO9vd8s9lOAXgvYNErOR+/MEBgahEt5tsTXdd4sjV4HUn2TFH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RvAJ+7fJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RvAJ+7fJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9ED911F000E9;
	Mon, 31 Aug 2026 12:09:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788178182;
	bh=Ts73YQbrc7ljgWJUxmQs/z68pcw5rTcdNbRg3rmRksk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RvAJ+7fJnYWVS/10EYcc/4/wkM4vrka3gkGPQKcw9ee16ssbSOuBQEn6gPBWEn7Qh
	 LEbjQrNOCvglFctHuHtYIlMgih1TBZq6UWMZ9/VnDSat7LAlaoXmQZfSDgaVp0IC8w
	 MnftLV6GBwj/Q+tPpOWdf6RWoUafKU5eGbQnUIimGFafxINR3+aJbTW+tVub2TWppM
	 Se6pkeVoDn9lccYmeuPvvWGQVzUpLiKi8JK8pKx9cb7wpgLKAH6KSBwdk0byP9TFGB
	 bNu9EZXE9e895QEaEm8wapHx1cWFjrDD7CEvvNxoSIvcv6mlDaugjQyCyNGFEFs80V
	 OYFq7MdRfuZaA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 9/9] mshv: set up own SynIC registers on a nested
 root partition
Reply-To: sashiko-reviews@lists.linux.dev
To: "Wei Hu" <weh@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <20260831112704.2851147-10-weh@linux.microsoft.com>
References: <20260825040505.826600-1-weh@linux.microsoft.com>
 <20260831112704.2851147-1-weh@linux.microsoft.com>
 <20260831112704.2851147-10-weh@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 12:09:42 +0000
Message-Id: <20260831120942.9ED911F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Missing memory decryption for locally allocated L1VH SIRBP in Conf=
idential VMs.
--

commit 0a5809fa9d9b76912e599a03beec81fda2326b1b
Author: Wei Hu <weh@microsoft.com>

mshv: set up own SynIC registers on a nested root partition

This patch modifies mshv_synic to set up its own SynIC registers on nested
root partitions instead of assuming VMBus has provisioned them. It also
updates the mapping of hypervisor-provided SIMP, SIEFP, and root SIRBP pages
to use MEMREMAP_DEC to support confidential hosts.

> diff --git a/drivers/hv/mshv_synic.c b/drivers/hv/mshv_synic.c
> index 0fdbae1e053c3..8470cf958f21b 100644
> --- a/drivers/hv/mshv_synic.c
> +++ b/drivers/hv/mshv_synic.c

[ ... ]

> @@ -511,8 +524,8 @@ static int mshv_synic_cpu_init(unsigned int cpu)
>  	sirbp.as_uint64 =3D hv_get_non_nested_msr(HV_MSR_SIRBP);
> =20
>  	if (hv_root_partition()) {
> -		event_ring_page =3D memremap(sirbp.base_sirbp_gpa << HV_HYP_PAGE_SHIFT,
> -					   HV_HYP_PAGE_SIZE, MEMREMAP_WB);
> +		event_ring_page =3D
> +			mshv_synic_map_shared_page(sirbp.base_sirbp_gpa);
> =20
>  		if (!event_ring_page)
>  			goto cleanup_siefp;

[Severity: High]
Since this patch adds support for confidential hosts by mapping
hypervisor-provided pages with MEMREMAP_DEC, what happens to the locally
allocated SIRBP in the else branch for L1VH partitions?

If we look further down in mshv_synic_cpu_init():

	} else {
		/*
		 * On L1VH the hypervisor does not provide a SIRBP page.
		 * Allocate one and program its GPA into the MSR.
		 */
		event_ring_page =3D (struct hv_synic_event_ring_page *)
			get_zeroed_page(GFP_KERNEL);

In a Confidential VM, memory allocated via get_zeroed_page() is encrypted by
default. Because set_memory_decrypted() is never called here, will the
hypervisor be unable to access the event ring, causing a regression in event
delivery for L1VH?

For comparison, drivers/hv/hv.c decrypts its locally allocated SynIC pages
via hv_alloc_page(..., decrypt=3Dtrue, ...).

[ ... ]

> @@ -595,8 +608,7 @@ static int mshv_synic_cpu_exit(unsigned int cpu)
>  	struct hv_message_page *msg_page;
>  	struct hv_synic_event_flags_page *event_flags_page;
>  	struct hv_synic_event_ring_page *event_ring_page;
> -	/* VMBus owns SIMP/SIEFP/SCONTROL when it is active */
> -	bool vmbus_active =3D hv_vmbus_exists();
> +	bool vmbus_active =3D mshv_synic_vmbus_owns_registers();
> =20
>  	msg_page =3D READ_ONCE(spages->hyp_synic_message_page);
>  	event_flags_page =3D READ_ONCE(spages->synic_event_flags_page);

[Severity: High]
If the allocation in mshv_synic_cpu_init() is updated to decrypt the page,
does the cleanup path in mshv_synic_cpu_exit() need a corresponding change?

Looking at the cleanup path in mshv_synic_cpu_exit():

	if (event_ring_page) {
		if (hv_root_partition())
			memunmap(event_ring_page);
		else
			free_page((unsigned long)event_ring_page);
	}

If the page is decrypted during initialization, will freeing it here without
first calling set_memory_encrypted() return a decrypted page to the kernel
allocator and cause a memory corruption regression?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831112704.2851=
147-1-weh@linux.microsoft.com?part=3D9

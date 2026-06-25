Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A16C630566D
	for <linux-hyperv@vger.kernel.org>; Thu, 25 Jun 2026 18:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782411832; cv=none; b=LehcHwrn7Z6YVOMxzAQ86lqbi637yvjhboSuZVls1bV+IORJQqJW21yE+JOcwwgPWeM1NSBMDtYexSUCYtQ/wf+U/sLDVs3syuN8WCW4uxVO1FdRATS6qneP+svq1k/sT7EHhXHx0hdhKIbCAIt0rZ0toZ+Emx+IvAVjIKn3tL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782411832; c=relaxed/simple;
	bh=QAA985uMRZvXyjsf8dvY73+oVXm57DdTytkSdH9p0n4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=UQmhOBMbSIJ2LQJU46AgliSUUjqYe62JYcJMTrUjPZAoqBvor5uBBXe43g56rxvip1j0vfH0yirEDPjWj8PluQCCJDBvemNbGS/RLLd1e0F+8T4SwFWKrINXXZysH2G0DgE1SHX3TnUJ4uXJpRAb5Agt/02Vtd3yTGfxkow4Kzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cFFAcn2E; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cFFAcn2E"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 311071F000E9;
	Thu, 25 Jun 2026 18:23:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782411831;
	bh=SJxnqCUsr4vmmjn+PhJmbMo1R1duQRGGCLMh7+S+sYk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cFFAcn2EmJk+EiSEXGhyKrS8M1SUXuxcqTEsAuO8Zbyw+noaslm5NBXIZDQEZIBNf
	 eSVZktbsK2gVB1iEUXc4sWIu7i3Wvy6gU9xXvGdCO74KgJzknHJdabYN1uhWE89ORq
	 R+g4mjY0sf6g8gwFrQsKnnF/Jmmz1kw1HfIDvByrEdB7eOuvbaibkknTsfXFQQSSCs
	 CJewet8iR7WdorrhuVxNPj2yWvDeRQu7LSLRfRwHHn83Rmq7v7de1dq23QPvhKj2pz
	 LykH/3S6rju43lJHIyA1yeCk7cJQYj/zJE80sN4MPKe3ts38XXrNk/I5v21lle3/vH
	 hWwbm2hlrBp/g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] mshv_vtl: clear hypercall output before copyout
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yousef Alhouseen" <alhouseenyousef@gmail.com>
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <20260625181314.1399-1-alhouseenyousef@gmail.com>
References: <20260624172157.2790-1-alhouseenyousef@gmail.com>
 <20260625181314.1399-1-alhouseenyousef@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 25 Jun 2026 18:23:50 +0000
Message-Id: <20260625182351.311071F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Uninitialized kernel memory in the `in` bounce page is exposed to =
the hypervisor and potentially other untrusted VTLs.
--

commit e6ad11845017945abcff5cffd83d1f2f8170c980
Author: Yousef Alhouseen <alhouseenyousef@gmail.com>

mshv_vtl: clear hypercall output before copyout

mshv_vtl_hvcall_call() copies output_size bytes to userspace.
The output page is freshly allocated. Userspace chooses the copyout length.
If the hypercall writes less, the tail can contain stale page data.
Clear the copied range before issuing the hypercall.

> diff --git a/drivers/hv/mshv_vtl_main.c b/drivers/hv/mshv_vtl_main.c
> --- a/drivers/hv/mshv_vtl_main.c
> +++ b/drivers/hv/mshv_vtl_main.c
> @@ -1148,12 +1148,22 @@ static int mshv_vtl_hvcall_call(struct mshv_vtl_h=
vcall_fd *fd,
>  	 */
>  	in =3D (void *)__get_free_page(GFP_KERNEL);

[Severity: High]
This is a pre-existing issue, but does this allocation also need to be
cleared to prevent leaking kernel memory to the hypervisor?

Since the subsequent copy_from_user() only copies hvcall.input_size bytes,
the tail of the page remains uninitialized. If a user provides a small
input_size but crafts hvcall.control so the hypervisor expects a larger
payload, the hypervisor will read the uninitialized tail of the page during
hv_do_hypercall().

Should this use __get_free_page(GFP_KERNEL | __GFP_ZERO) to prevent stale
data from being exposed to the hypervisor across security boundaries?

>  	out =3D (void *)__get_free_page(GFP_KERNEL);
> +	if (!in || !out) {
> +		ret =3D -ENOMEM;
> +		goto free_pages;
> +	}
> =20
>  	if (copy_from_user(in, (void __user *)hvcall.input_ptr, hvcall.input_si=
ze)) {
>  		ret =3D -EFAULT;
>  		goto free_pages;
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260625181314.1399=
-1-alhouseenyousef@gmail.com?part=3D1

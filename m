Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E001C3009E2;
	Sun, 13 Sep 2026 22:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789338967; cv=none; b=cmZQ3k4DA1y9TO4rFjarTvbZ3BWYZiwZlLRCJZbSa6cUz6M8Le1AOcJHOu+6ZoVsnFofU0jV9iGMa66Elo7WqZxuXjKvHxkG0EgrgaHOtTlnI9tj6gPoQVeIW64Aqg6LuN/YOJaFMK8sdZr/qg2ur7+37Qk1fxY6XjsC5u0JVYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789338967; c=relaxed/simple;
	bh=PyETr6kniFxbA8m0lnCw9/q5V4PTbXjgSumaMgZahhY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gH7AE48/9/LH5W5mww38TTcrO1QIYdUjDdEeCTK3OcvxUrAculSHbr1CETGSImLCDGUgNwx+BSd4ZLbAc/oig9oz/HU702n8RgR+Fq1PxwtQWFPLmaMiNpIhHw/y2GKYoNz/pO3HznPtacbf1j2sFCklWrZvnjDTg4ZgBgBflsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OT02HLRY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OT02HLRY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BF9E1F000FF;
	Sun, 13 Sep 2026 22:36:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789338966;
	bh=PyETr6kniFxbA8m0lnCw9/q5V4PTbXjgSumaMgZahhY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=OT02HLRY2Pj1BgXeOx8qKJykTZf3Q2612ZWRGqL9KZgYqdEdVW0KZmqiYh4NMOhM5
	 4kuVrYLF/sY9Y/hugPwHjuFlvXn3MvEK4DcXSbQYPkvfZkOq9A5cv3nHgWKxwimzVX
	 kLcbQs+B2lboXH30Nvv7U2BCQ/YGVXnFCKKlZ1n68b3+X8cRR/BeeoLXq9MwfjngD7
	 XnE6nUHPenGOJ1UTZ0rDZsVwjRfPl2LKUHmqdNf6MmgaCrQGdtrplPkRIqbfdVSLZU
	 5s8Q4sRkq3DlytBepUm07vpq+0T8L2QXpBCIFBNUO9wR1+FR8O+MKvY1C+rZMhQehJ
	 BJpmQKQDdMTQA==
Date: Sun, 13 Sep 2026 15:36:05 -0700
From: Wei Liu <wei.liu@kernel.org>
To: Tianyu Lan <ltykernel@gmail.com>
Cc: mhklinux@outlook.com, kys@microsoft.com, haiyangz@microsoft.com,
	wei.liu@kernel.org, decui@microsoft.com, longli@microsoft.com,
	tglx@kernel.org, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] x86/hyperv: Avoid using per-cpu output page in
 hv_apicid_to_vp_index()
Message-ID: <20260913223605.GD2219269@liuwe-devbox-debian-v2.local>
References: <20260902030127.581040-1-mhklinux@outlook.com>
 <CAMvTesAKMHYC36QViaUi_cw8-gSkBQyJtCd+Kt73HoDaLOkwUQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMvTesAKMHYC36QViaUi_cw8-gSkBQyJtCd+Kt73HoDaLOkwUQ@mail.gmail.com>

On Wed, Sep 02, 2026 at 02:30:02PM +0800, Tianyu Lan wrote:
> On Wed, Sep 2, 2026 at 11:02 AM Michael Kelley <mhkelley58@gmail.com> wrote:
> >
> > hv_apicid_to_vp_index() currently uses the per-cpu hypercall input
> > and output pages. This function is called when running in VTL2 and
> > when running in an SEV-SNP CoCo VM with no paravisor. In the former
> > case, the output page is allocated, but in the latter case it is
> > not, so the hypervisor stores the output VP index in memory that has
> > not been allocated by the guest.
> >
> > Fix this by using the input page for both input and output. The
> > hypercall has very small input and output, so sharing the same
> > page for both is straightforward. An alternative fix is to
> > allocate the per-cpu output page when running in an SEV-SNP CoCo
> > guest, but this uses significantly more memory, particularly
> > with larger vCPUs counts.
> >
> > Fixes: 86c48271e0d6 ("x86/hyperv: Fix APIC ID and VP index confusion in hv_snp_boot_ap()")
> > Signed-off-by: Michael Kelley <mhklinux@outlook.com>
> > ---
> > I'm not aware that this bug is causing any real problems because
> > SEV-SNP CoCo VMs on Hyper-V are rarely, if ever, used without a
> > paravisor. But it was on my list of little clean-ups to do, and
> > a recent Sashiko analysis [1] flagged the issue. So the best thing
> > to do is just fix it.
> Reviewed-by: Tianyu Lan <tiala@microsoft.com>

Applied. Thanks.

Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793252465;
	b=yAwTYJq/Uz2cLV5zk1vq2LX8t1lyBULieR4vm3JEg36BmeY0GHFf4zwulr2Bf9YFyN1i
	 MsWrCS9NI3w0zmVVUpgbFnZnTSDmvtk2N0YOM1boIZTy2zpGaIv8/LPS3CTlMZFaAaTc0
	 nP3ZFWtEEPawwWtCJMTaPzwkOYCbKRfycp5yAb+7z6xJfR22a1MYCmIQL9aA0omHSjUpc
	 j0H0wbo+VTNIbgbp2lP+Bk+WNC4VFX9BPPlSgGe7+0U9V5POn0F14+n7LqkitnCvJR/UR
	 ZLMd4VWfPbX+OFgOsW5CS4VWpJFDo+RaEaGLjY14dT3HLFIPZRjmCt+Sl0gcn68j4vQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793252465;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=rpIwuWJI4mUU+Vr37pPxQ2ayfurlJBPbC17PVqfWTR8=;
	b=qnl6hsIl7GWnvLpfhD1zCHL8+FSQ34JzJSItevX+aAGxqVGB+Fzo5H/Lt0so7Wul5zzA
	 lA4P4TMRov2VWrGYONfgyl357lAvQbuqYAdT3cgGoc4pa6FXCYQBZm8cgl4JtPnqXDavq
	 ND33daBfSt41ZE59IaH+gnN8IDEFtZ0wFE1hLpDfwa8cWOUDrxGAq81GBEH7/dGouOsfm
	 9lmWPNPFDOUEQaXFYK1QVLqIKedUGIQW716IxXSb6oTv8JoO72wK4HkEkjAEwrXpfg5ir
	 bEyRjKzir51EjNQAYP5120SuFT0+qRbkwU0V6/OJ5xL2vfzHh+Ro8n1rJVwrhWuqW7Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CbV3qZXR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46778606A31A;
	Thu, 29 Oct 2026 05:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CbV3qZXR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C0891F01825;
	Thu, 29 Oct 2026 05:41:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793252464;
	bh=rpIwuWJI4mUU+Vr37pPxQ2ayfurlJBPbC17PVqfWTR8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=CbV3qZXRHW3XrkXfTLQp+OWG5tdJOGe8xgMJynVAToS+xNDnpzB6+H0zYgNbeP2RV
	 etXdFuzqFhCBSPLXXaBmh2quQCJFuvTYhqIkpowRdvVdt/OTbeA1qhdC5mDBg5KcmG
	 2cDDGQyDbG5HSlK4OcBc77lzQaGh355eyFEf9vPl/WcnE588DgdQimD8l+oMQNDzio
	 sQu0UwdkYkggy9GOYcdPbBz6+u8rm8sJ5yg9NS06J6t0cW0+y7nt5gvyhQurR7Y0Io
	 M4UcD8ijZtH5/8bfz1Qj3l38ux3WVYqjZAKFhURKJoxyQYW9uGuLy25MQeghW2Cha0
	 OBBKblNLvpSJQ==
Date: Wed, 28 Oct 2026 22:41:03 -0700
From: Wei Liu <wei.liu@kernel.org>
To: Thorsten Leemhuis <linux@leemhuis.info>
Cc: Wei Liu <wei.liu@kernel.org>,
	Magnus Kulke <magnuskulke@linux.microsoft.com>,
	Wei Liu <liuwe@microsoft.com>, Arnd Bergmann <arnd@arndb.de>,
	Magnus Kulke <magnuskulke@microsoft.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Dexuan Cui <decui@microsoft.com>, linux-hyperv@vger.kernel.org,
	Long Li <longli@microsoft.com>, linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Souradeep Chakrabarti <schakrabarti@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Anirudh Rayabharam <Anirudh.Rayabharam@microsoft.com>
Subject: Re: [PATCH v4] drivers/hv: remove deposited pages from direct map
Message-ID: <20261029054103.GB3595008@liuwe-devbox-debian-v2.local>
References: <20260930121047.19993-1-magnuskulke@linux.microsoft.com>
 <07246cb1-1154-4b66-9a05-209f04a2b427@leemhuis.info>
 <20261028183157.GA3595008@liuwe-devbox-debian-v2.local>
 <879b3af5-3853-4f9d-8dea-c90c338a4369@leemhuis.info>
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Post: <mailto:linux-hyperv@vger.kernel.org>
List-Help: <mailto:linux-hyperv+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hyperv+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <879b3af5-3853-4f9d-8dea-c90c338a4369@leemhuis.info>

On Wed, Oct 28, 2026 at 07:44:14PM +0100, Thorsten Leemhuis wrote:
> On 10/28/26 19:31, Wei Liu wrote:
> > On Wed, Oct 28, 2026 at 07:28:15PM +0100, Thorsten Leemhuis wrote:
> >> On 9/30/26 14:10, Magnus Kulke wrote:
> >>> hv_call_deposit_pages() donates pages (deposit) to hypervisor for L2
> >>> guest on L1VH systems via HVCALL_DEPOSIT_MEMORY. The hypervisor takes
> >>> ownership of those pages and per contract revokes root partition
> >>> access to them, raising a #GP on access from the L1VH root partition.
> >>>
> >>> However, the pages remain mapped in the kernel direct map, so kernel
> >>> code may still access them even though the hypervisor has revoked
> >>> access.
> >>
> >> Wei, Magnus, this patch showed up in -next today and broke my daily
> >> Fedora builds on x86_64 and arm64 which use the rawhide config as base.
> >> Reverting it made the build succeed.
> > 
> > Can you share the kconfig?
> 
> Sadly can't access it directly, but it should be the attached one after
> running it through "make olddefconfig".
> 
> Ciao, Thorsten
> 
> >> """
> >>> drivers/hv/hv_proc.c: In function ‘hv_deposit_update_direct_map’:
> >>> drivers/hv/hv_proc.c:32:23: error: implicit declaration of function ‘set_direct_map_valid_noflush’; did you mean ‘set_direct_map_invalid_noflush’? [-Wimplicit-function-declaration]
> >>>    32 |                 err = set_direct_map_valid_noflush(pfn_to_page(pfns[i]),
> >>>       |                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >>>       |                       set_direct_map_invalid_noflush

I didn't end up building the kernel. I see why by purely inspecting the
linux-next tree.

That function was removed by Mike Rapoport in 37fb25b34cd92.

I will rework this in my branch -- we should follow what MM tree does.
Hopefully it will be a straightforward change.

Thanks for your report.

Wei

======

commit 37fb25b34cd9273cb987b80a46a13a1e3f0a534f
Author:     Mike Rapoport (Microsoft) <rppt@kernel.org>
AuthorDate: Thu Sep 3 12:28:32 2026 +0300
Commit:     Andrew Morton <akpm@linux-foundation.org>
CommitDate: Thu Sep 10 20:20:09 2026 -0700

    Revert "arch: introduce set_direct_map_valid_noflush()"

    Commit 0c6378a71574 ("arch: introduce set_direct_map_valid_noflush()")
    added set_direct_map_valid_noflush() to allow updating the direct map for
    a physically contiguous range in execmem.

    As Brendan recently pointed out [1], this API is confusing because on
    arm64 it means that is sets VALID bit in ptes, while on other
    architectures it is an analog of set_direct_map_default_noflush().

    The only user of set_direct_map_valid_noflush() was execmem's ROX cache
    freeing path and it was switched to utilize VM_FLUSH_RESET_PERMS for
    resetting permissions of the direct map alias.

    With the last user gone and with
    set_direct_map_{invalid,default}_noflush() accepting number of pages as a
    parameter, set_direct_map_valid_noflush() become a copy of
    set_memory_valid() on arm64 and a duplicate of
    set_direct_map_{invalid,default}_noflush() on other architecture, it is
    safe to remove set_direct_map_valid_noflush().

    Also drop a stale comment in arm64::__kernel_map_pages() that Linus
    bothered to add when merging changes containing
    set_direct_map_valid_noflush() to his tree.

    This reverts commit 0c6378a71574daa6cd1534ad42a956e3262756c7.

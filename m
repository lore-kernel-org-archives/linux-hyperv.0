Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E36A379EE8;
	Fri, 26 Jun 2026 11:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782472142; cv=none; b=DKQjSfCq7YuH5cNznYkhwnksM+y4BTcdWii3JmETB0zmBbHuJgxS8hTl6TNuRkDXjNFf5FKFVT+k9sd0XVkOi3QbOTdugIlxYrGD0xbxSirBTfsjjtPo1OHy5n4ibvBKAxZ3kz5Z9HKpw5zffRBEZFYsq5DgVcdyc88Tfj97+cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782472142; c=relaxed/simple;
	bh=tpxBv6SR8AFlZnUlebSAxkhctIUO8PhcUXPu/ZOgS2c=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=HHkOYFPp95st6nolPlvjQdpVLqWPEme8joCEHO6IV0wYBS0lHchD+AV+mVw29ZKBmBO5E52APlA8S7+H1Llz4ofRXQKULF2/JfADTlcLUQPNx6MKM+Eftt3OK2QV80CRwZUB9vigHMtgIBnp7kni9EQITIZruhkmuUo/JKzyufg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=gn8G+z5G; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="gn8G+z5G"
Received: from DairyQueen (unknown [4.194.122.162])
	by linux.microsoft.com (Postfix) with ESMTPSA id 6DA3320B7169;
	Fri, 26 Jun 2026 04:08:40 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 6DA3320B7169
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1782472130;
	bh=3tXlinCc4IpnuxZycQ2g/1yaIY+ksDllWGNc2F2P03I=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:From;
	b=gn8G+z5GBVcwrrg49tOu6UrJ2T/Q7/0ZG4TisIRJkAZJxzfJaem8sRm2Dq3BZJI7+
	 CRoYohSTdyZKVDOcxWqw0+h3F8t6vgjNnXxgZ1nb1RzuDefkxLuQKpJZlgFX/eEtJA
	 NmmLv/voUeuLZOsDLzUSs0jZ5ALyakKRlI0wy8E0=
From: "Kameron Carr" <kameroncarr@linux.microsoft.com>
To: "'Michael Kelley'" <mhklinux@outlook.com>,
	<kys@microsoft.com>,
	<haiyangz@microsoft.com>,
	<wei.liu@kernel.org>,
	<decui@microsoft.com>,
	<longli@microsoft.com>
Cc: <catalin.marinas@arm.com>,
	<will@kernel.org>,
	<mark.rutland@arm.com>,
	<lpieralisi@kernel.org>,
	<sudeep.holla@kernel.org>,
	<arnd@arndb.de>,
	<thuth@redhat.com>,
	<linux-hyperv@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>,
	<linux-arch@vger.kernel.org>
References: <20260625173500.1995481-1-kameroncarr@linux.microsoft.com> <20260625173500.1995481-5-kameroncarr@linux.microsoft.com> <SN6PR02MB4157D5F94B5C5F35020FF047D4EC2@SN6PR02MB4157.namprd02.prod.outlook.com>
In-Reply-To: <SN6PR02MB4157D5F94B5C5F35020FF047D4EC2@SN6PR02MB4157.namprd02.prod.outlook.com>
Subject: RE: [PATCH v2 4/6] Drivers: hv: Mark shared memory as decrypted for CCA Realms
Date: Fri, 26 Jun 2026 04:08:42 -0700
Message-ID: <000801dd055c$2e375050$8aa5f0f0$@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-us
Thread-Index: AQEAlq3oFwuiSVNoPj5kD0Q006gIdwI/GO7nAcdUdB636UC94A==

On Thursday, June 25, 2026 11:59 AM, Michael Kelley wrote:
> From: Kameron Carr <kameroncarr@linux.microsoft.com> Sent: Thursday,
> June 25, 2026 10:35 AM
> > We need to round up the memory allocated for the input/output pages to
> > the nearest PAGE_SIZE, since set_memory_decrypted() requires the size to
> > be a multiple of PAGE_SIZE. This only has an effect on ARM VMs that are
> > using PAGE_SIZE larger than 4K.
> 
> I think this change resulted from a Sashiko comment. My understanding is
> that the ARM CCA architecture only supports CCA guests with 4 KiB page
> size. Is that still the case, or has that restriction been lifted in a
later version
> of the architecture? I'm in favor of handling the larger page sizes, if
only for
> future proofing. But I wondered whether your intent is to always support
> > 4 KiB page sizes even if CCA doesn't support them now. Another way to
> put it: In reviewing code, should I flag issues related to page sizes > 4
KiB?

I think you might be right. I'm looking at RMM spec 2.0 beta 2, and the RMI
can have granule size 4KB, 16KB, 64KB, but the RSI is restricted to granule
size
4KB.

I'm open to suggestion on best way to move forward.

> > @@ -499,14 +500,16 @@ int hv_common_cpu_init(unsigned int cpu)
> >  		}
> >
> >  		if (!ms_hyperv.paravisor_present &&
> > -		    (hv_isolation_type_snp() || hv_isolation_type_tdx())) {
> > -			ret = set_memory_decrypted((unsigned long)mem,
> pgcount);
> > +		    (hv_isolation_type_snp() || hv_isolation_type_tdx() ||
> > +		     hv_isolation_type_cca())) {
> > +			ret = set_memory_decrypted((unsigned
> long)kasan_reset_tag(mem),
> > +				alloc_size >> PAGE_SHIFT);
> 
> I don't know enough about KASAN or the tag situation on ARM64
> to comment on this change. But this same sequence of allocating
> memory and then decrypting it occurs in other places in Hyper-V
> code. It seems like those places would also need the same
> kasan_reset_tag() call.

I'm not sure of the exact behavior of PAGE_END when there are
KASAN tags, but it looks like tags could mess with the address
comparison.

I do see that __virt_to_phys_nodebug() and virt_addr_valid() in
arch/arm64/include/asm/memory.h both reset tags before calling
__is_lm_address().

If there are many calls that follow this pattern, it may be better to
add the tag reset in __set_memory_enc_dec().

I can undo this change.

Regards,
Kameron




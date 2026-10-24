Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=13.77.154.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792802560;
	b=2ZVjphVHKcIPRMRa1J6EGi44Sk1zhIkW00Fe0zfBJzFcGadp8jQ9jZudmD1cWZXwnIk8
	 phtToZAw+iXcpKLZ2ArLG8Gv/n1Q2s9KGtr10JEQQyc6XiVhXM7NPPFoVtu+RIra0i/Nj
	 CyDXz4ydDEq5jZ0uPXFDOvkie8xy1Z2LQlQb73ab6Uhf2GfmzcgcD3HxNauUgCQu3+pJ6
	 2HGO6lXeFij4LDygWqtrt1InHQQDA288LPbiFgs2MzbXSsz68b91hFHfezF2TOewSo9RI
	 j8Q0jGsyVTBmg41ol4hLCHaFb8l1z2C1lSodPLoXPv3uqlRfxM9I5+Kdqhwx2WX4B1Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792802560;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:References:Content-Language:Cc:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:X-Spam-Status:
	 X-Spam-Checker-Version;
	bh=08pP9XbCtAK7nKt18DAVCDTlNsddbkO/GF53sPocWPo=;
	b=l7ipfqwM/hh48TiHYEvGP+ROHt2G7Q6XIEuxV+i1b61AMeNQXxAxdkou5lO3pPy1mdGJ
	 Z5Ld1zLff/OrT26GwMQLsifzc6oPSX336Gu1mSx8mO9+hMcK5rKxZwTtoVheSpmgfdlLe
	 53rsrzXqNZAYNtLvKR/CN/oarzGKkXECZGIAWdTPIWGMx7TmsFLe0S4ifYTZrbkvKEr86
	 /3En/yQKmpiGzu71F/I91o3fvHQjkXlmscRBfXMSGl7Ycf6Fplg1fgZstOOTw7a0irJlf
	 57WTBABEu1nfxexTsoakxHAyxAywb2hdoFlIfDOUuzK1R30JN110aNWZYstSqh7EDLw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.microsoft.com;
	spf=pass smtp.mailfrom=linux.microsoft.com;
	dkim=pass header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=ExbPoxRp;
	arc=none smtp.remote-ip=13.77.154.182
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FB94606A31A;
	Sat, 24 Oct 2026 00:42:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4FB94606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=ExbPoxRp
Received: from [192.168.0.15] (unknown [4.194.122.170])
	by linux.microsoft.com (Postfix) with ESMTPSA id 8E0D120B7166;
	Fri, 23 Oct 2026 17:42:27 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8E0D120B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1792802550;
	bh=08pP9XbCtAK7nKt18DAVCDTlNsddbkO/GF53sPocWPo=;
	h=Date:Subject:To:References:Cc:From:In-Reply-To:From;
	b=ExbPoxRpsqJ8WvksGtX7m/oEI2jfdb0KkDdzTIhebHAStaT37MbdjHsl1VyTN+Ar2
	 cRRgUnkKpeubrIPysU9j5vEGIEdkz7d+Ax7K4AoCj1G4+oymLugPgK4F2/eeLY781h
	 9jhTpP2R7TLlIZ0yuGfHbNtCIcu4nQL/iT6vViuE=
Message-ID: <ca9da220-cf8e-4458-8109-5182f240c078@linux.microsoft.com>
Date: Fri, 23 Oct 2026 17:42:35 -0700
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Post: <mailto:linux-hyperv@vger.kernel.org>
List-Help: <mailto:linux-hyperv+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hyperv+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] Drivers: hv: vmbus: fix dynamic ID races
To: Jiale Yao <yaojiale02@163.com>, Wei Liu <wei.liu@kernel.org>,
 Haiyang Zhang <haiyangz@microsoft.com>, Dexuan Cui <decui@microsoft.com>
References: <20261021143323.338146-1-yaojiale02@163.com>
Content-Language: en-US
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Stephen Hemminger <stephen@networkplumber.org>,
 linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
From: Kameron Carr <kameroncarr@linux.microsoft.com>
In-Reply-To: <20261021143323.338146-1-yaojiale02@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/21/2026 7:33 AM, Jiale Yao wrote:
> VMBus dynamic IDs have two races with their sysfs add and remove paths.
> 
> First, new_id_store() checks for an existing ID separately from inserting
> the new entry, allowing concurrent writers to add duplicate GUIDs. Move the
> check and insertion into one critical section.
> 
> Second, matching returns a pointer into the dynamic ID list after dropping
> the lock. A concurrent remove_id write can free that entry before probe uses
> it. Copy the ID while holding the lock and reject probe when a dynamic ID is
> removed between matching and probing.
> 
> The series was found by static analysis and checked with checkpatch.pl. Each
> patch was also checked individually and in series for application to the
> base commit below.
> 
> Jiale Yao (2):
>   Drivers: hv: vmbus: prevent duplicate dynamic IDs
>   Drivers: hv: vmbus: copy dynamic IDs before dropping the lock
> 
> ---
> Changes in v2:
> - Split the dynamic ID insertion TOCTOU into a preparatory patch.
> - Reject probe when the matching ID disappears before the second lookup.
> - Preserve the ID-less hvsock probe path.
> - Use scoped locking and memcpy() for the dynamic ID copy.
> - Document that the device ID is valid only during probe.
> - Cite the corresponding PCI and USB dynamic ID lifetime fixes.
> - Add Cc: stable@vger.kernel.org and use the VMBus subject prefix.
> 
> Link: https://lore.kernel.org/r/20261019085544.1834700-1-yaojiale02@163.com
> 
>  drivers/hv/vmbus_drv.c | 56 +++++++++++++++++++++++++-----------------
>  include/linux/hyperv.h |  1 +
>  2 files changed, 34 insertions(+), 23 deletions(-)
> 
> 
> base-commit: a804c5742bff224d4cb4d25dd383554d598be32b

Performed regression testing in Azure. No issues detected.

Tested-by: Kameron Carr <kameroncarr@linux.microsoft.com>


Besides the one NIT in PATCH 2/2, for the full series,

Reviewed-by: Kameron Carr <kameroncarr@linux.microsoft.com>

-- 
Regards,
Kameron

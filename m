Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793621550;
	b=MdgDJDiE8++VDl4wslIoxTod4gtXbcUvLxm3YGF8HzT+itMwDDhsyMotqbcSMRp9a8wo
	 R91TSnORA2Tu1hXo46NXb2b/aCH14IRzdlEleU9OfjfPgaPZJSHZlvVidSmFT85AvYNLT
	 CYqq0JOfP1KgUfjdcQvil3VCm/tofHugP0O4vEU6W9WcrhfZkUQ3nXvp6f0wPBn5MwXLO
	 Jr1QeLtzncE/jQGGySYD9XI1crX8+wvZpAGBIct4LJ1+sidf2sglRebRrbPSdBkFaFu2e
	 q/vs7Hjay++P91A87C5ArGZrfGvcWNIKMeIDi/Ax2TZEiqgjdzvtQiLWX0dfOZh53JA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793621550;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=42kWpsG9Z6lrlCHz9cuZnhbJ9wiLjaLNz5DpNtMKtpU=;
	b=KEWo9Gtq2wVl8vYpnuPuNpc8OFN4Qsi5P8LRbH7RSClHkhC2pO7n1ggrO1194IyfkJyd
	 wXk5yEasPsGgmO4zysuoDKrlBvSEoaSrVo8x+nL6G/iCpcPbsVwkEFCLBgxBmxPFoS+1p
	 8rDPHKVf+NyedTZs8xorjD4TMMxAftU6Eu3IEeqxjEAA/R+QbA/nA7agV6qDY5+Hn1Kvt
	 I6JhTKP7gpHT+tGBsx1xMSR0WB2ro5HUTQKOkyZ5Tq2h0MYFWEgOeJk0vK7ruSLf3bhm8
	 jKIc0xyntCZCCsT/ZxFRVJeLzw4wWcgY+vkzL3QjhN1TW9dReQRkX2lROKLBF+Uj6GQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=lET5Iiwm;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 924AB606A324;
	Mon,  2 Nov 2026 12:12:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 924AB606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=lET5Iiwm
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D8CBE153B;
	Mon,  2 Nov 2026 04:12:25 -0800 (PST)
Received: from arm.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 258A73F59E;
	Mon,  2 Nov 2026 04:12:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1793621548; bh=LDLkhtz2J8kntAj62nqHKUXzSrEajnevTEiXeI9yeaA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lET5IiwmXEcuJA3mJ7t/gUqnS0VPO7JCdGNxr0QsWHhd4sv5NHofA/ZHd5Z/g2OFK
	 C4D2e3pSJmF97NDdhXdPHU9XbNr2LyxExsHN2futubQMCfp6EXS0Hf1fb/tvYlnBIG
	 Ab1SR41yNpxvRZTecGKGt6tmMDPlI186uS1SMNcI=
Date: Mon, 2 Nov 2026 12:12:24 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Kameron Carr <kameroncarr@linux.microsoft.com>
Cc: decui@microsoft.com, haiyangz@microsoft.com, mhklinux@outlook.com,
	wei.liu@kernel.org, arnd@arndb.de, linux-arch@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org, lpieralisi@kernel.org,
	mark.rutland@arm.com, sudeep.holla@kernel.org, thuth@redhat.com,
	will@kernel.org
Subject: Re: [PATCH v6 2/6] arm64: hyperv: Detect Hyper-V via RSI host call
 in CCA Realms
Message-ID: <auh-KP-4gFxHtO1z@arm.com>
References: <20261031001412.4150488-1-kameroncarr@linux.microsoft.com>
 <20261031001412.4150488-3-kameroncarr@linux.microsoft.com>
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
In-Reply-To: <20261031001412.4150488-3-kameroncarr@linux.microsoft.com>

On Fri, Oct 30, 2026 at 05:14:08PM -0700, Kameron Carr wrote:
> When booting without ACPI, hyperv_detect_via_smccc() detects Hyper-V by
> querying the SMCCC vendor hypervisor UID. In an Arm CCA Realm the SMCCC
> call is handled by the RMM rather than by the hypervisor, so the
> query never reaches Hyper-V and detection fails.
> 
> When running in a Realm, forward ARM_SMCCC_VENDOR_HYP_CALL_UID_FUNC_ID
> to the host with RSI_HOST_CALL instead, which is how Hyper-V hypercalls
> are issued from a Realm.
> 
> This is done in the Hyper-V code rather than in the generic
> arm_smccc_hypervisor_has_uuid() because the other users expect different
> behavior.
> 
> hyperv_init() is an early_initcall and runs before the secondary CPUs
> are brought up, so a single __initdata host call structure is used
> without locking.
> 
> ACPI-based detection and non-Realm guests are unaffected.
> 
> Signed-off-by: Kameron Carr <kameroncarr@linux.microsoft.com>

This works for me, thanks. I replied to Dexuan clarifying my objection
to v5 do the UUID check generically.

-- 
Catalin

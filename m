Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793714506;
	b=OE1fhaXUEW1MiQiy+fQOeuvFh8PSDvOcdGsveWGP5O7rGC4E+eVcVN92YBjjA9mchr9f
	 AO7xyRyRL5E4NdiGtaHNeKxxy5SuMoV9EwSct0Bzlrhp7WEUa1qX54INU3AixHpyUWxhi
	 gYXCi9Ge+D+QZN/8jrOQz8mEvSNww8DyIAF/4XbbETIw07Fk2o5cTHvziWr7mWqMhUUiC
	 DTMfPh7JmjotmWpjSStwlZcN1g2yE3RnRRVeDHleYJ4sFvc81B/PpTO6iNPSXA99/5QIC
	 0l1cYy/ESegEVXWv4sclBDVsHmk9TCnn4HF78Wa/mPYh8pAQS3f49qzPU9OFPbTxhCQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793714506;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=aoEz3XDvNbQleGg7AGotOLvdqQR5gJ3dWjYehkJVEAg=;
	b=TjP+2PkKyGLutHrl2VC9AUNLNziDcMhaz4hG69Uh9IDrScxkewkUF/VIxxKX8J1bBQrx
	 iuf/TkD9nI9dLNVU7sU7HSTg/bQR8UMqHBJlsIPKVt+KilBQyfOku176XQ8JpbW3DE5MA
	 gcJItq/Md5/Qw+GDebBp2+zbktzsx+gzGJ7m5qStaseNPcM51deVeiN4n44+DQRvbQ6fa
	 3jrFH+KxZ79t3it1NTUjnO3VXUGD+DTYeC2XFu0x3yZCEyVUZO/M7VD/+JQssbh1BO6tG
	 mZxnZMuw/YnWAEkz4QY00z0FvQdUKXDiTTx6B4jeXNfLrH7272mjf4OEHuN/GE6zd9w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=YwBrmiMc;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 854756082BE5;
	Tue,  3 Nov 2026 14:01:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 854756082BE5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=YwBrmiMc
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4989C1595;
	Tue,  3 Nov 2026 06:01:40 -0800 (PST)
Received: from arm.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 32A593F673;
	Tue,  3 Nov 2026 06:01:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1793714503; bh=wIZLjMr9MrBhBElX8/30eyxmo0F41I4lrfTa+wBa7tQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YwBrmiMcxgxgc/oqB40Ht/y8m8LlWct0YtdnpHGGvzDuec16EtV7NY+oHv/hCetja
	 2f6zsYjxlTcIoz6eOMhAtSEfc75BbV73NZgTZSmw9FZPhcLeJhcnrlIilEq0T1jk4E
	 8CZPmtRTgv3jpFSsvkXhvGT+Q5XvXx7Avzo3Mwb8=
Date: Tue, 3 Nov 2026 14:01:38 +0000
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
Message-ID: <aunpQixDBFz9VBj8@arm.com>
References: <20261031001412.4150488-1-kameroncarr@linux.microsoft.com>
 <20261031001412.4150488-3-kameroncarr@linux.microsoft.com>
 <auh-KP-4gFxHtO1z@arm.com>
 <c87dc2c3-9211-46d2-9301-46a03d4b0ad7@linux.microsoft.com>
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
In-Reply-To: <c87dc2c3-9211-46d2-9301-46a03d4b0ad7@linux.microsoft.com>

On Mon, Nov 02, 2026 at 11:27:37AM -0800, Kameron Carr wrote:
> On 11/2/2026 4:12 AM, Catalin Marinas wrote:
> > On Fri, Oct 30, 2026 at 05:14:08PM -0700, Kameron Carr wrote:
> >> When booting without ACPI, hyperv_detect_via_smccc() detects Hyper-V by
> >> querying the SMCCC vendor hypervisor UID. In an Arm CCA Realm the SMCCC
> >> call is handled by the RMM rather than by the hypervisor, so the
> >> query never reaches Hyper-V and detection fails.
> >>
> >> When running in a Realm, forward ARM_SMCCC_VENDOR_HYP_CALL_UID_FUNC_ID
> >> to the host with RSI_HOST_CALL instead, which is how Hyper-V hypercalls
> >> are issued from a Realm.
> >>
> >> This is done in the Hyper-V code rather than in the generic
> >> arm_smccc_hypervisor_has_uuid() because the other users expect different
> >> behavior.
> >>
> >> hyperv_init() is an early_initcall and runs before the secondary CPUs
> >> are brought up, so a single __initdata host call structure is used
> >> without locking.
> >>
> >> ACPI-based detection and non-Realm guests are unaffected.
> >>
> >> Signed-off-by: Kameron Carr <kameroncarr@linux.microsoft.com>
> > 
> > This works for me, thanks. I replied to Dexuan clarifying my objection
> > to v5 do the UUID check generically.
> 
> Thank you for your review and suggestions.
> Your clarification makes sense.
> 
> Is this a "Reviewed-by" or an "Acked-by"?

I don't usually ack the hyperv patches as I don't know enough about it
but given that I commented on this particular patch in v5:

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>

-- 
Catalin

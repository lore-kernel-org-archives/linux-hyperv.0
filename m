Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFBD1373C07;
	Thu,  2 Apr 2026 21:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775164042; cv=none; b=cdbKZ2DG6+9TSeV3cJ+xGBuLzLI9KNQ2UJ++BsMGBIvG8RDZZV8oLG2t3BSSdvNNtRoZ3LPXa4XLdwdubVf85Eha61I5a8/3qnh+xhdehZtHpd7xYewmTCNhZ238cNdmLs2zYijuVZqA3qG7AdT0ATCMdhgycgpq0UR1ZZjKxbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775164042; c=relaxed/simple;
	bh=/sqnQ4JcG0mNdU9T5PJoM4FkqIL4/9RzmaHOd+M5Wwo=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=amIfWAs20kLix85DPJcMUHnOjFVl4JUuDyw513NkjUFjj5dHV2+aR7vlV+OXzOdoXcNACTAFQ38CjMidPll0YQAWqY8seb8vBC72cvJCntD8hjtjmsLhoYu+AQqIdXxcBOha0SwX7bwTs4s2fkXkwaiRgcUENoJgAh7YKmIkU8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ne3YsAzL; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YTqkYPL0; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ne3YsAzL";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YTqkYPL0"
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1775164039;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/sqnQ4JcG0mNdU9T5PJoM4FkqIL4/9RzmaHOd+M5Wwo=;
	b=Ne3YsAzLcmTLpGeKRKKo1CoTrkuJ/igVN9EMBWiAEoyk+uToOXnCdYgLq0RR3+8zfgsmy9
	vT2NDhRpLC6jhKnjudqqus66mySQu8TTfLvguHjbZT8lxOYM8YB6AtB8tcKooI1HhJvKl8
	nwZ4Oa0e3+HITWYvRHMenuz2VajkFvoowPaQ1hJg5as/wCZ1YQYgr4ZUrouGAG4bm6KZME
	lGm3jzywofDK08pdZJupEbO4P6n9GA1nc7TcSzatI5DlwLcOHML/LQSAzd5kG+UpVCLVuc
	XAbDesAgEF8L+KozLqByTDVu9hUlMWFtSHeV9D2LAd5d1qj7ZgJXok6k3FHbZw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1775164039;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/sqnQ4JcG0mNdU9T5PJoM4FkqIL4/9RzmaHOd+M5Wwo=;
	b=YTqkYPL0WPU88MvEG4zEvXBpSFwenjz9OO9aXJv1D/Rs7Hqc7aJ+65FisdpbtSGMPuEcsd
	xXlRJ0Gh7FSStKBQ==
To: mhklinux@outlook.com, kys@microsoft.com, haiyangz@microsoft.com,
 wei.liu@kernel.org, decui@microsoft.com, longli@microsoft.com,
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
 hpa@zytor.com, maz@kernel.org, bigeasy@linutronix.de, x86@kernel.org,
 linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org
Subject: Re: [PATCH 2/2] Drivers: hv: Move add_interrupt_randomness() to
 hypervisor callback sysvec
In-Reply-To: <20260402202400.1707-3-mhklkml@zohomail.com>
References: <20260402202400.1707-1-mhklkml@zohomail.com>
 <20260402202400.1707-3-mhklkml@zohomail.com>
Date: Thu, 02 Apr 2026 23:07:18 +0200
Message-ID: <87eckx6ph5.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Apr 02 2026 at 13:24, Michael Kelley wrote:
> From: Michael Kelley <mhklinux@outlook.com>
>
> The Hyper-V ISRs, for normal guests and when running in the
> hypervisor root patition, are calling add_interrupt_randomness() as a
> primary source of entropy. The call is currently in the ISRs as a common
> place to handle both x86/x64 and arm64. On x86/x64, hypervisor interrupts
> come through a custom sysvec entry, and do not go through a generic
> interrupt handler. On arm64, hypervisor interrupts come through an
> emulated GICv3. GICv3 uses the generic handler handle_percpu_devid_irq(),
> which does not do add_interrupt_randomness() -- unlike its counterpart
> handle_percpu_irq(). But handle_percpu_devid_irq() is now updated to do
> the add_interrupt_randomness(). So add_interrupt_randomness() is now
> needed only in Hyper-V's x86/x64 custom sysvec path.
>
> Move add_interrupt_randomness() from the Hyper-V ISRs into the Hyper-V
> x86/x64 custom sysvec path, matching the existing STIMER0 sysvec path.
> With this change, add_interrupt_randomness() is no longer called from any
> device drivers, which is appropriate.
>
> Signed-off-by: Michael Kelley <mhklinux@outlook.com>

Acked-by: Thomas Gleixner <tglx@kernel.org>

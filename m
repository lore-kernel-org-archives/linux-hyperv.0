Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78E2E49DD52
	for <linux-hyperv@vger.kernel.org>; Thu,  6 Aug 2026 23:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786059409; cv=none; b=DCqg+64ObWKpO6fBbpt9gVj4n/aCB/XS8r6Q7C/FStwSBQbviOfw9S3nyWscvkJ6rqC4PIvXhp/zJV2f5HNbQIlLmId4MwF8UwKNt2eCu2HO5wkFSZZ6C0LyZ7I8HZzvu+prhOv0sSJPUf5Ykgctj15edDb8b43G9MjZbeOYAHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786059409; c=relaxed/simple;
	bh=1uALf830n7JEUnTGzELSb3OUZCMrXoPiNs3kWl6RzcI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=h4oNKxQsYA5HxALo/RolCJXbLgRqN78MgpRhmCwjvanhX9uZrJ2hknn5gT68Sh52Z8I999MerFXP5G0XIhPI3hHXi73GrGWtt8luqWKwTigKvZSMKbNIMAHLmjJFBZtWdEqoF6UXnjwHIBEyfbqvwfwAhNo9HX2GM4+Eow0vwaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XgKTSrG/; arc=none smtp.client-ip=209.85.210.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XgKTSrG/"
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-84870e7f498so2970698b3a.3
        for <linux-hyperv@vger.kernel.org>; Thu, 06 Aug 2026 16:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786059406; x=1786664206; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=bafmbn4x7WGy8QY/EzYypINgs3wQBC6UPHmanD+knFs=;
        b=XgKTSrG/75sOzeYYPf1MfnDvKkv8+u60mgM3NzQ73LgLSbp2LusOilCrIuic32Wpbf
         95YNJLs4/euEYKf0UNw7pgr0v6g0xVnAGN2A7w4bjCG3fpFDD4IVgfOwA4tvrL6Xc2VY
         s7qD8+SgBmLaOqwK7E9iSeKEhDk0hh1R9Z8FnRVIKQlN3MDKIoSyvnnld2BjgIVGbnaA
         TDNSyo7mnEzFEHf/M8USZRSXLcFoXUfL4T18kH9nsk5bw0RMG495Sbzjpep+mm0CgHWr
         FybDSczkcFW617slxvRhI3ilwfaeP0xxF4UO1AW3uUCd4pOvlM26Fyo6ZEzOYrU6GVlZ
         /yww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786059406; x=1786664206;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bafmbn4x7WGy8QY/EzYypINgs3wQBC6UPHmanD+knFs=;
        b=pC4h1MmVYPSx55EUkL/OY8pqE2EO25qMtm7LTrR6Twg0HImiyWAUqKwp7jF3B/QGLj
         RTgaMkUhX2AVeM1hUGUYTNK5Xw3+7DiVudS+1R+WzrJfzcC+qKTVZf4F0p7KiNvvTOfE
         jysF8vE29kE+rPTzki7ffL07pj+QhPZf+AzJ2l8/3wlnrAFee0YYGf/SUZHpDjJO57ZM
         AHDBtvB9pHTwsE7b3Nzw7fioXWcCbBhl1h9lnd7KZJZaoD/gFpxdcg5/9q+CXXy9FFcB
         6rwUIpLj12Rt3Bdrm9Q+RsLxTglErj7TGyqqaO/MtBfcaeDGYAuWhta1iyTXgD7J2YTf
         6gkA==
X-Forwarded-Encrypted: i=1; AHgh+RqfMHFDHrBpauHZ/tgR9qj1nO1U5YCBfl1HVGMi579e/4yqaqK0UzwBmLWCeEbCrQU2mR+XePJbVurejdQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxXi/dM1dFZnsyX6kFDQwx1fFKoiTk48tCi+rNP+4mJW3P0g7h
	kMsx3Arx97MgOACnEMtRgJJH5NmWw3+v2LC31OUSmu+oNXuwpBOm21i3XQJOE+5NFunDfJU5GeD
	l7r5zZw==
X-Received: from pfks7.prod.google.com ([2002:a05:6a00:1947:b0:84e:2400:dc7d])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:409b:b0:842:5b63:6112
 with SMTP id d2e1a72fcca58-84f2e12d036mr22581852b3a.32.1786059406261; Thu, 06
 Aug 2026 16:36:46 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu,  6 Aug 2026 16:35:35 -0700
In-Reply-To: <20260806233609.212337-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260806233609.212337-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.679.g6767b8d81c-goog
Message-ID: <20260806233609.212337-19-seanjc@google.com>
Subject: [PATCH v6 18/51] x86/kvmclock: Rename kvm_get_tsc_khz() to kvmclock_get_tsc_khz()
From: Sean Christopherson <seanjc@google.com>
To: Kiryl Shutsemau <kas@kernel.org>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	"K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>, 
	Ajay Kaher <ajay.kaher@broadcom.com>, Alexey Makhalov <alexey.makhalov@broadcom.com>, 
	Jan Kiszka <jan.kiszka@siemens.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Juergen Gross <jgross@suse.com>, 
	Daniel Lezcano <daniel.lezcano@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
	John Stultz <jstultz@google.com>
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
	Boris Ostrovsky <boris.ostrovsky@oracle.com>, Stephen Boyd <sboyd@kernel.org>, 
	Miroslav Lichvar <mlichvar@redhat.com>, x86@kernel.org, linux-coco@lists.linux.dev, 
	kvm@vger.kernel.org, linux-hyperv@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	xen-devel@lists.xenproject.org, Michael Kelley <mhklinux@outlook.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Nikunj A Dadhania <nikunj@amd.com>, 
	David Woodhouse <dwmw@amazon.co.uk>, David Woodhouse <dwmw2@infradead.org>, 
	Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"

Rename kvm_get_tsc_khz() to kvmclock_get_tsc_khz() in anticipation of
adding support for getting TSC info from PV CPUID, i.e. in a KVM specific
way, but without non-kvmclock.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kernel/kvmclock.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/kvmclock.c b/arch/x86/kernel/kvmclock.c
index 35a879d33e9e..061a22d31dea 100644
--- a/arch/x86/kernel/kvmclock.c
+++ b/arch/x86/kernel/kvmclock.c
@@ -136,7 +136,7 @@ static inline void kvm_sched_clock_init(bool stable)
  * poll of guests can be running and trouble each other. So we preset
  * lpj here
  */
-static unsigned int __init kvm_get_tsc_khz(void)
+static unsigned int __init kvmclock_get_tsc_khz(void)
 {
 	return pvclock_tsc_khz(this_cpu_pvti());
 }
@@ -146,7 +146,7 @@ static void __init kvm_get_preset_lpj(void)
 	unsigned long khz;
 	u64 lpj;
 
-	khz = kvm_get_tsc_khz();
+	khz = kvmclock_get_tsc_khz();
 
 	lpj = ((u64)khz * 1000);
 	do_div(lpj, HZ);
@@ -342,8 +342,8 @@ void __init kvmclock_init(void)
 	flags = pvclock_read_flags(&hv_clock_boot[0].pvti);
 	kvm_sched_clock_init(flags & PVCLOCK_TSC_STABLE_BIT);
 
-	x86_init.hyper.get_tsc_khz = kvm_get_tsc_khz;
-	x86_init.hyper.get_cpu_khz = kvm_get_tsc_khz;
+	x86_init.hyper.get_tsc_khz = kvmclock_get_tsc_khz;
+	x86_init.hyper.get_cpu_khz = kvmclock_get_tsc_khz;
 	x86_platform.get_wallclock = kvm_get_wallclock;
 	x86_platform.set_wallclock = kvm_set_wallclock;
 #ifdef CONFIG_X86_LOCAL_APIC
-- 
2.55.0.679.g6767b8d81c-goog


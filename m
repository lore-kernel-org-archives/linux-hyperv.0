Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1129C4AACA8
	for <linux-hyperv@vger.kernel.org>; Thu,  6 Aug 2026 23:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786059436; cv=none; b=LRM101i/YKPNQUr7SOdInk17IRYUeflBmekAQv5l9u5Ocmy+SuDdq0gDWssE4jtRf45JAzCGiYJ8kizEKBqOHoKQm3+XJbWsLgmvJ8zxEu27m5FoMn7VvK5vDEPMmsUkdnixhGvTZ6eR8WJ0eLvqYl3fzWIYE22I4rckXwL+GS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786059436; c=relaxed/simple;
	bh=atSdA44tQM5iL7i468JQE5pWUtYdZ9gHhqtvG2Zh53o=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GpAAWYmSL8IsdhdcjsfToTctg0rbf9qkSy0iZN6FlpSBc75OnH4oMTCht8lu4UJUd1PM+PraTTnfLNu1XlDoLjs3dyinibel72ifgHsNMrEMU+j77lZY4BbfGcbYqSX3dC19C86gOu+1Nz4RgAwBd18hbYadyb0O2gT4wJWfhdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FccuUzN5; arc=none smtp.client-ip=209.85.210.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FccuUzN5"
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-84e3d575d6eso4633575b3a.3
        for <linux-hyperv@vger.kernel.org>; Thu, 06 Aug 2026 16:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786059434; x=1786664234; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=gswAR/5wSepHR0W/S6/oLzBYH0wiOXioT7kjM1AQclw=;
        b=FccuUzN517P6dv1EScvNGgc/kZAicCrl68GSLp765qNQLHwOCDrpMqa688XpUfASXk
         s3qlCUW6FIUAulelGJrFXfC4OP7iFciVoKpphQC3vUwmiu95MCZBk1N7jljNMEzwb3VA
         caa6of+/YVNCjgHSpf8/UORwT1K4PbnQj5s+Ee4oBqJBEUTAZnARFUNFkO9KKxCZscmh
         RxAWcbNAfS8ARhUSRQ6e2QiVtbui2Bpdcnep7DaIKAMLANG8egoAUw6ClxpAQGSS+Scs
         Xe5o+HNHAQay1F7RMXHkpga3KB1bcvR6EbBERBjawzUjaMN4tjbXrLvZRDC7CmZNzDh7
         NbKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786059434; x=1786664234;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gswAR/5wSepHR0W/S6/oLzBYH0wiOXioT7kjM1AQclw=;
        b=BKa4ArOT831qV9n34mwMUwc4QfAsp+l6EmgTWxoqJDZUVcUfmHAtnSsPQBdLgsccy2
         l4mt1cBcXahw1l/C0SPo/V8VrIAnTZha6GEeRKVN8U5MYdzGZPw8lbPFMdO1KTjsCBLw
         nZBXJIGRXhzab3lgjVoiF2ePg4Xe0L0uoPfjhZM3cqedWTo+G85gkEPOIJq0D6uOdaDy
         qMkEKKk8IiIqLqeT69N6CQppiSK/v8+OWGjd0yOWB3NT0lvDNQJ8XTy8U9mXb9El4lLH
         E3rinFGBTGpallnx6K5oUXyxZZPjJPRnoOu3oVANKhZmSVoQBiXxnhl/NoP0w0LBUSEl
         OS6Q==
X-Forwarded-Encrypted: i=1; AHgh+Ro7vXvZb05KXL+Aklku/DzFiKP9RxvNHKNa3knw70LMurvAPLJE6LWQolSNjO1qhczNqpwA5F9Qj01PEyI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQyG9CSaI5QrE+kHwsZhXQAF1f5o2Kdke1IvJ8t5LNvwS0emyQ
	RsoWl1tNL1DGZiIttTLZc/t2lYW6vct5hxfdFdTxJVZn2fqgju3kcyOksrLwXysLg8f7cfRRSNn
	Qf6asrA==
X-Received: from pfjt11.prod.google.com ([2002:a05:6a00:21cb:b0:84e:2062:2edb])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:9506:b0:84a:29a7:f64c
 with SMTP id d2e1a72fcca58-84f2de45511mr20003910b3a.0.1786059434181; Thu, 06
 Aug 2026 16:37:14 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu,  6 Aug 2026 16:35:57 -0700
In-Reply-To: <20260806233609.212337-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260806233609.212337-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.679.g6767b8d81c-goog
Message-ID: <20260806233609.212337-41-seanjc@google.com>
Subject: [PATCH v6 40/51] x86/pvclock: WARN if pvclock's valid_flags are overwritten
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

WARN if the common PV clock valid_flags are overwritten; all PV clocks
expect that they are the one and only PV clock, i.e. don't guard against
another PV clock having modified the flags.

Reviewed-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kernel/pvclock.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kernel/pvclock.c b/arch/x86/kernel/pvclock.c
index a51adce67f92..8d098841a225 100644
--- a/arch/x86/kernel/pvclock.c
+++ b/arch/x86/kernel/pvclock.c
@@ -21,6 +21,7 @@ static struct pvclock_vsyscall_time_info *pvti_cpu0_va __ro_after_init;
 
 void __init pvclock_set_flags(u8 flags)
 {
+	WARN_ON(valid_flags);
 	valid_flags = flags;
 }
 
-- 
2.55.0.679.g6767b8d81c-goog


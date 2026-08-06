Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5784641B8D9
	for <linux-hyperv@vger.kernel.org>; Thu,  6 Aug 2026 23:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786059394; cv=none; b=LA7kLynaV1qOJw/FYthmdlWvqPpyjmlYd+zPDyWJzc5kkyabzyfWIbd+Oi7jj/owwsiWIjd8hr9TuNrcTCGd2jKuSPim9LkRyFSn2g/z8pBKpI/p8hsP8gkgd2uPjZbXoEZYqrgZelLlBUDDiWYzwHXL4V2OSy+UMAVTCYan9cM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786059394; c=relaxed/simple;
	bh=X1lXC7wwYepEcyxXlelWc3xQjHjFJjQegmWHjMap6JE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rLc1HGdWEFlc4YNUSzakjZAiB6dtbquHf03b2bbDiRakQR98JhDB4L3DdE1KvnGRXhIPbslSO5l+liOieJA/kUKD9W8+W4c/Y66Jm0VzMKbBgBLkfEkhkTl9q5MMkhbohdhrZRmhSHOmuKLpYsj0mhS91Wl4TiVZK01zzGmZGF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PYVp2MfV; arc=none smtp.client-ip=209.85.215.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PYVp2MfV"
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cb6dd278512so1611780a12.3
        for <linux-hyperv@vger.kernel.org>; Thu, 06 Aug 2026 16:36:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786059389; x=1786664189; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Bl6f0kmYO+QvCHyY9ZYfUQzYrQcYJLjL3x7Z6ExdFrE=;
        b=PYVp2MfVOEWDFDxRKN84/PKiWyvbIzcu7P7uQ4Erve4pEIfjKG6I6JRYbwiUnHVRHj
         UNEBMz3CJD5CnZLpETc3AgtBG6Nt41HjP/AVSgc3LQstIS1mghd2y/ZgoSkEWdTETaVi
         FQ0GiG0I6w79YBc9ZFlTxqD62dnEFiZohXVH704P2bIfLybcwNy6rsmEDk02id+ru90K
         HOl1zB5RG4QOCUNzhFZIC+0v9taoPEWOvQUV02SAbVv10a90mwUH/wKVhKuVzbVM54Kz
         5UMlUpxWo2Kb7NoyK6UD9/wi4+X2BoaLk5MnaAHn/ugu2w6Zfn2Yh/edLPLldyJVSKqh
         4bsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786059389; x=1786664189;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Bl6f0kmYO+QvCHyY9ZYfUQzYrQcYJLjL3x7Z6ExdFrE=;
        b=Vvsi0WKisKNS9e8lcjdCl1QOdhAOWM6QJCu/HvL8t/k0M0qNfXoKR7OKHtftWAkQ3r
         fLz1BxPB44KZd8Eyyd+3+l6Sg0gY8Lzeax/CzeVOlYs9K9yNUYRCmjlTDaM/IqbyZWZY
         XVKCN0M4263LQ+Qcynv29vK+Rf4tQBKYE0itven8ahnu2P7pcwM65D1LkAmxMRm5RyU5
         JgjwTbxrWgXTpJ7KF9g1XQ+jSvA7vCRlBoS2qLIIkxapsKUiAN0DTTRv1rbIW97l079N
         UsEspr4Mk5N5U5wChLDhaCKGF78hxGmTdW5wCOBn8jy2ez+2N7dOMxGfTfnIa/Bocc0+
         BCBQ==
X-Forwarded-Encrypted: i=1; AHgh+RoAV5rFKTU8PXYl/vITWNJyZpKcpMCTnIugsJkX+9Nrd9g2LLGCWtHZqkOHoyU9eInhy2FdZfkogWythAU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxYl1N5dXpHR9vN9bGyyaDZRS3Pjd76zdy4OKXLD5Zpm+gJEEN
	AaZN2XAg0FuU5QwNV5g2RSgXluXbkZOhNji9rB+b9geXzxTP47RKw41dc2x/UhCWh+xRsJHPNaK
	kh8OXXg==
X-Received: from pgav2.prod.google.com ([2002:a05:6a02:2dc2:b0:c85:9dd2:d11e])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:7349:b0:3c6:3c5b:f2e1
 with SMTP id adf61e73a8af0-3cbadcfcacfmr5222309637.32.1786059388428; Thu, 06
 Aug 2026 16:36:28 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu,  6 Aug 2026 16:35:21 -0700
In-Reply-To: <20260806233609.212337-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260806233609.212337-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.679.g6767b8d81c-goog
Message-ID: <20260806233609.212337-5-seanjc@google.com>
Subject: [PATCH v6 04/51] x86/tsc: Restrict recalibrate_cpu_khz() export to
 p4-clockmod and powernow-k7
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

Export recalibrate_cpu_khz() only for its two users, p4-clockmod.ko and
powernow-k7.ko, to help document that recalibration is relevant only to
ancient CPUs.

For all intents and purposes, no functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kernel/tsc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index bc4348585194..09bf10f322ba 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -943,7 +943,7 @@ void recalibrate_cpu_khz(void)
 						    cpu_khz_old, cpu_khz);
 #endif
 }
-EXPORT_SYMBOL_GPL(recalibrate_cpu_khz);
+EXPORT_SYMBOL_FOR_MODULES(recalibrate_cpu_khz, "p4-clockmod,powernow-k7");
 
 
 static unsigned long long cyc2ns_suspend;
-- 
2.55.0.679.g6767b8d81c-goog


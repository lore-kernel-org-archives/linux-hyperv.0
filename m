Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D27D4252DF
	for <linux-hyperv@vger.kernel.org>; Wed,  1 Jul 2026 19:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782934409; cv=none; b=srb5aDjGvGe1tf7fklOsMkIoEYheNM2O+AM6NiBlDp4so5dvVTwXh4h3INs7ui8Ly3Sd3YKUIFU9gYZMHCIB6VNshqVTyaL2R0vT2a4kxflGSCUAohXQLlbrFhSScFxSHm53FK15Pgsv4u2P3Tl8gZ6y8LgGc1G5SHI4uESBNgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782934409; c=relaxed/simple;
	bh=y0eTf6sBBqtgXOMcKj6+dRH4mQYHxDct/p+oWayuTuo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kJN6e3XZUJVggjd+vpOChI/7o3CE+pb5jeZn2/fzXtqWzMO6CJ0Vy8rFZqBoCGeUSMbjxdwWr6M2NYfFUT1hP5vmJOCEswUgA2QcWDOQP2uX76zks1hjsuHTHhjrj8WI33spuldEnrZxE5TE2/tIOlcxbzbSfmyW+xulFFuLUug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VYsGQwdb; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VYsGQwdb"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2c804e38cb1so10415945ad.0
        for <linux-hyperv@vger.kernel.org>; Wed, 01 Jul 2026 12:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782934404; x=1783539204; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=KILxImADtcVlkoacCtqYmxEGcZEGxD9ytdtd9JfAHyU=;
        b=VYsGQwdbjNJamdALhE5BlmfZWBGea3Xdh8PfI0QLC+lE6ZyUQD0GnseyDS4wXNB6NP
         1jPilYvwLauF/zZwSz3VMO8R0HoH8UAPNUtSjrgKMoPwPABRXzoGLNKPYUmmAkJRq1Oj
         OQU2cmTECKsQvaa4//608dJkwLv4bOKIFUHQkdndI8uscNR/oJNp6IEUI49ae9n2lPOO
         jIH+47lmH3sW8dypj7XK6izqBPyw6bKYlOHoMBxMw6v+zCN8F+soOCkeyfKB7LwO2lln
         6bXN5cGaBT+RZUNeQYwR4x5x2l1uf8VRjmQXewatyNgl5CBM4OIoCA9KZBmDWkSj+uv/
         SR1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782934404; x=1783539204;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KILxImADtcVlkoacCtqYmxEGcZEGxD9ytdtd9JfAHyU=;
        b=kCKfyQP3cigNNvO09v6iNaY9DI0/kqvdW5abBfcgKQl6r8RV5mTu3ILJC5RgZ1itJ2
         QYn+nuRjivf5B7rCm08d1fytCclp7HW9kWSKIyCTVLYiI57wUivgoOPNjMHKh7ho2d3U
         7F3yNPMMKDhiHR2cUDKbDdIpARbxz1kuKSEfy+ECEPAcaKYublUFibXJYwBQNVb4Eb6u
         UhFwXJ5Enondr0Br+TNsg+xeTXZr9OM5VTdLJKFPHzPDVIslCaJK47Dm69688UXu5E95
         NJlQnD2LbNDYYi4kDSuV2YALqsCBWrcpZsiIdENcb5x+1TeiAwbEFXCotbYHqN/IrSiP
         uOag==
X-Forwarded-Encrypted: i=1; AHgh+Rr+7CZYgPXzpoUqpRxIHK/hWqWOIdkQRgbCQ6XPut6gaXbv4YahJyvvwmZr8RjZrrwcUPs2n5V2LCruXyY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxe/ZkECJEjK4/HcXHWlibnOIqLOnjZasnmk/21QZWffk3c0+wl
	oBm9/vuEHiQNNHu45MqKyBOGqcGoNBdDVQ7Z4smFn1kQdu0vrPfxo3vonVfcX7AwV/wXAqUI57H
	aDey/1w==
X-Received: from pltf1.prod.google.com ([2002:a17:902:74c1:b0:2c7:5af7:37a3])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:c952:b0:2c9:c169:7483
 with SMTP id d9443c01a7336-2ca7e87dc6bmr34187285ad.37.1782934403691; Wed, 01
 Jul 2026 12:33:23 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed,  1 Jul 2026 12:32:08 -0700
In-Reply-To: <20260701193212.749551-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260701193212.749551-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260701193212.749551-48-seanjc@google.com>
Subject: [PATCH v5 47/51] x86/paravirt: Don't use a PV sched_clock in CoCo
 guests with trusted TSC
From: Sean Christopherson <seanjc@google.com>
To: Jonathan Corbet <corbet@lwn.net>, Paolo Bonzini <pbonzini@redhat.com>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	Kiryl Shutsemau <kas@kernel.org>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Sean Christopherson <seanjc@google.com>, "K. Y. Srinivasan" <kys@microsoft.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>, 
	Ajay Kaher <ajay.kaher@broadcom.com>, Alexey Makhalov <alexey.makhalov@broadcom.com>, 
	Jan Kiszka <jan.kiszka@siemens.com>, Andy Lutomirski <luto@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Juergen Gross <jgross@suse.com>, 
	Daniel Lezcano <daniel.lezcano@kernel.org>, John Stultz <jstultz@google.com>
Cc: Shuah Khan <skhan@linuxfoundation.org>, "H. Peter Anvin" <hpa@zytor.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
	Boris Ostrovsky <boris.ostrovsky@oracle.com>, Stephen Boyd <sboyd@kernel.org>, linux-doc@vger.kernel.org, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev, 
	linux-hyperv@vger.kernel.org, virtualization@lists.linux.dev, 
	xen-devel@lists.xenproject.org, Tom Lendacky <thomas.lendacky@amd.com>, 
	Nikunj A Dadhania <nikunj@amd.com>, David Woodhouse <dwmw@amazon.co.uk>, 
	David Woodhouse <dwmw2@infradead.org>, Michael Kelley <mhklinux@outlook.com>, 
	Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"

Silently ignore attempts to switch to a paravirt sched_clock when running
as a CoCo guest with trusted TSC.  In hand-wavy theory, a misbehaving
hypervisor could attack the guest by manipulating the PV clock to affect
guest scheduling in some weird and/or predictable way.  More importantly,
reading TSC on such platforms is faster than any PV clock, and sched_clock
is all about speed.

Reviewed-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kernel/tsc.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index 012321fed5e5..a146fc7b5e74 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -283,6 +283,15 @@ bool using_native_sched_clock(void)
 int __init __paravirt_set_sched_clock(u64 (*func)(void), bool stable,
 				      void (*save)(void), void (*restore)(void))
 {
+	/*
+	 * Don't replace TSC with a PV clock when running as a CoCo guest and
+	 * the TSC is secure/trusted; PV clocks are emulated by the hypervisor,
+	 * which isn't in the guest's TCB.
+	 */
+	if (cc_platform_has(CC_ATTR_GUEST_SNP_SECURE_TSC) ||
+	    boot_cpu_has(X86_FEATURE_TDX_GUEST))
+		return -EPERM;
+
 	if (!stable)
 		clear_sched_clock_stable();
 
-- 
2.55.0.rc0.799.gd6f94ed593-goog


Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A80A4A09F2
	for <linux-hyperv@vger.kernel.org>; Thu,  6 Aug 2026 23:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786059412; cv=none; b=e/Z//nVWiTA7Zh50kFc6eTpH3yaodmnsN7R4E0nNHKgq5XzBAWa6wKQNubRrBJn+CqYHzEEEroUzwOn6ePfbniQ6I9d/YmCVi2cWv/VKmYg2RNu9q+KxyDn6bIK2wNvysfTTgd2oISYnvENwnnMPCd7CQW8cDzc1CzLy5aBSffo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786059412; c=relaxed/simple;
	bh=YuCMxhXTIsqx6zpcODEUb6qXKu+EziAmx+3M3LR9+3o=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=UMqjNtuqlO6w4VWh6RmdUjsVEshmm0IUNEnoAsVL1ORHyKtGl+Y+VqOMfFA9qNZVZY7y2TYJJ0yqtmCqA9FPz82mN15eiLBtNp2z4jt5kGk2IxrurCcuh1kPzGyEbyW4K0zWQDvZfslompawRrusnopBV54SRe/HfA9lWoaztYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ffcw/IHb; arc=none smtp.client-ip=209.85.216.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ffcw/IHb"
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-38f283baf1fso2571719a91.3
        for <linux-hyperv@vger.kernel.org>; Thu, 06 Aug 2026 16:36:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786059410; x=1786664210; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=eYIjdKzjgH3nVD0iNsx5sVBVp8XFdFFsnkR62+s/p+Q=;
        b=ffcw/IHb9JNHii8DAVND3kK4sXHRWcLf2Ymt82lp6bZ5WK+ETX/RsDZ0CZ3I2qbuZY
         U1nqKPfb3iBjUP46P5s0MvXZnFCObTSMshm5O/wE/OG0okGLv3VLxTF1lJviTG11Jz2l
         jxOfDJ6eD9N7VD5FuAb0ENAYbPXxZZWoi7SRQRneBfP4dKS7zEnfiDNz8yumuvRgWtNF
         Yi3El0FMjQLWpFdPbkVwuz5zq4uIRPv4yMk+r4AEV3mXuR22JMXn3ocP+3GBPpsop7/v
         h2F1nkdCTMs5TC7tDwn2LuWbldls9jKOmAs2Z6G9MUo/yQnp6abVLjmgJWLSTT5KtwMW
         lfaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786059410; x=1786664210;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=eYIjdKzjgH3nVD0iNsx5sVBVp8XFdFFsnkR62+s/p+Q=;
        b=ppXmdQ4H16FyM+ipp8flrq8Pge2VYixZM11Cm4gABxAG8lBZA7fEp7EGabg9A+oQKE
         /xHvyslQthMPoqxEZG8Aucxa4YncVjFxLYej3D2i2uuqZzIOMwPfCrYapJ5ZzG1n0s2j
         a1O3AtQZmfoUwaDDPwu1uUuc2zKIAJtXTMPO1F7g/Ic+2u46z0Qx3ChuAxNSk7zxUFzf
         7Kn+qEjk6iId0MXHPQB2EF9J0sQxxM+0qC7K/RoySXYPgm7fLo1kL7STsJ4Gl17w6UmG
         HOi2gK7Df5s10PEDSXKn4eajYhQIlnAmivvAM6vrNVBQohZL8fzWA0V3rbNrGmIk2R7x
         vvcw==
X-Forwarded-Encrypted: i=1; AHgh+RprkeU29CydMeBfZpb6GyTnGnXMhS3+IHOt9KhtRvbbCZ5nMKLT8Z94kAjmxeUpjgML+DweZ4DVnoQ2ims=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeT0heqpLtTmwd9S+WFGVH8IBS1Bx138tZ65Y7b8buYEdkHHRD
	i7mMDhWr9yT2J8YiUMN3ACx1/9yyS0fvXTc8T7SMX2xHgJep/WdgBnTRjTUqCL++M25V7Yo0ke5
	nhc4zkQ==
X-Received: from pjji3.prod.google.com ([2002:a17:90a:6503:b0:381:224:393a])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:c106:b0:38e:250b:122f
 with SMTP id 98e67ed59e1d1-3909d8d5993mr5453558a91.16.1786059409368; Thu, 06
 Aug 2026 16:36:49 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu,  6 Aug 2026 16:35:37 -0700
In-Reply-To: <20260806233609.212337-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260806233609.212337-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.679.g6767b8d81c-goog
Message-ID: <20260806233609.212337-21-seanjc@google.com>
Subject: [PATCH v6 20/51] KVM: x86: Officially define CPUID 0x40000010 as PV
 Timing Info (TSC and Bus)
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

From: David Woodhouse <dwmw@amazon.co.uk>

Formally define and document CPUID 0x40000010 as providing TSC and local
APIC bus frequency information for KVM's PV CPUID range.  Way back in
2008, VMware proposed (https://lkml.org/lkml/2008/10/1/246) carving out a
range of CPUID leaves for use by hypervisors.  While the broader proposal
from VMware was mostly shot down in flames, use of CPUID 0x40000010 to
provide TSC and local APIC bus frequency information survived and made it's
way into multiple guest operating systems.

XNU unconditionally assumes CPUID 0x40000010 contains the frequency
information, if it's present on any hypervisor:

  https://github.com/apple/darwin-xnu/blob/main/osfmk/i386/cpuid.c

As does FreeBSD:

  https://github.com/freebsd/freebsd-src/commit/4a432614f68

More importantly, QEMU (the de facto "reference" VMM for KVM) has
conditionally provided timing information in CPUID 0x40000010 for almost
9 years, since commit 9954a1582e ("x86-KVM: Supply TSC and APIC clock
rates to guest like VMWare").

So at this point it would be daft for KVM (or any hypervisor) to expose
0x40000010 for any *other* content.  Officially carve out and define the
CPUID leaf so that Linux-as-a-guest can follow suit and pull TSC and Local
APIC Bus frequency information from CPUID.

Defer providing userspace with the necessary information needed to
precisely and accurately enumerate the _actual_ configured TSC frequency
to the guest (that exact information, along with the scaled ratio, isn't
exposed to userspace).  As evidenced by QEMU, providing CPUID 0x40000010
without help from KVM is entirely possible, just not ideal.

Link: https://lore.kernel.org/all/ea0d7f43d910cee9600b254e303f468722fa355b.camel@infradead.org
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
[sean: drop KVM filling of CPUID, add documentation, massage changelog]
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 Documentation/virt/kvm/x86/cpuid.rst | 12 ++++++++++++
 arch/x86/include/uapi/asm/kvm_para.h | 11 +++++++++++
 2 files changed, 23 insertions(+)

diff --git a/Documentation/virt/kvm/x86/cpuid.rst b/Documentation/virt/kvm/x86/cpuid.rst
index bda3e3e737d7..a5ee8ff052ce 100644
--- a/Documentation/virt/kvm/x86/cpuid.rst
+++ b/Documentation/virt/kvm/x86/cpuid.rst
@@ -122,3 +122,15 @@ KVM_HINTS_REALTIME 0            guest checks this feature bit to
                                 preempted for an unlimited time
                                 allowing optimizations
 ================== ============ =================================
+
+function: KVM_CPUID_TIMING_INFO (0x40000010)
+
+returns::
+
+   eax = (Virtual) TSC frequency in kHz
+   ebx = (Virtual) Bus (local APIC timer) frequency in kHz
+   ecx = 0 (Reserved)
+   edx = 0 (Reserved)
+
+Note, KVM only defines the semantics of KVM_CPUID_TIMING_INFO; KVM does NOT
+advertise support via KVM_GET_SUPPORTED_CPUID.
diff --git a/arch/x86/include/uapi/asm/kvm_para.h b/arch/x86/include/uapi/asm/kvm_para.h
index a1efa7907a0b..c3a384711f3a 100644
--- a/arch/x86/include/uapi/asm/kvm_para.h
+++ b/arch/x86/include/uapi/asm/kvm_para.h
@@ -44,6 +44,17 @@
  */
 #define KVM_FEATURE_CLOCKSOURCE_STABLE_BIT	24
 
+/*
+ * The timing information leaf provides TSC and local APIC timer frequency
+ * information to the guest.  Note, userspace is responsible for filling the
+ * leaf with the correct information.
+ *
+ *  # EAX: (Virtual) TSC frequency in kHz.
+ *  # EBX: (Virtual) Bus (local APIC timer) frequency in kHz.
+ *  # ECX, EDX: Reserved (must be zero).
+ */
+#define KVM_CPUID_TIMING_INFO	0x40000010
+
 #define MSR_KVM_WALL_CLOCK  0x11
 #define MSR_KVM_SYSTEM_TIME 0x12
 
-- 
2.55.0.679.g6767b8d81c-goog


Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99F074A8C6A
	for <linux-hyperv@vger.kernel.org>; Thu,  6 Aug 2026 23:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786059429; cv=none; b=RXGYCQDzYdRA20QJfmzilZW+fX2b5Nhz+VNQ48fqbgkeunIVrbb2xlbGtR77I9yQWFjoWpfCThUVq7mzeRkwFFc3D1fC7Vw2MOGiox12NO/asqIVOmXbMmiUBHD6z09bLs1n+xR4woU1P19JzivLeXsztXXZKVx1TGomfcC7yXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786059429; c=relaxed/simple;
	bh=oL4k89x+CtNtrtSN/chXxcI7VW6e8o1GiS+d7EOGh0Q=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gAxD1H9MWpa+5W5AQFU/yeouQpD6fBJ1RBp0XLoDoodMSHcox8CaGBtqT1GLf4MzHhfsrXOr7IeGRoQQwwPWnYyvNqnPO9xP4HpCYsDmm19d0aIgkzBAxSDj/etmxukR1BA9Man0wkx+XcDOGrsga/nLzAnmfJXV77g3NuZm/b4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kt10IjlE; arc=none smtp.client-ip=209.85.214.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kt10IjlE"
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2d122bbc621so4929025ad.0
        for <linux-hyperv@vger.kernel.org>; Thu, 06 Aug 2026 16:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786059427; x=1786664227; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=f+UXuTD6z7zajVoSPLixW+N3kzbQtDvz4+hCO4pCJ+c=;
        b=kt10IjlEPSYMAwmb+8BxRvPl3xR9fCb7HCn283P5bBBL99NGuZ8JwWOrvjqTLYyuE7
         08v/WZP/kUv+rfr3lARtq/VUHbsYimPFyTuZMrynWxxn+IY1lAEN1yriQp4yicZ6rrNm
         ngH5+vAXawVbRGz7X1a01/zIN/rFnBAPgktW/c22V/i31Eh8au6yJeg9E3aVB8KNSy5w
         eF4xkFnZevrMdUg06k1wNsNHXumiyJ9Ph+JoxmUTpVEOcPd8FF6D4yGNnCaUdEufwZ2O
         xICH+Bd7TyKgH9DfkWpkEeLCwBhDe7PPzMkMZrXJgjKjxU9kUi2sQib1gXKggBhLOB6n
         yD9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786059427; x=1786664227;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=f+UXuTD6z7zajVoSPLixW+N3kzbQtDvz4+hCO4pCJ+c=;
        b=SHXKq+3cjmDu1ZNVeIAwbP31QRFclNr/GTFvw0k263ILxDhw5c99ycmgvDd0t3Ahly
         qgk6KP3N5DfZXLd1af08+yiHwtWOfvhhU3r/dGXuahoJIIBpbStYuAqsyVAviDjc4LkZ
         n4XcbM6rbjMorTXqptMo7N/9/irYl4Zn2CfgOVFIqdCiVcxtIa3VFYtxfYZiNNWtT/wp
         Zm1HgjF+UlW5NyNOohCJLbqJIlVUEGvBKAluZDW8ENa6M+SLW3yitKGPa3ELuK9/qWnc
         JGY3q9P4R/AEPBpQqGwIME1jkY1jtuTQy4rFaXfAQbaD9dbVe0TDNUJN9UIzx7LOLPnV
         k/bQ==
X-Forwarded-Encrypted: i=1; AHgh+RoAZ/ukGNUPwe5XoHNYToLakz3v6KA76zBdHOJqhWWl9S11Gb/GWzT2s0DeceTyiqC2gkzxFbZ9s9qypQQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIPS/vdqtbLwxLpW+QtTKHbhTdd+dOy7ykXWjzevaKLh5Sb+WB
	1m3JHr1GNCAPO318RehUz7dVU9taI2WVDO2qc/WfQZOIKfSNeXosyf9Bx6+bEJY7Wqg5n9KzMyG
	HqKO4Dg==
X-Received: from plbi11.prod.google.com ([2002:a17:903:20cb:b0:2cc:6da3:442d])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:f546:b0:2cc:aa36:c046
 with SMTP id d9443c01a7336-2d0ca77ece3mr197228075ad.14.1786059426608; Thu, 06
 Aug 2026 16:37:06 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu,  6 Aug 2026 16:35:51 -0700
In-Reply-To: <20260806233609.212337-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260806233609.212337-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.679.g6767b8d81c-goog
Message-ID: <20260806233609.212337-35-seanjc@google.com>
Subject: [PATCH v6 34/51] x86/vmware: NOP-ify save/restore hooks when using
 VMware's sched_clock
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

NOP-ify the sched_clock save/restore hooks when using VMware's version of
sched_clock.  This will allow extending paravirt_set_sched_clock() to set
the save/restore hooks, without having to simultaneously change the
behavior of VMware guests.

Note, it's not at all obvious that it's safe/correct for VMware guests to
do nothing on suspend/resume, but that's a pre-existing problem.  Leave it
for a VMware expert to sort out.

Reviewed-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kernel/cpu/vmware.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/vmware.c b/arch/x86/kernel/cpu/vmware.c
index cbe8b59ab79f..94fec990a02c 100644
--- a/arch/x86/kernel/cpu/vmware.c
+++ b/arch/x86/kernel/cpu/vmware.c
@@ -347,8 +347,11 @@ static void __init vmware_paravirt_ops_setup(void)
 
 	vmware_cyc2ns_setup();
 
-	if (vmw_sched_clock)
+	if (vmw_sched_clock) {
 		paravirt_set_sched_clock(vmware_sched_clock);
+		x86_platform.save_sched_clock_state = x86_init_noop;
+		x86_platform.restore_sched_clock_state = x86_init_noop;
+	}
 
 	if (vmware_is_stealclock_available()) {
 		has_steal_clock = true;
-- 
2.55.0.679.g6767b8d81c-goog


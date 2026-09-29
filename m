Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AB623D34B5
	for <linux-hyperv@vger.kernel.org>; Tue, 29 Sep 2026 01:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790646582; cv=none; b=IddRpdMxmoOUQyIjOx/zjHVMigNlk64bbi57iUsuOnjIgcZLoJfZfZN97THllAtaeJXGlagpWtQouIeZVQ7xrJ9PfTpcghtzUiokDRy5FqYy6iYyjQGIefnqQTPCjlW3zRe8GxSArUovroh2j96vMGFdjpc2cU5FnJsNddcTgsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790646582; c=relaxed/simple;
	bh=2uXsmCNKJ3fYrAUlJcM4AoeiTbwzMEpZN5UMc742K0c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ku911qI1zAgO6pKFTfyDk9RW8xfIizebnFFi6dYlyq07f6ni6sIGKKJ/2vs86Myzd8p6OxQpCU19hoVHmjppsYUgX0xHiIerfY1pStsLNHqO6q/V/1xf0FIpunf3aDezMf3aM5+tqoM8d11Mg46htJizRgcxqy0xuZCbzjKpYgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tb4O1rEj; arc=none smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tb4O1rEj"
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-3115c4451c8so345365eec.1
        for <linux-hyperv@vger.kernel.org>; Mon, 28 Sep 2026 18:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790646577; x=1791251377; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hUAmCu4dLAGCxw6PilbDzbZb7iwIhzniJHAXg+eRF9A=;
        b=Tb4O1rEjfylcgc+HRcs8W4FO7UcL01xzzfVCZ8mIQB2V361IynDG+K8bes2xvhAMmP
         dwtD1C9mbrsTsiUw35MEYyGyE1D/VVSbE+E+fto7CeyifjMeSML7GGFMLeqVIju8dBBG
         RgBaWH+TLTMPd7UJCfgTBmGxr+c71yc+YqVap2OqjpmEeCv3tz39nLkW45NwtB2gwArA
         +A6AqG+ci+kKfSbQtv9JZGePk8yRfEPGL5bBVFwaw6JEZCcp312U2W25HbDzERujKtsG
         0/4levkYtsWI8zmcBGP36ARpJX3D3vR7kSPObcQ//5wK4pKheNs51i5sEJDPf+YWFdBJ
         Pa3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790646577; x=1791251377;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=hUAmCu4dLAGCxw6PilbDzbZb7iwIhzniJHAXg+eRF9A=;
        b=eSXEu2PN918qJMgB1ryunDg7eEkRsNVQiWCjhpXeecBGt8bJRwZ+vi4q0gvL1imOQo
         jeXxa8y4KGQVOx5i+vEA9K26yijrwsNnKwR3SNCw4MtuIjbGLKXyg9Mu0gb4uJ73l+7d
         Stu0mVO1y+NZQhwJ2R3GpEioic7JYTyUkWIFJUYfM+WD/dYSlq0FZnmsqNPkgxGXfroU
         yiRqREbCB/BfO+nDm53gh8LoHCtyq2sV+OVFpUDtknm8Ny4q8K6wyWeOB88/pGcWVWee
         hasaTK5FNHCIpMSXi/JnruuPbkxavVtw/VHV3vKx2JBPJ96KLBOLa4TZLvzc1Oe3nc/h
         L28A==
X-Forwarded-Encrypted: i=1; AKwUvByGEp3tobV8lRbGWDkEWfOfRCQ7ROH9Tzn13Mandp4UmOtK/WwRdtgfNrai5rwh1QhRP2J05eoxZk3sU8M=@vger.kernel.org
X-Gm-Message-State: AFq9FYLjKN2Dcj207yz/1joRgPllklGpvukG9R1XF69EJnB+rIbb0tPO
	k/s7RuExfn1vY/4jd5FKZoNOWDNx6Dxpbg12t5l3WK7y66UUIhwlJ6ie
X-Gm-Gg: AYBFou01mNw2iQ9iuk32HrN7z7lVZ8yQ5pTfBUn4/8sC5oE5tCE7ZSiCZPmo9wY2ny1
	g34kbguPX3gL1YUJnDBFLOOk+R01rlxh1k4Kd71kyQvKtqomd2R8FD2stw7qe/7Vc2srXbWJOqJ
	CJwaDYnrFpNuCowsZdlAU5aAewOVZGBPKZv4UwW1pilekd0dzb86fdcrgHh/c/50/j3fSDTNZXy
	WLhA0HMnhi/htJmdpwMkZa9y8t/v9yOuLdb1DkntZwwvuGhB3FaLPw9ou2j4UwixkF1j9LiLB0w
	Ccai99gOTB264YHeQTj7ojMlAODgmYon+OiwIwXGFyRaJRHwL84J/iozb9uontc26DhXkyHpZRQ
	3dqEvxSY2D5cjrdye8swGQ71b3kEu3FV/ttBvZgJ8eF27ulC3aBeGZ3ogYa/1O5rVLPgJ17gsAB
	SjP4Pw9AUIj3N99mWiqhl1rDW7NWcHBBvC+G3Zh2TXU26WOGFyfZ7Kbyuoerf0cuLDstMsLU7gl
	zovd7B8dYd8SA==
X-Received: by 2002:a05:693c:4195:20b0:332:946c:477a with SMTP id 5a478bee46e88-34af8931057mr1416634eec.16.1790646576536;
        Mon, 28 Sep 2026 18:49:36 -0700 (PDT)
Received: from wujing.localdomain ([23.254.208.9])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3434958c3adsm40351662eec.22.2026.09.28.18.49.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 18:49:36 -0700 (PDT)
From: Qiliang Yuan <odys.yuan@gmail.com>
To: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>
Cc: Qiliang Yuan <odys.yuan@gmail.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>,
	linux-hyperv@vger.kernel.org
Subject: Re: [PATCH v2] KVM: x86: Clear CR3[63:32] on SMM entry when running on Hyper-V
Date: Tue, 29 Sep 2026 09:49:27 +0800
Message-ID: <20260929014927.151141-1-odys.yuan@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260929-kvm-smm-cr3-upper-bits-v2-1-622429d0cd3c@gmail.com>
References: <20260929-kvm-smm-cr3-upper-bits-v2-1-622429d0cd3c@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some more data on this, in case it helps either the KVM or the Hyper-V
side.  It is also tracked, with the WSL logs, at
https://github.com/microsoft/WSL/issues/41709


1. Setup
--------

  Host:   Windows 11 Pro 25H2, OS build 26200.9457 (fully up to date
          through Windows Update), WSL 2.9.3.0, AMD Ryzen 9 7940HX
  L1:     WSL2 kernel 6.18.35.2-microsoft-standard-WSL2, kvm_amd nested=1
  L2:     Windows 11 25H2 guest, q35, 4 vCPUs, 8GiB RAM,
          OVMF_CODE_4M.ms.fd (Secure Boot, SMM), swtpm,
          QEMU 10.2.1, libvirt 12.0.0

Wei mentioned that this may already be fixed in Hyper-V.  Since it
still reproduces on the latest released build above, the fix does not
seem to be in released builds yet.  Which build or channel carries it?
I am happy to test it.


2. Not a recent regression
--------------------------

The libvirt log of this guest on the same machine shows the same
"KVM: entry failed, hardware error 0xffffffff" going back a year:

  WSL kernel                    Period                    Boots  Failures
  5.15.167.4-microsoft-...      2025-09-01 .. 2025-10-01    127       133
  6.18.35.2-microsoft-...       2026-09-24 .. 2026-09-28     15        21
  6.18.35.2 + this patch (v2)   2026-09-29                    1         0


3. Testing of v2
----------------

I applied v2 to the WSL2 6.18.35.2 kernel and traced enter_smm() with
bpftrace, recording vcpu->arch.cr3 on entry and on return, while the
guest booted from firmware to the Windows desktop with SMM and Secure
Boot enabled:

  SMM entries in total:                        7532
  entries with CR3 above 4GiB before entry:    1185
  of those, CR3[63:32] cleared on return:      1185
  VMRUN failures:                                 0

For example:

  vcpu=1 cr3 before=0x13aa12000 after=0x3aa12000

Every one of those 1185 entries would have hit the failure without the
patch, and the guest returned from SMM normally in all cases.


4. The rejected VMCB
--------------------

To capture the failing state without restarting WSL, I built an
unpatched kvm.ko/kvm-amd.ko for the same running kernel, loaded them
with kvm_amd.dump_invalid_vmcb=1 and booted the guest.  It failed at
SMM entry again, with CR3 above 4GiB.

The relevant fields are exit_code ffffffff, rip 8000 (first instruction
of the SMI handler), cr0 00050032 (PE=0, PG=0), efer 00001000 (SVME
only, LMA=0), event_inj 0 (no pending event), and cr3 0000000262906000,
i.e. CR3[63:32] = 0x2 outside of long mode.  The full dump:

  SVM vCPU1 VMCB 000000004a03e896, last attempted VMRUN on CPU 2
  VMCB Control Area:
  cr_read:            0010
  cr_write:           0010
  dr_read:            00ff
  dr_write:           00ff
  exceptions:         00060042
  intercepts:         bddc8027 00006e7f
  pause filter count: 3000
  pause filter threshold:128
  iopm_base_pa:       000000034604c000
  msrpm_base_pa:      00000003d50da000
  tsc_offset:         ffffbe16edc138b1
  asid:               8
  tlb_ctl:            0
  int_ctl:            01000000
  int_vector:         00000000
  int_state:          00000000
  exit_code:          ffffffff
  exit_info1:         0000000000000000
  exit_info2:         0000000000000000
  exit_int_info:      00000000
  exit_int_info_err:  00000000
  nested_ctl:         1
  nested_cr3:         0000000260eac000
  avic_vapic_bar:     0000000000000000
  ghcb:               0000000000000000
  event_inj:          00000000
  event_inj_err:      00000000
  virt_ext:           0
  next_rip:           0000000000000000
  avic_backing_page:  0000000000000000
  avic_logical_id:    0000000000000000
  avic_physical_id:   0000000000000000
  vmsa_pa:            0000000000000000
  allowed_sev_features:0000000000000000
  guest_sev_features: 0000000000000000
  VMCB State Save Area:
  es:   s: 0000 a: 0893 l: ffffffff b: 0000000000000000
  cs:   s: fb00 a: 0893 l: ffffffff b: 000000007bffb000
  ss:   s: 0000 a: 0893 l: ffffffff b: 0000000000000000
  ds:   s: 0000 a: 0893 l: ffffffff b: 0000000000000000
  fs:   s: 0000 a: 0893 l: ffffffff b: 0000000000000000
  gs:   s: 0000 a: 0893 l: ffffffff b: 0000000000000000
  gdtr: s: 0000 a: 0000 l: 00000057 b: ffff9a0133f5ffb0
  ldtr: s: 0000 a: 0000 l: 00000000 b: 0000000000000000
  idtr: s: 0000 a: 0000 l: 00000000 b: 0000000000000000
  tr:   s: 0040 a: 008b l: 00000067 b: ffff9a0133f5e000
  vmpl: 0   cpl:  0               efer:          0000000000001000
  cr0:            0000000000050032 cr2:          ffffe7888c4ec690
  cr3:            0000000262906000 cr4:          0000000000000040
  dr6:            00000000ffff0ff0 dr7:          0000000000000400
  rip:            0000000000008000 rflags:       0000000000000002
  rsp:            ffffbf0c30b864d8 rax:          0000000000000000
  s_cet:          0000000000000000 ssp:          0000000000000000
  isst_addr:      0000000000000000
  star:           0023001000000000 lstar:        fffff801b9ac1840
  cstar:          fffff801b9ac1300 sfmask:       0000000000004700
  kernel_gs_base: 000000caa8494000 sysenter_cs:  0000000000000000
  sysenter_esp:   0000000000000000 sysenter_eip: 0000000000000000
  gpat:           0007010600070106 dbgctl:       0000000000000000
  br_from:        0000000000000000 br_to:        0000000000000000
  excp_from:      0000000000000000 excp_to:      0000000000000000
  rax:            0000000000000000 rbx:          fffff8014d990018
  rcx:            00000000000000b2 rdx:          00000000000000b2
  rsi:            0000000000000200 rdi:          0000000000000218
  rbp:            ffffbf0c30b86500 rsp:          ffffbf0c30b864d8
  r8:             0000000000000000 r9:           0000000000000000
  r10:            0000000000000000 r11:          ffff89fdab000000
  r12:            ffffbf0c30b86720 r13:          fffff8014d990060
  r14:            fffff8014d990078 r15:          0000000000000002

And QEMU's view of the same vCPU (it only prints CR3[31:0] here):

  KVM: entry failed, hardware error 0xffffffff
  EAX=00000000 EBX=4d990018 ECX=000000b2 EDX=000000b2
  ESI=00000200 EDI=00000218 EBP=30b86500 ESP=30b864d8
  EIP=00008000 EFL=00000002 [-------] CPL=0 II=0 A20=1 SMM=1 HLT=0
  ES =0000 00000000 ffffffff 00809300
  CS =fb00 7bffb000 ffffffff 00809300
  SS =0000 00000000 ffffffff 00809300
  DS =0000 00000000 ffffffff 00809300
  FS =0000 00000000 ffffffff 00809300
  GS =0000 00000000 ffffffff 00809300
  LDT=0000 00000000 00000000 00000000
  TR =0040 33f5e000 00000067 00008b00
  GDT=     33f5ffb0 00000057
  IDT=     00000000 00000000
  CR0=00050032 CR2=8c4ec690 CR3=62906000 CR4=00000000
  DR0=0000000000000000 DR1=0000000000000000 DR2=0000000000000000 DR3=0000000000000000
  DR6=00000000ffff0ff0 DR7=0000000000000400
  EFER=0000000000000000
  Code=00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 <bb> 4d 80 2e a1 38 fb 48 2e 89 07 2e 66 a1 30 fb 2e 66 89 47 02 2e 66 0f 01 17 b8 08 00 2e


Thanks,
Qiliang

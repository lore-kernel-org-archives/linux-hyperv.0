Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6BD22ECE86
	for <linux-hyperv@vger.kernel.org>; Sat, 10 Oct 2026 06:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791614344; cv=none; b=JxdMEdYDpqqZVeK3xwKsWGLKkjBD9iDWfYgxIzgX1yCtGfgylueom62Int9z16n7CLGK48z3hW6Dtua9Ku+RUfRyc8mbtOEMy+A110x+eRGxUs9+1ZFj+gi9GUH+xfetNCAGt6D6jocNNLp8ve2R9JuH77U7R8gks+E1dJO70UA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791614344; c=relaxed/simple;
	bh=VvOZFRNFzU74rD5N53fUE0BweZFT9ojM7Gn6WcwaBcc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=paeHb0PO0sxmnzDhUF5HktFcCuQIXOfZqeuBuHOBCjQ0ntRdw9Z/Oborb+yGh8clFqq40xqCLrQTXOHNSxIY/45cvxz8yiGMDt5nj7H6Jbj+BtOFb+CNNrDJqd0Y2XUnQTIUd4UBTLQKK6Qofon4sItNPYuCEFz4NPKbK5nO6t8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PYohm2Kh; arc=none smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PYohm2Kh"
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-3514b90bb89so621776eec.1
        for <linux-hyperv@vger.kernel.org>; Fri, 09 Oct 2026 23:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791614342; x=1792219142; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NNoJDUVAf5Gpl9HS5Mt5Zrcl3KNe8tjD3dUpaLRXafE=;
        b=PYohm2KhLBOHoCXVEEmb54/573meXQO9Dm4t2BK41sI3RqmNg3o5FdIg+TaRhfqBkU
         fKh1Q7BObz5oIDw8mWPWDgc9ibTJOGUGE6mZ/ozPm6Z6Hrzz63qU146dCQVOVLzh7z4E
         9Pavl47Nm0XMJ+u02GTK1NUyAWzNvDLm1LZ9lY9xC8WvEnuBxa44Ej6OWimnKTAIyI/Y
         mY+LLqQLM1bkZSQkC33FV8xRn/sGtosqGMZH/7WXbaCL1xWrsXly0GmM5kqpY39Oi/EU
         PqqcYHLHK81wsgHh1e3KkIIaXM4M21wcpJ1631HbbyEuSyaSGMO7wbB1nPSpe4PzSiGV
         zR7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791614342; x=1792219142;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=NNoJDUVAf5Gpl9HS5Mt5Zrcl3KNe8tjD3dUpaLRXafE=;
        b=ExGdscBxVXfefQehzsPG5Ik59Wydhb+i4FwM2k5v9/9FSXiG1gXIKZ0Oz9B3WNqSg4
         X0xvr5RdjM3o9rimgkoRKM5y+TnGPHdQujyuMTzNJ+i2mIOU/siNiJASIn1p6hn+hLlh
         NhP9Vi91J9zAKZeK8PhnbGesm4WT8XO6gBtVdKV+lbhz6l5c1pjTS85m+BDDU3XoXNr2
         CzZ3U7sltkxbij0nTvq+G69j/AyJZdRwArpyazbpqtARCyxBVOl5JZ6KqqFeEySp06sk
         Ssxke5W2SaTkgYjIhgJH/zFEnOAw0cTxwSl0oE1FgWYgKf9+DdFwWlCOBytX5rJ7F01U
         niKQ==
X-Forwarded-Encrypted: i=1; AKwUvBwZp8+h02Xu2nyzGRzTnkhidpxBVlIQ9QxVM/sTvZreOUyTgeL6TeuuBHHWj7jh+tIv6gprXPZEdoK0dDA=@vger.kernel.org
X-Gm-Message-State: AFq9FYJac6qRP4BTms+6t/hEM37ryxILfUFrK32aEAfcrfKliKligcSp
	uO0rcRxsoO9Aj7yTNbqB7JLqdvea+TqHy+Ft5cAg97GdAsjoXRQgxfXS
X-Gm-Gg: AYBFou36quuXFPS73jvFJcqk84MhSMUnogfkCZ5PsyIj5G+C+a7g3/QRKg8xJ9bD8Vg
	4Jm6qLmEVSOXNJuHTcG5Z3jx618Ux4+1xyeHVjQlIq/SJjuY3jWqEWurbPAIds2REu/tBvO9XCz
	6PXqjAQAf8AbQMFcONxgpC6o+a+YEf2zTxP7iF3E1W4SZlN3LMQABY4PJ3FMh/irDVp/gtwcuxE
	eO07KFe6dhOef67SE8wL1RVPJM/2lmIGgtG9ZLl2JDEPv5nptc9FferMr2l+F5Id9FeFmo3npxS
	1QcgLQr5E0X7xGN9t7tyLbCbDzGnYulu3T21uGLN/Wmm8EaTRbQUvnVhF6KKeIm3Yga6eA91tiR
	rbVcDu4ZNeMMXw/PH+2jjTe2hj6c1Mux18KJqgAcEPkfBWNp+19NQsWEmvdmVkljgWfC9cSP7Qi
	S6efU2Wa7IzYvFaatrZjjxc5yurVCzO5DSeYybrMZnKSLfzTMOHs+Awq/m4zeQCmcOkpqWZutCv
	W4=
X-Received: by 2002:a05:7301:182a:b0:34d:7ae5:8d78 with SMTP id 5a478bee46e88-3537e034fecmr5436058eec.31.1791614341854;
        Fri, 09 Oct 2026 23:39:01 -0700 (PDT)
Received: from wujing.localdomain ([23.254.208.9])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537cb1e05esm12615419eec.25.2026.10.09.23.38.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 23:39:01 -0700 (PDT)
From: Qiliang Yuan <odys.yuan@gmail.com>
To: Wei Liu <wei.liu@kernel.org>,
	Sean Christopherson <seanjc@google.com>
Cc: Qiliang Yuan <odys.yuan@gmail.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>,
	linux-hyperv@vger.kernel.org
Subject: Re: [PATCH v2] KVM: x86: Clear CR3[63:32] on SMM entry when running on Hyper-V
Date: Sat, 10 Oct 2026 14:38:53 +0800
Message-ID: <20261010063853.4109-1-odys.yuan@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260929014927.151141-1-odys.yuan@gmail.com>
References: <20260929-kvm-smm-cr3-upper-bits-v2-1-622429d0cd3c@gmail.com> <20260929014927.151141-1-odys.yuan@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Wei, Sean,

Wei, on the v1 thread
(https://lore.kernel.org/r/20260930014222.GA4053400@liuwe-devbox-debian-v2.local):

On Tue, Sep 29, 2026 at 06:42:22PM -0700, Wei Liu wrote:
> On Tue, Sep 29, 2026 at 08:57:55AM +0800, Qiliang Yuan wrote:
> > This machine is fully up to date through Windows Update, and the failure
> > reproduces on this build, so the fix does not seem to have reached the
> > released builds yet.  Which build or channel (e.g. Insider) carries it?
> > I am happy to test it.
>
> Windows 11 Pro, version 26H1 should have the fix.

I upgraded and retested.  The failure still reproduces on 26H2:

  Host:   Windows 11 Pro 26H2, OS build 26300.9457, WSL 3.0.1.0,
          AMD Ryzen 9 7940HX
  L1:     stock WSL2 kernel 6.18.40.1-microsoft-standard-WSL2
          (no patch), kvm_amd nested=1, dump_invalid_vmcb=1
  L2:     same Windows 11 guest as before, 8GiB RAM,
          OVMF_CODE_4M.ms.fd (Secure Boot, SMM)

I traced enter_smm() with bpftrace while the guest booted.  Of 3960
SMM entries, the 3959 with CR3 below 4GiB all went through; the first
and only one with CR3 above 4GiB was rejected, about 20 seconds after
the guest started:

  SMM entries in total:                        3960
  entries with CR3 above 4GiB before entry:       1
  VMRUN failures:                                 1

The rejected VMCB has the same signature as on 25H2: exit_code
ffffffff, rip 8000, cr0 00050032 (PE=0, PG=0), efer 00001000 (SVME
only, LMA=0), event_inj 0, and cr3 0000000269905000, i.e. CR3[63:32]
= 0x2 outside of long mode.  The full dump:

  SVM vCPU0 VMCB 00000000ed0da17d, last attempted VMRUN on CPU 19
  VMCB Control Area:
  cr_read:            0010
  cr_write:           0010
  dr_read:            00ff
  dr_write:           00ff
  exceptions:         00060042
  intercepts:         bddc8037 00006e7f
  pause filter count: 12000
  pause filter threshold:128
  iopm_base_pa:       0000000104fcc000
  msrpm_base_pa:      00000001046ec000
  tsc_offset:         ffffffdb30e59e26
  asid:               8
  tlb_ctl:            0
  int_ctl:            010f0100
  int_vector:         00000000
  int_state:          00000000
  exit_code:          ffffffff
  exit_info1:         0000000000000000
  exit_info2:         0000000000000000
  exit_int_info:      00000000
  exit_int_info_err:  00000000
  nested_ctl:         1
  nested_cr3:         0000000143167000
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
  cs:   s: f900 a: 0893 l: ffffffff b: 000000007bff9000
  ss:   s: 0000 a: 0893 l: ffffffff b: 0000000000000000
  ds:   s: 0000 a: 0893 l: ffffffff b: 0000000000000000
  fs:   s: 0000 a: 0893 l: ffffffff b: 0000000000000000
  gs:   s: 0000 a: 0893 l: ffffffff b: 0000000000000000
  gdtr: s: 0000 a: 0000 l: 00000057 b: fffff8002daaffb0
  ldtr: s: 0000 a: 0000 l: 00000000 b: 0000000000000000
  idtr: s: 0000 a: 0000 l: 00000000 b: 0000000000000000
  tr:   s: 0040 a: 008b l: 00000067 b: fffff8002daae000
  vmpl: 0   cpl:  0               efer:          0000000000001000
  cr0:            0000000000050032 cr2:          ffffe70bdbcf9000
  cr3:            0000000269905000 cr4:          0000000000000040
  dr6:            00000000ffff0ff0 dr7:          0000000000000400
  rip:            0000000000008000 rflags:       0000000000000002
  rsp:            fffffb04e7d867a8 rax:          0000000000000000
  s_cet:          0000000000000000 ssp:          0000000000000000
  isst_addr:      0000000000000000
  star:           0023001000000000 lstar:        fffff8009b4c1840
  cstar:          fffff8009b4c1300 sfmask:       0000000000004700
  kernel_gs_base: 00000076d3730000 sysenter_cs:  0000000000000000
  sysenter_esp:   0000000000000000 sysenter_eip: 0000000000000000
  gpat:           0007010600070106 dbgctl:       0000000000000000
  br_from:        0000000000000000 br_to:        0000000000000000
  excp_from:      0000000000000000 excp_to:      0000000000000000
  rax:            0000000000000000 rbx:          fffff8002f390018
  rcx:            00000000000000b2 rdx:          00000000000000b2
  rsi:            0000000000000200 rdi:          0000000000000218
  rbp:            fffffb04e7d867d0 rsp:          fffffb04e7d867a8
  r8:             0000000000000000 r9:           0000000000000000
  r10:            0000000000000000 r11:          ffffc6fbf1200000
  r12:            fffffb04e7d869f0 r13:          fffff8002f390060
  r14:            fffff8002f390078 r15:          0000000000000002

And QEMU's view of the same vCPU (it only prints CR3[31:0] here):

  KVM: entry failed, hardware error 0xffffffff
  EAX=00000000 EBX=2f390018 ECX=000000b2 EDX=000000b2
  ESI=00000200 EDI=00000218 EBP=e7d867d0 ESP=e7d867a8
  EIP=00008000 EFL=00000002 [-------] CPL=0 II=0 A20=1 SMM=1 HLT=0
  ES =0000 00000000 ffffffff 00809300
  CS =f900 7bff9000 ffffffff 00809300
  SS =0000 00000000 ffffffff 00809300
  DS =0000 00000000 ffffffff 00809300
  FS =0000 00000000 ffffffff 00809300
  GS =0000 00000000 ffffffff 00809300
  LDT=0000 00000000 00000000 00000000
  TR =0040 2daae000 00000067 00008b00
  GDT=     2daaffb0 00000057
  IDT=     00000000 00000000
  CR0=00050032 CR2=dbcf9000 CR3=69905000 CR4=00000000
  DR0=0000000000000000 DR1=0000000000000000 DR2=0000000000000000 DR3=0000000000000000
  DR6=00000000ffff0ff0 DR7=0000000000000400
  EFER=0000000000000000
  Code=00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 <bb> 4d 80 2e a1 38 fb 48 2e 89 07 2e 66 a1 30 fb 2e 66 89 47 02 2e 66 0f 01 17 b8 08 00 2e

Wei, could you check with your colleague which build actually carries
the fix?  If it is only in 26H1 and not yet in 26H2, that would explain
it.  I am happy to test any build.

Sean, since the latest released build is still affected, would you
consider taking v2 in the meantime?  It only changes behavior when KVM
runs on Hyper-V.

Thanks,
Qiliang

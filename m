Received: from pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com [44.245.243.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE92C43F8CB;
	Mon,  5 Oct 2026 19:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.245.243.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791228284; cv=none; b=ObnuEYc4CESXZl+Pu+Qh8n4Gwv/TGCseOfGSga8ytc1ryK0gEiKRzA0xcvnMdrYuLaPGtQw6tD7VfZs6A9MqXi2FdnxaO5yUVph3m1pln949No7/55HV9pCX01cbKMybEe7TblwYSdPOSEfryr2v59Gl5qnznzLnTAqB0CivkbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791228284; c=relaxed/simple;
	bh=ZDuxZkEDRudg2cgH0lUrTo3aWOvS7stWFQ5QI4bhfog=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=syHN3ZUSSteq9HP26C15n/71Q97YzI8A89nwd5QlhXy7nIpVfAgvXufhGuErTNYDlRV9Oy5tXYrOQ6hkSt5fGFgvxtC/Gda1kMOcXwGdftXSWA/PFZpswpz70VXxutSGuCGp8PKZ/+6S1SZtG7/HD1Caj9+5IvSJ5w/rDS6v2qA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.co.uk; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (2048-bit key) header.d=amazon.co.uk header.i=@amazon.co.uk header.b=RWNJGHd0; arc=none smtp.client-ip=44.245.243.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.co.uk header.i=@amazon.co.uk header.b="RWNJGHd0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.co.uk; i=@amazon.co.uk; q=dns/txt;
  s=amazoncorp2; t=1791228283; x=1822764283;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=acPACm7hsiGbc67MIkc1eWvek1PAKgg9FPPf+dpbngo=;
  b=RWNJGHd0GMRHmRcOcz9xM9eSqBZBAIJPu8vkd5pZYHXUXbDB2zh44uOc
   02m9loL0NLhJH/wSgqQcXv5h8kZfU8K9qAP95QBmfMSFoAEB2ipBBgiSd
   SZDe+dyeDmfh9d0rmnu2VpnLyq0VEs7dPepQukha8XioTY9Bq9pwXvGuO
   Pth8rqc9FLUrC1lhECpPGJDEqNbs33H143DWYi0TcBrr0MYuax0VL/fog
   87reDmjmyR+4Pab/EqbJNb4HR9FS6vVYA/lAVK7gSDgskB1/r1D/13D6h
   8yE/TPBFi3yN1cppg4sl+zLp0JN1e5Q4bsg5QoGcVoTPyRUvrUuc7tVBp
   w==;
X-CSE-ConnectionGUID: X7IWKMG+TFyRkEdIqZr2KA==
X-CSE-MsgGUID: TSsnHHQxTwCGbQ7olK6dVQ==
X-IronPort-AV: E=Sophos;i="6.27,142,1787011200"; 
   d="scan'208";a="29977024"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
  by internal-pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2026 19:24:41 +0000
Received: from EX19MTAUWA001.ant.amazon.com [205.251.233.236:10471]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.52.137:2525] with esmtp (Farcaster)
 id 7bb1d39c-d023-40bc-915d-8c6963cfb816; Mon, 5 Oct 2026 19:24:41 +0000 (UTC)
X-Farcaster-Flow-ID: 7bb1d39c-d023-40bc-915d-8c6963cfb816
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.49;
 Mon, 5 Oct 2026 19:24:41 +0000
Received: from dev-dsk-hmushi-1a-0c348132.eu-west-1.amazon.com
 (172.19.124.218) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.49; Mon, 5 Oct 2026
 19:24:38 +0000
From: Mushahid Hussain <hmushi@amazon.co.uk>
To: <kvm@vger.kernel.org>
CC: Sean Christopherson <seanjc@google.com>, Paolo Bonzini
	<pbonzini@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, "K . Y .
 Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, "Wei
 Liu" <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, Long Li
	<longli@microsoft.com>, <linux-hyperv@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <nh-open-source@amazon.com>,
	<mushi.shar@gmail.com>
Subject: [PATCH 0/3] KVM: x86: Support hibernation of a nested Hyper-V
Date: Mon, 5 Oct 2026 19:24:28 +0000
Message-ID: <20261005192431.87317-1-hmushi@amazon.co.uk>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D033UWC002.ant.amazon.com (10.13.139.196) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

A Windows guest with the Hyper-V role enabled runs its own hypervisor
(hvix64) nested under KVM. When KVM advertises the Hyper-V time and
frequency MSRs, hvix64 lets KVM own the partition reference time. It
then offers hibernation to Windows only if KVM also advertises CPUID
0x40000004 EAX bit 20 (RestoreTimeOnResume), and on resume restores
the saved TSC and reference time through HvCallRestorePartitionTime
(0x103). Both are reserved in the TLFS and defined in Microsoft's
hvdef crate.

Patch 1 fixes a stale nVMX sync flag that zeroed the vmcs12 segment
state hvix64 reloads on resume. It stands alone and is tagged for
stable. Patch 2 is a refactor with no functional change. Patch 3
advertises the bit and implements the hypercall, restoring kvmclock
and every vCPU's TSC inside one pvclock update.

Tested on Windows Server 2025 with Hyper-V running, guest initiated
hibernate and resume, under QEMU with a matching CPU property:
https://github.com/hmushi/qemu/tree/hv-restore-time-on-resume

Mushahid Hussain (3):
  KVM: nVMX: Clear stale vmcs02 sync flag in free_nested()
  KVM: x86: Extract __kvm_set_clock() from kvm_vm_ioctl_set_clock()
  KVM: x86: hyper-v: Implement HvCallRestorePartitionTime

 arch/x86/include/asm/kvm_host.h |   5 ++
 arch/x86/kvm/hyperv.c           |  36 +++++++++
 arch/x86/kvm/vmx/nested.c       |   1 +
 arch/x86/kvm/x86.c              | 131 +++++++++++++++++++++++++++-----
 arch/x86/kvm/x86.h              |   1 +
 include/hyperv/hvgdk_mini.h     |  12 +++
 6 files changed, 168 insertions(+), 18 deletions(-)


base-commit: 6bd2905303c58679e303941b7d8ae8c074cd95ce
-- 
2.47.3


Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBC6933F37A;
	Fri, 27 Mar 2026 20:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774642779; cv=none; b=swy4ODmPEfDkTSQiIlUwdX31UFRN3O3goSpo5Wp2Ouc5Km37An70hfz77ON+WH+faazoId4sLbiFeZql7dzvuRPIUcOj4kaKXBOc7yA8EWyQN1mDmiGVZaDPcE9UiNsrPJrcoNzIOq0s2EcKmI82dcPZXO+cLqZGBnCXrfyFLqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774642779; c=relaxed/simple;
	bh=t2Bt4LiIPR3hMK3DapAAFG9xjxoklX17ELqeNB+HQpQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bxwmzlo890DlF5b5CcIxSFLbTdLHpFpFDf0J6ObY5F9+71jRyV0MbJ28ivVtYzcnJ+wNR/49oof8HioU7wkcApV+/1jZD1AsmzrKiVdcxboJJGMYnnz/YjYY6kRc1jLApCYH84KtRZVQSiKLAcXRjWDGBLr5HzNJm++E0ikmSCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=SXGXx3dm; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="SXGXx3dm"
Received: by linux.microsoft.com (Postfix, from userid 1241)
	id A2E0820B710C; Fri, 27 Mar 2026 13:19:38 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A2E0820B710C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1774642778;
	bh=JXxMEOAFkIGkl3Zik1wmh4KJ3D5FaaVkpFUSnN1XqMA=;
	h=From:To:Cc:Subject:Date:From;
	b=SXGXx3dm8lsIpchDX5xy5+zu/6l1Giel+9xzdTUxjziGPDLEDU+ZfYGWOMJ8Su4Nj
	 BhX9iY53Zxr2OJtaBwa4TI4Z6oE6OnvvURRPK0ZMIYj8tSJ9ZgGnpNX3qa+bdeI6pW
	 iQykqi7rzdboi2McqXQHU+C8xfbqkc/tHNa8iQr0=
From: Jork Loeser <jloeser@linux.microsoft.com>
To: linux-hyperv@vger.kernel.org
Cc: x86@kernel.org,
	"K . Y . Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Roman Kisel <romank@linux.microsoft.com>,
	Michael Kelley <mhklinux@outlook.com>,
	linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org,
	Jork Loeser <jloeser@linux.microsoft.com>
Subject: [PATCH 0/6] Hyper-V: kexec fixes for L1VH (mshv)
Date: Fri, 27 Mar 2026 13:19:11 -0700
Message-ID: <20260327201920.2100427-1-jloeser@linux.microsoft.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series fixes kexec support when Linux runs as an L1 Virtual Host
(L1VH) under Hyper-V, using the MSHV driver to manage child VMs.

1. A variable shadowing bug in vmbus that hides the cpuhp state used
   for teardown.

2. Move hv_stimer_global_cleanup() from vmbus's hv_kexec_handler() to
   hv_machine_shutdown(). This ensures stimer cleanup happens before
   the vmbus unload.

3. LP/VP re-creation: after kexec, logical processors and virtual
   processors already exist in the hypervisor. Detect this and skip
   re-adding them.

4-5. SynIC cleanup: the MSHV driver manages its own SynIC resources
     separately from vmbus. Add proper teardown of MSHV-owned SINTs,
     SIMP, and SIEFP on kexec, scoped to only the resources MSHV
     owns.

6. Debugfs stats pages: unmap the VP statistics overlay pages before
   kexec to avoid stale mappings in the new kernel.

Jork Loeser (6):
  Drivers: hv: vmbus: fix hyperv_cpuhp_online variable shadowing
  x86/hyperv: move stimer cleanup to hv_machine_shutdown()
  x86/hyperv: Skip LP/VP creation on kexec
  mshv: limit SynIC management to MSHV-owned resources
  mshv: clean up SynIC state on kexec for L1VH
  mshv: unmap debugfs stats pages on kexec

 arch/x86/kernel/cpu/mshyperv.c |  15 +++-
 drivers/hv/hv_proc.c           |  47 +++++++++++
 drivers/hv/mshv_debugfs.c      |   7 +-
 drivers/hv/mshv_root_main.c    |  22 ++---
 drivers/hv/mshv_synic.c        | 144 ++++++++++++++++++++++-----------
 drivers/hv/vmbus_drv.c         |   2 -
 include/asm-generic/mshyperv.h |  10 +++
 include/hyperv/hvgdk_mini.h    |   1 +
 include/hyperv/hvhdk_mini.h    |  12 +++
 9 files changed, 190 insertions(+), 70 deletions(-)

-- 
2.43.0


Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35F38332EC8;
	Wed, 21 Jan 2026 02:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768963248; cv=none; b=tgqBbfzrmHxjV5lGx2kCjMLGQXK8C/Ab0zAX3AjXzN4qfB4s2Zc+mB5kgXKmLjhF0A/2zFfxNPVhd16elHOpL3dm5uHg6EyqXdob+841A1uifw49dQCBu3ajjdfw7Hef3cVOVFWmuX2G2Xh3p5gTlIeEbi9de59+wgtDPvNF62o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768963248; c=relaxed/simple;
	bh=En2HW4+UaKjpZS8Kh7qdMgwX3h09E7xgLtKoyYzyLAc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Do6dQks9YLdNlZsFxq1Hmz94cgEENT8rvPz0aErgwfjhK9ls9w2NIPcvfdNNaB2ufzSay8ZaU7DGuLPa7p+koG99Huv8KALqwA5FTLqU7nnakY1ftSeEVTfkpGoAkPkmqvqm0Ua4YVZMyw5OttsiiIkCXilNupg8Ea9rJxwqK5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=ecP9vS5P; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="ecP9vS5P"
Received: from mrdev.corp.microsoft.com (192-184-212-33.fiber.dynamic.sonic.net [192.184.212.33])
	by linux.microsoft.com (Postfix) with ESMTPSA id 82A4720B7167;
	Tue, 20 Jan 2026 18:40:46 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 82A4720B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1768963246;
	bh=CVwJONf59IKX8KA1dnLan/FVVfzrrZSgGi4IehKl2o8=;
	h=From:To:Cc:Subject:Date:From;
	b=ecP9vS5PNiQ8qSE77OFehPJEAfantY8fFYQgOf+Vl+fb1H+WuT8nM8VTj0UtbrHVu
	 Z7QvgaZd8sfZ96MzTxE5jxJOyiXu+FGE7Fts6fGTcBDPdhkSyvoB+meBzcBH/eM/pN
	 /tvfNszGt9s2lEFtXk0+flKA4e5TMFgbw2qUqg+E=
From: Mukesh R <mrathor@linux.microsoft.com>
To: linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: wei.liu@kernel.org
Subject: [PATCH V0] x86/hyperv: Fix compiler warnings in hv_crash.c
Date: Tue, 20 Jan 2026 18:40:45 -0800
Message-ID: <20260121024045.3834787-1-mrathor@linux.microsoft.com>
X-Mailer: git-send-email 2.51.2.vfs.0.1
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix two compiler warnings:
  o smp_ops is only defined if CONFIG_SMP
  o status is set but not explicitly used.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202512301641.FC6OAbGM-lkp@intel.com/
Signed-off-by: Mukesh R <mrathor@linux.microsoft.com>
---
 arch/x86/hyperv/hv_crash.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/hyperv/hv_crash.c b/arch/x86/hyperv/hv_crash.c
index c0e22921ace1..82915b22ceae 100644
--- a/arch/x86/hyperv/hv_crash.c
+++ b/arch/x86/hyperv/hv_crash.c
@@ -279,7 +279,6 @@ static void hv_notify_prepare_hyp(void)
 static noinline __noclone void crash_nmi_callback(struct pt_regs *regs)
 {
 	struct hv_input_disable_hyp_ex *input;
-	u64 status;
 	int msecs = 1000, ccpu = smp_processor_id();
 
 	if (ccpu == 0) {
@@ -313,7 +312,7 @@ static noinline __noclone void crash_nmi_callback(struct pt_regs *regs)
 	input->rip = trampoline_pa;
 	input->arg = devirt_arg;
 
-	status = hv_do_hypercall(HVCALL_DISABLE_HYP_EX, input, NULL);
+	hv_do_hypercall(HVCALL_DISABLE_HYP_EX, input, NULL);
 
 	hv_panic_timeout_reboot();
 }
@@ -628,8 +627,9 @@ void hv_root_crash_init(void)
 	if (rc)
 		goto err_out;
 
+#ifdef CONFIG_SMP
 	smp_ops.crash_stop_other_cpus = hv_crash_stop_other_cpus;
-
+#endif
 	crash_kexec_post_notifiers = true;
 	hv_crash_enabled = true;
 	pr_info("Hyper-V: both linux and hypervisor kdump support enabled\n");
-- 
2.51.2.vfs.0.1


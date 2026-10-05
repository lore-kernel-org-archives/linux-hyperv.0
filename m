Received: from pdx-out-003.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-003.esa.us-west-2.outbound.mail-perimeter.amazon.com [44.246.68.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59A5848E0DD;
	Mon,  5 Oct 2026 19:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.246.68.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791228335; cv=none; b=MmLKDBZMO8g6+Lg6manYL1J73jxU7L3gz+F/Sjb8YQuv2o0klNs1oTxQX0dUvRSlNQcazElPLYUHbwpSlZwNcr380DbXOwVWlry4c6B1yXOeVRaXNhqv3nZdgFDFAtAIJbXKBpoCWzwH6Qu0JuMTbEDdkbE5sG2PWse5htvMBNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791228335; c=relaxed/simple;
	bh=u2OJMbJVLuKBfV362XekAsWwZFymBrBi5BAMP06bsRU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JPrwVS6t4Mv7f7If0U1Vs4+YkOErREdU5H/5uUM4sUKed18db61rWC4kYNPD26IcUMYVHvS7iFD46JS3O9SWILHecXMQkLF7jrp1YNy9ITUbFL2gVgrsyMnZ1VVH4VBzSl8F+BYjbXyMzUDTVZdK3DIY1j8QAQ8oIiiF0Bei0TQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.co.uk; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (2048-bit key) header.d=amazon.co.uk header.i=@amazon.co.uk header.b=OOBzmpim; arc=none smtp.client-ip=44.246.68.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.co.uk header.i=@amazon.co.uk header.b="OOBzmpim"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.co.uk; i=@amazon.co.uk; q=dns/txt;
  s=amazoncorp2; t=1791228334; x=1822764334;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3+g2UDIi5qatXMV8fFfrhQQN75kakf+39DEWTsm3a1M=;
  b=OOBzmpimAK4jYSnAjMeutFBoYlMXbXgO0iLp02XriO1zHVoMqYEdQ0hy
   NMrvIG7TbBSclCwZUfAncjJusv8olWV12jZLtsBEkgDm1CUcMEHiCq3bA
   BJxCCWgz4kcThGJDLy1o4fgC729raYtH+acX8Bd9+ReTnFwHKWbzZDfYf
   7r7xLHlpvcuYx5YXjfHzCGCfb6MjwAanmivC2nrgOpY49M52xQvCLfR62
   zQC0J77FXho8XyVjovRu+1wvZ2jGKyezHIl18B7jeq65nbUzQdQ/c2jX1
   xue0KY1ovyUUhdxk96yVD/0/Hz/qrhnAy/39euEQ4eKgTChMN4XuiZ3FD
   Q==;
X-CSE-ConnectionGUID: t9XUAThlSbKZAoGZIBedGg==
X-CSE-MsgGUID: 3vc47IHcSyOgXnpiUwRO/g==
X-IronPort-AV: E=Sophos;i="6.27,142,1787011200"; 
   d="scan'208";a="30379943"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
  by internal-pdx-out-003.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2026 19:25:32 +0000
Received: from EX19MTAUWA001.ant.amazon.com [205.251.233.236:18404]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.37.83:2525] with esmtp (Farcaster)
 id 24f0ec7c-318e-4e49-845a-ab6c866807fc; Mon, 5 Oct 2026 19:25:31 +0000 (UTC)
X-Farcaster-Flow-ID: 24f0ec7c-318e-4e49-845a-ab6c866807fc
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.49;
 Mon, 5 Oct 2026 19:25:31 +0000
Received: from dev-dsk-hmushi-1a-0c348132.eu-west-1.amazon.com
 (172.19.124.218) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.49; Mon, 5 Oct 2026
 19:25:29 +0000
From: Mushahid Hussain <hmushi@amazon.co.uk>
To: <kvm@vger.kernel.org>
CC: Sean Christopherson <seanjc@google.com>, Paolo Bonzini
	<pbonzini@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, "K . Y .
 Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, "Wei
 Liu" <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, Long Li
	<longli@microsoft.com>, <linux-hyperv@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <nh-open-source@amazon.com>,
	<mushi.shar@gmail.com>
Subject: [PATCH 2/3] KVM: x86: Extract __kvm_set_clock() from kvm_vm_ioctl_set_clock()
Date: Mon, 5 Oct 2026 19:24:30 +0000
Message-ID: <20261005192431.87317-3-hmushi@amazon.co.uk>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261005192431.87317-1-hmushi@amazon.co.uk>
References: <20261005192431.87317-1-hmushi@amazon.co.uk>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D040UWA001.ant.amazon.com (10.13.139.22) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

Move the body of KVM_SET_CLOCK into __kvm_set_clock() and leave the
copy from userspace and the flags check in the ioctl handler. A
following patch steps kvmclock from inside KVM and needs the worker.

No functional change intended.

Assisted-by: Claude:claude-fable-5.1
Signed-off-by: Mushahid Hussain <hmushi@amazon.co.uk>
---
 arch/x86/kvm/x86.c | 40 +++++++++++++++++++++++-----------------
 1 file changed, 23 insertions(+), 17 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 32563a91fba99..19666a80240a5 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -4354,22 +4354,11 @@ static int kvm_vm_ioctl_get_clock(struct kvm *kvm, void __user *argp)
 	return 0;
 }
 
-static int kvm_vm_ioctl_set_clock(struct kvm *kvm, void __user *argp)
+static void __kvm_set_clock(struct kvm *kvm, struct kvm_clock_data *data)
 {
 	struct kvm_arch *ka = &kvm->arch;
-	struct kvm_clock_data data;
 	u64 now_raw_ns;
 
-	if (copy_from_user(&data, argp, sizeof(data)))
-		return -EFAULT;
-
-	/*
-	 * Only KVM_CLOCK_REALTIME is used, but allow passing the
-	 * result of KVM_GET_CLOCK back to KVM_SET_CLOCK.
-	 */
-	if (data.flags & ~KVM_CLOCK_VALID_FLAGS)
-		return -EINVAL;
-
 	kvm_hv_request_tsc_page_update(kvm);
 	kvm_start_pvclock_update(kvm);
 	pvclock_update_vm_gtod_copy(kvm);
@@ -4379,24 +4368,41 @@ static int kvm_vm_ioctl_set_clock(struct kvm *kvm, void __user *argp)
 	 * in use, we use master_kernel_ns + kvmclock_offset to set
 	 * unsigned 'system_time' so if we use get_kvmclock_ns() (which
 	 * is slightly ahead) here we risk going negative on unsigned
-	 * 'system_time' when 'data.clock' is very small.
+	 * 'system_time' when 'data->clock' is very small.
 	 */
-	if (data.flags & KVM_CLOCK_REALTIME) {
+	if (data->flags & KVM_CLOCK_REALTIME) {
 		u64 now_real_ns = ktime_get_real_ns();
 
 		/*
 		 * Avoid stepping the kvmclock backwards.
 		 */
-		if (now_real_ns > data.realtime)
-			data.clock += now_real_ns - data.realtime;
+		if (now_real_ns > data->realtime)
+			data->clock += now_real_ns - data->realtime;
 	}
 
 	if (ka->use_master_clock)
 		now_raw_ns = ka->master_kernel_ns;
 	else
 		now_raw_ns = get_kvmclock_base_ns();
-	ka->kvmclock_offset = data.clock - now_raw_ns;
+	ka->kvmclock_offset = data->clock - now_raw_ns;
 	kvm_end_pvclock_update(kvm);
+}
+
+static int kvm_vm_ioctl_set_clock(struct kvm *kvm, void __user *argp)
+{
+	struct kvm_clock_data data;
+
+	if (copy_from_user(&data, argp, sizeof(data)))
+		return -EFAULT;
+
+	/*
+	 * Only KVM_CLOCK_REALTIME is used, but allow passing the
+	 * result of KVM_GET_CLOCK back to KVM_SET_CLOCK.
+	 */
+	if (data.flags & ~KVM_CLOCK_VALID_FLAGS)
+		return -EINVAL;
+
+	__kvm_set_clock(kvm, &data);
 	return 0;
 }
 
-- 
2.47.3


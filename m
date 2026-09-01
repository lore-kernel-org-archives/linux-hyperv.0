Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8C0B36E460
	for <linux-hyperv@vger.kernel.org>; Tue,  1 Sep 2026 19:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788291163; cv=none; b=aOuUqC/c03x3n5xa7jNNruFbhYLSQbJBIVHKuqQh8dIlf8lHhXl23m49zJUhUvuIBNZJ2Ynk4kkzSNHnK9YImfg7TNasZoPMO58JVUPw9GEA6pecHH2oMB4DEGiuTx5nBTXLJCezTJn8G6XSr6SREDlEWQseqt6QB/K47Vqni68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788291163; c=relaxed/simple;
	bh=Kqtaom+taqfNxLyRIj5Pvu+l9YeWPfNKh2505bDeBmM=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=sNQnGnUS9Y5yv/vinUyVkB/dli/QXdisxSjlxpDf1CTm62R0e1rn8uIfv6lbiO6rgwuEvgRADezEgOw0NAqGFoWAvA0o5/iAnKF1kdXgMpZvaJsCfcsIiLk2bjSkBRRljdFx/dX7TBv+GBPwIh1hebDradhOexpMSYLWcuWG0Yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Icu3mpra; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Icu3mpra"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-cbedf433a99so276852a12.2
        for <linux-hyperv@vger.kernel.org>; Tue, 01 Sep 2026 12:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788291161; x=1788895961; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GglU6ce3asJqqKRR25XYj1dFcXPYjSuTYTF2kpVpolE=;
        b=Icu3mpraGpngCBjpu/tO1gdO37H1AsbnD09u0ppRGiXwJNSJBOy8+GJeaYIItYOgAF
         7t6J9APzGwo9sfShWvhj/leHJMDNFwzClMsOqWVE6dBFiF8PeH/IQkvzKFJ6aU6fPGpE
         KrvAmzgIjtVWDRrLkD/ASytlMPg3fsi5AcjiX+7oHqFf0waA2Obw44ihiZloDqpMX+UJ
         SXXXo1akMCbfHqXieEcbnO3KY5jFlZ9OQLmPFEo7651xWf4h1F4hF4T0SpTEMKBm8le5
         AloWlgXMmMSbPW2iCvBTG7Qweph6kv1h8ZbYTcAFAefVPkFHidNpmMYmSJDl0CML4tRT
         MrsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788291161; x=1788895961;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GglU6ce3asJqqKRR25XYj1dFcXPYjSuTYTF2kpVpolE=;
        b=eLHbtf7maqsmRNwp0JPAF0dIFmuclfoDOmYc9s2CAKBBFIM5hbT2wBzA1bb8Ib6/Ds
         dQcoOuk44OTxhSF2+6Oj2y8y865e91sEDrqLDqzck/FEdhN7z52e2f8C6aCHHNCb+sWk
         D6Spx0tcuGoruWu16wvvUrzw26x7x/YZ1oUyUBaadJxZlgKqJjFGnb3IkNoowxwZzLWh
         dVh+LPhrzuxBxpmALLQC0KwzpwC/uCvcUK/OeCI7NMF6D9s0GClYPL9VBjEoC4vD9e80
         /8wlERFW1MZZIlWqZ0AzqRN8bAgkOMZOtY1bduMvkUCzkbKP/Sy96uTngTzm3cjzlFZN
         qXXw==
X-Forwarded-Encrypted: i=1; AKwUvBzk5NV/yHV8+zxr/kw+XBH9Hl4uxG7cXPUrIWI2rTinYAht6bmyvDIe3t8kxpV0m1itFoAOCFXAKkI3LMs=@vger.kernel.org
X-Gm-Message-State: AFuF++m4rNvdkX0zxCXT24DA5FD+36eG6/IqFQeJiHrP2mt2PUXBVuOx
	YfzY3LAB5pnhW/3dkHzBqBEr0jP/9eM0+dqwWKxxdKCFAAtA8ESeqLvj
X-Gm-Gg: AYBFou3y103jZ4kHMo11aY32oR2sdy8j9S1mpp6xq+4fweiKhP3n+On9Hg38AiTekpW
	laMBzHWbx2D/KFgpXrvggAgUOxAdXzpiDnEozweFPpJXDRR2B1FgZLVfj0Fx6IA3w8P8Xoue9O/
	Y60k3+uQq/V7KHKF7DY63UUz8DqPxQjcJIBQG2gx9BaQjV8fBu/el9nlmGTjtq9Xk+Da/Y1tT0G
	nrG8/6ztMiEdHIR4zHmxCN15RO9q/ZdZfxbncR/sJaKtySF+SPXJwBPhMN1oVODFn0ox023l1Qc
	XXFdhgyGIOjcHfbrdJMFiEUkIlPyWmkPvLgIHyCRZ8nF2X7Y3CkKHc9IeqJST5higdAIxd07gOE
	AZYEYiPHpBSv4wHOqhQcDU8ocIP9qra6E2sw+S8eQ43CezVsC71F5fy/iS4VMui9X+U5dOjrJQK
	7qdtz9vucxboOb/IjxO1ZGfTGebLJbWFITGVMw+rYh+S23L+IRTTzl7mRu0yLkIPzoqI+BLF3Oz
	pylDs5JwLyEpxS0TbZM8FyGrTx3AXlXl+luaMYgBKg=
X-Received: by 2002:a17:90b:164b:b0:38e:4f41:83df with SMTP id 98e67ed59e1d1-396d1007e54mr53834346a91.15.1788291160960;
        Tue, 01 Sep 2026 12:32:40 -0700 (PDT)
Received: from localhost.localdomain (c-174-165-208-10.hsd1.wa.comcast.net. [174.165.208.10])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3990d80433dsm6916687a91.17.2026.09.01.12.32.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 12:32:40 -0700 (PDT)
From: Michael Kelley <mhkelley58@gmail.com>
X-Google-Original-From: Michael Kelley <mhklinux@outlook.com>
To: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	longli@microsoft.com,
	tglx@kernel.org,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] x86/hyperv: Avoid using per-cpu output page in hv_apicid_to_vp_index()
Date: Tue,  1 Sep 2026 12:32:36 -0700
Message-Id: <20260901193236.540188-1-mhklinux@outlook.com>
X-Mailer: git-send-email 2.25.1
Reply-To: mhklinux@outlook.com
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hv_apicid_to_vp_index() currently uses the per-cpu hypercall input
and output pages. This function is called when running in VTL2 and
when running in an SEV-SNP CoCo VM with no paravisor. In the former
case, the output page is allocated, but in the latter case it is
not, so the hypervisor stores the output VP index in memory that has
not been allocated by the guest.

Fix this by using the input page for both input and output. The
hypercall has very small input and output, so sharing the same
page for both is straightforward. An alternative fix is to
allocate the per-cpu output page when running in an SEV-SNP CoCo
guest, but this uses significantly more memory, particularly
with larger vCPU counts.

Fixes: 86c48271e0d6 ("x86/hyperv: Fix APIC ID and VP index confusion in hv_snp_boot_ap()")
Signed-off-by: Michael Kelley <mhklinux@outlook.com>
---

I'm not aware that this bug is causing any real problems because
SEV-SNP CoCo VMs on Hyper-V are rarely, if ever, used without a
paravisor. But it was on my list of little clean-ups to do, and
a recent Sashiko analysis [1] flagged the issue. So the best thing
to do is just fix it.

[1] https://lore.kernel.org/linux-hyperv/20260901171238.834601F00A3A@smtp.kernel.org/

 arch/x86/hyperv/hv_init.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index d5edc8530964..d0302bf2641e 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -731,7 +731,8 @@ int hv_apicid_to_vp_index(u32 apic_id)
 	input->partition_id = HV_PARTITION_ID_SELF;
 	input->apic_ids[0] = apic_id;
 
-	output = *this_cpu_ptr(hyperv_pcpu_output_arg);
+	/* Treat input as having 2 APIC IDs so output is 64-bit aligned */
+	output = (u32 *)((void *)input + struct_size(input, apic_ids, 2));
 
 	control = HV_HYPERCALL_REP_COMP_1 | HVCALL_GET_VP_INDEX_FROM_APIC_ID;
 	status = hv_do_hypercall(control, input, output);
-- 
2.25.1


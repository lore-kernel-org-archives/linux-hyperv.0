Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=13.77.154.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794011594;
	b=TXRBNYgItnIowWN9J5f8yu9P/B6uGlQEMn6BjEZgFmavj90kL7I2NjjwYw74bZEMb9qb
	 zYnM5Mt36Ltmkh5HfuB+VwpQ/2UCl5NYgxZL2ZcW+g3K3ZHrOQ0oiFKB85sPEmXyxP5Dp
	 841WfT2nP3YZJZB4eFhCNj7v3mrXKpyXK9Ntv2uWBbrfrejAIQSNyNjdbNKX6d0T+kVAW
	 97F4F4RjzKhdYqpj2sQ1PiC+3Dq/wUVC1KkH7swVXyZYXkdd0JO3aYCfFMfVKrSlol/Y5
	 PhHiqblH0C2q+h5P/HnR1GvQRuwClVCgYY5hjcRinXX8P4khGctbvrmar9Dsa/ueiUA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794011594;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Spam-Status:X-Spam-Checker-Version;
	bh=4AIzCiT9zAqiM5GA6FV2ih9/wZbuPRRZ3Er6s+GSRAA=;
	b=hNYJ7NIKfF9t2kwyqh7VQBOn7Bcbl9VnKWE29LW0JiIlH85uNbO/6DzJocSasBeSq2dK
	 ToSz/Jtupx7Z948zITEwylfJUIiA4bcQLPkbHl7uCtkLTzyNyNjAkjdFayBfNaP0xtRXZ
	 3nJ6Ltkc7GAKdKWYIt0vblH5rKgy70jqyqd81MnGsELBdvCZvOsrrJsqNragJCS4VF5af
	 QVPX2MmJcuCIpr3L5qTBKSDzoJSbTGWU4b3dSeGRcsWCsT7UpYuW3FqVpMbLQ768NYVcX
	 imQyA5twheHAzsP589iw12oeg0ReRyw4H7J44TSsKewH3EREdot6/Edf3TxJqqA7v2Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.microsoft.com;
	spf=pass smtp.mailfrom=linux.microsoft.com;
	dkim=pass header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b="W2kf/BGR";
	arc=none smtp.remote-ip=13.77.154.182
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0FDC606A326;
	Sat,  7 Nov 2026 00:33:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D0FDC606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=W2kf/BGR
Received: from mrdev.corp.microsoft.com (192-184-212-33.fiber.dynamic.sonic.net [192.184.212.33])
	by linux.microsoft.com (Postfix) with ESMTPSA id 751D520B7167;
	Fri,  6 Nov 2026 16:33:12 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 751D520B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1794011592;
	bh=4AIzCiT9zAqiM5GA6FV2ih9/wZbuPRRZ3Er6s+GSRAA=;
	h=From:To:Cc:Subject:Date:From;
	b=W2kf/BGROQlVkPNDhxVqdvuhzsdAaTigHkEXAsHvT1mi/n9vfuv38OKTLHitQVza4
	 LTrE7E9aJGMT+Nvfh/B6ANh98pIGk6I+buWC0xAK1/yJ9DMIMQ/o6cPqhKRPELgMM2
	 lq1iGzkAeA26uB9Ohk8+3tBt/hp1+Hiz++Qy9a30=
From: Mukesh R <mrathor@linux.microsoft.com>
To: linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	mhkelley58@gmail.com
Subject: [PATCH] mshv: Change parameter passing to hv_call_create_partition()
Date: Fri,  6 Nov 2026 16:33:03 -0800
Message-ID: <20261107003303.3897039-1-mrathor@linux.microsoft.com>
X-Mailer: git-send-email 2.51.2.vfs.0.1
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Post: <mailto:linux-hyperv@vger.kernel.org>
List-Help: <mailto:linux-hyperv+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hyperv+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

At present, mshv_ioctl_create_partition() for unknown reasons passes two
aggregate parameters by value to hv_call_create_partition(). Change that
to pass them by reference.

Signed-off-by: Mukesh R <mrathor@linux.microsoft.com>
---
 drivers/hv/mshv_root.h         |  4 ++--
 drivers/hv/mshv_root_hv_call.c | 12 ++++++------
 drivers/hv/mshv_root_main.c    |  5 ++---
 3 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/drivers/hv/mshv_root.h b/drivers/hv/mshv_root.h
index 1f086dcb7aa1..c61b52db7f00 100644
--- a/drivers/hv/mshv_root.h
+++ b/drivers/hv/mshv_root.h
@@ -275,8 +275,8 @@ void mshv_vp_stats_unmap(u64 partition_id, u32 vp_index,
 
 int hv_call_withdraw_memory(u64 count, int node, u64 partition_id);
 int hv_call_create_partition(u64 flags,
-			     struct hv_partition_creation_properties creation_properties,
-			     union hv_partition_isolation_properties isolation_properties,
+			     struct hv_partition_creation_properties *cr_prop,
+			     union hv_partition_isolation_properties *isol_prop,
 			     u64 *partition_id);
 int hv_call_initialize_partition(u64 partition_id);
 int hv_call_finalize_partition(u64 partition_id);
diff --git a/drivers/hv/mshv_root_hv_call.c b/drivers/hv/mshv_root_hv_call.c
index e761addda50e..bf0f90515dad 100644
--- a/drivers/hv/mshv_root_hv_call.c
+++ b/drivers/hv/mshv_root_hv_call.c
@@ -86,8 +86,8 @@ int hv_call_withdraw_memory(u64 count, int node, u64 partition_id)
 }
 
 int hv_call_create_partition(u64 flags,
-			     struct hv_partition_creation_properties creation_properties,
-			     union hv_partition_isolation_properties isolation_properties,
+			     struct hv_partition_creation_properties *cr_prop,
+			     union hv_partition_isolation_properties *isol_prop,
 			     u64 *partition_id)
 {
 	struct hv_input_create_partition *input;
@@ -105,11 +105,11 @@ int hv_call_create_partition(u64 flags,
 		input->flags = flags;
 		input->compatibility_version = HV_COMPATIBILITY_21_H2;
 
-		memcpy(&input->partition_creation_properties, &creation_properties,
-		       sizeof(creation_properties));
+		memcpy(&input->partition_creation_properties, cr_prop,
+		       sizeof(*cr_prop));
 
-		memcpy(&input->isolation_properties, &isolation_properties,
-		       sizeof(isolation_properties));
+		memcpy(&input->isolation_properties, isol_prop,
+		       sizeof(*isol_prop));
 
 		status = hv_do_hypercall(HVCALL_CREATE_PARTITION,
 					 input, output);
diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
index cc2cfce2aefd..89fe6fb9244a 100644
--- a/drivers/hv/mshv_root_main.c
+++ b/drivers/hv/mshv_root_main.c
@@ -2088,9 +2088,8 @@ mshv_ioctl_create_partition(void __user *user_arg, struct device *module_dev)
 	if (ret)
 		goto free_partition;
 
-	ret = hv_call_create_partition(creation_flags,
-				       creation_properties,
-				       isolation_properties,
+	ret = hv_call_create_partition(creation_flags, &creation_properties,
+				       &isolation_properties,
 				       &pt_id);
 	if (ret)
 		goto cleanup_irq_srcu;
-- 
2.51.2.vfs.0.1


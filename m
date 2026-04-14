Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 507863D6693
	for <linux-hyperv@vger.kernel.org>; Tue, 14 Apr 2026 11:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776165032; cv=none; b=kIsKJIoUWb7atySpWFy6w8iq55VdxrQEgxxxoEljqwVzq0K/LRX5Z/wybWp3yJ2qc2DnvVGShyvTPLtY69ml4Ygg2BytcbIHG35q9xGtAhtoImBcZEwGboOcWHmaHdZJ6b+/xQMw9Ew5UrkjBVdEbv60SqAv7dZ6zFHxwX+a5nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776165032; c=relaxed/simple;
	bh=82IQaS2ES25qPmD699gmQoChwdl4RWlF4bKfHQ2aUDY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Alq7HFLa93JMBmrfiqWji/ui2H3W5isxlHQjWsKRjtUeHjJri2dBFBfc3B2Eiy5Nx8u/ErQHxsbW+MnF5fzT/ZWqlOEj0dmMOSx0576VWJOvVeiM8/iIDAp1NMxHkLL9UK0LQhAM+p1i98djmx9duvfleTcFJB/VbWb2FJ/eBWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ukDgO92x; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ukDgO92x"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776165019;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=hZhQ8sQ09CCHw6DmqeFeC8lM0V+19zmCctdopql+ehk=;
	b=ukDgO92xgGx/jycisfHlyvhxirRBJgKpbiH7WoN/M1sy3Kg5i3stNLRgcf1jKtxurqHxmg
	LFAlezvJ3lb1W7Ws1CDqpJ9cXwZYq8VEOUhq+Qxy11B7YQnC4ybHIkAfdnCnuDePJ+yqKw
	iUHN5UC+/ryUM5U2hJhuWp0vqkkR4gM=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: "K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>,
	Greg Kroah-Hartman <gregkh@suse.de>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	stable@vger.kernel.org,
	Ky Srinivasan <ksrinivasan@novell.com>,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] hv: utils: handle and propagate errors in kvp_register
Date: Tue, 14 Apr 2026 13:10:08 +0200
Message-ID: <20260414111008.307220-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2385; i=thorsten.blum@linux.dev; h=from:subject; bh=82IQaS2ES25qPmD699gmQoChwdl4RWlF4bKfHQ2aUDY=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDJn3FCbohDMsn6favM37wlGvj4FpchGsc9+o8upcyuLMP 7iDOeJkRykLgxgXg6yYIsuDWT9m+JbWVG4yidgJM4eVCWQIAxenAEzEPIaR4Yi3SOKKCruLX5f1 bZTb4bZz1qOdr09+MFjIz5lgF/nilSfD/2RvtuYlUad3CQm0ttW4hn/S4Yzm4yrylDxx1a6y0n8 dOwA=
X-Developer-Key: i=thorsten.blum@linux.dev; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Make kvp_register() return an error code instead of silently ignoring
failures, and propagate the error from kvp_handle_handshake() instead of
returning success.

This propagates both kzalloc_obj() and hvutil_transport_send() failures
to kvp_handle_handshake() and thus to kvp_on_msg().

Fixes: 245ba56a52a3 ("Staging: hv: Implement key/value pair (KVP)")
Cc: stable@vger.kernel.org
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 drivers/hv/hv_kvp.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/drivers/hv/hv_kvp.c b/drivers/hv/hv_kvp.c
index 0d73daf745a7..6180ebe040ff 100644
--- a/drivers/hv/hv_kvp.c
+++ b/drivers/hv/hv_kvp.c
@@ -93,7 +93,7 @@ static void kvp_send_key(struct work_struct *dummy);
 static void kvp_respond_to_host(struct hv_kvp_msg *msg, int error);
 static void kvp_timeout_func(struct work_struct *dummy);
 static void kvp_host_handshake_func(struct work_struct *dummy);
-static void kvp_register(int);
+static int kvp_register(int);
 
 static DECLARE_DELAYED_WORK(kvp_timeout_work, kvp_timeout_func);
 static DECLARE_DELAYED_WORK(kvp_host_handshake_work, kvp_host_handshake_func);
@@ -127,24 +127,26 @@ static void kvp_register_done(void)
 	hv_poll_channel(kvp_transaction.recv_channel, kvp_poll_wrapper);
 }
 
-static void
+static int
 kvp_register(int reg_value)
 {
 
 	struct hv_kvp_msg *kvp_msg;
 	char *version;
+	int ret;
 
 	kvp_msg = kzalloc_obj(*kvp_msg);
+	if (!kvp_msg)
+		return -ENOMEM;
 
-	if (kvp_msg) {
-		version = kvp_msg->body.kvp_register.version;
-		kvp_msg->kvp_hdr.operation = reg_value;
-		strcpy(version, HV_DRV_VERSION);
+	version = kvp_msg->body.kvp_register.version;
+	kvp_msg->kvp_hdr.operation = reg_value;
+	strcpy(version, HV_DRV_VERSION);
 
-		hvutil_transport_send(hvt, kvp_msg, sizeof(*kvp_msg),
-				      kvp_register_done);
-		kfree(kvp_msg);
-	}
+	ret = hvutil_transport_send(hvt, kvp_msg, sizeof(*kvp_msg),
+				    kvp_register_done);
+	kfree(kvp_msg);
+	return ret;
 }
 
 static void kvp_timeout_func(struct work_struct *dummy)
@@ -186,9 +188,8 @@ static int kvp_handle_handshake(struct hv_kvp_msg *msg)
 	 */
 	pr_debug("KVP: userspace daemon ver. %d connected\n",
 		 msg->kvp_hdr.operation);
-	kvp_register(dm_reg_value);
 
-	return 0;
+	return kvp_register(dm_reg_value);
 }
 
 

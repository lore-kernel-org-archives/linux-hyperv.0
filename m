Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794477864;
	b=cDcA3z9Hh2s2ZfG6ML1mOiApYK1Bd29LgvMySk+ySBQQo9xKvgUsDAJ/CdtjTtjllh2N
	 6lKtU4Ex8bt8mJJJV4+X41CCGWMlzGjBt5pbIN0f627yfN014j1FT8t4zWBprEApT1keL
	 zr6vsbFc0lANTWieriSmd9J6Y3pZcqYtlkl02i/Rgp+BHhHHF7n9XMCIp1MuS69Pi2fAa
	 rcwEkq53XJ0Q/iZQFkXXq+jeQxqLEn0CQZh4Fmx6ROvqnnSIQhyLa2uof1SVzL2Ia7mYY
	 OcQcTG1Jf5+ZGcqbsEGK29KJZbkyIhQqJYSjTQhygUHtoOPnuGyI+zdKCDuCsP6yWGw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794477864;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=HtuOLru1xJlLWQAB+8xJt0wpPE+TJSHN0z/mx/ydS8M=;
	b=oix5ORsiKqnbkO1SUV40tugqh+xy8zr9xehJbCYDWkkzDUrD1RFLzFN7X+Nx4ACUHA77
	 A3QnTCiZyhrh8Ml/sKvSRDnHaz27+Yf9WqUWP4WBJQQS4Q5xSu5n3o2XQFa3vaozGvGRr
	 8TaOoqZf6dTtaDLRzvEkKMegtPCOz33RmtFxfwnnrgY97ac2xKRTU15lpQsSB3Vilw3X5
	 +jT1R6VhJzOzL0ICVN60qwkky28mIIXstTlTykCuinaIr4VbirQ5idoBc0oCLqONefGQb
	 2jhgoLU9LgfDeDjCDdoIFVnZDhYabycGlksyYIG5N1O4+oYMKcGCSCLiDhZYYo+l0dA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MGkX4002;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A912606A31C;
	Thu, 12 Nov 2026 10:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MGkX4002
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794477864;
	b=ujXKuXdyMqbrPxcfvgT9k4hnQqIZOGuRiej9VSzZpBalTOSzpyPW4rwmkD+k5NNgQIZK
	 9oDsGUMIaEk8xO0oNpsWwNoNV5XoIaWIYaK0xfr3Edc5ksR1I/+/MKtrJj+VRwZijMRO6
	 Na/3nbTZUEPlicpTr1ujJZ66fdxNz4Xp+lmC0TZhtHpRl+BhhHQshYCV4V9MO/F50XhJo
	 Gu93eyhqrQrUuYGjEkh7YIcW5qyIAaHp5o3kiB8HZ3TCH+l0kBqD5vqLmYgg+Pk+HcvDw
	 Q1KR0Jt9yhrx70gVxgj4v17kzHs4zIIxPrdFy+RjWswuQB0M4KwxwvBNLvgsizOpReA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794477864;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=HtuOLru1xJlLWQAB+8xJt0wpPE+TJSHN0z/mx/ydS8M=;
	b=Z56O2l9WubKjMVIiH3guK2vEPxN4mJR/CvZRWN78Asa1DblF90Dr6e99rI8TXmsZ1lyl
	 MB9V1PkayKm/2TtMxSIuTU7hLU9u5l+6LBKnxUFp7orYHJWcDSxHN7u9iB990XRGwn9WK
	 ck0aprzkfaMJeaVDmU56J1w/t061WpZErVm4iOV1IrHYdJv0BZoe6knf+KXP/xlcMLHbz
	 UC7ZDiUP6pWjpkifzBQxNV5nGSbaL9nj4vusiKfFySqNZ2SF1Gzd8bxtOsLAZuEcM9eXJ
	 0Q/dszkSIoxiKJf8QfA6WEss9L5IgiSEnRLvh44B19NHC1vw3BootxHCUXrAWIZEHCQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id BB9E71F00A05;
	Thu, 12 Nov 2026 10:04:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794477864;
	bh=HtuOLru1xJlLWQAB+8xJt0wpPE+TJSHN0z/mx/ydS8M=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=MGkX4002eDMdzvi02fAsUCul3fU4kG36dViyL5rTaIVUFxv9cHD1AB6wEKelMo0qu
	 u9zUywbc9YWipv85QZCV8ZeWrbP5fMRX+7Qlc8oyGxUqkkm9Eo3vQWjiOxP8aFdJOw
	 0Vc1brnbr3LDH56YSiyrlvMCUoCgeIOc67vhJE50fSZ5PIT+972naK9KhC7UBthb4r
	 kaVgqDOzJdOMDDdCExpJ7IWmAem0PcXZWGP+z1RttpZzGCf1FaNXET5IVANMx1IPr+
	 NrOlUmLiNac+WimTwIyE5ljlcclNtsMx+5hIbG6SLdEhmWM18NN2Q5MGUlnvlUZD06
	 7hO0GjBfPjESw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 1DFA249450;
	Thu, 12 Nov 2026 10:04:23 +0000 (UTC)
From: Suyuan Wang via B4 Relay <devnull+shyckless.gmail.com@kernel.org>
Date: Thu, 12 Nov 2026 10:04:18 +0000
Subject: [PATCH] mshv_vtl: Release mem_dev through put_device()
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Post: <mailto:linux-hyperv@vger.kernel.org>
List-Help: <mailto:linux-hyperv+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hyperv+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261112-hyperv-v1-1-67144d71878c@gmail.com>
X-B4-Tracking: v=1; b=H4sIACGP9WoC/yXMQQ5AMBCF4avIrDXRVi1cRSwYg7GopqUh4u6K5
 Zf8710QyDMFqLMLPEUOvNoEmWeAc2cnEjwkgypUJaVUYj4d+SiMQaO1RqpMCSl2nkY+vqOm/R3
 2fiHc3jXc9wMq+w0pagAAAA==
X-Change-ID: 20261112-hyperv-55c5333ce654
To: haiyangz@microsoft.com, decui@microsoft.com, wei.liu@kernel.org
Cc: romank@linux.microsoft.com, ssengar@linux.microsoft.com, 
 namjain@linux.microsoft.com, linux-kernel@vger.kernel.org, 
 linux-hyperv@vger.kernel.org, mhklinux@outlook.com
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794477862; l=2707;
 i=shyckless@gmail.com; s=default; h=from:subject:message-id;
 bh=BjfU+Rbjqy4Z7JxZoJTtVEHtxruhAGS1/m1B8KB8IlY=;
 b=WvAWhy9NDI3g+BAZA+frvhYpMFqdzLiDMXxRQ7QKq5MhBchStdcOIhAKz72CkCOwFTwVwG9vm
 c62ncDw5JjvClk1l1pIw1oC5EIn73N+AJmoAfCP4m4UFfhQyhPiSZtW
X-Developer-Key: i=shyckless@gmail.com; a=ed25519;
 pk=pMtccVGiWES3bV+7YBFuBclkvq2n2HBHQ5azaBrK2lY=
X-Endpoint-Received: by B4 Relay for shyckless@gmail.com/default with
 auth_id=1498
X-Original-From: Suyuan Wang <shyckless@gmail.com>
Reply-To: shyckless@gmail.com

From: Suyuan Wang <stevewong@hust.edu.cn>

mem_dev is set up with device_initialize() and device_add(), but it is
freed with a plain kfree(), both on the device_add() error path and on
module exit:

    device_del(mem_dev);
    kfree(mem_dev);

It has no release() callback either. Freeing an initialized device with
kfree() skips the final put_device() and device_release(). On module
unload this leaks the device name and the device_private allocated by
device_add(), and on the device_add() error path at least the name is
leaked. The leak is small, and the fix is to free the device the way
the driver core expects.

Give mem_dev a release() callback that frees it, and use put_device()
on the error path and device_unregister() in mshv_vtl_exit(). Nothing
else changes: the devm_memremap_pages() mapping is still torn down by
device_del() as before.

Found with a static analysis tool and checked by hand.

Fixes: 7bfe3b8ea6e3 ("Drivers: hv: Introduce mshv_vtl driver")
Cc: stable@vger.kernel.org
Co-developed-by: Kaixuan Li <kaixuan.li@ntu.edu.sg>
Signed-off-by: Kaixuan Li <kaixuan.li@ntu.edu.sg>
Signed-off-by: Suyuan Wang <stevewong@hust.edu.cn>
---
Compile tested with CONFIG_MSHV_VTL=y only, I don't have an OpenHCL
setup to run it.
---
 drivers/hv/mshv_vtl_main.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/hv/mshv_vtl_main.c b/drivers/hv/mshv_vtl_main.c
index 2d4fe24cecbf..bbf43330e129 100644
--- a/drivers/hv/mshv_vtl_main.c
+++ b/drivers/hv/mshv_vtl_main.c
@@ -1346,6 +1346,11 @@ static struct miscdevice mshv_vtl_low = {
 	.minor = MISC_DYNAMIC_MINOR,
 };
 
+static void mshv_vtl_mem_dev_release(struct device *dev)
+{
+	kfree(dev);
+}
+
 static int __init mshv_vtl_init(void)
 {
 	int ret;
@@ -1412,17 +1417,18 @@ static int __init mshv_vtl_init(void)
 	}
 
 	device_initialize(mem_dev);
+	mem_dev->release = mshv_vtl_mem_dev_release;
 	dev_set_name(mem_dev, "mshv vtl mem dev");
 	ret = device_add(mem_dev);
 	if (ret) {
 		dev_err(dev, "mshv vtl mem dev add: %d\n", ret);
-		goto free_mem;
+		goto put_mem;
 	}
 
 	return 0;
 
-free_mem:
-	kfree(mem_dev);
+put_mem:
+	put_device(mem_dev);
 free_low:
 	misc_deregister(&mshv_vtl_low);
 free_hvcall:
@@ -1439,8 +1445,7 @@ static int __init mshv_vtl_init(void)
 
 static void __exit mshv_vtl_exit(void)
 {
-	device_del(mem_dev);
-	kfree(mem_dev);
+	device_unregister(mem_dev);
 	misc_deregister(&mshv_vtl_low);
 	misc_deregister(&mshv_vtl_hvcall_dev);
 	misc_deregister(&mshv_vtl_sint_dev);

---
base-commit: 630059a5a632377b9b7b487baccde92b7ae1dd47
change-id: 20261112-hyperv-55c5333ce654

Best regards,
--  
Suyuan Wang <shyckless@gmail.com>



Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793612854;
	b=U6+IjAySUkolHRFOKbv1Kwb4G2FaY2obN5fnn1jd+U6eqdH8o4C/5GgwX31l5LyMQi/B
	 up8cZElGzKjtF5sdPrM3BLAAmWtPFHKqEbstmnatvQybRK8Tt+CR3Zge5IzFv73xHwKTB
	 oNHcbMAAHhewTDq31UiHfrIdVyyBFteOaksOssxLSOEZd/oslfLgpbnQ9DkuKj4tJqNf3
	 Q2RC4rezAuKEpHy+3InECQfC0JHyjMFSncE6lIxAZUZCyxL2MjcSG1tYLa2s3R7hUynA2
	 RxSwd6j6BqiVvaCQzwQm+rZfNaRs6CREjRlS1Y8LfC7qK+EKlPslPmozi4YUhAbQCSQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793612854;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=it6Vu4qt3zaK7MGxxtPRg8P0zTaXMG2Fc9lz6FZfK90=;
	b=mGm8vZMtrOki/7YPRc2PqzQtW9R3uiPVH8vw4Nnmi2qCk2+ajQ4G3wMsBLSDLQbQ2h+D
	 0vr6IpmygMZnX/xeAIq4wOa2CAKhLyUi5rIOGkX9CVJsq6APU7X6QRtG8ytrH5lqIk+zW
	 4qEHwFNy62dUS9LlEuEYRaOYpxpiSP50yECw598tMw6gqAwvdEA1uxIO2oiJXvbXbPb8n
	 ixFWLZjSWlfjxQMFmEZdbkxq0EwFD/OuUWiPABLniKfZOd9bjFTMukxC9KfH+awB3R5yr
	 K1V1okrONbERVaPe26BtGySd/7ldDbN1WiwrlKxJxRgQk2CJT2rhpk0kHfVo/lHswYA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=K0NFfgmA;
	arc=none smtp.remote-ip=209.85.210.171
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED8DD606A32C
	for <linux-hyperv@vger.kernel.org>; Mon,  2 Nov 2026 09:47:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ED8DD606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=K0NFfgmA
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-8a06454116eso1102784b3a.1
        for <linux-hyperv@vger.kernel.org>; Mon, 02 Nov 2026 01:47:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793612853; x=1794217653; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=it6Vu4qt3zaK7MGxxtPRg8P0zTaXMG2Fc9lz6FZfK90=;
        b=K0NFfgmAD1BkLg8Vt/1M9Vxej+O0L822wWuMB4YB4Y1hQQRNjtgQcrsP58wumtCELx
         SpieaXvvYyuxNDJEGYbpN7EyvRifFgu0dKpJ0pjVLHLFDBy9RfAhvTtnTAlvhXgkFNCF
         M+rCjjH572pyOW7iatpV+x5NgSO3sWLEqBthReSwYWQMH2k9NV0hV6SopvX2MVlfCqPm
         5sUEd87mQHEV0JN+mNP8yspBh1t1yg4TA4JxyGhqTK3tt7up252c3aRkxPAwh5VEdJN3
         m82Rw+PVNSFxv3kCIk0oFLkiBdwvSjx1Av2b5OVnPhD+uvZ3Z+pxFDaUTZm7Cg/CM2EH
         0Aag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793612853; x=1794217653;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=it6Vu4qt3zaK7MGxxtPRg8P0zTaXMG2Fc9lz6FZfK90=;
        b=eDDxEpNnLt18ha9MObLH5PNiT8nwUxNdlTLPdAbf6HiR2Dz12zzcl+5keH+oexca15
         5SpUdMEO7zhzxv3X71q5QlczJvd0Qas5eERpA+8ueyqxTPtIveMmZ16ba68B4cO2sNH/
         PYc14KzfzeQ1zXhRHqpOrd89fclvFuEYuZH9ZUgtuf2UicnWNG1wtNnhOOeaqVf0g0FI
         eDX2EFVsYd/YoxUcb244tm8tbYLxAzFV4+fpgMmgJnrcnm74R9c16V8bnP4prrxUcVEn
         aXnsEfsNT1sQeWAxqN2WC2ArtaCvKHhoAbIY7o8PWstqSUFNUeewwrIfcLnNDBKfTDhh
         5ZDg==
X-Forwarded-Encrypted: i=1; AKwUvByhFMO7SX9H5uxb455/pSBy908YzrUuwMaUimBo9tY1XnG/hun+hHbtEzcUSwbH9sxFiGndMzpKF44Pp+w=@vger.kernel.org
X-Gm-Message-State: APuU4Z8ZXaiw/ICnUMWvGbGoanYKrfU+ya/HpDcod+yDvZT9M8x053l4
	CRZB0q+9D0NlCwtQFXJNVz93CsASq/P/BSjoQzAcdoGEVjEVbXmFFI33
X-Gm-Gg: AYBFou3RbZmqkUnrJupllQEkBAvGViBKTNFfvi8nJxlWv9tEXydEB7pxdkKM3dFL7lg
	5ve6xz5UOEVnLoGG7TX3vipjhPgI6qlrRiJltsNcHJxlN1Ha9ojWkg/xzKIiHVxMAFVIYvZzKUI
	AyGehQnmB3Xe5JJ5N4q9C8aCOOjTSHHY7crXPkXk0liahVq6mYk7dew94nCjcUVbemkAphdn8gU
	w6P9lV3+9XkrDhRiMKA6FwrWPGYUrmtgmRP1jEizShebUFpUtljaXlT0xbt1z3KqO7NRWFIJIni
	9pMIDJGBvIqSoM6EUDBYHaq69S9Rhw6H1EIPn1Kngr5hxlZKLTaO4hG2UVZWAcf2yOoxfUc0uyk
	HZePRqsXprpRQ8jyNubcz85K24OIip/q99oTFI4nixCEF2oiid+NrZkwx8B5VkFMOB0Wc0mMisA
	orfjLHzj7JJdp37+dJSljS+1JPrNYkJYEUgzNHIkeltNW5vq38JsVg6InlT6kO5Hkp+DFFQxO8p
	0tr6VHxBwm4qBzgO9KmyM8+FzuZCM1Boyw+C6r+qtBNjijJjlWdgpFRYyGcLV2mGCYfPom/aD4j
	VpjK+bA2V3ekke6A0Tj51xX87nYhJadK9rScyLLEAgmQsDi+fu++upQ=
X-Received: by 2002:a05:6a00:3a21:b0:8a0:7677:c8c9 with SMTP id d2e1a72fcca58-8a9bfde052fmr8075185b3a.51.1793612853308;
        Mon, 02 Nov 2026 01:47:33 -0800 (PST)
Received: from localhost.localdomain ([155.69.168.11])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8aada3d479dsm1802116b3a.39.2026.11.02.01.47.30
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 02 Nov 2026 01:47:32 -0800 (PST)
From: Yuqiang Sun <izaiahsun@gmail.com>
To: haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com
Cc: mhklinux@outlook.com,
	stephen@networkplumber.org,
	linmq006@gmail.com,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 2/2] Drivers: hv: vmbus: Do not remove the channel when device registration fails
Date: Mon,  2 Nov 2026 17:47:19 +0800
Message-ID: <20261102094719.35760-3-izaiahsun@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261102094719.35760-1-izaiahsun@gmail.com>
References: <20261102094719.35760-1-izaiahsun@gmail.com>
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

When vmbus_device_register() fails, it drops the device it was setting
up, and the device's release, vmbus_device_release(), calls
hv_process_channel_removal() on the channel. That function is for
channels the host has rescinded and starts with
BUG_ON(!channel->rescind), so the kernel stops there. Without the
BUG_ON, it would unmap and release the relid, unlink the channel and
free it, and then the error path of vmbus_add_channel_work() would do
all of that again.

Leave the channel to vmbus_add_channel_work(): clear the device's
channel pointer before dropping the device on the error paths of
vmbus_device_register(), and only remove the channel in
vmbus_device_release() if there is one. If a driver was bound, its
remove callback runs in device_del() and still sees the channel.

Fixes: c2e5df616e1a ("vmbus: add per-channel sysfs info")
Cc: stable@vger.kernel.org
Signed-off-by: Yuqiang Sun <izaiahsun@gmail.com>
---

Notes:
    The bug was found with kbound, a research static analysis prototype.
    The patch, the changelog and the test setup were written with the help
    of an AI coding assistant (Claude); I have reviewed them and tested them
    as described in the cover letter.

 drivers/hv/vmbus_drv.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index fc0f16f51266..e8fb0c4c4f5e 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -979,9 +979,15 @@ static void vmbus_device_release(struct device *device)
 
 	hv_debug_rm_dev_dir(hv_dev);
 
-	mutex_lock(&vmbus_connection.channel_mutex);
-	hv_process_channel_removal(channel);
-	mutex_unlock(&vmbus_connection.channel_mutex);
+	/*
+	 * No channel if vmbus_device_register() failed: the channel was not
+	 * rescinded, and vmbus_add_channel_work() cleans it up.
+	 */
+	if (channel) {
+		mutex_lock(&vmbus_connection.channel_mutex);
+		hv_process_channel_removal(channel);
+		mutex_unlock(&vmbus_connection.channel_mutex);
+	}
 	kfree(hv_dev);
 }
 
@@ -2189,6 +2195,7 @@ int vmbus_device_register(struct hv_device *child_device_obj)
 	ret = device_register(&child_device_obj->device);
 	if (ret) {
 		pr_err("Unable to register child device\n");
+		child_device_obj->channel = NULL;
 		put_device(&child_device_obj->device);
 		return ret;
 	}
@@ -2228,7 +2235,10 @@ int vmbus_device_register(struct hv_device *child_device_obj)
 	kset_unregister(child_device_obj->channels_kset);
 
 err_dev_unregister:
-	device_unregister(&child_device_obj->device);
+	/* The driver's remove, if one was bound, still needs the channel */
+	device_del(&child_device_obj->device);
+	child_device_obj->channel = NULL;
+	put_device(&child_device_obj->device);
 	return ret;
 }
 
-- 
2.53.0


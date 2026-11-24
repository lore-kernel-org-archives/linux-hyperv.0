Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795556458;
	b=hHIigH6RWtL9oPVPqeSsh8J6PprE6CTDE1OcuXYM0AxVRMnyYWsA4rNGROJeOjzmWBqu
	 jwmdWYrxicuL2qkAuKE+7ZF2y/WY40ZokPd0LS0xp7OIoPUHxPIxNet2ODCnBbMyTfqRz
	 FFduqnyhpvKMayZq5vUSaM2M5RKigMVDJd7g9V2E327EhxolH+/JtkwJnkwHHa0yaBo9S
	 ZgA3iNdE248xA4iMcY6SOjOZq9dTYD2Fj3U8QQ20E6MdISlg/R6Bh9jQNSwbXHgVMlrtY
	 EoMpW/RXFVawNM0SnP9MMekBN8LIgeEDynWhStXWElwK1Assn9pXW/ZE4RoHSgH9KiQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795556458;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=w42z6p6tUvCwMwZ0RdL3hWrj/QD/3zaQrRloQWU7Khg=;
	b=inUE+7iO0q8pXgLusWwLcUFoHtbCU+fyD2gUNhtgZGDmenS8+c1BZgaEflGigwVHQAjO
	 DFhL+7Q2rwzjAXPSswuMe47GrcmzSAD+z7XQG8fb/qiWL3qmPaqTX4BAueqMSyfykAmgG
	 VJgSsWQ0iVg8Sx53BJdHG/wjj2EGqXFv78dUCQX22TA/46n6Ka1WKmIt7Xa+h7vGlGg4e
	 5HaujzK9vv6OEbYVCFgA2NvREVMrANsuJDJXwtYZSNT1ZWMJzZKieAu+GHDu3iKO55FIk
	 bEcS8YPmJCE7iybvi5x6aRhxpxHH8ssjTXWqSz5gBp5dxuKSCTiPOHbK1r1/fA+UB3A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yjhCQDxj;
	arc=none smtp.remote-ip=209.85.217.54
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94FBD606A332
	for <linux-hyperv@vger.kernel.org>; Tue, 24 Nov 2026 21:40:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 94FBD606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yjhCQDxj
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-7777fa8f1ccso1884006137.3
        for <linux-hyperv@vger.kernel.org>; Tue, 24 Nov 2026 13:40:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795556457; x=1796161257; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=w42z6p6tUvCwMwZ0RdL3hWrj/QD/3zaQrRloQWU7Khg=;
        b=yjhCQDxjYobdGBu8sg3D0o233SJfjxrR8hjxGeet+/gqhco/LIWFYS8K+YCDPfmRK+
         OKDWwHCuqrJiLO7OxplHM2S7Lskshv4o/6p7vNeUvYsxEe9GXa8s+/OEuz+L+gGYpebJ
         uEGAohwARfNlwShXkRwrP/99abHe7V0XVbj8cEQXG5yHhwkPNea6BZqXRaTVtvk0slny
         eTr5WtB5t0KMXM9O8ugq+Qveem3q3tpNheF0QZGbv3+UJE0/P9CArEYuFm686gVj4hJ5
         0n2MWj4Q8FtyJva5Xs7pVRPe/IiDDAK5X4CteY5IgT9zUJm83rHWMokZ0uIS54L5Mt1X
         vDmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795556457; x=1796161257;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=w42z6p6tUvCwMwZ0RdL3hWrj/QD/3zaQrRloQWU7Khg=;
        b=R4PDU+em3Slqssgy8k0yye0tCrqJIslm0VrXzpgvuoKYZz7jq1M5Bp6ZNhBam0ohBI
         A8qgbtYTE2QhSgETgOPYfh+iIO2s7h5csbOY0S4Ter++094iUgH8Nlfd7AxEslzLCrXq
         /atLV6VlXgWFS4nwlVQlJOyoBXR1ZIMxi4FRekwBrN2Av+tDs0IUnffC3MU+Hcb/oau1
         OPvnQNhcRla+lUndUnLNLrTHLqt62295FIRXFdSgqsN2YwMTB7WHs/ZC7vMoSujMmeRt
         RAoUIx6T+fOCzEHIT+Bop/9GEGq6uFy+c/GD0askH4KhtyfZJphZHlnZPSItDQCMfRrV
         /How==
X-Forwarded-Encrypted: i=1; AL+hErG6Qui9W3b47ZCDR2bSoiqwObYHWgbVh2EeZ+W4MmqgNKmd4S8M8wv1M8YVA3rgQH89Q6jOXqQ9Vp/DvQA=@vger.kernel.org
X-Gm-Message-State: APuU4Z9t2OTkirII9T/sI3bHf+yDJCAT1svc8aJcM3xjRmNbF/bxyBEP
	6PM7iIpKKBaPlxbjoiEACEfav8hle1KM5ix4EDaILIF9nA3ep6N8bHbE
X-Gm-Gg: AZFdTZdELwD1Xx+52pijhKloGEJm/Jp9YV78uwS5Hfzu7TXT6xCAzlv/1+INjqDZByx
	xXMp+K46x7q5vUhdXB2B9Bv1z+5RXffWIZT5Gfry7ExQ+jNiloWxkN7kKheQXM+roRiiKAe1+5K
	CW7uBKsYaPlQb1ZJlUbTgkXTLPV0u3Q2YNGvETtkP3LqtfIYhA2ywo/D90TcCQF/LqzS/RhkY9R
	2bnaJmIsiotNvJUpTqnoxw6ZpInlWvbYFT/c3/CEeoGzs+RomwnA91if7w4GAvMm0QBqoS7PV5K
	53nKTKCxC1kEkWdvcHO4wT0k7UzfuK8m3BWtVlk4e3zL7e+R09Q8IXYkZ8dLlxV23XT3qZcgryl
	o7Y3wLCh7lyed2iEdKEIZqpKHX91Hf2U5G3epQ96TOeBFY2O9QuSiXBF3/Vx2gDjUwbft117Led
	Sk22MDVJnrl5Enj81kwSFIiwjWGy6Zn9AMTqI4gzx6j5l0yWI3l8XoQZWTLeAXjCE1wvbIpGKCX
	tzOUxoMyYIbHGyIzjcMSrefUKbhE5oSU4c/6tkdK6592T40PloyJ2/vg3PrKr5b037A6AsneGIY
	dgnu3lBtThKt3k53SBBzrCsTLewJM2GwzNC6J03V+H11GUbig9r/
X-Received: by 2002:a05:6102:644d:b0:7a8:2a34:432e with SMTP id ada2fe7eead31-7d739356a57mr7901936137.9.1795556457444;
        Tue, 24 Nov 2026 13:40:57 -0800 (PST)
Received: from emedev.tailf75c28.ts.net ([179.238.117.100])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-99e6dec57ddsm15952879241.1.2026.11.24.13.40.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 13:40:57 -0800 (PST)
From: Emerson Busson <emersonbusson@gmail.com>
To: Wei Liu <wei.liu@kernel.org>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Dexuan Cui <decui@microsoft.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Michael Kelley <mhklinux@outlook.com>,
	Easwar Hariharan <eahariha@linux.microsoft.com>,
	Kameron Carr <kameroncarr@microsoft.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/3] hv: vmbus: allocate requestor metadata with kvcalloc()
Date: Tue, 24 Nov 2026 18:40:29 -0300
Message-ID: <20261124214030.174246-4-emersonbusson@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261124214030.174246-1-emersonbusson@gmail.com>
References: <20261124214030.174246-1-emersonbusson@gmail.com>
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

Opening a VMBus channel allocates a request-ID array and bitmap sized
from the ring buffer. For a 128-page NetVSC ring, kcalloc() and
bitmap_zalloc() require multi-page physically contiguous allocations
that can fail under buddy fragmentation even when order-0 pages remain
available.

Switch both guest-private structures to kvcalloc() and free them with
kvfree(), keeping slab allocation for small channels while allowing
vmalloc fallback under fragmentation. Guard against a zero requestor
size and clear the pointers after freeing.

Signed-off-by: Emerson Busson <emersonbusson@gmail.com>
---
 drivers/hv/channel.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/hv/channel.c b/drivers/hv/channel.c
index c0bf154915..8547b10f3d 100644
--- a/drivers/hv/channel.c
+++ b/drivers/hv/channel.c
@@ -733,10 +733,13 @@ EXPORT_SYMBOL_GPL(vmbus_alloc_buffer);
  */
 static u64 *request_arr_init(u32 size)
 {
-	int i;
+	u32 i;
 	u64 *req_arr;
 
-	req_arr = kcalloc(size, sizeof(u64), GFP_KERNEL);
+	if (!size)
+		return NULL;
+
+	req_arr = kvcalloc(size, sizeof(*req_arr), GFP_KERNEL);
 	if (!req_arr)
 		return NULL;
 
@@ -763,9 +766,10 @@ static int vmbus_alloc_requestor(struct vmbus_requestor *rqstor, u32 size)
 	if (!rqst_arr)
 		return -ENOMEM;
 
-	bitmap = bitmap_zalloc(size, GFP_KERNEL);
+	bitmap = kvcalloc(size / BITS_PER_LONG + !!(size % BITS_PER_LONG),
+			  sizeof(*bitmap), GFP_KERNEL);
 	if (!bitmap) {
-		kfree(rqst_arr);
+		kvfree(rqst_arr);
 		return -ENOMEM;
 	}
 
@@ -784,8 +788,10 @@ static int vmbus_alloc_requestor(struct vmbus_requestor *rqstor, u32 size)
  */
 static void vmbus_free_requestor(struct vmbus_requestor *rqstor)
 {
-	kfree(rqstor->req_arr);
-	bitmap_free(rqstor->req_bitmap);
+	kvfree(rqstor->req_arr);
+	kvfree(rqstor->req_bitmap);
+	rqstor->req_arr = NULL;
+	rqstor->req_bitmap = NULL;
 }
 
 static int __vmbus_open(struct vmbus_channel *newchannel,
-- 
2.43.0


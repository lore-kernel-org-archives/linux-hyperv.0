Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6E8D3CB2E7
	for <linux-hyperv@vger.kernel.org>; Thu, 17 Sep 2026 22:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789682524; cv=none; b=FqJTaFhWYEQUeACgB4Dq7YJdWcY3P0AwYGeC8oueKEWEk1VOgV/sbtXBNFfJsx2OMzOGi5QktVpliWZmWVQMyvHiWKY44e+fiKGd64fyn9nGFv9d/ofDbcQspybJhT5xWy04Lx2r65twurw3cEc4Et5OXg89aGYO1PG9IUf5fpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789682524; c=relaxed/simple;
	bh=QVy/c3lL0T2G0QS0X5UQ0e+4FGDESG9uqf0mPCrckvo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=o27OM5D6WW4kE8/sO6LSSeuk8JhWgegHnSVfxMKZp4iDPOdmaMZLzEVMk+GA5+z89mE/7SoJ6/eWF9Y0dlcGdG7fwetppaSY00dhKryblz4dLHNgJI7RtGuCvQM2nQvToU8dHwfFd7mmdjKO581PmpWuFrB0FcD0XCQkYyYl6JY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isec.pl; spf=pass smtp.mailfrom=isec.pl; dkim=pass (2048-bit key) header.d=isec.pl header.i=@isec.pl header.b=Y6/eCdhz; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isec.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isec.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isec.pl header.i=@isec.pl header.b="Y6/eCdhz"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49ccf3ca626so586905e9.0
        for <linux-hyperv@vger.kernel.org>; Thu, 17 Sep 2026 15:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isec.pl; s=google; t=1789682521; x=1790287321; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BSXvhhtGESzI8UKfdlYrqnmXXZ2KSc85lByA5Tdkzb4=;
        b=Y6/eCdhzByIEr8UL7XE/BqM8RugkBpEfFydGDrY1jNK3+STmAaxSJ6qtlMqa34E65q
         0Cu3+7PQ/c4ci9HVsdxfvScqdZQ5svLUuKvguTpvrB4Re9xZx2ZJcg4k/gJjM1HUO9qE
         P+8RvGvdX4r17LbqhS4dZlZmM5eNl50xoX6gN6fKJIj+/lnpwwtypcEIMMwlcwPsChWZ
         3uSuyh6MJGPS32SL8xv14VJyXucWMs928Z4C9gnqTJZjwbiL3axQ1wnZbG2BNfdzpAVy
         R5LYeMrtx+LC1gSd1ldruQU+t2vNABVcmYf/I09r7ihr1uSG1+sTD8sJNi2HMcSt0eP8
         czUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789682521; x=1790287321;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BSXvhhtGESzI8UKfdlYrqnmXXZ2KSc85lByA5Tdkzb4=;
        b=HoLCWXzRxyvUJYXm8i3syerWXWSnjmqCBrgD/sumdUK/8Lw3Uw+arA3Zdo9eLtdK/+
         nf6kX+0t2Xd9xJu5ox0G6Ir9SAlsaMaIzgDkZ66QzFQvmq/it74zv297U7z/bJ+vEIbT
         1EJcGrwOlN0Qo8CrZrKEiQCFzTREbL0vz8LOb8b9zIMSemZ2zCImQNisSgbq1sAY2c6S
         oGEBxJUJX9TYtLvLyh2Kkw58ZXtQRUw5YpriJlqhbLfmtSsqaVTxF6oKCOVl0tTPxzHe
         8uDoAOgCbJ1E661ZqzzfPrfkS1qcZxWgVTErYFfFRFSNEnt+JEZz3AuEWjNKcQY6qvWH
         NZcQ==
X-Gm-Message-State: AFuF++kKlS/DWN5xmqeiMz1AWYQXIvPcLdsC1EM81D7qSADshAoeIstd
	ZskHyonDHakul2NYF9sOe5pVdlnAitPJQ4+Xxy8bCClwjqPuh1nknTbK5bjM/I/ZY5E=
X-Gm-Gg: AYBFou08e9vi57vfV8JOHNWVBVfqYEwRzOvWhgosWoEg+kxuWItMdEWbz0JJasPf1nK
	aJ3QwJ+MNyMfJQRU4E+WuTdyS/wpyHtEktDe17Ld4mKlCWf/RAFes/IDFRTxf6MdHK7gazwDMwr
	og2Zc0ip2Ud8rZh/52iGjdQ9YXc68SNyPu3MPZG6XGxG8fg8JUz0w+Cp4OzHh4nqhytiiq+Y4Oe
	DH8k5InQRoKHzVr+mG+fu6WYC63gK3lVA6VU/tXG7+4jdzfQp+VzUhNI5fcVmEKUeOxn/WyojNd
	PSd2hE1/l+8VJPKw5Z7uL9t5hIOruJT/pnRRQ1GSltVp665OtoZ8UpdXfmeAYj7U16p1vryZNJS
	MRSvJ3v/wiKYCNE5cNgoAyeT/dAFQ2Y8u6Lc9HthHR0/0XMtl590K2PIlijEowooJUFinLr5y35
	lR6mca1L9VlxQonbq8o9DI3NHg2mQmpAwYBd1WyyfcjPMQRALcmeK+bvOjaajOsX58W7rNn6GXZ
	dkrO4KAhEsh6Kn1T9QgEmC6r37edAbTBsj8N5yPOqy7f4c=
X-Received: by 2002:a05:600c:c48e:b0:49c:dcec:bd27 with SMTP id 5b1f17b1804b1-49fc5687122mr2528885e9.8.1789682520862;
        Thu, 17 Sep 2026 15:02:00 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a318:80b3:9080:744c:a1ba:d233:283a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4870bf344fcsm19794436f8f.26.2026.09.17.15.01.59
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 17 Sep 2026 15:02:00 -0700 (PDT)
From: =?UTF-8?q?Bart=C5=82omiej=20Dmitruk?= <bartlomiej.dmitruk@isec.pl>
To: Dexuan Cui <decui@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	"K . Y . Srinivasan" <kys@microsoft.com>
Cc: linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org,
	Stefano Garzarella <sgarzare@redhat.com>,
	"Michael S . Tsirkin" <mst@redhat.com>
Subject: [PATCH] vsock/hv_sock: reject incoming connections when the listener is being released
Date: Fri, 18 Sep 2026 00:01:54 +0200
Message-ID: <20260917220156.56015-1-bartlomiej.dmitruk@isec.pl>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

hvs_open_connection() only checks sk_state == TCP_LISTEN and
sk_acceptq_is_full() before creating a child and calling
vsock_enqueue_accept().  __vsock_release() sets sk->sk_shutdown =
SHUTDOWN_MASK and flushes the accept queue while leaving sk_state ==
TCP_LISTEN, so a host channel offer that races close() of the listener
passes both checks and enqueues a child onto the already-flushed queue.
That child socket (and the VMBUS channel opened for it) is never accepted
or cleaned up and leaks.

The virtio transport guards exactly this case in
virtio_transport_recv_listen(); hv_sock lacks the equivalent guard.
hv_sock holds lock_sock(sk) across hvs_open_connection(), so the check is
race-free.

Signed-off-by: Bartłomiej Dmitruk <bartlomiej.dmitruk@isec.pl>
---
diff --git a/net/vmw_vsock/hyperv_transport.c b/net/vmw_vsock/hyperv_transport.c
--- a/net/vmw_vsock/hyperv_transport.c
+++ b/net/vmw_vsock/hyperv_transport.c
@@ -324,6 +324,14 @@
 
 	if (conn_from_host) {
 		if (sk_acceptq_is_full(sk))
+			goto out;
+
+		/* __vsock_release() may have already flushed the accept queue
+		 * and set sk_shutdown = SHUTDOWN_MASK while leaving sk_state ==
+		 * TCP_LISTEN.  Enqueuing a child now would leak the child socket
+		 * and its VMBUS channel.  Mirror virtio_transport_recv_listen().
+		 */
+		if (sk->sk_shutdown == SHUTDOWN_MASK)
 			goto out;
 
 		new = vsock_create_connected(sk);

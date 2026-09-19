Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDA0E19B5A3
	for <linux-hyperv@vger.kernel.org>; Sat, 19 Sep 2026 12:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789821098; cv=none; b=VhVo6Gpbb8hDF/Go+0BLwcJDoojw8XU7bRlphaxOw/Eq8AgOaFsoJGhaZ/svDQdSc+d8M1j+GJep3NyC8pQkPNCgN5j54pPcmjYw5teb1SLTS9udnfwishhtIcnKPyAcJC8bWZKaP3wSi+x1lSsu1ALsGj+kNRLTCVAa9fvF0TM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789821098; c=relaxed/simple;
	bh=roY2IqwHzwrcrhsrQDrMg9vMQMIiXHYHrXRILhi6xxQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Wc7n8sYAgJ4SXMwyBDNekkfdUvkkqVDt8LoK6Mv1BPBfPxutIP27xdxhTrMr6/oXy5WEDgCNi8E22c5Wda8zGbK/8DwXId+SLOQjypPZuhS4ThFZfLAzhpCEPTfVIFH6D5yD32QadX3dWtuWllqGwntEd7/ls9OWvajsSMbg1Uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isec.pl; spf=pass smtp.mailfrom=isec.pl; dkim=pass (2048-bit key) header.d=isec.pl header.i=@isec.pl header.b=cS1zikkN; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isec.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isec.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isec.pl header.i=@isec.pl header.b="cS1zikkN"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49ce364488dso4333655e9.0
        for <linux-hyperv@vger.kernel.org>; Sat, 19 Sep 2026 05:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isec.pl; s=google; t=1789821094; x=1790425894; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AWoa1wKmbRq3MEqfsLgwsOWlgxTV8JygGlO2bb0IVX4=;
        b=cS1zikkNnZ/oTE/4e95a25qRP351V7cwgo5zRq5/pMo+JBSy/tqYy4eKlxuTnsempT
         vN5gk7v14Luo2oN7iPNKEHINip4YNMR52K0+pwEmHfMiRyp9+CzleJ0+Q3Gcgz+lQTKV
         ZvEqMdIv5KAWi+TAG75zPZqpzYbZdm/VCiZwHS3B7BwQ4WYXmYGbeRm1NfnzexYUVW7n
         lnU0AE93pQMO84G/3BUCcui3pl2InrbX8Ha6C0mnqOFGPOZReSB5zVkN3y/5v+WqWwkK
         O7UtqRbYO8ryiOcNARAAJIq9Qx3d6fP1krk443mMfJU20JHTC1ZZucvfGF+Kk7vXRxPN
         iDZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789821094; x=1790425894;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=AWoa1wKmbRq3MEqfsLgwsOWlgxTV8JygGlO2bb0IVX4=;
        b=MXe/7vqGOEiveoEcbSlq2FjJWl6IObrr5RQ5/ak4qxrRkPCQae1ALZvaB5eHAgMDwZ
         E5HgBS+s4vim3MeiMtseNdN3WqSKc19htlEC2VwDcN55N9sNy7qKav/goMTUs3+x18N/
         U4FvMpJLTnH8y7YjX0AJzIfz1QQ0Fl/i5lADHioFC6H3ZKBuOXwk2WgjeJ3Ye+jPjymI
         pHMhN+BZGAxi4a+CTgYLJ/IedVyiEQVpnePS68Ae9wPQlpAKVCs1wM2A96OvN2ff/M7k
         rP8KPGmN0QzkA3HmwZ9wS8jjOCdpxjWCWGnILB5Mj8ttrX53rpNbL1tz/TSDcSJxdnlr
         GV2w==
X-Forwarded-Encrypted: i=1; AKwUvBxJcvEodzTUKmQY+axC2F4JTAsMeznwwv7k09JY6GerBt0p3fS0UpnQzEvK9Q4xaqogmiK86nNsP6GqiZY=@vger.kernel.org
X-Gm-Message-State: AFuF++m+46QIQYvuRk2n9ANnAJPxtiFNGH7BEUFnNR3fKVRQiuu7zHOM
	oP/qWitQ2kwPKNRzuAfk9qOXAJw5NIvPOwE6FKtuQZ24ApgKmvDrF1tcqbwlb/vxNn4=
X-Gm-Gg: AYBFou0gJGo71OCYMPtxIHeCF1epFy4GwTJu7pRKs4O6UoTccRERNAl9i9TlBhnvxHI
	BmAMcWZMc4g5LRNCRYBmU/uJ55XFGohxX0eSM549F/lg8+kDcNxaB0O3TNHPywcNB5RGpVTpXN5
	A9kB7XIC35iqMvaCZf4dja/e1cdgDLSB0xwIe6/Qd++7MTXB/HESc+e7a+2V3gRcGjix/3cW2O5
	Md+NDEx8NcToTxr4VudXMpCnjb7/Z2XAuQ5XkVs3P6/Z5za52ZDM6R4sGXRgVqEhnU/E4VWCDKC
	q2Jy5LzVS9CjFv6PRNfeGbZ739656BjVHtHbRDBk4t4cIXBbPhCknGyKdx3beGeE6meXl+eaR0N
	VrLtQaRd+s9lJiEEPNYgPdIKcEe1ClviSzs7AQeffIkEb56nkLd6ZqvCxTfyHd3LNE3CjZilCug
	ps73uhJynBGZg3GPtEPmXCWbtTFfGF2gcKWyI3Cc5QetVwLB7WrNXWVTguJG/gnOM4G58BeqMH7
	WPPYZbIWC/6RZJrPsODyr4P4hPBvHBk/YI+ZtvJW+8eI8M=
X-Received: by 2002:a05:600c:1389:b0:49d:2936:8ad1 with SMTP id 5b1f17b1804b1-49fc4f71c7dmr84366785e9.1.1789821093959;
        Sat, 19 Sep 2026 05:31:33 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a318:80b3:9080:dcd8:ca10:f229:8aed])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48724562aebsm7118300f8f.14.2026.09.19.05.31.32
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 19 Sep 2026 05:31:33 -0700 (PDT)
From: =?UTF-8?q?Bart=C5=82omiej=20Dmitruk?= <bartlomiej.dmitruk@isec.pl>
To: "K . Y . Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>,
	Stefano Garzarella <sgarzare@redhat.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	"Michael S . Tsirkin" <mst@redhat.com>,
	linux-hyperv@vger.kernel.org,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] vsock/hv_sock: don't finish a connection on a socket being released
Date: Sat, 19 Sep 2026 14:31:27 +0200
Message-ID: <20260919123128.28868-1-bartlomiej.dmitruk@isec.pl>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

hvs_open_connection() only checks sk->sk_state (TCP_LISTEN for a
host-initiated connection, TCP_SYN_SENT for a guest-initiated one) before
proceeding. __vsock_release() sets sk->sk_shutdown = SHUTDOWN_MASK and, for
a listener, flushes the accept queue, while leaving sk_state unchanged. A
VMBUS channel offer that races close() therefore still passes the state
check and either enqueues a child onto the already-flushed accept queue
(conn_from_host) or completes a connection on a socket being torn down
(!conn_from_host); the socket and its VMBUS channel then leak.

The virtio transport guards the listener case in
virtio_transport_recv_listen(); hv_sock has no equivalent. Add a
sk_shutdown == SHUTDOWN_MASK check to the common path right after
lock_sock(), so both the host- and guest-initiated paths bail out.
hv_sock holds lock_sock(sk) across hvs_open_connection(), so the check is
race-free.

This was found by code inspection; I do not have Hyper-V hardware to test on.

Fixes: ae0078fcf0a5 ("hv_sock: implements Hyper-V transport for Virtual Sockets (AF_VSOCK)")
Signed-off-by: Bartłomiej Dmitruk <bartlomiej.dmitruk@isec.pl>
---
v2: move the SHUTDOWN_MASK check to the common checks after lock_sock() so it
    also covers the guest-initiated (!conn_from_host) path; add Fixes tag
    (Stefano Garzarella).
v1: https://lore.kernel.org/netdev/20260917220156.56015-1-bartlomiej.dmitruk@isec.pl/

diff --git a/net/vmw_vsock/hyperv_transport.c b/net/vmw_vsock/hyperv_transport.c
--- a/net/vmw_vsock/hyperv_transport.c
+++ b/net/vmw_vsock/hyperv_transport.c
@@ -322,6 +322,15 @@
 	    (!conn_from_host && sk->sk_state != TCP_SYN_SENT))
 		goto out;
 
+	/* __vsock_release() may have already set sk_shutdown = SHUTDOWN_MASK
+	 * (and, for a listener, flushed the accept queue) while leaving the
+	 * socket in TCP_LISTEN/TCP_SYN_SENT.  Proceeding would enqueue a child
+	 * onto a released listener, or complete a connection on a released
+	 * socket, leaking it and its VMBUS channel.
+	 */
+	if (sk->sk_shutdown == SHUTDOWN_MASK)
+		goto out;
+
 	if (conn_from_host) {
 		if (sk_acceptq_is_full(sk))
 			goto out;

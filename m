Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793968769;
	b=VCJU1Hp8SCztnDTjHZBZTTHXCg3gsMK2jXoPv3XZ6g4hDj1nWi3JTTezbOJrARdZ1RKv
	 W+xmM8siOPfWQogDLFMw5DvUdAxkmjd/6XDp+jBLOKwUVVb1qZ6znOYgZMr/UYPEtwEfk
	 iIjRMc1tEGS4AlcdVu/8hrjadOJmH+B/re9lSG+Uc+dC5gA0j7+/0K2XGhRYOO1JvOb+1
	 WIbkzeSZpjOg4C4XYftGK4sUTaSHqofK+wHc9FHh4aC47Y7eUb2jFCFfdfUp2gD5owVjp
	 inh/V2MwNsDFiw9P39+CoMbQnV6HsRo8wqsxtCOsVjw/R12CUByZYnMIslpQtScnRpw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793968769;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=V/kcDgdJ3DHGubMyO4u6UCH7vslZXXrvBf4tKHWtNGM=;
	b=VQIVfPu+6qbhCrjP0kePmI194s4+xERjjHAjw3imWnzOMbBNuhJQZmizAUg8lvMWov7l
	 TbqwoaAKFnK72osvX7M6AhglWCHtkgx4FhMEV+x5UbymVVvzMIMkx5rpVBwwFl5NYNRHu
	 rhBXY82tlxh5axaaZxY93rkk/kg2LK4JkL4OEbHI9RRHhuGiNC5ZJL0UuvU0+n9Rj84fj
	 sTp0Zv5s1pVDuh8WJBZW2Nv/z3+XQOtUyxt6TEWPqPdoPpOfd9KJSWzHoO/3sdZwcoMkz
	 xGvYoJumPaQoHYlvie2IwhC6EAK6Sq4ysB8RyTMu1YVoh4zPbUqoedCvm8gZNLV63ng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JVGE5zOO;
	arc=none smtp.remote-ip=209.85.221.41
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08766606A32F
	for <linux-hyperv@vger.kernel.org>; Fri,  6 Nov 2026 12:39:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 08766606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JVGE5zOO
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-48b001cd92bso326685f8f.2
        for <linux-hyperv@vger.kernel.org>; Fri, 06 Nov 2026 04:39:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793968767; x=1794573567; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=V/kcDgdJ3DHGubMyO4u6UCH7vslZXXrvBf4tKHWtNGM=;
        b=JVGE5zOOaEbByQQGxTsCgkBcDpIMcDkVsz3ghCKe7umPhL/lyJaKBzWW1nwTf6Eb6m
         jjSJvEW40hyae6cFqUnsV4Vo5dk2Tl4gNQaK7GriRjkdT++TwgmvWYFHpTxmz7aj5f3R
         Ep82Pk+GfGvCGJ0r7mz4fwcigklpdpSq0MINTv3vxhrDLbfrYOvKwTsIdMbHB4B4h3eY
         RNN7ajH95YjGwhf1wlivpaTlYy3/pqe+QJC5hQDUAfN/uaUJLef/vrmRan5VyIWO5Ue9
         ZA9RhzjNvOB0/wvp3NEKC7Fb3Tk/qjSqBWhmobAUeGybhl5RD/P3UOWvJiFch14OyJd5
         cwjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793968767; x=1794573567;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=V/kcDgdJ3DHGubMyO4u6UCH7vslZXXrvBf4tKHWtNGM=;
        b=UQyvCny59Nqcm5tHE9ILlroRD/TuofbfpahEFQ6vSbAcGcQNtJcXUJ7t4DNIc24bLz
         dHs5cC3buXRy2gPz/9NczCj2KZGoxeWjZEdK4CSiLLtjbg+c/kXF3LAkGAkjBu3gZgyd
         ScGL27t9BtquaXNS5WVeEsxhIznFvY1FCzekyBQVJBVj79Nf7pU1nT5XFwqk4W+we3UD
         SPsU8fh5FJAUdku1BuPFW3RSkz+QbFwOJQYRuz4EcXGlCcrozkOERtgdkndfGB9zaB9f
         OgnDAJILihzqHqwbo6f7Ao3U6yvnGPh+apA4FovwE8Mk2NhQUxaDXyXCWsbzsciTZn4s
         Qkfw==
X-Forwarded-Encrypted: i=1; AL+hErHcQy9782xMLGcocKTYE/AWOYOWfu4MS+cfhkrf/3j6vJP7RUKwU0keK4V/cPcMHjtO/PTiMEgD0bymEm0=@vger.kernel.org
X-Gm-Message-State: APuU4Z+Fx9nPi/pbTUsSJOXh8LKTTx4OozvB1vyrkyBa0qku+0Lo3wU8
	4+YIlThBXT+xXVdLyI0x3DERKInsklxoH9PHOA7a3bYgXIMKAps5vQlW
X-Gm-Gg: AYBFou2JtaIhfOc62kEJKG21XO6TdtctTRFl2VdE6IV/K5bpo7EGSPsqJbTAoEAJY1t
	l4mteSZiE30wp2LBb79v4DLg86OXlc4mXby0vkFnsgrVtP49iQIF0HEGyI6Wl7lYMWN/jFeD/VN
	QDdC1rdnlXfoOr5CILw9+RYGDfhh6EtrjxTHHhErNOCX2POtuDbBh3E3qSHMPCWctZiWHNb6GrC
	fSfoOoEM/APywB524snXsGN+r1A56wJTvErf8635whKmJfQjqtWsimIZ23Vpxa7lqZHYwAEr8aG
	Tjk3izk+w8igAxNVF8RrFDhOoOioLAnfXyVenmrbDGRMB3cXToMSfEkXyR1e+DidUWOLg6bMj1B
	1ZXNY6JmZUQwICyLeAxmgJ+HzZMii73vYO1eyL3H2wd6r0MvJ44fDj3yZRLT5d8fOEDoKW/jAm3
	NQIcGAj7AMBKhz1ulSmJRAFlNlofpni2H3yFVWNA8mOrbomJOarISHm+OhYsTd45iKj9uMFQVpo
	JxIuY1/2PHC4YrH5GJX0HrgKv4DM0N7tNZBnP868zMyBUKlgc/32nBihIWF2JNj2NZwfCW4pqnM
	Um24Jhmv7JfdU6V05aH9GHc0D/WNvpWDTon79waAQsyt5u/qhSrCDDQBErWrWurgSOZgNbARpvv
	xVgBhgcyzOb1TMDkffClqCxuc/+1e
X-Received: by 2002:a5d:59c1:0:b0:48e:3df8:74cb with SMTP id ffacd0b85a97d-49273e5b29fmr5340663f8f.6.1793968767067;
        Fri, 06 Nov 2026 04:39:27 -0800 (PST)
Received: from andreayoga.localdomain ([151.37.255.194])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-492d6d63ae2sm3776938f8f.11.2026.11.06.04.39.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 04:39:26 -0800 (PST)
From: Andrea Parri <parri.andrea@gmail.com>
To: Stefano Garzarella <sgarzare@redhat.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Andrea Parri <parri.andrea@gmail.com>,
	Bobby Eshleman <bobbyeshleman@meta.com>,
	Simon Horman <horms@kernel.org>,
	Luigi Leonardi <leonardi@redhat.com>,
	Xuewei Niu <niuxuewei.nxw@antgroup.com>,
	linux-hyperv@vger.kernel.org,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] hv_sock: Report no unread data before a channel is available
Date: Fri,  6 Nov 2026 13:39:18 +0100
Message-ID: <20261106123920.162131-1-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.53.0
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

The Hyper-V transport is assigned before the asynchronous VMBus channel
offer completes.  Its zero-initialized hvsock therefore has a NULL chan
until hvs_open_connection() associates the channel with the socket.

SIOCINQ can query the assigned transport while the socket is connecting,
or after connect() fails once the transport has been assigned.  Unlike
poll(), that path does not check stream_is_active() before calling the
transport's stream_has_data callback.  hvs_stream_has_data() then passes
the NULL channel to hvs_channel_readable_payload(), and any user in the
guest can trigger an oops:

  BUG: kernel NULL pointer dereference, address: 0000000000000178
  RIP: 0010:hvs_stream_has_data+0x23/0x120
  Call Trace:
   <TASK>
   ? vsock_ioctl+0x74/0xf0
   sock_do_ioctl+0x42/0xf0
   sock_ioctl+0x27d/0x310
   do_vfs_ioctl+0x700/0x810
   __x64_sys_ioctl+0x7d/0xf0

Return zero unread bytes when no channel is available, before accessing
the receive state or ring.  Leave the existing channel-backed receive
handling unchanged.

The oops was reproduced on an unmodified v7.4-rc1 kernel in a WSL2
guest with a small user-space program, available on request.  With this
patch, the program reports zero unread bytes and the kernel logs nothing.
Other vsock_test cases were not run, as most of them need a host-side
peer.

AI assistance was used to identify the issue and develop the fix.

Fixes: f7c722659275 ("vsock: Add support for SIOCINQ ioctl")
Cc: stable@vger.kernel.org
Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
---
An alternative is to check stream_is_active() in vsock_do_ioctl(), as
vsock_poll() does.  That would also change SIOCINQ on VMCI sockets that
are not connected yet, from -ENOENT to 0.  I kept this fix in hv_sock to
limit it to the crash, and can send the generic check separately for
net-next.

The reproducer is a new vsock_test case.  I have not posted it, as
Documentation/process/security-bugs.rst asks for reproducers of bugs
found with AI assistance.  I can send it privately, and will post it
once this fix is merged.

 net/vmw_vsock/hyperv_transport.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/vmw_vsock/hyperv_transport.c b/net/vmw_vsock/hyperv_transport.c
index 855b15971c359..551eabe690144 100644
--- a/net/vmw_vsock/hyperv_transport.c
+++ b/net/vmw_vsock/hyperv_transport.c
@@ -697,6 +697,9 @@ static s64 hvs_stream_has_data(struct vsock_sock *vsk)
 	struct hvsock *hvs = vsk->trans;
 	s64 ret;
 
+	if (!hvs->chan)
+		return 0;
+
 	if (hvs->recv_data_len > 0)
 		return hvs->recv_data_len;
 

base-commit: 475ff14ba558bb8857bca878f1d593784ccc4f0f
-- 
2.53.0


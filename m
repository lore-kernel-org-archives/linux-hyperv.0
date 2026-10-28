Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793203517;
	b=BJ5J3+JRuqK8oxMvD3Fm0aUkklXgsUDxtbjJcnSCPJXuHfIoyVACkV8etsC2cOPPVHl7
	 KdzeplFjwQMI80KnltxoA0YEXSn/YfKJHnpcjhBa7/P0/ZpUeDXomMh7axwBHWvufJJGV
	 I9OhxsrUIbXwD8L7EBv8sXpjcVlcsvyBAhwu8IIvFPZeyPGgYsVsfIqJDnvVpdz7m2AW4
	 xTxUKl7ZlJUP4tmW0BJY2VMNzVbHmroWMQ1aDoz7pp4K9AgIouGaUB2a7BilPVZE9Gzna
	 bdxxjxG/RTXkcfQ6sjyBg3y07M8qVfEIZgCnyy3vVN5PGuIkCmpA7/mR251wS3NPP9g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793203517;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=nEyeX3aqTLompuWb5IEEzexFWok9xp4lREyH12ON5qU=;
	b=Cy45UZdwBckwyQFLoAQaM1sORgRjdkvhOhh/8mEpN//z0erEIi/9KEvzK5ZpFbnkFTKj
	 OhhbPpdLWKxoYsxBVf7KmNEM+NY5fQOsbora6x7k6tvSThnUVvmctu8YaI3hF7D78DRtJ
	 eBPMeoXTEAvtT5DeK5HhVvlSobVrb1Vt3QwVDFg2vvkCYBHAZVOpkdcrpHAeoVcrFfFBt
	 G20QsUbIsyhgGkgi6sgjK36rsYvpdARI8umxtzHedSDZM5kBXPbYwEZToN7qOW//zfiQ5
	 9bmBOOfZU7iySBiXhh7IDAo3IrHLiJlloygBfMZiwIsK37rBTWgjTtpIa2ZDzf+1kDw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b="KNBAq/uV";
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b="cT2u/K56";
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09118606A332
	for <linux-hyperv@vger.kernel.org>; Wed, 28 Oct 2026 16:05:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 09118606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=KNBAq/uV;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=cT2u/K56
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793203515;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nEyeX3aqTLompuWb5IEEzexFWok9xp4lREyH12ON5qU=;
	b=KNBAq/uVhozscSg7642/j7MHQoxobMpNrwGKKBpmGfFqARFwwo6Hje1kCrV3bauzGKMYir
	w0UUs5O2rSvsI8+ITJBBUU7G3BYVZGtO+JDWrOxeoE7KaAtzVVnPK7zBwtkL2+Ti7BUBaI
	bAIYXDrEisIxo37p24UZoa4+dCepUGg=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-333-8kQPMwcXPw2TWYG1H8mFpw-1; Wed, 28 Oct 2026 12:05:11 -0400
X-MC-Unique: 8kQPMwcXPw2TWYG1H8mFpw-1
X-Mimecast-MFC-AGG-ID: 8kQPMwcXPw2TWYG1H8mFpw_1793203510
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-48e0af48c18so884425f8f.2
        for <linux-hyperv@vger.kernel.org>; Wed, 28 Oct 2026 09:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1793203510; x=1793808310; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nEyeX3aqTLompuWb5IEEzexFWok9xp4lREyH12ON5qU=;
        b=cT2u/K56l3zZjYNJrBqB4Lh9/tx/4yBbDbKGa45jbwS3YjSbIUHeJAA4ghFpusZ2Ew
         77nJhPyxDW3m64XOHjBh7trFHTU9z8I/cpen4Dzs8AB1ZteLeqPJxHEXDvZNUNdW3/58
         f4V1zYvqhpmq5dcaTePtE3esUnbbW5LrYO7cxEmUg7VZZ+AkkBHmJnuHxzLpHVPTK0jV
         VQJvHkCLpHW1ggDAl/Id9LN5jPwr11R0jmYTDWGMXz96jFPKZm5hNsacDCRqoSA2k3p4
         bmQ6U3FpLGQJFLQgiLh6Gty+YRcUGmFiV8kw5vL8pyUYqlhRKyFpNELX5oPGC92gK0FU
         NwbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793203510; x=1793808310;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nEyeX3aqTLompuWb5IEEzexFWok9xp4lREyH12ON5qU=;
        b=GKSodSlpnQBICeUzxechBngAPNUNWvvUk+eNaQ7ST2RNcuJclmQG1KH0noYD1HJKiH
         Q8Oea3JKkeBviXcskXoVI9vn9EXHaEt/9Gsc/J0kUr/y3oY9sgCBVbQHoVBQqIMSP5pr
         h7w7QAin0wsRXXig4F1BQ3vnr7I4bWU8BJ6ZR9HG6EBQ2d9uT9DKFt46oijYqig+w3qI
         i23EfNoC8pCFnfwPWy8+SY6JICasK1XXBcMSi4XQV6e9YvrkTVue61G75cDMya8A6Ofp
         GrfSrLZK6XsJaWH3traZREgrGTcxZAoTZlJKH3Ap3Heiqd0B/5lSWOFszobQMIpyTv+I
         6IcA==
X-Forwarded-Encrypted: i=1; AKwUvBzuo0OraYyRHa0RAAGUQ96k33kIpRi8saNd9gKl1yUePYbN9rlwoaYg761lXN0gQNjDcVUypb67lH6uZfY=@vger.kernel.org
X-Gm-Message-State: AFq9FYI39pM2NK9qFYL8HLApWb5c9LFsANY7L6MC5i2ONPdUG68aWhTR
	HP/y7skXmz0rH1S3XVSnSAjHvC5jUrFm/dfxONxQhiV1d8uPr1K1lpbhIl9fSj9dPJbMHBrCIYq
	MyaA11q7XHVEPo3VeDdfrhBO4rB9hLrXzpSv2aNFEjHB+QUepTHitKbD/gan8Fegd1A==
X-Gm-Gg: AYBFou1oQtw8ZbfWHNgC91vCKyaR7noVab6ZMhwo0XKKFhoZ2Khefgbw9tQD3ry4pya
	B4i7nr3idddSnO2D6dtWAyX73o/rzfLuYmRcvTANgdPgLKdLcwbthwdXQt8dCpi6Xcwmff02uJg
	fbUEbvy4lw4609e0FKrJjHjqm8UY2IUH73kGJdWGFNz7DPP94XhpXYHNpwsOkPmNj10XryXWGPF
	0LkMGbegb3WivwUeOU4kZuDGbBlucwGGgzuqPYwBIVfEECgI51ofVc8FhXuYgQYXIc6ddYKo7QV
	RedGW6Y0pu63yoO8dM80KG5otLx6Wx9JhNDIycnDvus/HkB0CubiZ2ZqyzG07SxSvwrZ2o94pcb
	3vNPeYwr2/Ssu3wF3CWN5gwUskF936ulyVpmPdwd3XNcXHfJweT91lzMGWuWfxGzltolDLnFAtV
	buPJtyY4RuI6c=
X-Received: by 2002:a5d:6191:0:b0:48e:75f:477d with SMTP id ffacd0b85a97d-48e5d288b60mr5160453f8f.7.1793203509881;
        Wed, 28 Oct 2026 09:05:09 -0700 (PDT)
X-Received: by 2002:a5d:6191:0:b0:48e:75f:477d with SMTP id ffacd0b85a97d-48e5d288b60mr5160376f8f.7.1793203509240;
        Wed, 28 Oct 2026 09:05:09 -0700 (PDT)
Received: from [192.168.0.19] (217.red-88-4-146.dynamicip.rima-tde.net. [88.4.146.217])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ebd47basm31898410f8f.32.2026.10.28.09.05.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 09:05:08 -0700 (PDT)
From: Sergio Lopez <slp@redhat.com>
Date: Wed, 28 Oct 2026 17:04:37 +0100
Subject: [PATCH RFC 8/8] vsock: add datagram tests to vsock_test
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
Message-Id: <20261028-vsock-dgram-support-v1-8-e457cf7cee78@sinrega.org>
References: <20261028-vsock-dgram-support-v1-0-e457cf7cee78@sinrega.org>
In-Reply-To: <20261028-vsock-dgram-support-v1-0-e457cf7cee78@sinrega.org>
To: Stefano Garzarella <sgarzare@redhat.com>, 
 Bobby Eshleman <bobbyeshleman@meta.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Bryan Tan <bryan-bt.tan@broadcom.com>, 
 Vishnu Dasa <vishnu.dasa@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
 Dexuan Cui <decui@microsoft.com>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org, bpf@vger.kernel.org, 
 linux-hyperv@vger.kernel.org, Sergio Lopez <slp@redhat.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=40322; i=slp@sinrega.org;
 h=from:subject:message-id; bh=TIwuWd7i1+qWGmyOY30SaVBp/DeXM1FXCyycqwV80Vk=;
 b=owEBbQKS/ZANAwAKAfRpJ40vDAI1AcsmYgBq4h0htLCtYL3MYVsmGrp5FLdiUPazEV5O7J8jw
 pN8fDSY1+yJAjMEAAEKAB0WIQS+1fz3US2GgJFC6KL0aSeNLwwCNQUCauIdIQAKCRD0aSeNLwwC
 NU1FEACfCEdwEkGyP21Q4FVO40H0HO7z5fvC8+M82QO3LS96OgAppqur1laeb+UDTZSRL1WcERY
 vwfHnJG5/IUIbhn7DZFhpmp0zKVurgvTHAdho1OZZcndCtI9Kagkc29Ev7W6zCWtCN+Oq+YG/ui
 lWJuGwCve/KVuCZ58CuMxebwCUI2L5z0IXY2ZJzun/uinpmCBHlWJFx887E9QQWR1EwfMJGPo2l
 fj7Fovkn/48vmA0uGn6fH7oVLWudyI+iH/MN4cNg07yRuDOH8ohzIyPEaoksKYaZUoQY88tpDB5
 iawf5uLfK27ThHqguFdH01Z/Xgqot9U6PYoUMrDhsloVSb1qYTNaJrZpgvcMKVmtESZmNDPSzz7
 AnS9vJ0ijqf2DP8PJgrpE3Hx6gOm1xSDYmzToY8j3eEfxeZ9y1dZ+1DDw0gFqFBnJrOXKOvSWn1
 kCjIJHz9JEeKV+293POOZJu1e0amrJbkR5JcTkCFziwRIqHMyD8L5WnmoLVYBmpg41WFEuixZ8C
 UAL/CzGLkZ9WCl1vpT2fROvhY/iWz4e9c0EwpV1FhpPaP4DyinuVrPtBBvHFdHEFtb1URR5LGED
 uayEqcSMg2IpJZkqtZ+MWY4RYzHUUHmH8aofpW5NQsltpeBvfTIxxCRGZ24Ye9HIxlcjtSWoreE
 mKjWFdF7ucwY14w==
X-Developer-Key: i=slp@sinrega.org; a=openpgp;
 fpr=BED5FCF7512D86809142E8A2F469278D2F0C0235

Cover local semantics, host/guest transfers, routing and queue
accounting. Synchronize capability-based skips and document manual
checks.

Signed-off-by: Sergio Lopez <slp@redhat.com>
---
 tools/testing/vsock/Makefile           |   3 +-
 tools/testing/vsock/README             |  23 +-
 tools/testing/vsock/util.c             |  62 +--
 tools/testing/vsock/util.h             |  10 +
 tools/testing/vsock/vsock_test.c       | 154 ++++++-
 tools/testing/vsock/vsock_test_dgram.c | 809 +++++++++++++++++++++++++++++++++
 tools/testing/vsock/vsock_test_dgram.h |  26 ++
 7 files changed, 1055 insertions(+), 32 deletions(-)

diff --git a/tools/testing/vsock/Makefile b/tools/testing/vsock/Makefile
index 88211fd132d2..78e2cb7b1193 100644
--- a/tools/testing/vsock/Makefile
+++ b/tools/testing/vsock/Makefile
@@ -1,7 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0-only
 all: test vsock_perf
 test: vsock_test vsock_diag_test vsock_uring_test
-vsock_test: vsock_test.o vsock_test_zerocopy.o timeout.o control.o util.o msg_zerocopy_common.o
+vsock_test: vsock_test.o vsock_test_zerocopy.o vsock_test_dgram.o \
+	    timeout.o control.o util.o msg_zerocopy_common.o
 vsock_diag_test: vsock_diag_test.o timeout.o control.o util.o
 vsock_perf: vsock_perf.o msg_zerocopy_common.o
 
diff --git a/tools/testing/vsock/README b/tools/testing/vsock/README
index 680ce666ceb5..be34b032ef13 100644
--- a/tools/testing/vsock/README
+++ b/tools/testing/vsock/README
@@ -5,7 +5,7 @@ Hyper-V.
 
 The following tests are available:
 
-  * vsock_test - core AF_VSOCK socket functionality
+  * vsock_test - stream, seqpacket and datagram functionality
   * vsock_diag_test - vsock_diag.ko module for listing open sockets
 
 The following prerequisite steps are not automated and must be performed prior
@@ -32,7 +32,7 @@ Invoke test binaries in both directions as follows:
                         --control-port=1234 \
                         --peer-cid=2
   (host)# $TEST_BINARY --mode=client \
-                       --control-port=$GUEST_IP \
+                       --control-host=$GUEST_IP \
                        --control-port=1234 \
                        --peer-cid=3
 
@@ -51,6 +51,25 @@ suite run, e.g.
 
 For more information see Documentation/dev-tools/kmemleak.rst.
 
+Datagram tests
+--------------
+vsock_test includes datagram cases in the client/server runs above. Unsupported
+cases print a skip reason.
+
+Virtio/vhost datagrams require kernel support on both sides and a VMM that
+negotiates VIRTIO_VSOCK_F_DGRAM. Load vsock_loopback on both host and guest for
+the local cases, and make /dev/vsock available. VMCI's dedicated datagram
+transport takes priority when loaded, causing virtio/vhost cases to skip.
+
+Run only the local datagram cases without a peer or TCP control connection:
+
+  ./vsock_test --local
+
+Use --list and --pick <test_id> to select individual cases. The BPF admission
+test (48, requiring BPF privileges) and nested routing test (49, requiring both
+virtio and vhost transports) need explicit selection. The VMCI queue-length
+test (53) runs only with VMCI.
+
 vsock_perf utility
 -------------------
 'vsock_perf' is a simple tool to measure vsock performance. It works in
diff --git a/tools/testing/vsock/util.c b/tools/testing/vsock/util.c
index 299a4e8ecb63..6ad97403697f 100644
--- a/tools/testing/vsock/util.c
+++ b/tools/testing/vsock/util.c
@@ -499,47 +499,55 @@ void run_tests(const struct test_case *test_cases,
 	int i;
 
 	for (i = 0; test_cases[i].name; i++) {
+		const struct test_case *test = &test_cases[i];
 		void (*run)(const struct test_opts *opts);
+		const char *reason;
 		char *line;
 
-		printf("%d - %s...", i, test_cases[i].name);
+		if (opts->local && !test->local)
+			continue;
+		printf("%d - %s...", i, test->name);
 		fflush(stdout);
 
-		/* Full barrier before executing the next test.  This
-		 * ensures that client and server are executing the
-		 * same test case.  In particular, it means whoever is
-		 * faster will not see the peer still executing the
-		 * last test.  This is important because port numbers
-		 * can be used by multiple test cases.
-		 */
-		if (test_cases[i].skip)
-			control_writeln("SKIP");
-		else
-			control_writeln("NEXT");
-
-		line = control_readln();
-		if (control_cmpln(line, "SKIP", false) || test_cases[i].skip) {
-
-			printf("skipped\n");
-
+		if (opts->local) {
+			if (test->skip) {
+				printf("skipped\n");
+				continue;
+			}
+		} else {
+			/* Agree on explicit selection before any capability check
+			 * or test can exchange messages on the control connection.
+			 */
+			control_writeln(test->skip ? "SKIP" : "NEXT");
+			line = control_readln();
+			if (control_cmpln(line, "SKIP", false) || test->skip) {
+				printf("skipped\n");
+				free(line);
+				continue;
+			}
+			control_cmpln(line, "NEXT", true);
 			free(line);
-			continue;
 		}
 
-		control_cmpln(line, "NEXT", true);
-		free(line);
-
-		if (opts->mode == TEST_MODE_CLIENT)
-			run = test_cases[i].run_client;
+		if (test->check) {
+			reason = test->check(opts);
+			if (reason) {
+				printf("skipped: %s\n", reason);
+				continue;
+			}
+		}
+		if (opts->local || opts->mode == TEST_MODE_CLIENT)
+			run = test->run_client;
 		else
-			run = test_cases[i].run_server;
-
+			run = test->run_server;
 		if (run)
 			run(opts);
-
 		printf("ok\n");
 	}
 
+	if (opts->local)
+		return;
+
 	printf("All tests have been executed. Waiting other peer...");
 	fflush(stdout);
 
diff --git a/tools/testing/vsock/util.h b/tools/testing/vsock/util.h
index 9dabb547021e..e23290e7dcc6 100644
--- a/tools/testing/vsock/util.h
+++ b/tools/testing/vsock/util.h
@@ -51,6 +51,10 @@ struct test_opts {
 	enum test_mode mode;
 	unsigned int peer_cid;
 	unsigned int peer_port;
+	unsigned int bind_cid;
+	bool local;
+	bool to_host;
+	bool expect_to_host;
 };
 
 /* A test case definition.  Test functions must print failures to stderr and
@@ -66,6 +70,12 @@ struct test_case {
 	void (*run_server)(const struct test_opts *opts);
 
 	bool skip;
+	bool local; /* Can run without a control connection */
+
+	/* Return a skip reason or NULL after the selection barrier. Checks
+	 * that coordinate over the control channel must agree on both peers.
+	 */
+	const char *(*check)(const struct test_opts *opts);
 };
 
 void init_signals(void);
diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
index 10b9074fb87f..f4ff6a42a9cb 100644
--- a/tools/testing/vsock/vsock_test.c
+++ b/tools/testing/vsock/vsock_test.c
@@ -27,6 +27,7 @@
 #include <linux/sockios.h>
 
 #include "vsock_test_zerocopy.h"
+#include "vsock_test_dgram.h"
 #include "timeout.h"
 #include "control.h"
 #include "util.h"
@@ -2911,6 +2912,95 @@ static struct test_case test_cases[] = {
 	{
 		.name = "SO_INQ option validation",
 		.run_client = test_so_inq_validation_client,
+	},
+		.name = "SOCK_DGRAM autobind, duplicate bind and wildcard destination",
+		.run_client = test_dgram_bind,
+		.run_server = test_dgram_bind,
+		.check = vsock_dgram_check_local,
+		.local = true,
+	},
+	{
+		.name = "SOCK_DGRAM queue ioctls, poll, peek, truncation and empty messages",
+		.run_client = test_dgram_receive,
+		.run_server = test_dgram_receive,
+		.check = vsock_dgram_check_local,
+		.local = true,
+	},
+	{
+		.name = "SOCK_DGRAM unsupported receive flags preserve normal data",
+		.run_client = test_dgram_receive_flags,
+		.run_server = test_dgram_receive_flags,
+		.check = vsock_dgram_check_local,
+		.local = true,
+	},
+	{
+		.name = "SOCK_DGRAM socket filter trims receive length",
+		.run_client = test_dgram_filter,
+		.run_server = test_dgram_filter,
+		.check = vsock_dgram_check_local,
+		.local = true,
+	},
+	{
+		.name = "SOCK_DGRAM connect, disconnect and shutdown peer filtering",
+		.run_client = test_dgram_connect,
+		.run_server = test_dgram_connect,
+		.check = vsock_dgram_check_local,
+		.local = true,
+	},
+	{
+		.name = "SOCK_DGRAM explicit loopback source CIDs and reply addresses",
+		.run_client = test_dgram_source_cid,
+		.run_server = test_dgram_source_cid,
+		.check = vsock_dgram_check_local,
+		.local = true,
+	},
+	{
+		.name = "SOCK_DGRAM connected stream/seqpacket cannot shadow datagrams",
+		.run_client = test_dgram_bound_lookup,
+		.run_server = test_dgram_bound_lookup,
+		.check = vsock_dgram_check_local,
+		.local = true,
+	},
+	{
+		.name = "SOCK_DGRAM sockmap and sockhash reject datagrams (BPF privileges)",
+		.run_client = test_dgram_sockmap,
+		.run_server = test_dgram_sockmap,
+		.skip = true,
+		.check = vsock_dgram_check_local,
+		.local = true,
+	},
+	{
+		.name = "SOCK_DGRAM nested CID_HOST loopback rejection (nested VM only)",
+		.run_client = test_dgram_nested_source,
+		.run_server = test_dgram_nested_source,
+		.skip = true,
+		.check = vsock_dgram_check_local,
+		.local = true,
+	},
+	{
+		.name = "SOCK_DGRAM bidirectional sizes, 64 KiB boundaries and RX refill",
+		.run_client = test_dgram_sizes,
+		.run_server = test_dgram_sizes,
+		.check = vsock_dgram_check_peer,
+	},
+	{
+		.name = "SOCK_DGRAM connected socket alternates loopback and peer routes",
+		.run_client = test_dgram_routes,
+		.run_server = test_dgram_routes,
+		.check = vsock_dgram_check_routes,
+	},
+	{
+		.name = "SOCK_DGRAM peer filtering and disconnect across transports",
+		.run_client = test_dgram_peer_filter,
+		.run_server = test_dgram_peer_filter,
+		.check = vsock_dgram_check_peer,
+	},
+	{
+		.name = "SOCK_DGRAM VMCI ioctl(SIOCINQ) payload length",
+		.run_client = test_dgram_vmci_inq,
+		.run_server = test_dgram_vmci_inq,
+		.check = vsock_dgram_check_vmci,
+		.local = true,
 	},
 	{},
 };
@@ -2957,6 +3047,26 @@ static const struct option longopts[] = {
 		.has_arg = required_argument,
 		.val = 't',
 	},
+	{
+		.name = "local",
+		.has_arg = no_argument,
+		.val = 'L',
+	},
+	{
+		.name = "bind-cid",
+		.has_arg = required_argument,
+		.val = 'b',
+	},
+	{
+		.name = "to-host",
+		.has_arg = no_argument,
+		.val = 'T',
+	},
+	{
+		.name = "expect-to-host",
+		.has_arg = no_argument,
+		.val = 'E',
+	},
 	{
 		.name = "help",
 		.has_arg = no_argument,
@@ -2972,8 +3082,10 @@ static void usage(void)
 		"  Server: vsock_test --control-port=1234 --mode=server --peer-cid=3\n"
 		"  Client: vsock_test --control-host=192.168.0.1 --control-port=1234 --mode=client --peer-cid=2\n"
 		"\n"
-		"Run vsock.ko tests.  Must be launched in both guest\n"
-		"and host.  One side must use --mode=client and\n"
+		"  Local: vsock_test --local [--pick=<test_id>]\n"
+		"\n"
+		"Run vsock.ko tests. Paired tests must be launched in both guest\n"
+		"and host. One side must use --mode=client and\n"
 		"the other side must use --mode=server.\n"
 		"\n"
 		"A TCP control socket connection is used to coordinate tests\n"
@@ -2986,8 +3098,14 @@ static void usage(void)
 		"specified with --peer-port=<port> (or the default port)\n"
 		"and the next one.\n"
 		"\n"
+		"--local runs local datagram cases without a control connection.\n"
+		"\n"
 		"Options:\n"
 		"  --help                 This help message\n"
+		"  --local                Run local datagram cases without a peer\n"
+		"  --bind-cid <cid>       Source CID for peer datagram tests [default: ANY]\n"
+		"  --to-host              Route peer datagrams through the frontend\n"
+		"  --expect-to-host       Expect the upstream datagram source flag\n"
 		"  --control-host <host>  Server IP address to connect to\n"
 		"  --control-port <port>  Server port to listen on/connect to\n"
 		"  --mode client|server   Server or client mode\n"
@@ -3011,7 +3129,10 @@ int main(int argc, char **argv)
 		.mode = TEST_MODE_UNSET,
 		.peer_cid = VMADDR_CID_ANY,
 		.peer_port = DEFAULT_PEER_PORT,
+		.bind_cid = VMADDR_CID_ANY,
 	};
+	bool picked = false;
+	size_t i;
 
 	srand(time(NULL));
 	init_signals();
@@ -3023,6 +3144,18 @@ int main(int argc, char **argv)
 			break;
 
 		switch (opt) {
+		case 'L':
+			opts.local = true;
+			break;
+		case 'b':
+			opts.bind_cid = parse_cid(optarg);
+			break;
+		case 'T':
+			opts.to_host = true;
+			break;
+		case 'E':
+			opts.expect_to_host = true;
+			break;
 		case 'H':
 			control_host = optarg;
 			break;
@@ -3055,6 +3188,7 @@ int main(int argc, char **argv)
 		case 't':
 			pick_test(test_cases, ARRAY_SIZE(test_cases) - 1,
 				  optarg);
+			picked = true;
 			break;
 		case '?':
 		default:
@@ -3062,6 +3196,22 @@ int main(int argc, char **argv)
 		}
 	}
 
+	if (optind != argc)
+		usage();
+	if (opts.local) {
+		if (opts.mode != TEST_MODE_UNSET || control_host || control_port)
+			usage();
+		if (picked) {
+			for (i = 0; test_cases[i].name; i++) {
+				if (!test_cases[i].skip && !test_cases[i].local) {
+					fprintf(stderr, "test %zu requires paired mode\n", i);
+					exit(EXIT_FAILURE);
+				}
+			}
+		}
+		run_tests(test_cases, &opts);
+		return EXIT_SUCCESS;
+	}
 	if (!control_port)
 		usage();
 	if (opts.mode == TEST_MODE_UNSET)
diff --git a/tools/testing/vsock/vsock_test_dgram.c b/tools/testing/vsock/vsock_test_dgram.c
new file mode 100644
index 000000000000..d818f43176dc
--- /dev/null
+++ b/tools/testing/vsock/vsock_test_dgram.c
@@ -0,0 +1,809 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Datagram feature tests for vsock. */
+
+#include <errno.h>
+#include <fcntl.h>
+#include <linux/bpf.h>
+#include <linux/filter.h>
+#include <linux/sockios.h>
+#include <poll.h>
+#include <stdarg.h>
+#include <stdint.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/ioctl.h>
+#include <sys/syscall.h>
+#include <time.h>
+#include <unistd.h>
+
+#include "control.h"
+#include "timeout.h"
+#include "vsock_test_dgram.h"
+
+#define MAX_DGRAM (64 * 1024)
+
+static void fail(const char *fmt, ...)
+{
+	va_list ap;
+
+	fprintf(stderr, "\nFAIL: ");
+	va_start(ap, fmt);
+	vfprintf(stderr, fmt, ap);
+	va_end(ap);
+	fputc('\n', stderr);
+	exit(EXIT_FAILURE);
+}
+
+static void check(int ret, const char *operation)
+{
+	if (ret < 0)
+		fail("%s: %s", operation, strerror(errno));
+}
+
+static void expect_error(ssize_t ret, int error, const char *operation)
+{
+	if (ret != -1 || errno != error)
+		fail("%s: expected %s, got %zd (%s)", operation,
+		     strerror(error), ret, ret == -1 ? strerror(errno) : "success");
+}
+
+static int64_t now_ms(void)
+{
+	struct timespec ts;
+
+	check(clock_gettime(CLOCK_MONOTONIC, &ts), "clock_gettime");
+	return (int64_t)ts.tv_sec * 1000 + ts.tv_nsec / 1000000;
+}
+
+static short poll_fd(int fd, short events, int milliseconds)
+{
+	struct pollfd pfd = { .fd = fd, .events = events };
+	int ret;
+
+	do {
+		ret = poll(&pfd, 1, milliseconds);
+	} while (ret < 0 && errno == EINTR);
+	check(ret, "poll");
+	if (pfd.revents & (POLLERR | POLLNVAL))
+		fail("unexpected poll events %#x", pfd.revents);
+	return pfd.revents;
+}
+
+static void wait_readable(int fd)
+{
+	if (!(poll_fd(fd, POLLIN, TIMEOUT * 1000) & POLLIN))
+		fail("waiting for socket readability timed out");
+}
+
+static struct sockaddr_vm address(unsigned int cid, unsigned int port)
+{
+	return (struct sockaddr_vm) {
+		.svm_family = AF_VSOCK,
+		.svm_cid = cid,
+		.svm_port = port,
+	};
+}
+
+static struct sockaddr_vm sock_name(int fd, bool peer)
+{
+	struct sockaddr_vm addr;
+	socklen_t len = sizeof(addr);
+	int ret;
+
+	if (peer)
+		ret = getpeername(fd, (struct sockaddr *)&addr, &len);
+	else
+		ret = getsockname(fd, (struct sockaddr *)&addr, &len);
+	check(ret, peer ? "getpeername" : "getsockname");
+	if (len != sizeof(addr) || addr.svm_family != AF_VSOCK)
+		fail("invalid socket address");
+	return addr;
+}
+
+static unsigned int local_cid(void)
+{
+	unsigned int cid;
+	int fd;
+
+	fd = open("/dev/vsock", O_RDONLY | O_CLOEXEC);
+	check(fd, "open /dev/vsock");
+	check(ioctl(fd, IOCTL_VM_SOCKETS_GET_LOCAL_CID, &cid), "get local CID");
+	close(fd);
+	if (cid == VMADDR_CID_ANY || cid <= VMADDR_CID_LOCAL)
+		fail("a virtio or vhost transport is required (local CID %u)", cid);
+	return cid;
+}
+
+static void bind_fd(int fd, unsigned int cid, unsigned int port)
+{
+	struct sockaddr_vm addr = address(cid, port);
+
+	check(bind(fd, (struct sockaddr *)&addr, sizeof(addr)), "bind");
+}
+
+static int dgram_socket(void)
+{
+	int fd = socket(AF_VSOCK, SOCK_DGRAM | SOCK_NONBLOCK | SOCK_CLOEXEC, 0);
+	int rcvbuf = 1024 * 1024;
+
+	check(fd, "socket(AF_VSOCK, SOCK_DGRAM): check transport/feature support");
+	check(setsockopt(fd, SOL_SOCKET, SO_RCVBUF, &rcvbuf, sizeof(rcvbuf)), "SO_RCVBUF");
+	return fd;
+}
+
+enum dgram_capability {
+	DGRAM_SOCKET = 1 << 0,
+	DGRAM_VIRTIO = 1 << 1,
+	DGRAM_VMCI = 1 << 2,
+	DGRAM_LOOPBACK = 1 << 3,
+	DGRAM_PEER = 1 << 4,
+};
+
+static bool dgram_unavailable(int error)
+{
+	return error == EAFNOSUPPORT || error == EPROTONOSUPPORT ||
+	       error == ESOCKTNOSUPPORT || error == ENODEV;
+}
+
+static unsigned int dgram_capabilities(const struct test_opts *opts,
+				       unsigned int needs)
+{
+	unsigned int caps = DGRAM_SOCKET;
+	struct sockaddr_vm peer;
+	int fd, local_fd;
+
+	fd = socket(AF_VSOCK, SOCK_DGRAM | SOCK_NONBLOCK | SOCK_CLOEXEC, 0);
+	if (fd < 0) {
+		if (dgram_unavailable(errno))
+			return 0;
+		check(fd, "probe datagram socket");
+	}
+	/* VMCI registers the dedicated datagram transport when loaded. */
+	if (!access("/sys/module/vmw_vsock_vmci_transport", F_OK))
+		caps |= DGRAM_VMCI;
+	else
+		caps |= DGRAM_VIRTIO;
+
+	if ((needs & DGRAM_PEER) && (caps & DGRAM_VIRTIO)) {
+		bind_fd(fd, opts->bind_cid, VMADDR_PORT_ANY);
+		peer = address(opts->peer_cid, opts->peer_port);
+		if (opts->to_host)
+			peer.svm_flags = VMADDR_FLAG_TO_HOST;
+		if (!connect(fd, (struct sockaddr *)&peer, sizeof(peer)))
+			caps |= DGRAM_PEER;
+		else if (!dgram_unavailable(errno) && errno != EINVAL)
+			check(-1, "probe peer datagram route");
+	}
+	close(fd);
+
+	if ((needs & DGRAM_LOOPBACK) && (caps & DGRAM_VIRTIO)) {
+		/* Binding a stream socket to CID_LOCAL probes registration of
+		 * the loopback transport without sending a packet to the host.
+		 */
+		local_fd = vsock_bind_try(VMADDR_CID_LOCAL, VMADDR_PORT_ANY, SOCK_STREAM);
+		if (local_fd >= 0) {
+			caps |= DGRAM_LOOPBACK;
+			close(local_fd);
+		} else if (errno != EADDRNOTAVAIL) {
+			check(local_fd, "probe loopback transport");
+		}
+	}
+	return caps;
+}
+
+static const char *dgram_check(const struct test_opts *opts, unsigned int needs)
+{
+	unsigned int local = dgram_capabilities(opts, needs);
+	unsigned int both = local;
+
+	/* run_tests() has already synchronized explicit --pick/--skip
+	 * selection. Both peers can now safely exchange capabilities.
+	 */
+	if (!opts->local) {
+		control_writeulong(local);
+		both &= control_readulong();
+	}
+	if (!(both & DGRAM_SOCKET))
+		return local & DGRAM_SOCKET ?
+			"datagrams unavailable at peer" : "datagrams unavailable locally";
+	if ((needs & DGRAM_VIRTIO) && !(both & DGRAM_VIRTIO))
+		return "requires virtio/vhost datagram transports on both peers";
+	if ((needs & DGRAM_VMCI) && !(both & DGRAM_VMCI))
+		return "requires VMCI datagram transports on both peers";
+	if ((needs & DGRAM_LOOPBACK) && !(both & DGRAM_LOOPBACK))
+		return "load vsock_loopback on both peers";
+	if ((needs & DGRAM_PEER) && !(both & DGRAM_PEER))
+		return "peer route does not support datagrams";
+	return NULL;
+}
+
+const char *vsock_dgram_check_local(const struct test_opts *opts)
+{
+	return dgram_check(opts, DGRAM_VIRTIO | DGRAM_LOOPBACK);
+}
+
+const char *vsock_dgram_check_peer(const struct test_opts *opts)
+{
+	return dgram_check(opts, DGRAM_VIRTIO | DGRAM_PEER);
+}
+
+const char *vsock_dgram_check_routes(const struct test_opts *opts)
+{
+	return dgram_check(opts, DGRAM_VIRTIO | DGRAM_PEER | DGRAM_LOOPBACK);
+}
+
+const char *vsock_dgram_check_vmci(const struct test_opts *opts)
+{
+	return dgram_check(opts, DGRAM_VMCI);
+}
+
+static int bound_socket(unsigned int cid)
+{
+	int fd = dgram_socket();
+
+	bind_fd(fd, cid, VMADDR_PORT_ANY);
+	return fd;
+}
+
+static struct sockaddr_vm local_address(int fd)
+{
+	struct sockaddr_vm addr = sock_name(fd, false);
+
+	addr.svm_cid = VMADDR_CID_LOCAL;
+	return addr;
+}
+
+static void connect_fd(int fd, const struct sockaddr_vm *addr)
+{
+	check(connect(fd, (const struct sockaddr *)addr, sizeof(*addr)), "connect");
+}
+
+static void disconnect_fd(int fd)
+{
+	struct sockaddr_vm addr = { .svm_family = AF_UNSPEC };
+	socklen_t len = sizeof(addr);
+
+	check(connect(fd, (struct sockaddr *)&addr, sizeof(addr)), "disconnect");
+	expect_error(getpeername(fd, (struct sockaddr *)&addr, &len),
+		     ENOTCONN, "getpeername after disconnect");
+}
+
+static int queue_bytes(int fd, unsigned long op)
+{
+	int bytes;
+
+	check(ioctl(fd, op, &bytes), "queue ioctl");
+	if (bytes < 0)
+		fail("negative queue length: %d", bytes);
+	return bytes;
+}
+
+static void expect_inq(int fd, int expected)
+{
+	int actual = queue_bytes(fd, SIOCINQ);
+
+	if (actual != expected)
+		fail("SIOCINQ: expected %d, got %d", expected, actual);
+}
+
+static void wait_sent(int fd)
+{
+	int64_t deadline = now_ms() + TIMEOUT * 1000;
+
+	while (queue_bytes(fd, SIOCOUTQ)) {
+		if (now_ms() >= deadline)
+			fail("SIOCOUTQ did not return to zero");
+		usleep(1000);
+	}
+}
+
+static void send_packet(int fd, const struct sockaddr_vm *addr,
+			const void *buf, size_t len)
+{
+	int64_t deadline = now_ms() + TIMEOUT * 1000;
+	ssize_t ret;
+
+	for (;;) {
+		ret = sendto(fd, buf, len, MSG_DONTWAIT | MSG_NOSIGNAL,
+			     (const struct sockaddr *)addr, addr ? sizeof(*addr) : 0);
+		if (ret >= 0)
+			break;
+		if (errno != EAGAIN && errno != EINTR)
+			fail("sendto(%zu bytes): %s", len, strerror(errno));
+		if (now_ms() >= deadline)
+			fail("sendto(%zu bytes) timed out", len);
+		poll_fd(fd, POLLOUT, 1);
+	}
+	if (ret != len)
+		fail("partial datagram send: %zd/%zu", ret, len);
+}
+
+static struct sockaddr_vm recv_packet(int fd, void *buf, size_t capacity,
+				      int flags, size_t expected, bool truncated)
+{
+	struct sockaddr_vm src = { 0 };
+	struct iovec iov = { .iov_base = buf, .iov_len = capacity };
+	struct msghdr msg = {
+		.msg_name = &src,
+		.msg_namelen = sizeof(src),
+		.msg_iov = &iov,
+		.msg_iovlen = 1,
+	};
+	ssize_t ret;
+
+	wait_readable(fd);
+	ret = recvmsg(fd, &msg, flags | MSG_DONTWAIT);
+	check(ret, "recvmsg");
+	if (ret != expected || !!(msg.msg_flags & MSG_TRUNC) != truncated)
+		fail("recvmsg: expected %zu bytes, trunc=%d; got %zd, flags=%#x",
+		     expected, truncated, ret, msg.msg_flags);
+	if (msg.msg_namelen != sizeof(src) || src.svm_family != AF_VSOCK)
+		fail("invalid recvmsg source address");
+	return src;
+}
+
+static void expect_empty(int fd)
+{
+	char byte;
+
+	if (poll_fd(fd, POLLIN, 0) & POLLIN)
+		fail("unexpected queued datagram");
+	expect_error(recv(fd, &byte, 1, MSG_DONTWAIT), EAGAIN, "empty recv");
+	expect_inq(fd, 0);
+}
+
+void test_dgram_bind(const struct test_opts *opts)
+{
+	int rx = bound_socket(VMADDR_CID_ANY);
+	struct sockaddr_vm dest = local_address(rx);
+	int tx = dgram_socket();
+	int other = dgram_socket();
+	struct sockaddr_vm src;
+	char byte;
+
+	dest.svm_cid = VMADDR_CID_ANY;
+	expect_error(bind(other, (struct sockaddr *)&dest, sizeof(dest)),
+		     EADDRINUSE, "duplicate bind");
+	send_packet(tx, &dest, "A", 1);
+	src = recv_packet(rx, &byte, 1, 0, 1, false);
+	if (byte != 'A' || src.svm_port != sock_name(tx, false).svm_port ||
+	    src.svm_cid != VMADDR_CID_LOCAL || src.svm_port < 1024)
+		fail("autobind or wildcard destination returned an invalid source");
+	close(rx);
+	bind_fd(other, VMADDR_CID_ANY, dest.svm_port);
+	close(other);
+	close(tx);
+}
+
+void test_dgram_receive(const struct test_opts *opts)
+{
+	int rx = bound_socket(VMADDR_CID_ANY);
+	int tx = bound_socket(VMADDR_CID_ANY);
+	struct sockaddr_vm dest = local_address(rx);
+	char buf[80];
+	char first[31], second[79];
+
+	memset(first, 'A', sizeof(first));
+	memset(second, 'B', sizeof(second));
+	expect_empty(rx);
+	if (!(poll_fd(tx, POLLOUT, 0) & POLLOUT))
+		fail("new socket is not writable");
+	if (queue_bytes(tx, SIOCOUTQ))
+		fail("new socket has pending output");
+	send_packet(tx, &dest, first, sizeof(first));
+	send_packet(tx, &dest, second, sizeof(second));
+	wait_readable(rx);
+	expect_inq(rx, sizeof(first));
+	recv_packet(rx, buf, 5, MSG_PEEK, 5, true);
+	if (memcmp(buf, first, 5))
+		fail("MSG_PEEK payload mismatch");
+	expect_inq(rx, sizeof(first));
+	recv_packet(rx, buf, 5, MSG_TRUNC, sizeof(first), true);
+	wait_readable(rx);
+	expect_inq(rx, sizeof(second));
+	recv_packet(rx, buf, sizeof(buf), 0, sizeof(second), false);
+	if (memcmp(buf, second, sizeof(second)))
+		fail("datagram boundary or payload mismatch");
+	send_packet(tx, &dest, "", 0);
+	wait_readable(rx);
+	expect_inq(rx, 0);
+	recv_packet(rx, buf, sizeof(buf), MSG_PEEK, 0, false);
+	recv_packet(rx, buf, sizeof(buf), 0, 0, false);
+	send_packet(tx, &dest, first, sizeof(first));
+	recv_packet(rx, buf, 0, MSG_TRUNC, sizeof(first), true);
+	expect_empty(rx);
+	wait_sent(tx);
+	close(tx);
+	close(rx);
+}
+
+void test_dgram_receive_flags(const struct test_opts *opts)
+{
+	int rx = bound_socket(VMADDR_CID_ANY);
+	int tx = bound_socket(VMADDR_CID_ANY);
+	struct sockaddr_vm dest = local_address(rx);
+	const int flags[] = { MSG_OOB, MSG_ERRQUEUE };
+	char byte;
+	size_t i;
+
+	send_packet(tx, &dest, "A", 1);
+	wait_readable(rx);
+	for (i = 0; i < ARRAY_SIZE(flags); i++) {
+		expect_error(recv(rx, &byte, 1, flags[i] | MSG_DONTWAIT),
+			     EOPNOTSUPP, "unsupported receive flag");
+		expect_inq(rx, 1);
+	}
+	recv_packet(rx, &byte, 1, 0, 1, false);
+	if (byte != 'A')
+		fail("unsupported flags consumed the normal packet");
+	close(tx);
+	close(rx);
+}
+
+void test_dgram_vmci_inq(const struct test_opts *opts)
+{
+	int rx = bound_socket(VMADDR_CID_ANY);
+	int tx = bound_socket(VMADDR_CID_ANY);
+	struct sockaddr_vm dest = sock_name(rx, false);
+	char first[31], second[79], buf[80];
+
+	memset(first, 'A', sizeof(first));
+	memset(second, 'B', sizeof(second));
+	/* CID_ANY is resolved by the dedicated transport to its local CID. */
+	dest.svm_cid = VMADDR_CID_ANY;
+	send_packet(tx, &dest, first, sizeof(first));
+	send_packet(tx, &dest, second, sizeof(second));
+	wait_readable(rx);
+	expect_inq(rx, sizeof(first));
+	recv_packet(rx, buf, sizeof(buf), 0, sizeof(first), false);
+	if (memcmp(buf, first, sizeof(first)))
+		fail("VMCI first payload mismatch");
+	wait_readable(rx);
+	expect_inq(rx, sizeof(second));
+	recv_packet(rx, buf, sizeof(buf), 0, sizeof(second), false);
+	if (memcmp(buf, second, sizeof(second)))
+		fail("VMCI second payload mismatch");
+	send_packet(tx, &dest, "", 0);
+	wait_readable(rx);
+	expect_inq(rx, 0);
+	recv_packet(rx, buf, sizeof(buf), 0, 0, false);
+	expect_empty(rx);
+	close(tx);
+	close(rx);
+}
+
+void test_dgram_filter(const struct test_opts *opts)
+{
+	struct sock_filter insn[] = { BPF_STMT(BPF_RET | BPF_K, 7) };
+	struct sock_fprog prog = { .len = ARRAY_SIZE(insn), .filter = insn };
+	int rx = bound_socket(VMADDR_CID_ANY);
+	int tx = bound_socket(VMADDR_CID_ANY);
+	struct sockaddr_vm dest = local_address(rx);
+	char data[100], buf[100];
+
+	memset(data, 'F', sizeof(data));
+	check(setsockopt(rx, SOL_SOCKET, SO_ATTACH_FILTER, &prog, sizeof(prog)),
+	      "SO_ATTACH_FILTER");
+	send_packet(tx, &dest, data, sizeof(data));
+	wait_readable(rx);
+	expect_inq(rx, 7);
+	recv_packet(rx, buf, 1, MSG_PEEK | MSG_TRUNC, 7, true);
+	expect_inq(rx, 7);
+	memset(buf, 0, sizeof(buf));
+	recv_packet(rx, buf, sizeof(buf), MSG_TRUNC, 7, false);
+	if (memcmp(buf, data, 7) || buf[7])
+		fail("filtered receive copied beyond the filtered payload");
+	send_packet(tx, &dest, data, sizeof(data));
+	recv_packet(rx, buf, 1, MSG_TRUNC, 7, true);
+	expect_empty(rx);
+	close(tx);
+	close(rx);
+}
+
+static void check_peer_filter(int rx, int allowed, int stray)
+{
+	struct sockaddr_vm dest = local_address(rx);
+	char byte;
+
+	/* Both packets use the same ordered loopback worker. */
+	send_packet(stray, &dest, "B", 1);
+	send_packet(allowed, &dest, "A", 1);
+	recv_packet(rx, &byte, 1, 0, 1, false);
+	if (byte != 'A')
+		fail("connected socket accepted a different peer");
+	expect_empty(rx);
+}
+
+void test_dgram_connect(const struct test_opts *opts)
+{
+	int rx = bound_socket(VMADDR_CID_ANY);
+	int allowed = bound_socket(VMADDR_CID_ANY);
+	int stray = bound_socket(VMADDR_CID_ANY);
+	struct sockaddr_vm peer = local_address(allowed);
+	struct sockaddr_vm dest = local_address(rx);
+	char byte;
+
+	connect_fd(rx, &peer);
+	check_peer_filter(rx, allowed, stray);
+	disconnect_fd(rx);
+	send_packet(stray, &dest, "B", 1);
+	recv_packet(rx, &byte, 1, 0, 1, false);
+	if (byte != 'B')
+		fail("disconnect did not remove peer filtering");
+	connect_fd(rx, &peer);
+	check(shutdown(rx, SHUT_WR), "shutdown SHUT_WR");
+	if (poll_fd(rx, POLLOUT, 0) & POLLOUT)
+		fail("write-shutdown socket is still writable");
+	check_peer_filter(rx, allowed, stray);
+	check(shutdown(rx, SHUT_RD), "shutdown SHUT_RD");
+	if (!(poll_fd(rx, POLLIN | POLLRDHUP, 0) & POLLRDHUP))
+		fail("read shutdown did not report POLLRDHUP");
+	close(stray);
+	close(allowed);
+	close(rx);
+}
+
+void test_dgram_source_cid(const struct test_opts *opts)
+{
+	unsigned int cids[] = { VMADDR_CID_LOCAL, local_cid() };
+	size_t i;
+
+	for (i = 0; i < ARRAY_SIZE(cids); i++) {
+		int rx = bound_socket(VMADDR_CID_ANY);
+		int tx = bound_socket(cids[i]);
+		struct sockaddr_vm dest = local_address(rx);
+		struct sockaddr_vm src;
+		char byte;
+
+		send_packet(tx, &dest, "A", 1);
+		src = recv_packet(rx, &byte, 1, 0, 1, false);
+		if (src.svm_cid != cids[i] || src.svm_flags ||
+		    src.svm_port != sock_name(tx, false).svm_port)
+			fail("explicit loopback source CID %u was not preserved", cids[i]);
+		send_packet(rx, &src, "R", 1);
+		recv_packet(tx, &byte, 1, 0, 1, false);
+		if (byte != 'R')
+			fail("reply to explicit source CID failed");
+		close(tx);
+		close(rx);
+	}
+}
+
+void test_dgram_bound_lookup(const struct test_opts *opts)
+{
+	const int types[] = { SOCK_STREAM, SOCK_SEQPACKET };
+	unsigned int cid = local_cid();
+	size_t i;
+
+	for (i = 0; i < ARRAY_SIZE(types); i++) {
+		int listener = vsock_bind(VMADDR_CID_ANY, VMADDR_PORT_ANY, types[i]);
+		int stream = vsock_bind(VMADDR_CID_LOCAL, VMADDR_PORT_ANY, types[i]);
+		struct sockaddr_vm listen_addr = local_address(listener);
+		struct sockaddr_vm src = sock_name(stream, false);
+		struct sockaddr_vm dest;
+		int accepted, tx, rx;
+		char byte;
+
+		check(listen(listener, 1), "listen");
+		if (vsock_connect_fd(stream, listen_addr.svm_cid, listen_addr.svm_port))
+			fail("%s loopback connect: %s",
+			     types[i] == SOCK_STREAM ? "stream" : "seqpacket", strerror(errno));
+		wait_readable(listener);
+		accepted = accept4(listener, NULL, NULL, SOCK_NONBLOCK | SOCK_CLOEXEC);
+		check(accepted, "accept");
+		if (sock_name(accepted, true).svm_cid != VMADDR_CID_LOCAL ||
+		    sock_name(accepted, true).svm_port != src.svm_port)
+			fail("unexpected accepted loopback peer");
+		close(listener);
+		rx = dgram_socket();
+		bind_fd(rx, cid, src.svm_port);
+		dest = sock_name(rx, false);
+		tx = dgram_socket();
+		/* Reuse the listener's port for the datagram source. The receive
+		 * socket uses the stream client's port at another local CID.
+		 * Connected lookup ignores the destination CID, so it would find
+		 * the stream client before the bound datagram socket.
+		 */
+		bind_fd(tx, VMADDR_CID_LOCAL, listen_addr.svm_port);
+		send_packet(tx, &dest, "D", 1);
+		recv_packet(rx, &byte, 1, 0, 1, false);
+		if (byte != 'D' || (poll_fd(stream, POLLIN, 0) & POLLIN) ||
+		    (poll_fd(accepted, POLLIN, 0) & POLLIN))
+			fail("connected socket shadowed the reused datagram port");
+		send_byte(stream, 1, 0);
+		wait_readable(accepted);
+		recv_byte(accepted, 1, 0);
+		send_byte(accepted, 1, 0);
+		wait_readable(stream);
+		recv_byte(stream, 1, 0);
+		close(tx);
+		close(rx);
+		close(accepted);
+		close(stream);
+	}
+}
+
+void test_dgram_sockmap(const struct test_opts *opts)
+{
+	const int types[] = { BPF_MAP_TYPE_SOCKMAP, BPF_MAP_TYPE_SOCKHASH };
+	int fd = bound_socket(VMADDR_CID_ANY);
+	struct sockaddr_vm addr = local_address(fd);
+	uint64_t value = fd;
+	uint32_t key = 0;
+	size_t i;
+
+	connect_fd(fd, &addr);
+	for (i = 0; i < ARRAY_SIZE(types); i++) {
+		union bpf_attr attr = {
+			.map_type = types[i],
+			.key_size = sizeof(key),
+			.value_size = sizeof(value),
+			.max_entries = 1,
+		};
+		int map = syscall(__NR_bpf, BPF_MAP_CREATE, &attr, sizeof(attr));
+
+		check(map, "BPF_MAP_CREATE (requires BPF privileges and CONFIG_BPF_SYSCALL)");
+		memset(&attr, 0, sizeof(attr));
+		attr.map_fd = map;
+		attr.key = (uintptr_t)&key;
+		attr.value = (uintptr_t)&value;
+		attr.flags = BPF_ANY;
+		expect_error(syscall(__NR_bpf, BPF_MAP_UPDATE_ELEM, &attr, sizeof(attr)),
+			     EOPNOTSUPP, "datagram sockmap admission");
+		close(map);
+	}
+	close(fd);
+}
+
+void test_dgram_nested_source(const struct test_opts *opts)
+{
+	int rx, tx;
+	struct sockaddr_vm dest;
+
+	if (local_cid() <= VMADDR_CID_HOST)
+		fail("this test requires both a guest frontend and vhost_vsock");
+	rx = bound_socket(VMADDR_CID_LOCAL);
+	tx = bound_socket(VMADDR_CID_HOST);
+	dest = local_address(rx);
+	expect_error(sendto(tx, "A", 1, MSG_NOSIGNAL,
+			    (struct sockaddr *)&dest, sizeof(dest)),
+		     EADDRNOTAVAIL, "nested CID_HOST loopback send");
+	expect_error(connect(tx, (struct sockaddr *)&dest, sizeof(dest)),
+		     EADDRNOTAVAIL, "nested CID_HOST loopback connect");
+	if (queue_bytes(tx, SIOCOUTQ))
+		fail("rejected route left pending output");
+	expect_empty(rx);
+	close(tx);
+	close(rx);
+}
+
+static int peer_socket(const struct test_opts *opts, struct sockaddr_vm *peer)
+{
+	int fd = bound_socket(opts->bind_cid);
+
+	control_writeulong(sock_name(fd, false).svm_port);
+	*peer = address(opts->peer_cid, control_readulong());
+	if (opts->to_host)
+		peer->svm_flags = VMADDR_FLAG_TO_HOST;
+	return fd;
+}
+
+static void check_source(const struct test_opts *opts,
+			 const struct sockaddr_vm *peer, const struct sockaddr_vm *src)
+{
+	bool upstream = opts->expect_to_host || opts->peer_cid == VMADDR_CID_HOST;
+
+	if (src->svm_cid != peer->svm_cid || src->svm_port != peer->svm_port ||
+	    src->svm_flags != (upstream ? VMADDR_FLAG_TO_HOST : 0))
+		fail("source expected %u:%u flags=%u, got %u:%u flags=%u",
+		     peer->svm_cid, peer->svm_port, upstream ? VMADDR_FLAG_TO_HOST : 0,
+		     src->svm_cid, src->svm_port, src->svm_flags);
+}
+
+static void fill_payload(char *buf, size_t len, unsigned int seed)
+{
+	size_t i;
+
+	for (i = 0; i < len; i++)
+		buf[i] = (i * 131 + seed) & 0xff;
+}
+
+void test_dgram_sizes(const struct test_opts *opts)
+{
+	const size_t sizes[] = { 0, 1, 7, 255, 4095, 4096, 4097,
+				8192, 32768, 65535, MAX_DGRAM };
+	char *data = malloc(MAX_DGRAM + 1);
+	char *buf = malloc(MAX_DGRAM + 1);
+	struct sockaddr_vm peer, src;
+	unsigned int round;
+	int fd;
+	size_t i;
+
+	if (!data || !buf)
+		fail("malloc");
+	fd = peer_socket(opts, &peer);
+	fill_payload(data, MAX_DGRAM + 1, 0);
+	expect_error(sendto(fd, data, MAX_DGRAM + 1, MSG_NOSIGNAL,
+			    (struct sockaddr *)&peer, sizeof(peer)),
+		     EMSGSIZE, "oversized datagram");
+	if (queue_bytes(fd, SIOCOUTQ))
+		fail("oversized datagram left pending output");
+	/* More than a default RX ring's worth, including on small rings. */
+	for (round = 0; round < 32; round++) {
+		for (i = 0; i < ARRAY_SIZE(sizes); i++) {
+			fill_payload(data, sizes[i], round * ARRAY_SIZE(sizes) + i);
+			if (opts->mode == TEST_MODE_CLIENT)
+				send_packet(fd, &peer, data, sizes[i]);
+			src = recv_packet(fd, buf, MAX_DGRAM + 1, 0, sizes[i], false);
+			check_source(opts, &peer, &src);
+			if (memcmp(data, buf, sizes[i]))
+				fail("payload mismatch: size %zu, round %u", sizes[i], round);
+			if (opts->mode == TEST_MODE_SERVER)
+				send_packet(fd, &src, buf, sizes[i]);
+		}
+	}
+	wait_sent(fd);
+	expect_empty(fd);
+	close(fd);
+	free(buf);
+	free(data);
+}
+
+void test_dgram_routes(const struct test_opts *opts)
+{
+	struct sockaddr_vm peer, src, stored, local;
+	int fd = peer_socket(opts, &peer);
+	int aux = bound_socket(VMADDR_CID_ANY);
+	unsigned int round;
+	char byte;
+
+	connect_fd(fd, &peer);
+	stored = sock_name(fd, true);
+	local = local_address(aux);
+	for (round = 0; round < 32; round++) {
+		send_packet(fd, &local, "L", 1);
+		recv_packet(aux, &byte, 1, 0, 1, false);
+		if (byte != 'L')
+			fail("sendto on a connected socket did not use loopback");
+		src = sock_name(fd, true);
+		if (src.svm_cid != stored.svm_cid || src.svm_port != stored.svm_port ||
+		    src.svm_flags != stored.svm_flags)
+			fail("per-message route changed the connected peer");
+		send_packet(fd, NULL, "P", 1);
+		src = recv_packet(fd, &byte, 1, 0, 1, false);
+		check_source(opts, &peer, &src);
+		if (byte != 'P')
+			fail("connected send did not retain the peer route");
+	}
+	wait_sent(fd);
+	close(aux);
+	close(fd);
+}
+
+void test_dgram_peer_filter(const struct test_opts *opts)
+{
+	struct sockaddr_vm peer, src;
+	int fd = peer_socket(opts, &peer);
+	int stray = bound_socket(opts->bind_cid);
+	char byte;
+
+	connect_fd(fd, &peer);
+	control_writeln("CONNECTED");
+	control_expectln("CONNECTED");
+	send_packet(stray, &peer, "B", 1);
+	send_packet(fd, NULL, "A", 1);
+	src = recv_packet(fd, &byte, 1, 0, 1, false);
+	check_source(opts, &peer, &src);
+	if (byte != 'A')
+		fail("connected socket accepted a different peer port");
+	disconnect_fd(fd);
+	control_writeln("DISCONNECTED");
+	control_expectln("DISCONNECTED");
+	send_packet(stray, &peer, "B", 1);
+	src = recv_packet(fd, &byte, 1, 0, 1, false);
+	if (byte != 'B' || src.svm_cid != peer.svm_cid || src.svm_port == peer.svm_port)
+		fail("disconnected socket did not accept the new peer");
+	close(stray);
+	close(fd);
+}
diff --git a/tools/testing/vsock/vsock_test_dgram.h b/tools/testing/vsock/vsock_test_dgram.h
new file mode 100644
index 000000000000..0dec74ef5f46
--- /dev/null
+++ b/tools/testing/vsock/vsock_test_dgram.h
@@ -0,0 +1,26 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef VSOCK_TEST_DGRAM_H
+#define VSOCK_TEST_DGRAM_H
+
+#include "util.h"
+
+const char *vsock_dgram_check_local(const struct test_opts *opts);
+const char *vsock_dgram_check_peer(const struct test_opts *opts);
+const char *vsock_dgram_check_routes(const struct test_opts *opts);
+const char *vsock_dgram_check_vmci(const struct test_opts *opts);
+
+void test_dgram_bind(const struct test_opts *opts);
+void test_dgram_receive(const struct test_opts *opts);
+void test_dgram_receive_flags(const struct test_opts *opts);
+void test_dgram_filter(const struct test_opts *opts);
+void test_dgram_connect(const struct test_opts *opts);
+void test_dgram_source_cid(const struct test_opts *opts);
+void test_dgram_bound_lookup(const struct test_opts *opts);
+void test_dgram_sockmap(const struct test_opts *opts);
+void test_dgram_nested_source(const struct test_opts *opts);
+void test_dgram_sizes(const struct test_opts *opts);
+void test_dgram_routes(const struct test_opts *opts);
+void test_dgram_peer_filter(const struct test_opts *opts);
+void test_dgram_vmci_inq(const struct test_opts *opts);
+
+#endif /* VSOCK_TEST_DGRAM_H */

-- 
2.56.0


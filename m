Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793592393;
	b=MLX512VAsIpwGN5NXfWPskljmFTeP1EFlyERAcojzhnfsyC4K0Iq1+ILRyErSTAg4dH1
	 0KkcoqH0U0d94l5ljzNhVe4imXNa/BnGBOek0eaAUxEWbk6jGa+Le03drjsCRtEYdHY1j
	 pFUYWgEYpG7smjn6vrQ3Q/ZseWbBNotHY1xWbj9Y7d0WLXKCUGfZu/uQdDA+8l17ccy2d
	 iIB3hqX2EfR9V5QdyhGWCsZXfZ8gOsT7RTZSCmv8v/fS2qFB2qfizu8JMGnkQsPL2qPOL
	 oT/hC0kLEgOUOq1PzWx/yiNrJYUzx3ibftaEcONtA/b9nasPxL46zbzeDYaqXvqjL0g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793592393;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=AbAfqOiSmjkr5zT5Z7ymwEcuZe5nRrpvvhFQphOc1AI=;
	b=JzOSfQtXoqYh9H1dTx2Q0MXPSLgrFLRz+jLLcuMEbdM2B8bhp70374c4DNgjJNXdmAXE
	 t4iMRtHUQD0kfRyOEsIXWpAGvxWPWW3ZJH/7/amqv0goDwzg6zSbVYUjbkB9nTH2l1nfD
	 lVadpOKkJP7t40fvs7ARpTgcDwtDetXr/DwILplClHsLsTarqMsqdyeR2+Ue1JYosUOmK
	 AVubdG/XCILm1JkvuRTOmiPxQ5u4Iz5favCqi+1BF3NGnroLw6nZtMm08ONtUSre58ct8
	 ioLAlm9jaN0iYvrGdJ4/EVSrn7iCnF28ZsB2rmvA6xqvGmLjcEPe/SRSZe7GEe4HWhQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JWLQCKFB;
	arc=none smtp.remote-ip=209.85.160.172
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CC93606A324
	for <linux-hyperv@vger.kernel.org>; Mon,  2 Nov 2026 04:06:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2CC93606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JWLQCKFB
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-533797e72e8so15981921cf.2
        for <linux-hyperv@vger.kernel.org>; Sun, 01 Nov 2026 20:06:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793592392; x=1794197192; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=AbAfqOiSmjkr5zT5Z7ymwEcuZe5nRrpvvhFQphOc1AI=;
        b=JWLQCKFBXrllvFnSHpX2xu3Q1JLga4oXPWOdDsC+1pPEh+PVFIuffrO4vQyrA+e7FC
         scf+IEjssWijwOf+f4k5IRf82opwvRhQZ1xZdIxqrNGChwYZz63krFqcotclwavSj8z4
         zflPbXMxNvYG+PUcG2bMBmymE3E4PNnuARcfUT3a6BD6G/erD1TXRWWZEtJDHmXzoW2i
         3Hpw/aAVNp/yt2k+ghkysIYsJPjfW5+7SmneCkIwqElziwmIdUyWiswDSTMrOM1R5SNk
         v6rmjMLMWqXim8hlNCQ7rYDJQ1wf+uPxe9HfHOc68OkQaU2UKJjKQdc4Tr5V44hCuP/r
         RJzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793592392; x=1794197192;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AbAfqOiSmjkr5zT5Z7ymwEcuZe5nRrpvvhFQphOc1AI=;
        b=xr4y1NoxKjwvDZABlg5zRcQYu3F2nmMDFuJktV+8XelEc47HT94PZf5DW6TbcA1S0J
         3cn8fMGMo1tnGetqTW8qvPnmk3GH+ghGStfUEbc/zlL+SFpJoN10u98U2ovPrd3bpKSd
         gVBCcA2IjusKcc6N1/W0rfiX7xt/X8KeOh0HZXDH7NyQ1oMP62SCveQRbArzolVuK4Ot
         SXEAcIp+1zWV9htbSruh/ZRiEtSUdMz90wtodTur5TPatYtxDBlkqybr7aiKUv6dmk49
         WhqIn3aTehcLdEcGAlhouwxsFgdPGtgFKqbL0sSHySeKy/6JmzhxOxJzNl84OrBh8YFN
         C4lQ==
X-Forwarded-Encrypted: i=1; AKwUvByOfY10Vso8M3OV5XJbnAsMDpRmXViFppk/zayjiMiKHxYwHSWox3vAtiPKRo7j2XSQk/UGz6nxPEFyLJI=@vger.kernel.org
X-Gm-Message-State: APuU4Z8Fcs2rpBXUo7B29JEsRrIcbifdQSfDQ3JGzjBvTdK+atLQfCPO
	YNX6kOkDBfCmCRZ8hT0O7mbjHNQCL3vqRTELN4dEH4al76/0E1UAepMyIob2Aw==
X-Gm-Gg: AYBFou32IOwN2nXIlhl0z9XTJSKtDHJ5/QeAVFqOvodeWPxKVNRVKa+AqgSFnAuqMLI
	YnTwfgZbmqISwlbD9kmgLhMidBjqj6CDdbk329o1K3o5q7AGt7AojrCl6wWCGNGPw5C+KVF6CHi
	r/bTwuE0AKYQht5Vr00KK11Z6UpYv68UkZjJ2YPnmE6YaRiqQk1SbplMPO+iAGmXxRkFZTepnl9
	e668LN8OcWtOyUC01mTfMjJZsH+49BCA9h1K7UEbr1MeIPq7TEeV/nPyQTAkJtPBBXBsviE02pI
	c83JKAnTO3TGJGT9+cpiNSNmLCD5TzmTL4t0NKIbVgk4hIYjLydBt0Z3b3FbFUEzRPdvRmtdoRm
	/pIXH/XOLYsjZkwKRSdDkEU0keYWqJA4f2unht4UqtQj/hiGuCseAN1Bbk/N87V5VLkoE6v7NdP
	eoeozt3hTXOvydvpwu9Q9C9QZdf8ULqc6I0AM3fs43oTvyFdyRIX5ppnZ/yZ0MUfzRFVHk5EJX1
	dvl2iNtJ3PDaeeNPyzfA7LR4n3PNCh82hjy5s//g1wd3PiqW4auOBXhmEsk4r1NolDYbwmfK0r/
	EswzFXhQm1ANvtV6qsfbMqFVjmAKRf1UN4SWncJ8E9OHAaqpYMhhuXxZxPpXJ3QdF0hUJ5uW0w=
	=
X-Received: by 2002:a05:622a:4ce:b0:532:f0a2:ef4 with SMTP id d75a77b69052e-542b62a466dmr143441661cf.26.1793592391864;
        Sun, 01 Nov 2026 20:06:31 -0800 (PST)
Received: from i4-gl-tmk5904.ad.psu.edu ([130.203.156.186])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-54311f75ff5sm75790931cf.10.2026.11.01.20.06.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 20:06:31 -0800 (PST)
From: Yuho Choi <oss.patchbox@gmail.com>
To: Haiyang Zhang <haiyangz@microsoft.com>,
	Dexuan Cui <decui@microsoft.com>
Cc: Wei Liu <wei.liu@kernel.org>,
	linux-hyperv@vger.kernel.org
Subject: net: mana: HWC memory after a failed DESTROY_HWC
Date: Sun,  1 Nov 2026 23:06:26 -0500
Message-ID: <20261102040629.368393-2-oss.patchbox@gmail.com>
X-Mailer: git-send-email 2.43.0
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

Hi Haiyang, Dexuan,

I have a question about the HWC teardown in mana_hwc_destroy_channel()
(drivers/net/ethernet/microsoft/mana/hw_channel.c, v7.4-rc1).

The function sends DESTROY_HWC but does not check the result, and then
frees the HWC queues and message buffers:

	if (gc->max_num_cqs > 0) {
		mana_smc_teardown_hwc(&gc->shm_channel, false);
		gc->max_num_cqs = 0;
	}

	if (hwc->txq)
		mana_hwc_destroy_wq(hwc, hwc->txq);
	...

mana_smc_teardown_hwc() itself says that waiting for the response "is
required to ensure hardware invalidates MST entries before software
frees memory". So I wonder what happens when the teardown fails, i.e.
when the PF returns an error (-EPROTO) or does not answer in time
(-ETIMEDOUT):

1. Can the hardware still write EQEs, CQEs or HWC responses to these
   pages after the driver has freed them?

2. Or is the function always reset in that case, so that nothing can
   reach the memory anymore? One case I have in mind is
   mana_serv_reset(), which calls mana_gd_suspend() while the HWC is
   not responding, so the teardown there may often fail.

If (1) is possible, I have a patch ready that keeps the HWC rings and
message buffers allocated when the teardown fails, leaking a few pages
instead of freeing memory the hardware may still use, and I would be
glad to send it. If (2) always holds, there is nothing to fix and I
will drop it.

This came from code inspection as part of ongoing, not yet published
research, and I have not reproduced it. I used an LLM to help with the
analysis and this mail.

Thanks,
Yuho

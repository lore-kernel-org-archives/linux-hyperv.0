Return-Path: <SRS0=nlEZ=5Z=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2737C2BA2B
	for <linux-hyperv@archiver.kernel.org>; Thu,  9 Apr 2020 16:38:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7761620768
	for <linux-hyperv@archiver.kernel.org>; Thu,  9 Apr 2020 16:38:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pu1D2EHm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726961AbgDIQiD (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Thu, 9 Apr 2020 12:38:03 -0400
Received: from mail-wr1-f45.google.com ([209.85.221.45]:45126 "EHLO
        mail-wr1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726837AbgDIQiD (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 9 Apr 2020 12:38:03 -0400
Received: by mail-wr1-f45.google.com with SMTP id v5so12635084wrp.12;
        Thu, 09 Apr 2020 09:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4AVcBDvhexR6mBdaQRyvT90vU+CQBIsl+K2COSOrYtw=;
        b=Pu1D2EHmyzcO/fceKBaMG8H2e5Wke+nExGr58gOz3gL1VCXd2kHRJUlHwmG30idKq4
         Msev0hZ72tccRypTtonEje+v4tLDOwUlArXFv757tqPLIJj4lZS7QktYEyyXdi+HnohG
         HF93IYNB0ifQR2rwJCuHni8uGvbT1qfSqnF1mUcbskihk7TYDWih5XItXZq6OtnkqB2d
         Nc2wrxauVwUxQKJ7Dg87E41z6f0rIA6cLQZQ3k1izJ0l44UAKD5YygSX9AjiTtRjG0u7
         ZntL6zH30Z+HlKbDqevKXMe4QCX9eFtZ4cKkhSigTaSw6rHbCIOt8Epj8EKEizzq+Q7m
         v4aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4AVcBDvhexR6mBdaQRyvT90vU+CQBIsl+K2COSOrYtw=;
        b=d1rillUwoiofFsvUl3NKhURyzM312n8hKFDaLlB2XPbYp8iPCxBySzA2gycStHhUKQ
         ThWIao/L4gRmQsDVCeUbzzMHgO3KwwrcLHovpZZYoT8enKwRqU6L8dx5EW8M8ZuWNXtS
         OpiWCTxE1LDxlneTxEuerhl17/YNtUNA49jR9HGpGXuFegiyNGqJO154kVl5WaNEdHWx
         UhVf+HLS+PfAxqKrfjA6nKb2Xog8f+QgzrM9c7zYDQns9gtcMQsWY+xApMyG5wnzvnoI
         mLBgq7PHVt3EfMQr0n3SDE94LLhxJy0fz1KAuOpRlUiiIIJEeBD8hD+cbVdyAG99bVMv
         7fzw==
X-Gm-Message-State: AGi0PuZKTYsX8w3Whoj6dguP2OFUSqAktGghr8KOtLKxpyk3O3ZK0Qvc
        AfF9jmA6RS85pxU1VHtA+tgK+XeI1ZpyLQ==
X-Google-Smtp-Source: APiQypL7HW3KK+VyLASTjR2EDm47BhJ5WgxYBASliRtC0CvhqdVbf4AWEZNPJdFhKJQDme6e3ydUgQ==
X-Received: by 2002:adf:fa4f:: with SMTP id y15mr44534wrr.118.1586450281881;
        Thu, 09 Apr 2020 09:38:01 -0700 (PDT)
Received: from jondnuc.lan (IGLD-84-229-155-55.inter.net.il. [84.229.155.55])
        by smtp.gmail.com with ESMTPSA id f16sm4239240wmc.37.2020.04.09.09.38.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2020 09:38:01 -0700 (PDT)
From:   Jon Doron <arilou@gmail.com>
To:     kvm@vger.kernel.org, linux-hyperv@vger.kernel.org
Cc:     vkuznets@redhat.com, Jon Doron <arilou@gmail.com>
Subject: [PATCH v1 0/1] x86/kvm/hyper-v: Add support to SYNIC exit on EOM
Date:   Thu,  9 Apr 2020 19:37:44 +0300
Message-Id: <20200409163745.573547-1-arilou@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

According to the TLFS:
"A write to the end of message (EOM) register by the guest causes the
hypervisor to scan the internal message buffer queue(s) associated with
the virtual processor.

If a message buffer queue contains a queued message buffer, the hypervisor
attempts to deliver the message.

Message delivery succeeds if the SIM page is enabled and the message slot
corresponding to the SINTx is empty (that is, the message type in the
header is set to HvMessageTypeNone).
If a message is successfully delivered, its corresponding internal message
buffer is dequeued and marked free.
If the corresponding SINTx is not masked, an edge-triggered interrupt is
delivered (that is, the corresponding bit in the IRR is set).

This register can be used by guests to poll for messages. It can also be
used as a way to drain the message queue for a SINTx that has
been disabled (that is, masked)."

So basically this means that we need to exit on EOM so the hypervisor
will have a chance to send all the pending messages regardless of the
SCONTROL mechnaisim.

Jon Doron (1):
  x86/kvm/hyper-v: Add support to SYNIC exit on EOM

 arch/x86/include/asm/kvm_host.h |  1 +
 arch/x86/kvm/hyperv.c           | 65 +++++++++++++++++++++++++++++----
 arch/x86/kvm/hyperv.h           |  1 +
 arch/x86/kvm/x86.c              |  5 +++
 include/uapi/linux/kvm.h        |  1 +
 5 files changed, 65 insertions(+), 8 deletions(-)

-- 
2.24.1


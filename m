Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE47739D6D5
	for <linux-hyperv@vger.kernel.org>; Fri, 28 Aug 2026 03:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787888695; cv=none; b=Fka5v0atlxqQp9WBZNHxYGANt/KwPGzQWJL7B+mQahfzV0ksB/Hzlr7sZ664oxcuLGs/y/eI6kJytuEUk63KAh0OW/KIPVqKsqi0K0anJJQ/Kr6dljNcLM8QLe3SyklsPRzfYdkbtMizlLIfqrlme7yuUK6K4YMZMEpbGdhfEaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787888695; c=relaxed/simple;
	bh=oyqO7yApbiBq84HOVVa9hmxDcvJ9fuCOtoFjK3Ayl00=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=vEuFffvcVQcZhFozS1Ow/adpCid2opFy2ngkxhYx9qjaDi5GXjwAih4cCjzlQzsa/iTfPHaDHoBHMrLJtVqbsoDa3WQQ3XxQWQ6yE+fCtp3K9+XTzEWCiAX5frtDiBf6ibLCOHJOf9w6NAvqxhigy9m6iKaSeDpY5jE4/0Z1eW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CRinrNCg; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CRinrNCg"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-8541875f596so74384b3a.0
        for <linux-hyperv@vger.kernel.org>; Thu, 27 Aug 2026 20:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787888693; x=1788493493; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=E5k4SS5gxupECR4Og0IkmCwIimkhRF1YOiA+xzlWzz4=;
        b=CRinrNCgDI43q+FvqwEyXY2cq2cAYSgEdQqZUK1bpaGmfvsmL234yvTrec6VKDhy0P
         QF/QkZrMocA/JuErkzQizFrLXQvtEqiLh9qhMuK+3yF+ykDEZVAPiCl7LrgvIgcOcXTC
         tfDndXzkq55+PS8hN/Py1b0akqcF9YYyulESjG8WUra4vQAr3P0mKCl2XQz3/LBSgyBT
         sHVWzrmqgN28IXFdkp0ImTE9/1HNQSP4EjlrpxHlvxykS3KwvVQRU8SfFqMKkZ0tlqpv
         CA8IPYYpDjE9W4y2uEHGIlqvYoAWXJr1ijlOmy/186F+zpUES8cFqp48AQSjvLelQAbc
         Dbeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787888693; x=1788493493;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=E5k4SS5gxupECR4Og0IkmCwIimkhRF1YOiA+xzlWzz4=;
        b=T4Rzi2fMuOz0LuH1v2jqdxgPyy93ClCTRGIPdBmXXrK0zLb+ghI/7/6aoWsXU3b0dz
         Oq9PAFiuWWje1qlPi86c92E1yrEBhICystalFyOi6af/n7NCPN2vqxlHhsTGeT1FcP2a
         RSfqgZPUdnQvgLQN251Kn+yKjOdQQCM9PynGs/7bUyd4nBYvzsZ5frLckFG3yjFZ9oR5
         EoNtB10d8A8azsHi8dLM4x2vUTlS4R2POBmNifafOkDDzrD/uIob/HGhP7+gdsZ0xMT4
         MdPlD4bI5ptOS+kLUpCu18zYom0OYHXlx6VKouglyS0rLL+C+w1LYWDxD2U2OV0J5jJP
         U+Rw==
X-Forwarded-Encrypted: i=1; AHgh+RpLL8230sVHqwS5/EGo6d46fzSzHkRBOtKnOfkPW1/9XPT5a+uSJbc4SVZ9OU22++zFVkggfHgha3pPNtk=@vger.kernel.org
X-Gm-Message-State: AFuF++m7ijE1aSMnf5OT9hq+QznDxUdtCwccuGgMW5ToyH/nT8xk8x1h
	TIaUyVvyzni3452tJIjYl7ebUWLyM7wKVTndNTetQSVzOfeF/j6zESxy
X-Gm-Gg: AR+sD11r7TZJ/16eGRD3k9tqBe3r8COv1r/+nCkhx3vjUqeqM/1hPTP51NgY4oS+Hww
	53ASO69Bfl6Iw8aTu3/FvzTVc6RsZ95nD3fCYaWABoUr3TQRLt4XNBKeb3XdZ6PhenwI86ayL5b
	VaQRZKTfEkymYYapNEEh3jJqvyxBu0PJdYPElZKQAYZdPGLVx3EjsuhxilD5tpsXmeIGfFMje9I
	Uk5uQWhnBPa5gB9RtR1Oj8KDTeKmfD7YEEMZCKcbIi9NJI5XWZmLbDMQNU2HKrA13McL+LbmPSp
	5GsuExWFLo1bm+zhdFCRT8/sSBhvD5SyjytngDHGyEPVn5JWtyHauj7p/gQf/W0xd9TIJFArYbR
	XBSmYS42wdu/sGQOwIoNHQbMJzvdnKRNqowVRcymWVQ4io/6BKH0HzXqHDcnjpZwZvtVym/log5
	UJJTxgVxsTn9z+5s++O6LSNsMtKMSrlqVocqVW6ls3NlsHRlHlqFbWd0HS++k0uKU/PTr9G+XjM
	Be25/HTKWq+04FnxpfGojoXqfrt0vwfr5B9mgBR8Ks=
X-Received: by 2002:a05:6a00:4fca:b0:846:8b22:4933 with SMTP id d2e1a72fcca58-8562c24568cmr6389634b3a.17.1787888693036;
        Thu, 27 Aug 2026 20:44:53 -0700 (PDT)
Received: from localhost.localdomain (c-174-165-208-10.hsd1.wa.comcast.net. [174.165.208.10])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8569f49f50bsm158541b3a.11.2026.08.27.20.44.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 20:44:52 -0700 (PDT)
From: Michael Kelley <mhkelley58@gmail.com>
X-Google-Original-From: Michael Kelley <mhklinux@outlook.com>
To: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	longli@microsoft.com,
	linux-hyperv@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] Drivers: hv: Remove !CPU_BIG_ENDIAN qualifier for arm64
Date: Thu, 27 Aug 2026 20:44:48 -0700
Message-Id: <20260828034448.8291-1-mhklinux@outlook.com>
X-Mailer: git-send-email 2.25.1
Reply-To: mhklinux@outlook.com
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Support for CPU_BIG_ENDIAN configurations on arm64 was deprecated
in commit 1cf89b6bf660 ("arm64: Kconfig: Make CPU_BIG_ENDIAN depend
on BROKEN"). The support is now in the process of being completely
removed.

The Kconfig for Hyper-V guests on arm64 currently has a
!CPU_BIG_ENDIAN qualifier since Hyper-V only supports little
endian. But with Linux on arm64 restricted to little endian,
that qualifier is no longer necessary. Remove it.

Signed-off-by: Michael Kelley <mhklinux@outlook.com>
---
 drivers/hv/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hv/Kconfig b/drivers/hv/Kconfig
index aa11bcefddf2..db8464fcd119 100644
--- a/drivers/hv/Kconfig
+++ b/drivers/hv/Kconfig
@@ -5,7 +5,7 @@ menu "Microsoft Hyper-V guest support"
 config HYPERV
 	bool "Microsoft Hyper-V core hypervisor support"
 	depends on (X86 && X86_LOCAL_APIC && HYPERVISOR_GUEST) \
-		|| (ARM64 && !CPU_BIG_ENDIAN)
+		|| ARM64
 	select PARAVIRT
 	select X86_HV_CALLBACK_VECTOR if X86
 	select OF_EARLY_FLATTREE if OF
-- 
2.25.1


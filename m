Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EA6346AA7A;
	Tue, 21 Jul 2026 15:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784647942; cv=none; b=KueHFyCmx3N0S6m55RgL3zB7zJUAsJClf0rop7bP9Z6s0aE6oF02B4M9h5rj/RGQ+lLMTZrN16OcCaam0R6KyS9GIeosByNjRZS+QfyM3/DkRBIEovoA3k2g9s6mAMzPGRYA2nYuywkoQ6RSW66CmVjVJp5dSY8m/qEbji1Ya1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784647942; c=relaxed/simple;
	bh=xraByHUbZBROtfuuLq4Nu7dvLRkL4mE/tvhwLC8rI30=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=achq5W0WOcSxrEEgS3HLDz60lcSG1KtXTW+e/ZxfdrEtBB01NCtoacT0qVc+SBMPRfjHp9eGg4Zi5FfFWYVAZHq3gG9TJ4eGzwzE+V60HlV4WCjiY/YlhrflbMlVkdOu3QZ8eSy+HRSZH6yDbJjcU15PNSAXmuY1RcxA0sPedNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QonKfwey; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KR/4Id0h; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QonKfwey";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KR/4Id0h"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1784647939;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=S608Kmt1HWYBmXlyAtfEnJyZo4qSzz2UPVUErauAwgA=;
	b=QonKfweyQKlfNzLnPt/3a9ryetPE+5eg807zYdwLwkVz3rc/XUdi/Zz9OWt3jMyWxKVONe
	jxAzsZBJCL9kt81rZNQqnCFCxcZbpwPhtnq1gMsccFeiTYZS/7mEMRsBJbo+tdvHm0H4GL
	PnT/cTNPPdKJLsI0jbBAPQiWOQ8sRlU9bSGyT9vHpfrEGW7oCZG//2B2+4bx56xwy8Mjmb
	LYN2A65MC2bIvvFDzAxyz7yMs/tZ2Pmb8JD1piWtHgxcJhNR+It1PMZ+u2nD8GjxvccoJa
	ZMP4OuvMq7ypyWS2a5feJ7M1KTnJTKJx0RWIj5nZ/PV6cyQDfhZGlWCbnHiIrA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1784647939;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=S608Kmt1HWYBmXlyAtfEnJyZo4qSzz2UPVUErauAwgA=;
	b=KR/4Id0hdWDHOiWjdReDIvPxEtFDZwdnoK6TaAAkTf0W5SiDlqotJwD9UPtPyOR2LpuPrN
	Uu9AnXKOVO9oaBBg==
To: linux-hyperv@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: "K. Y. Srinivasan" <kys@microsoft.com>,
	Dexuan Cui <decui@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	Long Li <longli@microsoft.com>,
	Michael Kelley <mhklinux@outlook.com>,
	Wei Liu <wei.liu@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH v2 0/2] Drivers: hv: vmbus: Small cleanups 
Date: Tue, 21 Jul 2026 17:32:14 +0200
Message-ID: <20260721153216.382536-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Replacing the lockdep_hardirq_threaded() annotation which does not
belong in drivers and removing the vmbus_irq_initialized which seems
redundant.

v1=E2=80=A6v2: https://lore.kernel.org/all/20260401151517.1743555-1-bigeasy=
@linutronix.de/
  - Added a comment next to the invocation of __vmbus_isr()
  - Added the "Drivers:" prefix to the subject line

Sebastian Andrzej Siewior (2):
  Drivers: hv: vmbus: Replace lockdep_hardirq_threaded() with lockdep
    annotation
  Drivers: hv: vmbus: Remove vmbus_irq_initialized

 drivers/hv/vmbus_drv.c | 27 ++++++++++++++++-----------
 1 file changed, 16 insertions(+), 11 deletions(-)

--=20
2.53.0


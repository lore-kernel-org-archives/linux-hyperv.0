Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=13.77.154.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794624797;
	b=rLtxeytUcn0xHQeSYwrDoPDFUo3MxIUJTiSU9KDy5lubwiZinRiLRMdEa3yMSWkuXLOk
	 7F8ulp2lznpGoac572qoYQSubCEbIv975qM++mmCXCcwptMmJGnFLOyX7tpXltn9zGiZ6
	 f0mzn7EhALrKmBJpoDNT3opVpsoUZT2c04kDU5biBL3+X7W+0JrpetRj5Y7ssHOrUXWoe
	 gkjuxHIykHrwufBA3HsI9GhxPwFec8l9DAVSlaOd5xJ5KUjttRXaiQYZtvn05DxHmFb9f
	 g8RcPohLppv3Xl3zFGefvW/i6ShGLjEPgXY8/0wGVBiSs5W8TeUTIcCco7f+n32nALg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794624797;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Spam-Status:X-Spam-Checker-Version;
	bh=YscMcYma1QZFpH9GQZJsPKho/D/g0TKycRL1zJFLFnA=;
	b=2m47E9zA6R7pkX6LVNbY4ART2sH3qKQCkcbE8fZVTn8sTl+khgWCN9ZzSuxs9qahDQbU
	 fkU2r48SLb+T4Tl98q+XhW+4bmTnVUvFKnmsaC5wQP5jkpiF4N9T6+GDuwFndPWCnHPP7
	 6dVKcDTtd51nUWcmtnfmLm/QRb88pvPNfRWU6R6yh1tbMm79PwMhX9zo0+5Vg/buRTsPZ
	 ypftp9WiL4L1Ots2lF84pEgWLMUg40c8r9E4nNOLTaVuZY6AFF/CJ/SSb4azVTaBDPf7T
	 GCcpPknc37fewbX53jPhfS6zwTiCdstyU3eWq85VwbEkX18tiq3xDF65QAqWcXATiAg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.microsoft.com;
	spf=pass smtp.mailfrom=linux.microsoft.com;
	dkim=pass header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=TXhODVBl;
	arc=none smtp.remote-ip=13.77.154.182
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC7DA606A32E;
	Sat, 14 Nov 2026 02:53:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DC7DA606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=TXhODVBl
Received: from mrdev.corp.microsoft.com (192-184-212-33.fiber.dynamic.sonic.net [192.184.212.33])
	by linux.microsoft.com (Postfix) with ESMTPSA id 9240220B7166;
	Fri, 13 Nov 2026 18:53:11 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 9240220B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1794624791;
	bh=YscMcYma1QZFpH9GQZJsPKho/D/g0TKycRL1zJFLFnA=;
	h=From:To:Cc:Subject:Date:From;
	b=TXhODVBljrGdn2HqssTgPbsi4RSavkharjOoT+piZjWQ6WS4wcEOPO/9x8x5TPq/O
	 sP8UtYFbb3KEK7SoBlw6hiN7tlKRAb/iSmdPadyMe0F/J4oWMYAaJde4hG7vUXb4ev
	 yaEmdNP/t+CEfaBn3VagvyRS6+ZFSfGjdiOAk+s4=
From: Mukesh R <mrathor@linux.microsoft.com>
To: linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	mhkelley58@gmail.com,
	kameroncarr@linux.microsoft.com
Subject: [PATCH V1 0/2] Hyper-V: Fix bugs and issues around repeat hypercall
Date: Fri, 13 Nov 2026 18:53:11 -0800
Message-ID: <20261114025313.1257042-1-mrathor@linux.microsoft.com>
X-Mailer: git-send-email 2.51.2.vfs.0.1
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

This short series addresses few issues around repeat hypercall, most
importantly the bug around not checking completed entries in case of
failure.

V1:
 o Rename hv_isolation_hw_cvm() to hv_isolation_type_hw()
 o Add HV_REP_COUNT_MAX in case this goes in before the pre-commit
   patch that adds it.

Mukesh R (2):
  Drivers: hv: Add new function hv_isolation_type_hw()
  Drivers: hv: Fix bugs and issues around repeat hypercall

 arch/x86/hyperv/ivm.c          |  7 +++-
 drivers/hv/hv_common.c         | 11 ++++--
 drivers/hv/mshv_common.c       | 19 +++++++---
 drivers/hv/mshv_root_hv_call.c | 21 +++++++----
 drivers/hv/mshv_root_main.c    |  6 +--
 include/asm-generic/mshyperv.h | 67 +++++++++++++++++++++++++---------
 include/hyperv/hvgdk_mini.h    |  2 +-
 7 files changed, 94 insertions(+), 39 deletions(-)

-- 
2.51.2.vfs.0.1


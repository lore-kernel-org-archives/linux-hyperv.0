Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 265E53537D0;
	Thu, 23 Apr 2026 12:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776948193; cv=none; b=aOg/PjqwoEMYv7Zl21NHOZTyhk8vAFdQcBIpx4iCk7etr+yJ6WVh6H5uf4e8jAIySInEqnBWD5Vfte4dIlKI6eKMV0RaPrgRxTVJx0tGz/FQAvNU8vExH+4zSwwyFqZPH69ujJk8+Nv9JpHwJEFNEImrsctYbQ+uz7Ffd++7+sA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776948193; c=relaxed/simple;
	bh=vPUV+9IKyChIXzMqTscljhgydmQTFZc3z74+Dvtr0hw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bUxMSJgh/FZvDa4ake8wG43Gpd9Iyi1ciNYinLKEfNKMRzvHRXJ8WZJOI2EqLTPyytZ2/+jcwg0DJmSuMXAZs0XM5ir3Qa/5Rpyib8HZ/oSdvbISHzRmgwbd1yl1yQSwTK8tgER6iskRAmOLNLhHp2EU1BhOfEjM+Pb/SDlEfzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Q+rLxbyv; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Q+rLxbyv"
Received: from CPC-namja-026ON.redmond.corp.microsoft.com (unknown [4.213.232.18])
	by linux.microsoft.com (Postfix) with ESMTPSA id 4315E20B716A;
	Thu, 23 Apr 2026 05:43:03 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4315E20B716A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1776948190;
	bh=xYrsyIoC51W4Qe8bosyyU9xMtVV38HlYUTBKJNuSgig=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Q+rLxbyvnffxyuNo7mQNSV1jDnHtH+MsGn2tqlrxeqczaIVyO9o9XxHTxfZYPivTj
	 IlWMlNYJBS65wirhfC6MYZYo470rxfD5FcIRjgLk/a3YENQESPYAlJHYYI/zpIJ0qL
	 YIZqDaeCfud83sBftDNVa/ckgxRBUqNnkc8Qs3/U=
From: Naman Jain <namjain@linux.microsoft.com>
To: "K . Y . Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H . Peter Anvin" <hpa@zytor.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Michael Kelley <mhklinux@outlook.com>
Cc: Marc Zyngier <maz@kernel.org>,
	Timothy Hayes <timothy.hayes@arm.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Sascha Bischoff <sascha.bischoff@arm.com>,
	mrigendrachaubey <mrigendra.chaubey@gmail.com>,
	Naman Jain <namjain@linux.microsoft.com>,
	linux-hyperv@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	vdso@mailbox.org,
	ssengar@linux.microsoft.com
Subject: [PATCH v2 06/15] mshv_vtl: Make sint vector architecture neutral
Date: Thu, 23 Apr 2026 12:41:56 +0000
Message-ID: <20260423124206.2410879-7-namjain@linux.microsoft.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260423124206.2410879-1-namjain@linux.microsoft.com>
References: <20260423124206.2410879-1-namjain@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Generalize Synthetic interrupt source vector (sint) to use
vmbus_interrupt variable instead, which automatically takes care of
architectures where HYPERVISOR_CALLBACK_VECTOR is not present (arm64).

Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
Reviewed-by: Michael Kelley <mhklinux@outlook.com>
Reviewed-by: Roman Kisel <vdso@mailbox.org>
Signed-off-by: Naman Jain <namjain@linux.microsoft.com>
---
 drivers/hv/mshv_vtl_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hv/mshv_vtl_main.c b/drivers/hv/mshv_vtl_main.c
index b607b6e7e121..91517b45d526 100644
--- a/drivers/hv/mshv_vtl_main.c
+++ b/drivers/hv/mshv_vtl_main.c
@@ -234,7 +234,7 @@ static void mshv_vtl_synic_enable_regs(unsigned int cpu)
 	union hv_synic_sint sint;
 
 	sint.as_uint64 = 0;
-	sint.vector = HYPERVISOR_CALLBACK_VECTOR;
+	sint.vector = vmbus_interrupt;
 	sint.masked = false;
 	sint.auto_eoi = hv_recommend_using_aeoi();
 
@@ -753,7 +753,7 @@ static void mshv_vtl_synic_mask_vmbus_sint(void *info)
 	const u8 *mask = info;
 
 	sint.as_uint64 = 0;
-	sint.vector = HYPERVISOR_CALLBACK_VECTOR;
+	sint.vector = vmbus_interrupt;
 	sint.masked = (*mask != 0);
 	sint.auto_eoi = hv_recommend_using_aeoi();
 
-- 
2.43.0


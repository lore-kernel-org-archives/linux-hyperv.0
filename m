Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36DB73EDAA6;
	Thu, 23 Apr 2026 12:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776948225; cv=none; b=hSYc5rcubyOcWI0PUmDTeU0O50mSbfa3hEBDpJqCrcNYKyi64mROdlh+3CnphJkfpgVMyO23JGxAHkG/icxgV36OG7qTmP2LvshLfOUJwYGgVmUTlhf1B/aiEuOAtlm5/i6wulpVioxpE39gTi/jJbmalxRVyYG2o8072M56vk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776948225; c=relaxed/simple;
	bh=xTtc9TutELlyQEkkRXCdnqpf1ZRzLYGo6NHAK52BlN4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W6klJioMewCazYvck6BYxq6ptxJI7JMzgB+llmD0d0ZHR2iubSYpvKHLTWZ9AM568tZbtuMiiTkY/w/H4JridVvKDitOzMxUQZvTyMYAjni9jRGvOoeijqieItC2r3+UYDgRSa5A/8Vbu60p9QFCmXZHdOipAJIkwh/H85RbIEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=jnDmNSc0; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="jnDmNSc0"
Received: from CPC-namja-026ON.redmond.corp.microsoft.com (unknown [4.213.232.18])
	by linux.microsoft.com (Postfix) with ESMTPSA id 37DC520B7167;
	Thu, 23 Apr 2026 05:43:37 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 37DC520B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1776948224;
	bh=HSbbqWv3vuhtoGamHoPNheyejHz2e9u0oDYSbNnHoaw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jnDmNSc0a/QiF41tnxPVpEemp0ovscQVoHm7CEknskN0kFoNazOQmBlBxrsnROhBF
	 HheeJD79c5Vtd0Nsn/hk4DaJ85YaULJVPW12qOrDSXkk2T4+rkdp4TmKCHfJ7PXX7H
	 s4ZTD4CYNMR+wg+YC3mqrxLdgn9/4lpM4PspwDDo=
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
Subject: [PATCH v2 10/15] arm64: hyperv: Add hv_vtl_configure_reg_page() stub
Date: Thu, 23 Apr 2026 12:42:00 +0000
Message-ID: <20260423124206.2410879-11-namjain@linux.microsoft.com>
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

ARM64 does not support the register page overlay, so provide a stub
that returns false. This pairs with the preceding commit that moved
hv_vtl_configure_reg_page() out of common code into architecture-
specific files.

Signed-off-by: Naman Jain <namjain@linux.microsoft.com>
---
 arch/arm64/hyperv/hv_vtl.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/hyperv/hv_vtl.c b/arch/arm64/hyperv/hv_vtl.c
index 59cbeb74e7b9..e07f6a865350 100644
--- a/arch/arm64/hyperv/hv_vtl.c
+++ b/arch/arm64/hyperv/hv_vtl.c
@@ -156,3 +156,10 @@ void mshv_vtl_return_call(struct mshv_vtl_cpu_context *vtl0)
 	kernel_neon_end(&fpsimd_state);
 }
 EXPORT_SYMBOL(mshv_vtl_return_call);
+
+bool hv_vtl_configure_reg_page(struct mshv_vtl_per_cpu *per_cpu)
+{
+	pr_debug("Register page not supported on ARM64\n");
+	return false;
+}
+EXPORT_SYMBOL_GPL(hv_vtl_configure_reg_page);
-- 
2.43.0


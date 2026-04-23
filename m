Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 856A91D6DB5;
	Thu, 23 Apr 2026 12:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776948147; cv=none; b=NDt9bhw/yk9A7BlfK4MrxWSeWExcOHHwd0RApk7fOOjEBuGMqooCXc9F7wfzIPh18oSNfZSuXS19dAjSOw123ODuJlypo5lJ42EUa6BfecnJ2qfhwsKg8BAZt5aSOVxTgg+3xoji2Tl7FKpYriOeS5Yc3KDIadStbDZkXwHMjCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776948147; c=relaxed/simple;
	bh=gNYAnUIiKY0dORHx1+xnjVbI2nukScfNAsanmDS/YPk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j5nF7G6UhEepofKNgrhIXycabAV3AiWxsFqCONSkZpEGeU3z0fTJkTm8W8TwCey5yVHF2e9sMctRuexwnSmsiHv42ZsalQTYRRn7xu+8++J8qzBw1CDHDvuhjNRL+QWqSK3wIIifiqYS3p+zAQ59K11P2lK6SCJfxqOt5rSLGow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=sdJr3BxS; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="sdJr3BxS"
Received: from CPC-namja-026ON.redmond.corp.microsoft.com (unknown [4.213.232.18])
	by linux.microsoft.com (Postfix) with ESMTPSA id 2833120B7168;
	Thu, 23 Apr 2026 05:42:18 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2833120B7168
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1776948146;
	bh=I2iUOz06N9pWMf1bIo71EnFA9O21Frf4P70pvQqdric=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sdJr3BxSKfa5DEwVFAHUFBYZT3CYc4MAfq8UWukagegS/A86yvkIHkLGL8iNV/AmX
	 sZQvA8TInk618z9cr/L8VcWhIK1vnpLV8JbFypwHHhnWweLdVlRRK6x4v0dVdtqL1i
	 5HUfRb7io3Hlx8KeTctmRzzkcsl9Mi34N8U1zmHM=
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
Subject: [PATCH v2 01/15] arm64: smp: Export arch_smp_send_reschedule for mshv_vtl module
Date: Thu, 23 Apr 2026 12:41:51 +0000
Message-ID: <20260423124206.2410879-2-namjain@linux.microsoft.com>
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

mshv_vtl_main.c calls smp_send_reschedule() which expands to
arch_smp_send_reschedule(). When CONFIG_MSHV_VTL=m, the module cannot
access this symbol since it is not exported on arm64.

smp_send_reschedule() is used in mshv_vtl_cancel() to interrupt a vCPU
thread running on another CPU. When a vCPU is looping in
mshv_vtl_ioctl_return_to_lower_vtl(), it checks a per-CPU cancel flag
before each VTL0 entry. Setting cancel=1 alone is not enough if the
target CPU thread is sleeping - the IPI from smp_send_reschedule() kicks
the remote CPU out of idle/sleep so it re-checks the cancel flag and
exits the loop promptly.

Other architectures (riscv, loongarch, powerpc) already export this
symbol. Add the same EXPORT_SYMBOL_GPL for arm64. This is required
for adding arm64 support in MSHV_VTL.

Reviewed-by: Michael Kelley <mhklinux@outlook.com>
Reviewed-by: Roman Kisel <vdso@mailbox.org>
Signed-off-by: Naman Jain <namjain@linux.microsoft.com>
---
 arch/arm64/kernel/smp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index 1aa324104afb..26b1a4456ceb 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -1152,6 +1152,7 @@ void arch_smp_send_reschedule(int cpu)
 {
 	smp_cross_call(cpumask_of(cpu), IPI_RESCHEDULE);
 }
+EXPORT_SYMBOL_GPL(arch_smp_send_reschedule);
 
 #ifdef CONFIG_ARM64_ACPI_PARKING_PROTOCOL
 void arch_send_wakeup_ipi(unsigned int cpu)
-- 
2.43.0


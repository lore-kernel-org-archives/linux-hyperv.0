Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4008438655B;
	Fri, 10 Jul 2026 05:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783662021; cv=none; b=q8L/q676ay/RMGhJiGVf91zI2DVE8kf6UzVctfWJmh3QS8qaGjmNiAxEfmc8CoDO8JX/PrEFrGKJINp8TvSX28+xz7HXAH115w5/2PYa4N4jn810IDf5qrctx3ZaLqYEq7vxU2nOqRZYrDJOImz+MEmrYyXw24YC7z0yHnirx5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783662021; c=relaxed/simple;
	bh=tNyN7VVgk7d7vTBIq7H6GNjWdKKdMlocdEqF343DGdc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XPNPbZT3vw8QhYNFFh3dnibc41qeY2KIVs+UynLYnjsNWJilZAIj0i4wDzwgAO4Wta8gtwrRunKh83lWQH27lSmoyf65WZx14gLbiZ05x56Wn/WlcN6ZUEe/YDvbPXQiXt0PnhPrgsxUbXDOK/W7wW4VdvUu+q0++RyBLdsEHBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=ZiUxvhgx; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="ZiUxvhgx"
Received: from CPC-namja-026ON.redmond.corp.microsoft.com (unknown [4.213.232.18])
	by linux.microsoft.com (Postfix) with ESMTPSA id 90CF320B716E;
	Thu,  9 Jul 2026 22:40:05 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 90CF320B716E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1783662008;
	bh=OT2ZhnplNTldk6j44LgyKhMNU+W9ACg04Y41ypoxni8=;
	h=From:To:Cc:Subject:Date:From;
	b=ZiUxvhgxmlsCYPBdkSTnY89TcDn96AflBbN0fVGyySJn1N3JxSpapcMXzXJ+Of1gl
	 lkZAEg84B+rm/nIts60J85bnebf/GTVYvLKFKcSASxe2gyoIapT33dMEINGAH6UC8n
	 m0c2cvkhkN59exezYCSWAUpKxRKu0vYvsMydo1zo=
From: Naman Jain <namjain@linux.microsoft.com>
To: Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H . Peter Anvin" <hpa@zytor.com>
Cc: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>,
	linux-kernel@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	Michael Kelley <mhklinux@outlook.com>
Subject: [RFC PATCH] x86/apic: Fix lost IRQ during forced vector migration on Hyper-V
Date: Fri, 10 Jul 2026 05:40:07 +0000
Message-ID: <20260710054007.288807-1-namjain@linux.microsoft.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Hyper-V the MSI retarget hypercall is asynchronous. When a CPU is
taken offline, chip_data_update() frees the outgoing CPU's vector inline
because the deferred cleanup-vector mechanism is unavailable for an
offline CPU. A device interrupt raised inside the stop_machine window can
be posted to the outgoing CPU's old vIRR after that inline free, causing
two problems:

1) The completion it carries is lost, as nothing drains the old vector
   once it is freed. If it was the last in-flight completion on an
   otherwise idle queue, the command times out and the controller is
   reset. This is the functional bug.

2) When the outgoing CPU re-enables interrupts during teardown, the late
   delivery finds VECTOR_UNUSED and reevaluate_vector() logs "No irq
   handler" - harmless but noisy.

The native MSI path (msi_set_affinity()) handles this race with
VECTOR_RETRIGGERED + irq_retrigger, but the Hyper-V MSI chip carries
IRQCHIP_MOVE_DEFERRED and reaches the forced-migration else-branch in
chip_data_update() instead, so it never gets that protection.

Mirror that protection in the forced-migration path:

- Issue __apic_send_IPI(newcpu, newvec) after installing the new mapping
  so a raced completion is drained on the new target. The retarget is
  asynchronous, so the outgoing IRR is not authoritative and the IPI is
  unconditional; a spurious or duplicate ISR is harmless to the MSI
  completion-draining handlers (NVMe, netdev), which find an empty queue.
- Mark the freed slot VECTOR_RETRIGGERED so the late stray is absorbed by
  reevaluate_vector() rather than logged. The write is unconditional
  because apic_free_vector() leaves the slot pointing at this irq's stale
  desc, not an unused entry (unlike msi_set_affinity()).

The migration runs under stop_machine with interrupts disabled on all
CPUs, so any raced CQE is visible before the new CPU handles the
retrigger.

The guard is restricted to edge MSI vectors on Hyper-V: it requires
X86_HYPER_MS_HYPERV, an external vector, a non-level trigger, and an
attached msi_desc. Only the MSI retarget hypercall is asynchronous, so
this is the sole path with the race; edge IOAPIC lines retarget
synchronously via the RTE and IR-remapped interrupts via the IRTE, and
neither is touched. Narrowing to MSI also keeps the unconditional
retrigger confined to completion-draining handlers, which tolerate a
phantom ISR, rather than arbitrary edge handlers. The slot marking and
completion drain must happen where the vector is freed and the new
mapping is installed, which is why the guard lives in chip_data_update()
rather than the Hyper-V MSI chip, which cannot reach vector_irq[].

Verified on a 64-CPU Azure VM: zero "No irq handler" events across 320
CPU hotplug passes with concurrent NVMe I/O, compared to ~460 per 5
minutes before the fix. No NVMe timeouts or controller resets observed.

Fixes: e84cf6aa501c5 ("x86/apic/vector: Handle vector release on CPU unplug correctly")
Cc: stable@vger.kernel.org
Assisted-by: GitHub-Copilot:claude-opus-4.8
Signed-off-by: Naman Jain <namjain@linux.microsoft.com>
---
 arch/x86/kernel/apic/vector.c | 48 +++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/arch/x86/kernel/apic/vector.c b/arch/x86/kernel/apic/vector.c
index bddc544653999..3577e9ca23ba6 100644
--- a/arch/x86/kernel/apic/vector.c
+++ b/arch/x86/kernel/apic/vector.c
@@ -20,6 +20,7 @@
 #include <asm/i8259.h>
 #include <asm/desc.h>
 #include <asm/irq_remapping.h>
+#include <asm/hypervisor.h>
 
 #include <asm/trace/irq_vectors.h>
 
@@ -152,6 +153,7 @@ static void chip_data_update(struct irq_data *irqd, unsigned int newvec, unsigne
 	struct apic_chip_data *apicd = apic_chip_data(irqd);
 	struct irq_desc *desc = irq_data_to_desc(irqd);
 	bool managed = irqd_affinity_is_managed(irqd);
+	bool hv_retrigger = false;
 
 	lockdep_assert_held(&vector_lock);
 
@@ -181,7 +183,46 @@ static void chip_data_update(struct irq_data *irqd, unsigned int newvec, unsigne
 		apicd->prev_cpu = apicd->cpu;
 		WARN_ON_ONCE(apicd->cpu == newcpu);
 	} else {
+		/*
+		 * The outgoing CPU cannot use the deferred cleanup-vector
+		 * mechanism, so its vector is freed inline below. On Hyper-V the
+		 * MSI retarget hypercall is asynchronous, so an interrupt raised
+		 * inside the stop_machine window can be posted to the outgoing
+		 * CPU's old vIRR after the free. Two complementary steps handle
+		 * that (see also the retrigger at the end of the function):
+		 *
+		 *  - Retrigger on the new target so a raced completion is drained
+		 *    there rather than lost. The retarget is asynchronous, so the
+		 *    outgoing IRR is not authoritative and the IPI is issued
+		 *    unconditionally; a spurious ISR is harmless to
+		 *    completion-draining handlers (they find an empty queue).
+		 *  - Mark the freed slot VECTOR_RETRIGGERED so a late stray is
+		 *    absorbed by reevaluate_vector() instead of logging "No irq
+		 *    handler" while the CPU still takes interrupts during
+		 *    teardown; __setup_vector_irq() resets it on re-online.
+		 *
+		 * This mirrors msi_set_affinity()'s protection, which the Hyper-V
+		 * MSI chip bypasses via IRQCHIP_MOVE_DEFERRED. The guard is
+		 * restricted to edge MSI vectors on Hyper-V (msi_desc present):
+		 * only the MSI retarget hypercall is asynchronous, so edge IOAPIC
+		 * lines (retargeted synchronously via the RTE) and level-triggered
+		 * lines never see this race and must not be force-injected.
+		 */
+		if (hypervisor_is_type(X86_HYPER_MS_HYPERV) &&
+		    apicd->vector >= FIRST_EXTERNAL_VECTOR &&
+		    !irqd_is_level_type(irqd) && irq_data_get_msi_desc(irqd))
+			hv_retrigger = true;
 		apic_free_vector(apicd->cpu, apicd->vector, managed);
+		/*
+		 * apic_free_vector() releases the matrix bit but leaves the
+		 * outgoing CPU's vector_irq[] slot pointing at the stale desc, so
+		 * the marker is written unconditionally here. (Unlike
+		 * msi_set_affinity(), which marks a genuinely unused slot and
+		 * therefore guards with IS_ERR_OR_NULL, the slot here still holds
+		 * this irq's old desc.)
+		 */
+		if (hv_retrigger)
+			per_cpu(vector_irq, apicd->cpu)[apicd->vector] = VECTOR_RETRIGGERED;
 	}
 
 setnew:
@@ -190,6 +231,13 @@ static void chip_data_update(struct irq_data *irqd, unsigned int newvec, unsigne
 	BUG_ON(!IS_ERR_OR_NULL(per_cpu(vector_irq, newcpu)[newvec]));
 	per_cpu(vector_irq, newcpu)[newvec] = desc;
 	apic_update_irq_cfg(irqd, newvec, newcpu);
+	/*
+	 * Drain any completion that raced onto the freed vIRR by retriggering
+	 * on the new target (see the else-branch above). Issued after the new
+	 * mapping is installed so the handler is present when it is serviced.
+	 */
+	if (hv_retrigger)
+		__apic_send_IPI(newcpu, newvec);
 }
 
 static void vector_assign_managed_shutdown(struct irq_data *irqd)
-- 
2.43.0


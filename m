Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 887AC37F313;
	Mon, 10 Aug 2026 06:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786342914; cv=none; b=aJshwKqCVxXhDr4u9inNKL7Wtk0U7BWJsLSEbNNQWB/+WyWzSNU3BsTSvaTw9OjXU7OdELYBzSlrHHiO/tmlta6nuKZzSFI0sEGJXIJp6xVzflGlDxjP8TTmyrqGBgfOSEmrcwvJWQhs2hRKv0kxlXg4MZXwfCkIECaBElBJ84U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786342914; c=relaxed/simple;
	bh=U9EhGutCA+SP7TEQ24HS1kT1NrvLEcw7O/mZGNhETlQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rG324Lx84aauOMQfU8jvIC1rFD1iYtF24emViHEZOvmzImaJ3iN2fPQOpFtBC7WY2ejA1cOpMOPm4YStLuGy54NVWuV11NVYFI2mu3Ouva7+dPmD9Fn4nok/pa7djpOqfx3w4t+ttLYyJui7rmyWut1rECL2jq1NjXBiAMlj+uY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=goczk8yo; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="goczk8yo"
Received: from CPC-namja-026ON.redmond.corp.microsoft.com (unknown [4.213.232.19])
	by linux.microsoft.com (Postfix) with ESMTPSA id 82FF620B7166;
	Sun,  9 Aug 2026 23:21:25 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 82FF620B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1786342888;
	bh=rIC8eIGvqqRXNzktnGhZfSdOmCV/232oIXpGSrGrXt4=;
	h=From:To:Cc:Subject:Date:From;
	b=goczk8yoIcJ/5cbYeakyIlU3CB6tx/SWMNmtgmf3pWNI6u+AHfZTTKjuvRhwFYEP6
	 jq2D32y3Mf1FHX3OlVcOuQytWG6IjhC0kaPSN9qgQcCXpAlkxUUc05R+GOmGi211Ft
	 LAMgaaWbkMacbrV1kwSgZRXZE1Y11ZqnulZEdras=
From: Naman Jain <namjain@linux.microsoft.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Ming Lei <tom.leiming@gmail.com>,
	Ming Lei <ming.lei@redhat.com>
Cc: Wangyang Guo <wangyang.guo@intel.com>,
	Tianyou Li <tianyou.li@intel.com>,
	Tim Chen <tim.c.chen@linux.intel.com>,
	Long Li <longli@microsoft.com>,
	linux-kernel@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	Michael Kelley <mhklinux@outlook.com>
Subject: [PATCH v2] lib/group_cpus: rotate extra groups to avoid IRQ stacking
Date: Mon, 10 Aug 2026 06:21:44 +0000
Message-ID: <20260810062144.2108758-1-namjain@linux.microsoft.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

group_cpus_evenly() computes how a device's queue interrupts are spread
across CPUs. It backs managed-interrupt affinity (kernel/irq/affinity.c)
and block-multiqueue mappings (block/blk-mq-cpumap.c), and is invoked
independently by every device that uses them - NVMe, NICs, storage HBAs,
and virtio devices. Its output is deterministic, i.e. for a given
topology, two similar devices produce an identical group-to-CPU mapping.

When ngroups < ncpus, some groups end up with only a single CPU. An
interrupt whose mask has one CPU can only run there, making that CPU a
"hot" handler. Because the mapping is deterministic, identical devices
compute the same layout and stack all their single-CPU IRQs onto the
very same CPUs, leaving the rest of the system idle.

This is easy to hit in practice. On an Azure L96as_v4 VM (96 vCPUs, 2
NUMA nodes of 48 CPUs, 6 NVMe disks with 62 I/O queues each),
group_cpus_evenly() splits each disk's 62 queues into 31 per node over
48 CPUs. 48 does not divide evenly by 31:

    per NUMA node: 48 CPUs / 31 queues
      17 groups get 2 CPUs   (cover 34 CPUs)
      14 groups get 1 CPU    (cover 14 CPUs)  <- single-CPU "hot" queues

That is 14 hot queues per node, 28 per disk. All 6 disks land them on
the same 28 CPUs, so 168 hot interrupts pile onto 28 of 96 CPUs while
two-thirds of the system handles none:

    Before (per-CPU, disks whose IRQs it services):
      CPU  0: 3 disks    ...   CPU 34: 6 disks (all six)
      CPU  1: 3 disks    ...   CPU 47: 6 disks (all six)
    Summary: 28 CPUs (34-47, 82-95) served all 6 disks and the other 68
    served only 3. Those 28 CPUs cap throughput and inflate tail
    latency while most of the system is idle.

Fix this by introducing a per-caller rotation via a static atomic
counter (group_spread_cnt). Each call to group_cpus_evenly() takes a
unique spread_offset, applied to the two decisions that were previously
deterministic:

1) Cluster-level rotation in __try_group_cluster_cpus(): after
   alloc_groups_to_nodes() distributes groups proportionally across
   clusters, integer rounding leaves some clusters with one extra
   group. The extras are redistributed starting from a rotated
   position, with a stride of ncluster/total_extra to minimize overlap
   between consecutive callers. A multi-pass fallback ensures all
   extras are placed even when some clusters are at capacity.

2) Intra-cluster rotation in assign_cpus_to_groups(): the sequential
   extra assignment is replaced with a modular expression,
     (v + spread_offset) % nv->ngroups < extra_grps
   rotating which groups within a cluster receive the extra CPU.

Nothing else about the layout changes - same queue count, same NUMA
weighting, same full CPU coverage and locality. Each caller simply
starts its mapping from a different point, and each individual call
still produces a valid, fair distribution. Across callers, different
CPUs absorb the single-CPU group IRQ load:

    After (same setup, with the rotation):
      CPU  0: 4 disks    CPU  2: 4 disks    CPU 47: 4 disks
      CPU  1: 4 disks    CPU  3: 4 disks    ...
    Summary: no CPU serves more than 4 disks, and all 96 CPUs are used.

The total interrupt work is unchanged - every CPU still handles one
queue per disk; only the placement of the single-CPU hot queues moves.
This benefits every managed-IRQ, blk-mq, and virtio-vdpa / virtio-fs
device with no driver changes.

Because the offset comes from a global counter advanced once per call,
the mapping now depends on call (device probe) order. A given device's
exact layout can differ from one boot to the next, and a later recompute
(e.g. a blk-mq remap) may pick a different layout. Every such layout is
still valid, fair, and proportional - only the choice among equally good
mappings varies.

On a 96-vCPU Hyper-V VM running 4K random-read fio across 6 NVMe disks,
worst-disk degradation versus average dropped from 11% to 5%, and the
previously penalized disks gained 12% IOPS at 10% lower latency.

Fixes: 89802ca36c96 ("lib/group_cpus: make group CPU cluster aware")
Co-developed-by: Long Li <longli@microsoft.com>
Signed-off-by: Long Li <longli@microsoft.com>
Signed-off-by: Naman Jain <namjain@linux.microsoft.com>
---
Changes since v1
(https://lore.kernel.org/all/20260324075352.2326972-1-namjain@linux.microsoft.com/):
- Cluster base is now a per-cluster proportional floor
  (ngroups * cap / ncpus) instead of the global per-cluster minimum,
  so proportional weighting is preserved on asymmetric (e.g.
  big.LITTLE) cluster topologies. (Sashiko review)
- Document that the rotation offset is call/probe-order dependent: a
  device's exact layout may vary across boots and recomputes (each
  layout is still valid, fair, and proportional).
- Rewrite the commit message with a worked example and fio numbers.

 lib/group_cpus.c | 149 +++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 137 insertions(+), 12 deletions(-)

diff --git a/lib/group_cpus.c b/lib/group_cpus.c
index e6e18d7a49bba..8bed0f9d2110b 100644
--- a/lib/group_cpus.c
+++ b/lib/group_cpus.c
@@ -7,6 +7,7 @@
 #include <linux/slab.h>
 #include <linux/cpu.h>
 #include <linux/sort.h>
+#include <linux/atomic.h>
 #include <linux/group_cpus.h>
 
 #ifdef CONFIG_SMP
@@ -255,12 +256,20 @@ static void alloc_nodes_groups(unsigned int numgrps,
 	alloc_groups_to_nodes(numgrps, numcpus, node_groups, nr_node_ids);
 }
 
+/*
+ * Per-caller rotation counter for group_cpus_evenly().
+ * Wrapping is harmless: the offset is only used modulo small values
+ * (ncluster or nv->ngroups), so any unsigned value works.
+ */
+static atomic_t group_spread_cnt = ATOMIC_INIT(0);
+
 static void assign_cpus_to_groups(unsigned int ncpus,
 				  struct cpumask *nmsk,
 				  struct node_groups *nv,
 				  struct cpumask *masks,
 				  unsigned int *curgrp,
-				  unsigned int last_grp)
+				  unsigned int last_grp,
+				  unsigned int spread_offset)
 {
 	unsigned int v, cpus_per_grp, extra_grps;
 	/* Account for rounding errors */
@@ -270,11 +279,15 @@ static void assign_cpus_to_groups(unsigned int ncpus,
 	for (v = 0; v < nv->ngroups; v++, *curgrp += 1) {
 		cpus_per_grp = ncpus / nv->ngroups;
 
-		/* Account for extra groups to compensate rounding errors */
-		if (extra_grps) {
+		/*
+		 * Rotate which groups get the extra CPU so that
+		 * successive callers produce different mappings,
+		 * avoiding IRQ stacking when multiple devices
+		 * share the same CPU topology.
+		 */
+		if (extra_grps &&
+		    (v + spread_offset) % nv->ngroups < extra_grps)
 			cpus_per_grp++;
-			--extra_grps;
-		}
 
 		/*
 		 * wrapping has to be considered given 'startgrp'
@@ -361,7 +374,8 @@ static bool __try_group_cluster_cpus(unsigned int ncpus,
 				     struct cpumask *node_cpumask,
 				     struct cpumask *masks,
 				     unsigned int *curgrp,
-				     unsigned int last_grp)
+				     unsigned int last_grp,
+				     unsigned int spread_offset)
 {
 	struct node_groups *cluster_groups;
 	const struct cpumask **clusters;
@@ -379,6 +393,111 @@ static bool __try_group_cluster_cpus(unsigned int ncpus,
 	if (ncluster == 0)
 		goto fail_no_clusters;
 
+	/*
+	 * Rotate which clusters receive extra groups so that different
+	 * callers of group_cpus_evenly() produce different group-to-CPU
+	 * mappings. Without this, all devices get identical affinity
+	 * masks, causing IRQ stacking on CPUs assigned single-CPU groups.
+	 *
+	 * alloc_groups_to_nodes() distributes ngroups proportionally, but
+	 * integer rounding causes some clusters to get one more group
+	 * than others. The assignment is deterministic, so every device
+	 * gets the same mapping. Fix: compute a proportional floor for
+	 * each cluster (ngroups * cap / ncpus), collect only the
+	 * rounding-induced extras, then redistribute them starting from
+	 * a rotated position. This preserves the proportional weighting
+	 * across differently-sized clusters while rotating the rounding
+	 * extras, keeping the rotation effective on both symmetric and
+	 * asymmetric cluster topologies.
+	 *
+	 * Note: after alloc_groups_to_nodes(), cluster_groups[].ngroups
+	 * holds the group count (the union no longer holds per-cluster CPU
+	 * counts), so each cluster's CPU capacity (cap) is taken from its
+	 * mask. The ncpus divisor is the function parameter, which equals
+	 * the sum of the per-cluster caps.
+	 */
+	if (ncluster > 1) {
+		unsigned int total_extra = 0;
+		unsigned int start, stride;
+
+		/*
+		 * Compute a per-cluster proportional floor and collect
+		 * only the rounding-induced extras for redistribution.
+		 *
+		 * Each cluster's floor is ngroups * cap / ncpus, which
+		 * preserves its proportional share.  Only the rounding
+		 * remainders (typically one per cluster) are collected
+		 * for rotated redistribution, keeping the rotation
+		 * effective even on asymmetric topologies (e.g.
+		 * big.LITTLE) where differently-sized clusters would
+		 * otherwise absorb all extras deterministically.
+		 */
+		for (i = 0; i < ncluster; i++) {
+			unsigned int cap, prop_floor, base;
+
+			cap = cpumask_weight_and(clusters[cluster_groups[i].id],
+						 node_cpumask);
+			prop_floor = ngroups * cap / ncpus;
+
+			/*
+			 * Use proportional floor as base.  Ensure at
+			 * least 1 group per cluster, and never exceed
+			 * alloc_groups_to_nodes()'s original allocation
+			 * (which may be less than prop_floor when small
+			 * clusters consumed groups via max(1,...)).
+			 */
+			base = prop_floor > 0 ? prop_floor : 1;
+			if (base > cluster_groups[i].ngroups)
+				base = cluster_groups[i].ngroups;
+
+			total_extra += cluster_groups[i].ngroups - base;
+			cluster_groups[i].ngroups = base;
+		}
+
+		/*
+		 * Redistribute rounding extras using a stride to scatter
+		 * them across clusters.  With stride = ncluster / extras,
+		 * consecutive callers' extra sets overlap minimally
+		 * (e.g. max 2 overlap for 6 callers with 24 clusters
+		 * and 7 extras, vs 6 overlap with stride 1).
+		 */
+		start = spread_offset % ncluster;
+		stride = (total_extra > 0 && total_extra < ncluster) ?
+			 ncluster / total_extra : 1;
+
+		for (i = 0; i < ncluster && total_extra > 0; i++) {
+			unsigned int idx =
+				(start + i * stride) % ncluster;
+			unsigned int cap;
+
+			cap = cpumask_weight_and(clusters[cluster_groups[idx].id],
+						 node_cpumask);
+			if (cluster_groups[idx].ngroups < cap) {
+				cluster_groups[idx].ngroups++;
+				total_extra--;
+			}
+		}
+
+		/* Fallback: place remaining extras wherever they fit */
+		while (total_extra > 0) {
+			unsigned int placed = 0;
+
+			for (i = 0; i < ncluster && total_extra > 0; i++) {
+				unsigned int cap;
+
+				cap = cpumask_weight_and(clusters[cluster_groups[i].id],
+							 node_cpumask);
+				if (cluster_groups[i].ngroups < cap) {
+					cluster_groups[i].ngroups++;
+					total_extra--;
+					placed++;
+				}
+			}
+			if (!placed)
+				break;
+		}
+	}
+
 	for (i = 0; i < ncluster; i++) {
 		struct node_groups *nv = &cluster_groups[i];
 
@@ -389,7 +508,8 @@ static bool __try_group_cluster_cpus(unsigned int ncpus,
 			continue;
 		WARN_ON_ONCE(nv->ngroups > nc);
 
-		assign_cpus_to_groups(nc, nmsk, nv, masks, curgrp, last_grp);
+		assign_cpus_to_groups(nc, nmsk, nv, masks, curgrp, last_grp,
+				      spread_offset);
 	}
 
 	ret = true;
@@ -404,7 +524,8 @@ static bool __try_group_cluster_cpus(unsigned int ncpus,
 static int __group_cpus_evenly(unsigned int startgrp, unsigned int numgrps,
 			       cpumask_var_t *node_to_cpumask,
 			       const struct cpumask *cpu_mask,
-			       struct cpumask *nmsk, struct cpumask *masks)
+			       struct cpumask *nmsk, struct cpumask *masks,
+			       unsigned int spread_offset)
 {
 	unsigned int i, n, nodes, done = 0;
 	unsigned int last_grp = numgrps;
@@ -455,13 +576,14 @@ static int __group_cpus_evenly(unsigned int startgrp, unsigned int numgrps,
 		WARN_ON_ONCE(nv->ngroups > ncpus);
 
 		if (__try_group_cluster_cpus(ncpus, nv->ngroups, nmsk,
-					     masks, &curgrp, last_grp)) {
+					     masks, &curgrp, last_grp,
+					     spread_offset)) {
 			done += nv->ngroups;
 			continue;
 		}
 
 		assign_cpus_to_groups(ncpus, nmsk, nv, masks, &curgrp,
-				      last_grp);
+				      last_grp, spread_offset);
 		done += nv->ngroups;
 	}
 	kfree(node_groups);
@@ -488,6 +610,7 @@ static int __group_cpus_evenly(unsigned int startgrp, unsigned int numgrps,
 struct cpumask *group_cpus_evenly(unsigned int numgrps, unsigned int *nummasks)
 {
 	unsigned int curgrp = 0, nr_present = 0, nr_others = 0;
+	unsigned int spread_offset;
 	cpumask_var_t *node_to_cpumask;
 	cpumask_var_t nmsk, npresmsk;
 	int ret = -ENOMEM;
@@ -510,6 +633,8 @@ struct cpumask *group_cpus_evenly(unsigned int numgrps, unsigned int *nummasks)
 	if (!masks)
 		goto fail_node_to_cpumask;
 
+	spread_offset = (unsigned int)atomic_fetch_inc(&group_spread_cnt);
+
 	build_node_to_cpumask(node_to_cpumask);
 
 	/*
@@ -528,7 +653,7 @@ struct cpumask *group_cpus_evenly(unsigned int numgrps, unsigned int *nummasks)
 
 	/* grouping present CPUs first */
 	ret = __group_cpus_evenly(curgrp, numgrps, node_to_cpumask,
-				  npresmsk, nmsk, masks);
+				  npresmsk, nmsk, masks, spread_offset);
 	if (ret < 0)
 		goto fail_node_to_cpumask;
 	nr_present = ret;
@@ -545,7 +670,7 @@ struct cpumask *group_cpus_evenly(unsigned int numgrps, unsigned int *nummasks)
 		curgrp = nr_present;
 	cpumask_andnot(npresmsk, cpu_possible_mask, npresmsk);
 	ret = __group_cpus_evenly(curgrp, numgrps, node_to_cpumask,
-				  npresmsk, nmsk, masks);
+				  npresmsk, nmsk, masks, spread_offset);
 	if (ret >= 0)
 		nr_others = ret;
 
-- 
2.43.0


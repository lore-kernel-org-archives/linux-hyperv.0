Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D43444D030;
	Thu,  7 May 2026 15:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778168652; cv=none; b=q99P5l/SGDdyrmH911fc4e498IXlj7WQVQajv/c8Y3k0Mg+F41X1Ci410gHHjNLdpyDG9iNHYfGqjSvOVTz0L7hREA6T7zeb8/xP+r5/1n9LQVHv+jLmMeW4nluOid0cyo0AD/Z/0NgPvMp6HiEvuB2ciAU22TvoGTmHpJQSRT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778168652; c=relaxed/simple;
	bh=iHm3PRLgx+E0j6jYUMI/Rjo08Ejg0YTFa/0yt7RgJwM=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dLm8TX+6dyVd6KDaUxuEoiOMnbTknthP45yQdmPapvVj8WRphFAmRcZb+XwBeCNtk43pG4XdhpgVbGb86j4Y1vxiVnH0nYtmbdyTTh3gOz+of+SY6WMtvJywapchSyKyKKH221u2KrY2Zf3PJD3OpAbsHcWndjEaWDH0tsaBV7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=GNaGpUq4; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="GNaGpUq4"
Received: from skinsburskii-cloud-desktop.internal.cloudapp.net (unknown [4.155.116.186])
	by linux.microsoft.com (Postfix) with ESMTPSA id A6B3420B7167;
	Thu,  7 May 2026 08:44:07 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A6B3420B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1778168647;
	bh=WbrUv/xecwJdetkoIS3sTAaBa08854dwNImgR1lq1go=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=GNaGpUq45ra6RpTTqZqu2pbjNL7PryqMGIApauXXnoNDNjyWu9kZJQmeGclyBg0/k
	 CwjbaYxcWzPpyemwAh1AeuilpFq4lrLABWBqFK1zwXUwEnfe4ZSYxPXt6iuCiNbc99
	 Qc478cwRS3TyKBMeu1U8/37+tzfXTZsq1n40lMn0=
Subject: [PATCH v4 13/18] mshv: Add missing vp_index bounds check in intercept
 ISR
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, longli@microsoft.com
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 07 May 2026 15:44:10 +0000
Message-ID: 
 <177816865065.21765.5112039734725197893.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
In-Reply-To: 
 <177816592843.21765.4364464279247150355.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
References: 
 <177816592843.21765.4364464279247150355.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

mshv_intercept_isr() reads vp_index from the SynIC intercept message
payload and uses it directly to index into partition->pt_vp_array without
validating that vp_index < MSHV_MAX_VPS.

Mshv treats the Microsoft Hypervisor as trusted, so a malformed vp_index is
not a security concern; the threat model does not include a malicious
hypervisor. A hypervisor bug that placed an out-of-range value here would,
however, cause an out-of-bounds read of pt_vp_array in hardirq context,
manifesting as random memory corruption or a host crash with no clear
signal pointing back to the hypervisor as the source.

handle_bitset_message() and handle_pair_message() already perform this
defensive check on hypervisor-supplied vp_index values, with an explicit
"This shouldn't happen, but just in case" comment  Add the same check to
mshv_intercept_isr() for consistency, turning a potential silent corruption
into a debuggable pr_debug message.

Fixes: 621191d709b14 ("Drivers: hv: Introduce mshv_root module to expose /dev/mshv to VMMs")
Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
---
 drivers/hv/mshv_synic.c |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/hv/mshv_synic.c b/drivers/hv/mshv_synic.c
index bac890cd2b468..89207aad7cf1f 100644
--- a/drivers/hv/mshv_synic.c
+++ b/drivers/hv/mshv_synic.c
@@ -387,6 +387,11 @@ mshv_intercept_isr(struct hv_message *msg)
 	 */
 	vp_index =
 	       ((struct hv_opaque_intercept_message *)msg->u.payload)->vp_index;
+	/* This shouldn't happen, but just in case. */
+	if (unlikely(vp_index >= MSHV_MAX_VPS)) {
+		pr_debug("VP index %u out of bounds\n", vp_index);
+		goto unlock_out;
+	}
 	vp = partition->pt_vp_array[vp_index];
 	if (unlikely(!vp)) {
 		pr_debug("failed to find VP %u\n", vp_index);



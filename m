Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B0B841B344;
	Thu,  7 May 2026 15:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778168630; cv=none; b=gC4zTcSzHb8ztlRq3K9sb7fnd+u/VA1mTAE30Ed0iq8w86ofHI5sLEBe45If6/Avsl+tQIw71U1mZc8Nh95L7izR5ewOA/xAizlN37oKGzZClOj7mZzkam12R78VNs51q1CJqkFqaZmzkH4QMFEwFGJPdUJCsnyIVGYLfjAwTlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778168630; c=relaxed/simple;
	bh=w8zGpvNdHCEwpQC41U+LGi4hcfJAIRGgdoJmOvavBko=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ijY0RFan6F6+6tvGnc6On3s1G6ma5Xlb2dwn5dMb5MrzFQoIZZDOzmVmq96WZX8E09VbaZBtXQ9ypC9S8a65sZpjMFeCiBO/+5M6pgJi9L2dOABrRCqpse0jtvatkWEGMxxuCudHpZmw3Nu0+nCnEktROXwaVjdsAkWP18i02u0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=d79bUDyn; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="d79bUDyn"
Received: from skinsburskii-cloud-desktop.internal.cloudapp.net (unknown [4.155.116.186])
	by linux.microsoft.com (Postfix) with ESMTPSA id 2293120B7165;
	Thu,  7 May 2026 08:43:46 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2293120B7165
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1778168626;
	bh=BZS6/WrlIxsM0Va1aIBK75IzmygEjv6FxrlQhutfgXk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=d79bUDynNv9hmvDIz/YgfLI0BnfLNyj9egfmo9Ekw6AstHcMt9nEV0aYJsucumSa/
	 rFOnMUxMquF8oK05vvRXwmHsRvP5uxPcBMyWIxIjahupufos8s5+Uina4ivEQPum/Z
	 jPy/lf7bq2Hh95ZHcwQYyRKj/TBx4yd4uw4e499o=
Subject: [PATCH v4 09/18] mshv: Fix duplicate GSI detection for GSI 0
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, longli@microsoft.com
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 07 May 2026 15:43:49 +0000
Message-ID: 
 <177816862911.21765.306085307721937662.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
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
Content-Transfer-Encoding: 8bit

The duplicate routing entry check in mshv_update_routing_table() uses
guest_irq_num != 0 to detect whether a GSI slot is already occupied.
This fails for GSI 0 because its guest_irq_num is 0 both when the slot
is unused (zero-initialized) and when legitimately assigned. As a
result, duplicate entries for GSI 0 are silently accepted, with the
second entry overwriting the first — corrupting the routing table
without any error reported to userspace.

While GSI 0 (legacy timer) is unlikely to appear in MSI-based routing
in practice, the check is semantically wrong — it conflates
"uninitialized" with "GSI number 0." Use girq_entry_valid instead,
which is explicitly set to true when an entry is populated and remains
zero for unused slots regardless of the GSI number.

Fixes: 621191d709b14 ("Drivers: hv: Introduce mshv_root module to expose /dev/mshv to VMMs")
Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
---
 drivers/hv/mshv_irq.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hv/mshv_irq.c b/drivers/hv/mshv_irq.c
index 59584a132ca9f..db05512db5548 100644
--- a/drivers/hv/mshv_irq.c
+++ b/drivers/hv/mshv_irq.c
@@ -88,7 +88,7 @@ int mshv_update_routing_table(struct mshv_partition *partition,
 		/*
 		 * Allow only one to one mapping between GSI and MSI routing.
 		 */
-		if (girq->guest_irq_num != 0) {
+		if (girq->girq_entry_valid) {
 			r = -EINVAL;
 			goto out;
 		}



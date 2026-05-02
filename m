Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEA6521ADA4;
	Sat,  2 May 2026 04:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777696094; cv=none; b=EH36q4cbAmTMs58GZ42ykyXYYx9esT6d9IHK/PCepgPlxvkMwrqbF2NhzlkisjI75WotgjXCkUKzxDOUoLWYTOiNi923PcPOU19V3xmcE3cL+RPJm2NzsM7Wvxj4QWaOHrXMO3uBU94jQ8iyOGNdkZ61U5QslatQL/srzzYTyM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777696094; c=relaxed/simple;
	bh=UhbPtpOtF8adVWEcrhJCGaZfOpHmg4mma6YChpfSNsA=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=anU/R2c5mbGgWOKXOTtMseQ3S1uDGr69cyaITKe6qX5o8L6cOosE5WTY2Vwz0hTof8RbZnIAoggM2WaqkMqYlI0FCkXtRGeHOdjahIw/jtJyXE2DEVjso5Yrpty99yg/5DFm7evwdzZYUjkX3e5EXe4R+/8KbnApfUYl7Hfa86w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Fw/PFbt4; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Fw/PFbt4"
Received: from skinsburskii-cloud-desktop.internal.cloudapp.net (unknown [4.155.116.186])
	by linux.microsoft.com (Postfix) with ESMTPSA id 4F9ED20B7172;
	Fri,  1 May 2026 21:28:12 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4F9ED20B7172
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1777696092;
	bh=41vMCnBFQ+h/hWyrAhm+rDmCa9KdDYvWtC741ydUrIQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=Fw/PFbt4qACO1X6BLfaxd8LFb28WR8/Ao/Akq7QOFdNYPzj55MMjYwH88RWsCwuYb
	 k96Dqpwn2Ye5+c2RPdmVjvYKYP9I+cfUKqEDft6e5L9gQLlqHIZA4KYguRS5v67F1w
	 crge41Y8IN8NRT8e33aniVQmaLA8wVodYnR21QM8=
Subject: [PATCH v2 11/18] mshv: Fix duplicate GSI detection for GSI 0
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, longli@microsoft.com
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Sat, 02 May 2026 04:28:12 +0000
Message-ID: 
 <177769609235.222166.12366414442072990803.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
In-Reply-To: 
 <177769588777.222166.3414280094142944420.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
References: 
 <177769588777.222166.3414280094142944420.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
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
index b3142c84dcbc2..65a4ffc82d566 100644
--- a/drivers/hv/mshv_irq.c
+++ b/drivers/hv/mshv_irq.c
@@ -51,7 +51,7 @@ int mshv_update_routing_table(struct mshv_partition *partition,
 		/*
 		 * Allow only one to one mapping between GSI and MSI routing.
 		 */
-		if (girq->guest_irq_num != 0) {
+		if (girq->girq_entry_valid) {
 			r = -EINVAL;
 			goto out;
 		}



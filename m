Received: from mail-pl1-f227.google.com (mail-pl1-f227.google.com [209.85.214.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60FAC3F5BD9
	for <linux-hyperv@vger.kernel.org>; Tue,  9 Jun 2026 11:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781005743; cv=none; b=tU0+mrNLj7nUDEM28DbjGipEVerSLM1+/LZBt8QlmyNhA9ilgC0A8tQAVCQb1LTmDjWc4AknrZdGX3m0rU+biQb9xdw9JUiZtjNsLetOWoAnMGSxUMjwXQ9S44dWdSge4bjW54QVcxfY+HSzhE/vgka36LiFroSg3nknCAlpp+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781005743; c=relaxed/simple;
	bh=idiuQJNN0GZ7hWFIbxqI9skHLKDG4DRE2a8a21vQ7TQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DW/CYdL6TO2BdFuh2QmomZQHBbru9OZoGch8OwgNK0+2KlRVuS2y+mKz6uRSxSxIuyRkdfQVSP0+fjUHolpQHF34a8LP9I7ABPYncuEc6yXRuvFmkFKsT+OoyrB0FeevZ9o+yM2t+rxphkMu8I7HhQx0IH84QNX9lvwc05r62Mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=e06sNo4R; arc=none smtp.client-ip=209.85.214.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="e06sNo4R"
Received: by mail-pl1-f227.google.com with SMTP id d9443c01a7336-2bf30d530bdso54515355ad.3
        for <linux-hyperv@vger.kernel.org>; Tue, 09 Jun 2026 04:49:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781005742; x=1781610542;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Cij0f7XK3gPTc98cKs5ll/gp5Fj5YlFQkChYuGOVaaM=;
        b=NOD/ZYGbLDeRiZ/SeLDI+JPg6viEdyLmtMhr5DgBnzZyixFU6qiumFsBXUpm4urtYA
         cewPx5JOGxbZj/+l0POE5R8ywT+iQHVEC8OdVd39KVBTZscwMaS83V2b6H+lIS3MT4fP
         kE4qy1joq5hcbhotEHuYwcy5rJaNrAm5f77eumvTsQbNy02/kgAXcIYpapq+8F1IvJ8/
         WVp2n8+O0SS9TR8CkY1chnYMdEICPJTbHX1Ptdw4gEMhN3UQPYlH81w6XFn/qFhRlQt8
         ydNQ+yxZHzAk+b0ZYpL0+MVibf74qQWsBTBkEKWjh/BxlzTo5G6kDaOiRu78Y/P2b6nJ
         JwXg==
X-Forwarded-Encrypted: i=1; AFNElJ8YSdALRVnx8YLA1GOvSdGOZLBwa8Kn2KbGb3KkMWyOiPiUSY55IDzd5vx699qtCREk8no6ARQvdFbG8rs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXzrJcZf/JSjUq8z1MBNc89h7pyPId49jdSm/CnvYJzrangIIX
	QXRooX2biV8sNPnUqio4yVChX63D4bT9EoSatghoFlyuCYltuFPrqqvNNRqgDf2z28293pbKscm
	wbZKSeqhYDJYbWbha1MCEg+p1p1SDC83atMc7+4nW7gbpJpeMtFnjk3X5nBPs2y9iG1Z5I/7b1H
	PASUihXStlOSEFeqUa+ptTnDVpUwdopLxy0+3ehepjRlzp9QaFvMh7ynl7iglmhvFllaCEebyjP
	JznGgRY2eyYoletVUQ=
X-Gm-Gg: Acq92OHWb4eY47DyMpzfTSjU7z5RMRpx1rXDVj0J8e1PDySs8jteqI6BvFmSTe7Lh6V
	+5euwaXfvy/eW/SD19SB+/qBtk7+V0+drkLWpiOmoAVWlZ09fQ6O6mlXCc+8xMPuPGqa4jMntET
	HdY9gNvUtEYr8yJnvwMBmVHqXgVBCUOVmeIkhEFqMq4qtH4Hiw3u9KInG57At22nUmKFqAhGJ7h
	BRzVAWXg+vkNhMHf6hQRn1Y0O07z8PJoLFuzzoVevHZD3fKUnNvIQDUfsv0AE+VQsPlOPIFBUTj
	SeUdhZzNmm2Wv2ydH8H8zRITx36UfsdDYJwqskXUnLFY1Nf1XgIoIUG1cCXhBP9pwbyDe4JqNUx
	28akXR7hwJRc2qRz1vEdIw8i8AL+LueHBuS6Qm7TQmqAwnbLsA8pk3Lr03IYQEKh5ldBnqax/9t
	1pvKmw6/0w/apljfX2QyJYy20Oi4M2KjWD76ShEJIND5B8ZGSRf3R9q8uDce2r0EXQ1tU=
X-Received: by 2002:a17:902:ef09:b0:2c2:5446:30e1 with SMTP id d9443c01a7336-2c254463556mr114362085ad.11.1781005741721;
        Tue, 09 Jun 2026 04:49:01 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-21.dlp.protect.broadcom.com. [144.49.247.21])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2c164fa6822sm19059295ad.24.2026.06.09.04.49.01
        for <linux-hyperv@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Jun 2026 04:49:01 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-36b808bedfaso6243244a91.1
        for <linux-hyperv@vger.kernel.org>; Tue, 09 Jun 2026 04:49:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1781005739; x=1781610539; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cij0f7XK3gPTc98cKs5ll/gp5Fj5YlFQkChYuGOVaaM=;
        b=e06sNo4RL1szcwmfAvf5K/+fgiSMK5oGTIgcSEuBFYCZBheyKe0CdkKPCY4FomdVUG
         Jd4TpOrsJ/9JXk3XmUUSEnkV8QqVrZuqYn38cuA/sOzRjdmkWkPM2RpixlMxsgIpE7xE
         YrRyRE3xPOI9wxlYhzE9VL9GwRPp6z8Nin2Tk=
X-Forwarded-Encrypted: i=1; AFNElJ/ffTC4V7LU6NY7QzP0T9vSWJ3ORA5aysRNkM8Gxue2eQchgv/UAGQmLIR9NZC7z28YiAXeX9kugbsksEg=@vger.kernel.org
X-Received: by 2002:a17:90b:5787:b0:36b:8824:d7cc with SMTP id 98e67ed59e1d1-370f057a115mr22377795a91.20.1781005739382;
        Tue, 09 Jun 2026 04:48:59 -0700 (PDT)
X-Received: by 2002:a17:90b:5787:b0:36b:8824:d7cc with SMTP id 98e67ed59e1d1-370f057a115mr22377714a91.20.1781005738858;
        Tue, 09 Jun 2026 04:48:58 -0700 (PDT)
Received: from sumit_ws.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36f6bf903fasm18898075a91.2.2026.06.09.04.48.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 04:48:57 -0700 (PDT)
From: Sumit Saxena <sumit.saxena@broadcom.com>
To: "Martin K . Petersen" <martin.petersen@oracle.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: "James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>,
	linux-scsi@vger.kernel.org,
	linux-block@vger.kernel.org,
	Adam Radford <aradford@gmail.com>,
	Khalid Aziz <khalid@gonehiking.org>,
	Adaptec OEM Raid Solutions <aacraid@microsemi.com>,
	Matthew Wilcox <willy@infradead.org>,
	Hannes Reinecke <hare@suse.com>,
	"Juergen E . Fischer" <fischer@norbit.de>,
	Russell King <linux@armlinux.org.uk>,
	linux-arm-kernel@lists.infradead.org,
	Finn Thain <fthain@linux-m68k.org>,
	Michael Schmitz <schmitzmic@gmail.com>,
	Anil Gurumurthy <anil.gurumurthy@qlogic.com>,
	Sudarsana Kalluru <sudarsana.kalluru@qlogic.com>,
	Oliver Neukum <oliver@neukum.org>,
	Ali Akcaagac <aliakc@web.de>,
	Jamie Lenehan <lenehan@twibble.org>,
	Ram Vegesna <ram.vegesna@broadcom.com>,
	target-devel@vger.kernel.org,
	Bradley Grove <linuxdrivers@attotech.com>,
	Satish Kharat <satishkh@cisco.com>,
	Sesidhar Baddela <sebaddel@cisco.com>,
	Karan Tilak Kumar <kartilak@cisco.com>,
	Yihang Li <liyihang9@h-partners.com>,
	Don Brace <don.brace@microchip.com>,
	storagedev@microchip.com,
	HighPoint Linux Team <linux@highpoint-tech.com>,
	Tyrel Datwyler <tyreld@linux.ibm.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	linuxppc-dev@lists.ozlabs.org,
	Brian King <brking@us.ibm.com>,
	Lee Duncan <lduncan@suse.com>,
	Chris Leech <cleech@redhat.com>,
	Mike Christie <michael.christie@oracle.com>,
	open-iscsi@googlegroups.com,
	Justin Tee <justin.tee@broadcom.com>,
	Paul Ely <paul.ely@broadcom.com>,
	Kashyap Desai <kashyap.desai@broadcom.com>,
	Shivasharan S <shivasharan.srikanteshwara@broadcom.com>,
	Chandrakanth Patil <chandrakanth.patil@broadcom.com>,
	megaraidlinux.pdl@broadcom.com,
	Sathya Prakash Veerichetty <sathya.prakash@broadcom.com>,
	Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
	mpi3mr-linuxdrv.pdl@broadcom.com,
	Suganath Prabu Subramani <suganath-prabu.subramani@broadcom.com>,
	Ranjan Kumar <ranjan.kumar@broadcom.com>,
	MPT-FusionLinux.pdl@broadcom.com,
	Daniel Palmer <daniel@thingy.jp>,
	GOTO Masanori <gotom@debian.or.jp>,
	YOKOTA Hiroshi <yokota@netlab.is.tsukuba.ac.jp>,
	Jack Wang <jinpu.wang@cloud.ionos.com>,
	Geoff Levand <geoff@infradead.org>,
	Michael Reed <mdr@sgi.com>,
	Nilesh Javali <njavali@marvell.com>,
	GR-QLogic-Storage-Upstream@marvell.com,
	Narsimhulu Musini <nmusini@cisco.com>,
	"K . Y . Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>,
	linux-hyperv@vger.kernel.org,
	"Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Eugenio Perez <eperezma@redhat.com>,
	virtualization@lists.linux.dev,
	Vishal Bhakta <vishal.bhakta@broadcom.com>,
	bcm-kernel-feedback-list@broadcom.com,
	Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	xen-devel@lists.xenproject.org,
	James Rizzo <james.rizzo@broadcom.com>,
	Sumit Saxena <sumit.saxena@broadcom.com>
Subject: [PATCH v3 1/4] scsi: scan: allocate sdev and starget on the NUMA node of the host adapter
Date: Tue,  9 Jun 2026 17:48:00 +0530
Message-ID: <20260609121806.2121755-2-sumit.saxena@broadcom.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260609121806.2121755-1-sumit.saxena@broadcom.com>
References: <20260609121806.2121755-1-sumit.saxena@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

From: James Rizzo <james.rizzo@broadcom.com>

When a host adapter is attached to a specific NUMA node, allocating
scsi_device and scsi_target via kzalloc() may place them on a remote
node.  All hot-path I/O accesses to these structures then cross the NUMA
interconnect, adding latency and consuming inter-node bandwidth.

Use kzalloc_node() with dev_to_node(shost->dma_dev) so allocations land
on the same node as the HBA, reducing cross-node traffic and improving
I/O performance on NUMA systems.

Signed-off-by: James Rizzo <james.rizzo@broadcom.com>
Signed-off-by: Sumit Saxena <sumit.saxena@broadcom.com>
---
 drivers/scsi/scsi_scan.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/scsi_scan.c b/drivers/scsi/scsi_scan.c
index e27da038603a..121a14d5fdb8 100644
--- a/drivers/scsi/scsi_scan.c
+++ b/drivers/scsi/scsi_scan.c
@@ -34,6 +34,7 @@
 #include <linux/kthread.h>
 #include <linux/spinlock.h>
 #include <linux/async.h>
+#include <linux/topology.h>
 #include <linux/slab.h>
 #include <linux/unaligned.h>
 
@@ -287,8 +288,8 @@ static struct scsi_device *scsi_alloc_sdev(struct scsi_target *starget,
 	struct Scsi_Host *shost = dev_to_shost(starget->dev.parent);
 	struct queue_limits lim;
 
-	sdev = kzalloc(sizeof(*sdev) + shost->transportt->device_size,
-		       GFP_KERNEL);
+	sdev = kzalloc_node(sizeof(*sdev) + shost->transportt->device_size,
+		       GFP_KERNEL, dev_to_node(shost->dma_dev));
 	if (!sdev)
 		goto out;
 
@@ -502,7 +503,7 @@ static struct scsi_target *scsi_alloc_target(struct device *parent,
 	struct scsi_target *found_target;
 	int error, ref_got;
 
-	starget = kzalloc(size, GFP_KERNEL);
+	starget = kzalloc_node(size, GFP_KERNEL, dev_to_node(shost->dma_dev));
 	if (!starget) {
 		printk(KERN_ERR "%s: allocation failure\n", __func__);
 		return NULL;
-- 
2.43.7


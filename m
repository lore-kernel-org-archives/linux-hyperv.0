Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F3FD1A08AF;
	Tue,  8 Sep 2026 02:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788833635; cv=none; b=NJonDuCLvcdQ2bEX/Mv3LXnrb0mwnUDOS8bCH1lWx1g1RTwwspglPudFvGebIFECsEPqch7FQPA0xob+nplKnWCFB3cMhzdRZZM3noc+zf/Dp01ypdALfjC0d90w7vkiLKVYHu2OaSQPXTaFPRcO0Rat4pcB3epHJ1ZYQ7vL9WE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788833635; c=relaxed/simple;
	bh=pooB1+kLvn0K08/XqVSn+hNjMog0yUOnYLSPfq4zh3Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aZgHZ7xIm8NP8qkU+FkU3JrwIt93IBBxrIkdZYr/S1V8Xkfjl/54xD49oXrtZs4q2V8ANkHue4xAXQ6bpxobH+jj0buwbWtZRUqcdpycR8tWGOvrhhcUUsBMW7BVPQuYu2VLJCHZEjVbdKq4qufHRZaAmCDVttndKkoc49GXCjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=cPjECBcO; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="cPjECBcO"
Received: from mrdev.corp.microsoft.com (192-184-212-33.fiber.dynamic.sonic.net [192.184.212.33])
	by linux.microsoft.com (Postfix) with ESMTPSA id 1DE7420B7001;
	Mon,  7 Sep 2026 19:13:14 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1DE7420B7001
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1788833594;
	bh=QvGDILRucFI6OopMwF9J+dAQuwi89FLjcsw1gK0ADQQ=;
	h=From:To:Cc:Subject:Date:From;
	b=cPjECBcOrgB+SU+VvkCwDBGGKnOfVcraPLy+xjfv6UQuR7xtP5fh4iSV5/dRufsgn
	 MaOdIEClcNFZpubW+s9AN+uNQ8yE1GZfJdfHj4RTcRwBaCcF/hEXU7LDoeVHEgCPBW
	 7VNciD6hm+YuNfStBlPKSkrlNUVl9/aTvUsMoEfE=
From: Mukesh R <mrathor@linux.microsoft.com>
To: linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: kys@microsoft.com,
	wei.liu@kernel.org,
	mhkelley58@gmail.com,
	mrathor@linux.microsoft.com
Subject: [PATCH V1 0/3] Redesign memory deposit logic
Date: Mon,  7 Sep 2026 19:13:37 -0700
Message-ID: <20260908021340.2548924-1-mrathor@linux.microsoft.com>
X-Mailer: git-send-email 2.51.2.vfs.0.1
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This small series redesigns the memory deposit logic when Linux runs on
Hyper-V hypervisor as a privileged VM, the second patch explains why.
The series is split in three patches, the first patch renames the
functions to _old and this makes the 2 main patch much easier and nicer
to review. Last patch just removes the *_old functions from first patch.

Thanks,
-Mukesh

V1:
 o Remove hv_alloc_contig_pages() and make contiguous allocation part of
   hv_alloc_dep_pages(), thus getting rid of the kmalloc.
 o Instead of stubbing out functions, rename them to *_old.

Mukesh R (3):
  mshv: Rename memory deposit memory functions to old
  mshv: Redesign hypervisor memory deposit logic
  mshv: Remove unused *_old memory deposit functions

 drivers/hv/hv_proc.c           | 250 +++++++++++++++++++--------------
 drivers/hv/mshv_root_hv_call.c |  10 +-
 include/asm-generic/mshyperv.h |   5 -
 3 files changed, 145 insertions(+), 120 deletions(-)

-- 
2.51.2.vfs.0.1


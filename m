Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB6E2157A5A;
	Sat, 12 Sep 2026 00:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789171418; cv=none; b=ZO7lhet0sVDDww9zg3eJ/LXKi/lsQkoQA5GEwQMOmzjPafzLDEY9uI0nQZjGWtF2bXQ8mmSPmTazu2uzvT9M4tWVscu6w05XC19dkr4gVbYr8v6MNpl/MfHti1aUpP58+3gkyWqdK40Zl0rzmX0OZiGU+sLvzKvKZPjo+jGGGlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789171418; c=relaxed/simple;
	bh=ljImxSARlImIWCfI26fpSA0puw18fokbpQ6ryY2BX7Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GWW1zwaof1tpSuySJFn4uUYyFF/C0DiKEY0gWj6p2L3M5qPWzAhAG0eC8WhYLCRzRJ4FEsAi6i3TyE4Ihi4Rq9bICV1lM7WI7p5LkscVnqj590Ul7/IVOfMRBAn+i+iiV17Jxv6gEQwb6NGXpb2wysc9diaDHI8C3Lgk8OU+34A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=WBUfFldT; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="WBUfFldT"
Received: from mrdev.corp.microsoft.com (192-184-212-33.fiber.dynamic.sonic.net [192.184.212.33])
	by linux.microsoft.com (Postfix) with ESMTPSA id 5CB2D20B7166;
	Fri, 11 Sep 2026 17:02:52 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5CB2D20B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1789171372;
	bh=KbbeNAbKnLi4K2xTGirN8aJRfGt2gYTtz1BdXQq9+do=;
	h=From:To:Cc:Subject:Date:From;
	b=WBUfFldT3YPJiOuFqmtuTIwCow4y7v2LtxqlV/ozShJHj0wPjjojMNhfwSmITx77l
	 kHMh7pLeoORNKH+4vDTmynWWyrp0G/ZVXpsL2sPUoAqS9JdMMRVWFbjyVggowKnEaL
	 ureQNwKd/4L+W6Xgs3rF+DV1CF6J6e+PCNDtlrFA=
From: Mukesh R <mrathor@linux.microsoft.com>
To: linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: kys@microsoft.com,
	wei.liu@kernel.org,
	mhkelley58@gmail.com,
	mrathor@linux.microsoft.com
Subject: [PATCH V2 0/3] MSHV: Redesign memory deposit logic
Date: Fri, 11 Sep 2026 17:03:15 -0700
Message-ID: <20260912000318.2959621-1-mrathor@linux.microsoft.com>
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
functions to _old and that makes the 2 main patch much easier and nicer
to review. Last patch just removes the *_old functions from first patch.

Thanks,
-Mukesh

V2:
 o Enhance comments
 o In case of contiguous and failure, don't goto err_free_dep_pages but
   just return also. It should not happen, but if it does, hypevisor will
   throw error.

V1:
 o Remove hv_alloc_contig_pages() and make contiguous allocation part of
   hv_alloc_dep_pages(), thus getting rid of the kmalloc.
 o Instead of stubbing out functions, rename them to *_old.

Mukesh R (3):
  mshv: Rename memory deposit memory functions to _old
  mshv: Redesign hypervisor memory deposit logic
  mshv: Remove unused *_old memory deposit functions

 drivers/hv/hv_proc.c           | 246 +++++++++++++++++++--------------
 drivers/hv/mshv_root_hv_call.c |  10 +-
 include/asm-generic/mshyperv.h |   5 -
 3 files changed, 141 insertions(+), 120 deletions(-)

-- 
2.51.2.vfs.0.1


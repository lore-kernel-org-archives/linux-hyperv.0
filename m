Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91EF821C16A;
	Thu, 28 May 2026 00:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779928962; cv=none; b=bi+RCWBzc/b8r6Eps9NYN5UrgrMiqRA1ra9Whc2mH3MaEInYgUF43rY78aMp/0cklpk34FzttJkSE8mA7DyDXtuEFrrflhAsF3IFhJSntf+BvC8PM0aN+aGMT3xLsXymTevachVlUOpTSSy305S+k52keL02grW8VJL2fgCyTfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779928962; c=relaxed/simple;
	bh=6Antn2h2FO/sUWKHjowtOEK63kZei/zzdOk8ZY5rq/k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Sf1O6mbRkwfoEQtwNFsBlOYPiwqgnorNbF72dHrwcGZx5akrTYU5DOhgSumq/HNjoXp3aJKM43pKeCHK3Gfy0nIBANhVt6KPAeKqBFz/lJ2avXV06E0jflnoVBqsVzmXWk4EjqxS8kt626tASENR7hnqcenI8LMXvW9NBkYTSKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=W9kAPBs8; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="W9kAPBs8"
Received: by linux.microsoft.com (Postfix, from userid 1241)
	id F1B1220B716D; Wed, 27 May 2026 17:42:27 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com F1B1220B716D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1779928947;
	bh=8XqGfPBcF9bFjDUhWCxrpIIXmVyxEM9VuCw6U3fAvno=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=W9kAPBs8LwEWBV0ebKB/ahPWQuFzeLJ6xNmCYxKujyhsamuhvAAWjEe9z72dZsEtP
	 kUds189D7aKJHbd3LE6QYUtwgD6foSF58eDpH1+s1/eKnLq5WuYzt8Hoz7lXKZV2Ts
	 rilWfX9z+RcPy4AxdmmGO1/QNhU4PO6QOAMxD7Qo=
From: Jork Loeser <jloeser@linux.microsoft.com>
To: linux-hyperv@vger.kernel.org,
	linux-mm@kvack.org,
	kexec@lists.infradead.org
Cc: "K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>,
	Mike Rapoport <rppt@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Alexander Graf <graf@amazon.com>,
	Jason Miu <jasonmiu@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	Baoquan He <bhe@redhat.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Kees Cook <kees@kernel.org>,
	Ran Xiaokai <ran.xiaokai@zte.com.cn>,
	Justinien Bouron <jbouron@amazon.com>,
	Sourabh Jain <sourabhjain@linux.ibm.com>,
	Pingfan Liu <piliu@redhat.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	linux-arm-kernel@lists.infradead.org,
	x86@kernel.org,
	linux-kernel@vger.kernel.org,
	Michael Kelley <mhklinux@outlook.com>,
	Jork Loeser <jloeser@linux.microsoft.com>
Subject: [RFC PATCH 19/20] kexec: export kexec_in_progress for modules
Date: Wed, 27 May 2026 17:42:01 -0700
Message-ID: <20260528004204.1484584-20-jloeser@linux.microsoft.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260528004204.1484584-1-jloeser@linux.microsoft.com>
References: <20260528004204.1484584-1-jloeser@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Modules that register reboot notifiers may need to distinguish a
kexec from a regular reboot.  Export kexec_in_progress so they can
check without requiring a built-in wrapper.

Signed-off-by: Jork Loeser <jloeser@linux.microsoft.com>
---
 kernel/kexec_core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index a43d2da0fe3e..68efbba52fbd 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -53,6 +53,7 @@ atomic_t __kexec_lock = ATOMIC_INIT(0);
 
 /* Flag to indicate we are going to kexec a new kernel */
 bool kexec_in_progress = false;
+EXPORT_SYMBOL_GPL(kexec_in_progress);
 
 bool kexec_file_dbg_print;
 
-- 
2.43.0


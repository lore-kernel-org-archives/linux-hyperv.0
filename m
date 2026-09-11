Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7BE2486425;
	Fri, 11 Sep 2026 21:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789162401; cv=none; b=A8YitdoY6NWohbDMEoqsI+b3RR2adKkll6tlbdlxetWTMf7o/Lv3R2qXCha6AHL4geeaKEnYJOjxjpw5Y1jRU+Hyz7BVgNNpu2OKHBkZy/MIRSlbR6ZLsAZ1v71ov//DthNeNc/6WglKsk+SHqL5YtjuR0NnhcmDEqOoBmqtO+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789162401; c=relaxed/simple;
	bh=LLh915AQdAp4J10TCNRimZZoYeqU7drKfQ5rboSF9y0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qFmioBj9tbXXrLVu9ehyZZmC5IvDM2us0gcpmAsAkz3MZZTlvDT2FxzdFekKmqMJzx9cDXeQm4PwM9Bkpg9qm71MYERFQWXYptzlQj3vVuEeWh64Ix/z0Sz3qGAZvRsqza/lH2KK7bMC3XUT6HtS3RRQAPmgaiK+30uiub1HbT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=is0jUT2T; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="is0jUT2T"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789162399; x=1820698399;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LLh915AQdAp4J10TCNRimZZoYeqU7drKfQ5rboSF9y0=;
  b=is0jUT2TmWOokkEX4FGMe/1MuibjTCuZkhbqW3FNMbCRGA/J56R6Fdhn
   wxbSnjwQwiJaqkqHPBKY+JYvNgYTCdVbmKTI2+TvwHra/9/Gdqx7GivBF
   BhKJdSc/6H5iAgtEOauqlr58zdmYrHuwwGvkaQN/4ijjQmzvUFfQp7k66
   YIzFC1owJ6Ai3zTkrx4oGvYhl0dmreNosxgC6/xyamcHQ/+YmrtZ5oUOk
   VVg8UhQhXJGFH/vOY18L/fiElHERNj/Im0Di/79nV4HWnMhUXqRRLQXo4
   /CTHlOsSmNw0yELsmIrkyznGaSVfHiTq49/doFJOMqT6DK79h5GLLLmw5
   Q==;
X-CSE-ConnectionGUID: 3EsP74/4ROe9tWo+JTZcLQ==
X-CSE-MsgGUID: GlA1+uO7SamTjXboBcXzCA==
X-IronPort-AV: E=McAfee;i="6800,10657,11902"; a="89506468"
X-IronPort-AV: E=Sophos;i="6.27,98,1787036400"; 
   d="scan'208";a="89506468"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2026 14:33:18 -0700
X-CSE-ConnectionGUID: oMrzMjhKSuekEVWUIbJibA==
X-CSE-MsgGUID: Dzin76L+QiuFAL6LDY6KzA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,98,1787036400"; 
   d="scan'208";a="265833602"
Received: from smtp.ostc.intel.com ([10.54.69.131])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2026 14:33:17 -0700
Received: from cwf-2s5.sh.intel.com (cwf-2s5.sh.intel.com [10.239.48.132])
	by smtp.ostc.intel.com (Postfix) with ESMTP id 738646393;
	Fri, 11 Sep 2026 14:33:11 -0700 (PDT)
From: Shreshth Srivastava <shreshth.srivastava@intel.com>
To: jgross@suse.com,
	linux-kernel@vger.kernel.org,
	x86@kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	kvm@vger.kernel.org,
	linux-coco@lists.linux.dev
Cc: acme@kernel.org,
	adrian.hunter@intel.com,
	alexander.shishkin@linux.intel.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	decui@microsoft.com,
	haiyangz@microsoft.com,
	hpa@zytor.com,
	irogers@google.com,
	james.clark@linaro.org,
	jolsa@kernel.org,
	kas@kernel.org,
	kys@microsoft.com,
	longli@microsoft.com,
	mark.rutland@arm.com,
	mhklinux@outlook.com,
	mingo@redhat.com,
	namhyung@kernel.org,
	pbonzini@redhat.com,
	peterz@infradead.org,
	rick.p.edgecombe@intel.com,
	seanjc@google.com,
	tglx@kernel.org,
	wei.liu@kernel.org,
	shreshth.srivastava@intel.com
Subject: Re: [PATCH v3 13/13] x86/msr: Simplify some rdmsrq() use cases
Date: Fri, 11 Sep 2026 17:33:10 -0400
Message-ID: <20260911213310.381839-1-shreshth.srivastava@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260821105709.1671132-1-jgross@suse.com>
References: <20260821105709.1671132-1-jgross@suse.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Juergen,

I'm working on a v3 of Dave's "x86/msr: Consolidate native/paravirt MSR
functions" series on top of yours, so I tried testing this patch.

While I'm here: you mentioned you'd send a V3 after rc1 if conflicts
turned up. Is that still the plan? I wasn't sure whether to base on v2
plus the respins of 4 and 13, or wait.

Most of the code this touches can't run on my box, so I compared compiled
output instead. Built patches 1-12, then 1-13, with the same .config and
compiler, and diffed "objdump -d" output for every .o in both trees. All
9396 objects came out identical. The 1-13 kernel boots fine under KVM.

Only tried the one config: x86_64, gcc 11.5.0,
CPU_SUP_{INTEL,AMD,ZHAOXIN}=y, HYPERV=y, KVM_INTEL=y, KVM_INTEL_TDX=y.

Tested-by: Shreshth Srivastava <shreshth.srivastava@intel.com>

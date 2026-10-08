Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB82B44C65C;
	Thu,  8 Oct 2026 21:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791494317; cv=none; b=gYl0a2YqqHwUXkehXzQAbf74bfpmwim9uveWSJc7SKcNcn84KvLDJDt8VOjjcn3dzKAKMnv+mR91l7BoFCCbnLAPVKrMyDZh24R9q7gIeEx86zMPPjPreg41wVQvFUx340DrbHcQSxQiuumdHNRNa/pVtfyp5lJ1sdJJFvVfvUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791494317; c=relaxed/simple;
	bh=O0xRsH1+GO6yWhQ5iXZ2vAKeNw+97F5kBSTCSn41Z/k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QtICxEIiETJq+w+B2Z3oP1FDXQcKM+RblJrt1QOcJG8OdaEsh+76Wh+qx66x5p5L9jNU6PFvhC39xX7Qewjl1TuVROsq9ESYf8dfywASwnEvlcRFf3RjQdCUlL9NDLe2VaQFqfm9G2mOCTmkUyQJbgU+KPf3/SFmzba/dEse6xY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FBVpopMu; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FBVpopMu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791494312; x=1823030312;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=O0xRsH1+GO6yWhQ5iXZ2vAKeNw+97F5kBSTCSn41Z/k=;
  b=FBVpopMugj6wK50YlmOjPaEHaXWPgfFsqTrBx8fGkqxdOsAIRL7p/e6F
   7IrzqItzDLESgH9jfNs2x/vTURLNLYFeT/+CY4uzMRovEtCvwWvzcvkBC
   slvlLgyOxWMPS4qL+c6IzH9sM66nBfUOj4SvBPwajRiUNtbrEQmzEjPg8
   WTdWqlNWhotPSZT6IwUSXf3ffQ59HGyGlnlxuYaDI6YRf+q9XIlXlMw88
   xiwKMZ00nlH2tjyFlamK8CrC1bJud4tz0z3ZSIRSGzXYV9wJzLoCumOus
   l9TDTRlNUxqnRu+3UT45ph/5z/yb9gJrfRKFuVTF+YoUqgw1feQg22qKG
   Q==;
X-CSE-ConnectionGUID: tG5cIJLqQYKyuOpJs4VdoA==
X-CSE-MsgGUID: hywWNRGWS6y2lGDXFIz0pg==
X-IronPort-AV: E=McAfee;i="6800,10657,11929"; a="400590"
X-IronPort-AV: E=Sophos;i="6.27,147,1787036400"; 
   d="scan'208";a="400590"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2026 14:18:32 -0700
X-CSE-ConnectionGUID: 4Of94Tx2QvWMINYkF7txHw==
X-CSE-MsgGUID: rN9904TAR1SK1l6dJmhGMQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,147,1787036400"; 
   d="scan'208";a="144384"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 08 Oct 2026 14:18:27 -0700
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xEvVQ-000000004tk-1vnJ;
	Thu, 08 Oct 2026 21:18:24 +0000
Date: Fri, 9 Oct 2026 05:17:40 +0800
From: kernel test robot <lkp@intel.com>
To: Emerson Busson <emersonbusson@gmail.com>, mhklinux@outlook.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, kys@microsoft.com,
	haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH v2 02/14] hv: vmbus: validate chunk buffer allocation and
 cleanup
Message-ID: <202610090551.ezkWePE5-lkp@intel.com>
References: <20261007190752.336426-3-emersonbusson@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261007190752.336426-3-emersonbusson@gmail.com>

Hi Emerson,

kernel test robot noticed the following build errors:

[auto build test ERROR on char-misc/char-misc-testing]
[also build test ERROR on char-misc/char-misc-next char-misc/char-misc-linus linus/master v7.3-rc6 next-20261008]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Emerson-Busson/hv-vmbus-convert-ring-backing-through-the-chunk-allocator/20261007-160739
base:   char-misc/char-misc-testing
patch link:    https://lore.kernel.org/r/20261007190752.336426-3-emersonbusson%40gmail.com
patch subject: [PATCH v2 02/14] hv: vmbus: validate chunk buffer allocation and cleanup
config: i386-randconfig-1005-20261008 (https://download.01.org/0day-ci/archive/20261009/202610090551.ezkWePE5-lkp@intel.com/config)
compiler: clang version 22.1.3 (https://github.com/llvm/llvm-project e9846648fd6183ee6d8cbdb4502213fcf902a211)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261009/202610090551.ezkWePE5-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202610090551.ezkWePE5-lkp@intel.com/

All errors (new ones prefixed by >>):

>> ld.lld: error: undefined symbol: kunit_unary_assert_format
   >>> referenced by vmbus_buffer_test.c:48 (drivers/hv/vmbus_buffer_test.c:48)
   >>>               drivers/hv/vmbus_buffer_test.o:(vmbus_ring_fallback_order_zero_test) in archive vmlinux.a
   >>> referenced by vmbus_buffer_test.c:49 (drivers/hv/vmbus_buffer_test.c:49)
   >>>               drivers/hv/vmbus_buffer_test.o:(vmbus_ring_fallback_order_zero_test) in archive vmlinux.a
   >>> referenced by vmbus_buffer_test.c:61 (drivers/hv/vmbus_buffer_test.c:61)
   >>>               drivers/hv/vmbus_buffer_test.o:(vmbus_buffer_failed_teardown_leaks_test) in archive vmlinux.a
   >>> referenced 3 more times

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

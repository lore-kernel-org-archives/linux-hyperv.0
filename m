Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F189D3ADBAC;
	Thu,  8 Oct 2026 16:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791478202; cv=none; b=JbxahD0c2Q6k0F2hqi2Oi2vtfktVQFllasgaeD8zFUyBEPOoxP8cgyB7iqJjRRDetdzTWQ0eFd/nj5PH2FgBP6Y3HT2Eo71LpDcz3KXg5e5xOrZmhex1DZBpf2e8GPJnlt0dWoMr6vDQ2piPfUPAa7jMjhfXmwt1fqJhG0UFs4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791478202; c=relaxed/simple;
	bh=wEpyQLioBMW4Ub+2PydT+0oLGLWVpaDngxSSXhXf2Oc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WCxn66B0wgk6nnvZ9cChHuUBKccpb9b4D29Z7o2AZToxMO9WyDAqgzvNRmhN0TKnBKqtH2IVW+ikXW1kKWhu7ZRppYihL5kfeSxqqFEJALXU4QGBQ5weva+fziEZUNaOtD5mtYBz+aMEJH5lXpdfbfICYipLQ87+0wp2mw3MAVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JROKLuid; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JROKLuid"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791478199; x=1823014199;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wEpyQLioBMW4Ub+2PydT+0oLGLWVpaDngxSSXhXf2Oc=;
  b=JROKLuidzgMny1H58WWMd6WB307kGWVM+my20yXrnKReLgz5athyAp/S
   dWfhFE6uQPAgbrptVL/1+/QFn0gz4nZyi6SsXtZsONWVPB8dm3fALMEzD
   Y4uTSJsHNEThySyDmU8TDm3ZlEDR1XqNLtFrkEMwt0xDgFJO0V1UXH0eu
   b6FvRpk1D7ZCG8pmykGSMH8yG2iazgFmbdTYBZQrDiBNNrObOSgFTN26f
   5Yv1ACO00hZtqgin7OzWBJRnbXycyAXun6fr3QWPjkZCtnQpj4AwEcLxb
   +fZqOlFkufKBH9SEvf8oXq7sBb6CUMx5M3ZiJkuES/MZfI92kzh5UJbhe
   Q==;
X-CSE-ConnectionGUID: 4zunkUHjQUClrVJgvlvTKg==
X-CSE-MsgGUID: mbYk6qzlROSWadx0qswPsg==
X-IronPort-AV: E=McAfee;i="6800,10657,11928"; a="267531"
X-IronPort-AV: E=Sophos;i="6.27,146,1787036400"; 
   d="scan'208";a="267531"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2026 09:49:58 -0700
X-CSE-ConnectionGUID: yh4TIP33S8yrX2oYUrn73w==
X-CSE-MsgGUID: 3VsiRZ6DRRSEr/VEVIds9g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,146,1787036400"; 
   d="scan'208";a="426295"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 08 Oct 2026 09:49:55 -0700
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xErJX-000000004fS-0kVy;
	Thu, 08 Oct 2026 16:49:51 +0000
Date: Fri, 9 Oct 2026 00:49:37 +0800
From: kernel test robot <lkp@intel.com>
To: Emerson Busson <emersonbusson@gmail.com>, mhklinux@outlook.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, kys@microsoft.com,
	haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH v2 10/14] hv: vmbus: pin buffer pages across UIO mmap to
 close the reclaim race
Message-ID: <202610090058.hvXsWpoT-lkp@intel.com>
References: <20261007190752.336426-11-emersonbusson@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261007190752.336426-11-emersonbusson@gmail.com>

Hi Emerson,

kernel test robot noticed the following build warnings:

[auto build test WARNING on char-misc/char-misc-testing]
[also build test WARNING on char-misc/char-misc-next char-misc/char-misc-linus linus/master v7.3-rc6 next-20261008]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Emerson-Busson/hv-vmbus-convert-ring-backing-through-the-chunk-allocator/20261007-160739
base:   char-misc/char-misc-testing
patch link:    https://lore.kernel.org/r/20261007190752.336426-11-emersonbusson%40gmail.com
patch subject: [PATCH v2 10/14] hv: vmbus: pin buffer pages across UIO mmap to close the reclaim race
config: i386-randconfig-1001-20261008 (https://download.01.org/0day-ci/archive/20261009/202610090058.hvXsWpoT-lkp@intel.com/config)
compiler: clang version 22.1.3 (https://github.com/llvm/llvm-project e9846648fd6183ee6d8cbdb4502213fcf902a211)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261009/202610090058.hvXsWpoT-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202610090058.hvXsWpoT-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/uio/uio_hv_generic.c:428:
>> drivers/uio/uio_hv_generic_mmap_test.c:36:34: warning: implicit conversion from 'u64' (aka 'unsigned long long') to 'unsigned long' changes value from 18446744073709551615 to 4294967295 [-Wconstant-conversion]
      36 |                            hv_uio_mmap_range_valid(8, U64_MAX, 1));
         |                            ~~~~~~~~~~~~~~~~~~~~~~~    ^~~~~~~
   include/linux/limits.h:25:19: note: expanded from macro 'U64_MAX'
      25 | #define U64_MAX         ((u64)~0ULL)
         |                          ^~~~~~~~~~
   include/kunit/test.h:1014:31: note: expanded from macro 'KUNIT_EXPECT_FALSE'
    1014 |         KUNIT_EXPECT_FALSE_MSG(test, condition, NULL)
         |                                      ^~~~~~~~~
   include/kunit/test.h:1019:7: note: expanded from macro 'KUNIT_EXPECT_FALSE_MSG'
    1019 |                                   condition,                                   \
         |                                   ^~~~~~~~~
   include/kunit/test.h:812:10: note: expanded from macro 'KUNIT_FALSE_MSG_ASSERTION'
     812 |                               condition,                                       \
         |                               ^~~~~~~~~
   include/kunit/test.h:788:16: note: expanded from macro 'KUNIT_UNARY_ASSERTION'
     788 |         if (likely(!!(condition_) == !!expected_true_))                        \
         |                       ^~~~~~~~~~
   include/linux/compiler.h:76:40: note: expanded from macro 'likely'
      76 | # define likely(x)      __builtin_expect(!!(x), 1)
         |                                             ^
   1 warning generated.


vim +36 drivers/uio/uio_hv_generic_mmap_test.c

    27	
    28	static void hv_uio_ring_mmap_range_test(struct kunit *test)
    29	{
    30		KUNIT_EXPECT_TRUE(test, hv_uio_mmap_range_valid(8, 0, 8));
    31		KUNIT_EXPECT_TRUE(test, hv_uio_mmap_range_valid(8, 4, 4));
    32		KUNIT_EXPECT_FALSE(test, hv_uio_mmap_range_valid(8, 8, 1));
    33		KUNIT_EXPECT_FALSE(test, hv_uio_mmap_range_valid(8, 7, 2));
    34		KUNIT_EXPECT_FALSE(test, hv_uio_mmap_range_valid(8, 0, 0));
    35		KUNIT_EXPECT_FALSE(test,
  > 36				   hv_uio_mmap_range_valid(8, U64_MAX, 1));
    37	}
    38	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

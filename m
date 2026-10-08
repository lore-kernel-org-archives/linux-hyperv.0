Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F0E63ACF17;
	Thu,  8 Oct 2026 17:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791478987; cv=none; b=Q5ZRED+oWGSVcsQxj8sPRMDt34RKLlShwhbPTnGEO4hp/SGv4DTIICABqLI2ai/Oyd1IjtJIcJ7bg38XQCyAfI+/UjynlfdI7bqvizOOuvrm0hL9WawmMtPyY+a0Yx43+4WD+EEvtWLbKIDV1wTBD4tfoZuFgVSSs1aNgHXMMsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791478987; c=relaxed/simple;
	bh=J9cx9pMDMvILCUgaH6jkkc0B9b6i+Cq9CtRvXhNbwTE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SPuFIvn1qH0xdyCgO6sECzTrq3xssE04WV02rwMdQZuGue0jeSp192cOQ9iaWQ7djRcEM4Bc/aTb712kh/TV5ksOQa34Oobprdh8qotw5Ez51FI9WGhePhsca81ODHjoRDiceD3K+uJGGybQoHYpxAvrJftU6BU2OGNdkyGU6iI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jKYgBGYE; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jKYgBGYE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791478985; x=1823014985;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=J9cx9pMDMvILCUgaH6jkkc0B9b6i+Cq9CtRvXhNbwTE=;
  b=jKYgBGYEX5W0krxYn1PpYG9DgAZ7uvzYma4eHs8KdY+L6D+4qr6+JGD2
   xrk/tdz7muBRG1224qt1chBTAmt6BO4gkVGQBhsQ9vXZaaBm2IucK2zKh
   IifsMDxbFIT9u0i3g4Hxz/nFJ/rfx417qE81VkbnjkDG5pgq9paDNcmyc
   drx8vAOPO5ArQlETvkWdLIM9O+ItHPmKgSlQ09tjwsMRshvsuvoQoL1qf
   3kwQllZgKdCurTJ/9fWpzW2aeJ8PZ8Pt/eP1v6nIh7xoIchOHqsfuobrm
   ezDyW+Vw98bM2hj4ci6FKbFMpB1BMUbrbqvNUICmMRJRkIqSfSdnSFIDt
   A==;
X-CSE-ConnectionGUID: lFGVUVyYSPW3R8SFIDfysg==
X-CSE-MsgGUID: s/z4s2k9RjeeJjXddtMYmg==
X-IronPort-AV: E=McAfee;i="6800,10657,11928"; a="268902"
X-IronPort-AV: E=Sophos;i="6.27,146,1787036400"; 
   d="scan'208";a="268902"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2026 10:03:04 -0700
X-CSE-ConnectionGUID: jTsoPRl6S6+tTa4GE81akw==
X-CSE-MsgGUID: Dc6OB/68R4e8kzQ2gWr6cA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,146,1787036400"; 
   d="scan'208";a="428776"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 08 Oct 2026 10:03:00 -0700
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xErWC-000000004hw-3Viu;
	Thu, 08 Oct 2026 17:02:56 +0000
Date: Fri, 9 Oct 2026 01:02:31 +0800
From: kernel test robot <lkp@intel.com>
To: Emerson Busson <emersonbusson@gmail.com>, mhklinux@outlook.com
Cc: oe-kbuild-all@lists.linux.dev, kys@microsoft.com,
	haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH v2 10/14] hv: vmbus: pin buffer pages across UIO mmap to
 close the reclaim race
Message-ID: <202610090020.wViiihcQ-lkp@intel.com>
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
config: i386-randconfig-1013-20261008 (https://download.01.org/0day-ci/archive/20261009/202610090020.wViiihcQ-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261009/202610090020.wViiihcQ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202610090020.wViiihcQ-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from include/linux/dev_printk.h:14,
                    from include/linux/device.h:15,
                    from drivers/uio/uio_hv_generic.c:22:
   drivers/uio/uio_hv_generic_mmap_test.c: In function 'hv_uio_ring_mmap_range_test':
>> include/linux/limits.h:25:25: warning: conversion from 'long long unsigned int' to 'long unsigned int' changes value from '18446744073709551615' to '4294967295' [-Woverflow]
      25 | #define U64_MAX         ((u64)~0ULL)
         |                         ^~~~~~~~~~~~
   include/linux/compiler.h:76:45: note: in definition of macro 'likely'
      76 | # define likely(x)      __builtin_expect(!!(x), 1)
         |                                             ^
   include/kunit/test.h:810:9: note: in expansion of macro 'KUNIT_UNARY_ASSERTION'
     810 |         KUNIT_UNARY_ASSERTION(test,                                            \
         |         ^~~~~~~~~~~~~~~~~~~~~
   include/kunit/test.h:1017:9: note: in expansion of macro 'KUNIT_FALSE_MSG_ASSERTION'
    1017 |         KUNIT_FALSE_MSG_ASSERTION(test,                                        \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~
   include/kunit/test.h:1014:9: note: in expansion of macro 'KUNIT_EXPECT_FALSE_MSG'
    1014 |         KUNIT_EXPECT_FALSE_MSG(test, condition, NULL)
         |         ^~~~~~~~~~~~~~~~~~~~~~
   drivers/uio/uio_hv_generic_mmap_test.c:35:9: note: in expansion of macro 'KUNIT_EXPECT_FALSE'
      35 |         KUNIT_EXPECT_FALSE(test,
         |         ^~~~~~~~~~~~~~~~~~
   drivers/uio/uio_hv_generic_mmap_test.c:36:55: note: in expansion of macro 'U64_MAX'
      36 |                            hv_uio_mmap_range_valid(8, U64_MAX, 1));
         |                                                       ^~~~~~~


vim +25 include/linux/limits.h

3c9d017cc283df Andy Shevchenko 2023-08-04  14  
54d50897d544c8 Masahiro Yamada 2019-03-07  15  #define U8_MAX		((u8)~0U)
54d50897d544c8 Masahiro Yamada 2019-03-07  16  #define S8_MAX		((s8)(U8_MAX >> 1))
54d50897d544c8 Masahiro Yamada 2019-03-07  17  #define S8_MIN		((s8)(-S8_MAX - 1))
54d50897d544c8 Masahiro Yamada 2019-03-07  18  #define U16_MAX		((u16)~0U)
54d50897d544c8 Masahiro Yamada 2019-03-07  19  #define S16_MAX		((s16)(U16_MAX >> 1))
54d50897d544c8 Masahiro Yamada 2019-03-07  20  #define S16_MIN		((s16)(-S16_MAX - 1))
54d50897d544c8 Masahiro Yamada 2019-03-07  21  #define U32_MAX		((u32)~0U)
3f50f132d8400e John Fastabend  2020-03-30  22  #define U32_MIN		((u32)0)
54d50897d544c8 Masahiro Yamada 2019-03-07  23  #define S32_MAX		((s32)(U32_MAX >> 1))
54d50897d544c8 Masahiro Yamada 2019-03-07  24  #define S32_MIN		((s32)(-S32_MAX - 1))
54d50897d544c8 Masahiro Yamada 2019-03-07 @25  #define U64_MAX		((u64)~0ULL)
54d50897d544c8 Masahiro Yamada 2019-03-07  26  #define S64_MAX		((s64)(U64_MAX >> 1))
54d50897d544c8 Masahiro Yamada 2019-03-07  27  #define S64_MIN		((s64)(-S64_MAX - 1))
54d50897d544c8 Masahiro Yamada 2019-03-07  28  

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

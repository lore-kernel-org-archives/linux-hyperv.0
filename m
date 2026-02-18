Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BD5A314D2D;
	Wed, 18 Feb 2026 12:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771418157; cv=none; b=Y/R9radv9QN7p7yLuunNijcxxpMycMYKDQeWEX811JwFO8/P+CKmVb2OD9wzhzSD71/whMHCTVsOinX1h+IGf4+kkIT1fAGHG3O819VupLfYWYpWE7OpICC4Gl9qSZj2vlfjrbhK+SzO91qFrSVsLTMj+TnGEBEcuoUooZtVG1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771418157; c=relaxed/simple;
	bh=o0SwT6PYBpYEzsFfqbHKWMYYtkEGcaEQ+KeM+TT+0OY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K8l4GWwGdy+Q8Ck/1OoOjRIJ5SIuppGTWG469Vxuv07tHzTu5QTvOSXKGOXoVqiqLTkOJP51y/0whgf/8pCEGHXjVov56uWfL2UhQDIGiftOXcCqrx4PChmB+Vd+mLafPjMjyBTZSfFCbOfv33XtOhIiNeJawrv7yMferi84SHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Zk/deMNN; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Zk/deMNN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771418155; x=1802954155;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=o0SwT6PYBpYEzsFfqbHKWMYYtkEGcaEQ+KeM+TT+0OY=;
  b=Zk/deMNNjxfPrfhWoJfkO+q/qnd3ywWwb4bMZu7wQmOYYdRN348iDoVv
   I4XbljsuSBQHCmJRggrMAcoQRgaM/8BJMoTNfj2ElDn54ItIEjityMUkQ
   e6iHZcYyLuQFdVTdxThIJ0bYMDSH5kHZatHUJxazW05xJhobmhrj/eLbY
   VTjdOFhDEOAX4Xgyapdgme0SY3iOvgvai2UXOWRU/BCc4wz/ml2JjMmfE
   SdT8oxUMV1nAkGuITK1P3pAJGFDYJPWlTD4fL4EGpky+Xo9dFoltbEGl6
   svmSO+aUZqe+e+xiLMoomJ9y1A/+VKWmcW6E3qXpc0x6IfHW0kHqEEjFf
   w==;
X-CSE-ConnectionGUID: aHhLjZ5lSsWDlC9vyzipdg==
X-CSE-MsgGUID: MDRxuwcBTj2F81iSodk0KQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11704"; a="71512364"
X-IronPort-AV: E=Sophos;i="6.21,298,1763452800"; 
   d="scan'208";a="71512364"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2026 04:35:54 -0800
X-CSE-ConnectionGUID: vmHA2hqBRh+qBrhoJ0n5Tg==
X-CSE-MsgGUID: sUEnwvBkSaSlIaNd1mGyOg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,298,1763452800"; 
   d="scan'208";a="213424457"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 18 Feb 2026 04:35:51 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vsgmS-000000012L2-308U;
	Wed, 18 Feb 2026 12:35:48 +0000
Date: Wed, 18 Feb 2026 20:35:08 +0800
From: kernel test robot <lkp@intel.com>
To: Mukesh R <mrathor@linux.microsoft.com>, linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, kys@microsoft.com,
	haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
	longli@microsoft.com, tglx@linutronix.de, mingo@redhat.com,
	bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
	hpa@zytor.com
Subject: Re: [PATCH v2] x86/hyperv: Reserve 3 interrupt vectors used
 exclusively by mshv
Message-ID: <202602182000.O5dSFVVd-lkp@intel.com>
References: <20260217231158.1184736-1-mrathor@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260217231158.1184736-1-mrathor@linux.microsoft.com>

Hi Mukesh,

kernel test robot noticed the following build warnings:

[auto build test WARNING on tip/x86/core]
[also build test WARNING on linus/master v6.19 next-20260217]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Mukesh-R/x86-hyperv-Reserve-3-interrupt-vectors-used-exclusively-by-mshv/20260218-071406
base:   tip/x86/core
patch link:    https://lore.kernel.org/r/20260217231158.1184736-1-mrathor%40linux.microsoft.com
patch subject: [PATCH v2] x86/hyperv: Reserve 3 interrupt vectors used exclusively by mshv
config: x86_64-rhel-9.4 (https://download.01.org/0day-ci/archive/20260218/202602182000.O5dSFVVd-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260218/202602182000.O5dSFVVd-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202602182000.O5dSFVVd-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> arch/x86/kernel/cpu/mshyperv.c:485:13: warning: 'hv_reserve_irq_vectors' defined but not used [-Wunused-function]
     485 | static void hv_reserve_irq_vectors(void)
         |             ^~~~~~~~~~~~~~~~~~~~~~


vim +/hv_reserve_irq_vectors +485 arch/x86/kernel/cpu/mshyperv.c

   480	
   481	/*
   482	 * Reserve vectors hard coded in the hypervisor. If used outside, the hypervisor
   483	 * will either crash or hang or attempt to break into debugger.
   484	 */
 > 485	static void hv_reserve_irq_vectors(void)
   486	{
   487		#define HYPERV_DBG_FASTFAIL_VECTOR	0x29
   488		#define HYPERV_DBG_ASSERT_VECTOR	0x2C
   489		#define HYPERV_DBG_SERVICE_VECTOR	0x2D
   490	
   491		if (cpu_feature_enabled(X86_FEATURE_FRED))
   492			return;
   493	
   494		if (test_and_set_bit(HYPERV_DBG_ASSERT_VECTOR, system_vectors) ||
   495		    test_and_set_bit(HYPERV_DBG_SERVICE_VECTOR, system_vectors) ||
   496		    test_and_set_bit(HYPERV_DBG_FASTFAIL_VECTOR, system_vectors))
   497			BUG();
   498	
   499		pr_info("Hyper-V:reserve vectors: %d %d %d\n", HYPERV_DBG_ASSERT_VECTOR,
   500			HYPERV_DBG_SERVICE_VECTOR, HYPERV_DBG_FASTFAIL_VECTOR);
   501	}
   502	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

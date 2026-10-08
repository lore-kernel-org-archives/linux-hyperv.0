Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58AB842050;
	Thu,  8 Oct 2026 17:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791481904; cv=none; b=k+stXpkj2w18cGFGJiv2dP+/GMNoP3IlZ+ywqgmq3ssd3cJuIjxtksoHOFfkFZUWoXMLJBg5mRAzc6Rgl+7nEQG64uytX8vvr1ZhXGnFR1lUneTOMhfeLY9mJtBXbeKzJBLIGN7fXwMroyOW0baCI8wEjpmwvY/ud4pHIeoqgUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791481904; c=relaxed/simple;
	bh=rBFWQbhkH900ZEQUv0RU4iR949i2ZbAFgh+zqLo3xVE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XFpXL0lhPL7XaoGO41QPXZx1lSQlSlFQumxxvj35QymRex7bPee1UnRyMRYSiAk5bYOG1BhR9BYnj9oi+d+XmAgyloyvcRagJ1JAfSGC2Brq6nDsAt65ShnBybhBkdKXX2oTRHsZT8zV1uVvmvCxuxMbTLmJz7Ae4TU4PV7iMCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cr6aMcxY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cr6aMcxY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43D001F000FF;
	Thu,  8 Oct 2026 17:51:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791481902;
	bh=QHmYeC2UpPFyvVtZ5YJtR7pkqTeCTUBI7PeV4rONroM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Cr6aMcxYQHQByuaI/HcZkCnFmVrN4zG8lckY1rUcNZxPl7T6BpjdKyJYcB/EkrCZ2
	 1jQc6J/U1JrO0aL974lLwihVJibYvKVtPv+5lbuwkXx7v6EqEfLk27x4Il/3YuoRlV
	 dZQw06RGn0EkQpSD/Tei5nqLKlmbUFMAtFVE6eU0i66O3N9x4s5KfrIdOf+AUw1yjr
	 SfpHf/cQFUFj7Aiu7S71xKJxV5OTjfkmbdQ0Mdc574G8Ik0FZP1KKXWt9MpYE4TTM/
	 /PI2o5D91GunuWSRYOXLMwVJJP4W0HRcRhd92Tc7jAGt02NhEDdmhzs/P4I8gEpRYg
	 6RGLQ+qN5+BqQ==
Date: Thu, 8 Oct 2026 19:51:36 +0200
From: Nathan Chancellor <nathan@kernel.org>
To: kernel test robot <lkp@intel.com>
Cc: Emerson Busson <emersonbusson@gmail.com>, mhklinux@outlook.com,
	llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
	linux-hyperv@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH v2 10/14] hv: vmbus: pin buffer pages across UIO mmap to
 close the reclaim race
Message-ID: <20261008175136.GA3580170@ax162>
References: <20261007190752.336426-11-emersonbusson@gmail.com>
 <202610090058.hvXsWpoT-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202610090058.hvXsWpoT-lkp@intel.com>

On Fri, Oct 09, 2026 at 12:49:37AM +0800, kernel test robot wrote:
> Hi Emerson,
> 
> kernel test robot noticed the following build warnings:
> 
> [auto build test WARNING on char-misc/char-misc-testing]
> [also build test WARNING on char-misc/char-misc-next char-misc/char-misc-linus linus/master v7.3-rc6 next-20261008]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Emerson-Busson/hv-vmbus-convert-ring-backing-through-the-chunk-allocator/20261007-160739
> base:   char-misc/char-misc-testing
> patch link:    https://lore.kernel.org/r/20261007190752.336426-11-emersonbusson%40gmail.com
> patch subject: [PATCH v2 10/14] hv: vmbus: pin buffer pages across UIO mmap to close the reclaim race
> config: i386-randconfig-1001-20261008 (https://download.01.org/0day-ci/archive/20261009/202610090058.hvXsWpoT-lkp@intel.com/config)
> compiler: clang version 22.1.3 (https://github.com/llvm/llvm-project e9846648fd6183ee6d8cbdb4502213fcf902a211)
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261009/202610090058.hvXsWpoT-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202610090058.hvXsWpoT-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>):
> 
>    In file included from drivers/uio/uio_hv_generic.c:428:
> >> drivers/uio/uio_hv_generic_mmap_test.c:36:34: warning: implicit conversion from 'u64' (aka 'unsigned long long') to 'unsigned long' changes value from 18446744073709551615 to 4294967295 [-Wconstant-conversion]
>       36 |                            hv_uio_mmap_range_valid(8, U64_MAX, 1));
>          |                            ~~~~~~~~~~~~~~~~~~~~~~~    ^~~~~~~

GCC also warns in the same way. Should probably be ULONG_MAX since
'pgoff_t' is 'unsigned long'?

-- 
Cheers,
Nathan

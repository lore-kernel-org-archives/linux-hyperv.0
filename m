Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52F8741D21E;
	Mon, 24 Aug 2026 12:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787576103; cv=none; b=XPxFFdF8BY0gFbiMRca3tdyf9F1P/K2MKxSdyjZroEPFJZyIo+bOr/H9eoyZ/qtZ08WVGfHdbZQryKYLBdoaU5IRqQFRHdlDbkdK7rrztAtFzY2s4zmCwHKuZDgYj+f5/n6k7rZrKtnPQ8Ond56Zos9IXBzBA3QWiREyZbt6LVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787576103; c=relaxed/simple;
	bh=mUq2gHuUf8XxU1AIfiG1unNySbidltaYykylgtPlCUs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YWumF624OSdJ2E6mcaBkcXTc4JLyEWn4u/hRK6ZVo/qebsvT/HoUn+Lfy1gQgYR1AR7sESP4OqgoXqJ3C/jqlDwSqLVdaWndRUyQBrxAnxMWVICSikX84qKXY0BMTN3T9KKRS7UTImLY/Z4wIXUeKvh/MdbjFVTXNLOeVE0KA+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=M2/ZxkPJ; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="M2/ZxkPJ"
Received: by linux.microsoft.com (Postfix, from userid 1216)
	id D54EE20B7166; Mon, 24 Aug 2026 05:54:30 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D54EE20B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1787576070;
	bh=l76qoPNZkHuyJa8sJH1HkxI3uFpghRbUgx7w7U5CkPM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=M2/ZxkPJ5WEBrOYUHHyazedStqMkOxgwYTsSRW/ijtMDqlVIQvoyI6gOrMG6Arr5u
	 +poYi/bcNh3wdnxDsixoTWbwHQLsGrP/vhidwop3iJVV5Ym7dA+aCAg5B2r48guzDE
	 +n5wIQs1kGFOezkouBpqpyUn6Pm/r3ZL/9qLNFh8=
Date: Mon, 24 Aug 2026 08:54:30 -0400
From: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
To: mhklinux@outlook.com
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, longli@microsoft.com,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/6] drm_hyperv: Remove support for synth video
 protocol of old Hyper-V hosts
Message-ID: <aow/BjVxSeX0o52l@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20260805203751.2678-1-mhklinux@outlook.com>
 <20260805203751.2678-5-mhklinux@outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260805203751.2678-5-mhklinux@outlook.com>

On Wed, Aug 05, 2026 at 01:37:49PM -0700, Michael Kelley wrote:
> With the overall removal of Linux support for running on Hyper-V
> hosts earlier than WS2016 and Windows 10, it's no longer necessary
> to support older synthetic video protocols. Remove the support.
> 
> Signed-off-by: Michael Kelley <mhklinux@outlook.com>

Applied, thanks!

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBBDE40A936;
	Sun, 13 Sep 2026 22:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789338922; cv=none; b=QYXKdxt6W8SL/bTQUsqfJkdA+iS8raX+sKj9wd6Mcg66GdT3EoLc9n2q4RjPxk6PQWQzPigWKc1J/vQHCQFqy2y9M9EBbX5tGCeaDY+QF72oDrsJyzqap2RQlgV6tCpcZ/0U3426iwQv9HaXtsT0cj/qHXah3YbrgNoWvprr4eQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789338922; c=relaxed/simple;
	bh=LOp//g0bc+vTk2Dmip4yNKD5H+grs7CkiRjsLcw9eGA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nP/I0EKBhM1VyKMQY0YibCDZeIREScZjmDt8hGBlNL6pMC8EMlnIhNNpbpsdL7QaeA6zHgTMbt7H2vhpxoYJoBK+DtmDdYOcRiYK2H4BsJEdLiJDFZ37b5tgaCYNulfNiFQxQ6OvM6VXEQDWj8qZleOr8JGrBQiCWvPC8bfR6YI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CFtneyHV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CFtneyHV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 421C51F00893;
	Sun, 13 Sep 2026 22:35:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789338920;
	bh=KYUhZjDEg9ultMYW7GBGOQ3tpye6JGPr8fYLY6CdUbQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=CFtneyHVTMyWjDhnI6cehreYdU0vVQaWFS3s/ehfv7F+Qhjqz603m9P4wBeaZ1VjH
	 SYML5rfU0DfufgPd4meecYmXe+SXjN2sqj8ooTiw+c0FKvv4JtS9nwRCPbPEXUO1Da
	 0ZON36YfiNx0IG3SFBZgTU9caio4UDuu3OOq++KYuEJ1/NXhlxa6siValXg9wTHTqm
	 aDgVQq/Tc8aZtwSP72LU5C80SvBqgGDNZLGNXeHWyO0qr8m/goGghhbQV8qF4Km1uP
	 dpxGChy92FHHUPq8MSJxNqej2Sqnq3dHpQfLiKE7Jz6OyNDWK0HPB3LlUtQHEY4N49
	 p/uHu3XmCq/hQ==
Date: Sun, 13 Sep 2026 15:35:19 -0700
From: Wei Liu <wei.liu@kernel.org>
To: Jiangshan Yi <yijiangshan@kylinos.cn>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, longli@microsoft.com, tglx@kernel.org,
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
	x86@kernel.org, hpa@zytor.com, linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org, 13667453960@163.com
Subject: Re: [PATCH] x86/hyperv: Fix stale comments after stimer message mode
 removal
Message-ID: <20260913223519.GC2219269@liuwe-devbox-debian-v2.local>
References: <20260901033201.167219-1-yijiangshan@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260901033201.167219-1-yijiangshan@kylinos.cn>

On Tue, Sep 01, 2026 at 11:32:01AM +0800, Jiangshan Yi wrote:
> The removal of stimer message mode in commit be0cfab740e5 ("clocksource:
> hyper-v: Remove support for stimer interrupts in message mode") left a
> few comments out of date. hv_stimer_setup_percpu_clockev() picked up two
> typos ("afters", "to allows"), and the hv_synic_suspend() comment still
> references the deleted hv_stimer_legacy_cleanup(), the legacy non-Direct
> Mode configuration, and clockevents_unbind_device(), which is no longer
> on the cleanup path.
> 
> Update the typos and rewrite the hv_synic_suspend() comment to describe
> the current Direct Mode path: non-boot CPU stimers are cleaned up via
> the cpuhp teardown callback hv_stimer_cleanup(), and CPU0's stimer is
> left alone because it is harmless (interrupts stay disabled across the
> suspend/resume window) and is shut down later by the timekeeping code.
> 
> Signed-off-by: Jiangshan Yi <yijiangshan@kylinos.cn>

Applied. Thanks.

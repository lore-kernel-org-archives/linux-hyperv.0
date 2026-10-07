Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D176C342CB2;
	Wed,  7 Oct 2026 02:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791338405; cv=none; b=rmMArQe4U5sd8DN1lRlmtFkK6zCq27p7i2uuq/3qpaabr4ANlX/qN7YP6u1K5Whza4VGTMI/IsGF7u6ITZEfiHLAdC4Qf4aNycCPt6hJphYoXgwoCia7yoArwdxVkOhBpUQ0RXLGaNM5dXtaOh3E9MWJ0VGf6xwLkCICLXtxJdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791338405; c=relaxed/simple;
	bh=hQI7+l7+kL7N+CQxlVcq6Y142VSu3G1JYjYFOlDsO5E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a6wGj06BS8ewrPm027e12qHEaMOv0YVTQxZLF4ooX5ek82uCBnctCeq1s9LH6sdqSKmdnVjUWNonNjen0G8Vcq2DZFvng6GofoUUPKYF8ivKxagsKwvG3a/emUADT1kBo3LS0cXiAf1mmSzTREvQH1r7Ecsht53ifyDL4nvzXGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b6i7Cook; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b6i7Cook"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 097CF1F0089D;
	Wed,  7 Oct 2026 02:00:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791338404;
	bh=hQI7+l7+kL7N+CQxlVcq6Y142VSu3G1JYjYFOlDsO5E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=b6i7CookuI0pkWl1hNHh1CQahcix3c+gh14MWePwlAeSM3L5LDP63Y2gJXalIjxjc
	 3qnIx6vKxBCcEf5ViLfMq1/rnGWupUJMrGemSOx5jy6ygQ+s3QI04Ygm3/BJt+D3PO
	 tR1M6Nu56txeW7caJaUN/xCw3o5l1b5FU/qkNLQz22I7G/C8/AZ2z0jxFarCcMHymi
	 L+pVa2V8iXN/HSGiwfOM/Yf/Kh0xPpThXMT9t3BCiho/yncdVWdSDYX2IqnHBeibUT
	 JXG3pihMNJGYsLSuR344Ww4y1Qv6oWESOdVrXV9nm2kJKEOAB62w+x3nxGJ97K71yD
	 FOR0RO9V+b/0g==
Date: Tue, 6 Oct 2026 19:00:01 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Kameron Carr <kameroncarr@linux.microsoft.com>
Cc: Haiyang Zhang <haiyangz@microsoft.com>, "davem@davemloft.net"
 <davem@davemloft.net>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "edumazet@google.com" <edumazet@google.com>, "pabeni@redhat.com"
 <pabeni@redhat.com>, "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
 "horms@kernel.org" <horms@kernel.org>, "wei.liu@kernel.org"
 <wei.liu@kernel.org>, Dexuan Cui <DECUI@microsoft.com>,
 "longli@microsoft.com" <longli@microsoft.com>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 "hawk@kernel.org" <hawk@kernel.org>, "andriin@fb.com" <andriin@fb.com>,
 Saurabh Singh Sengar <ssengar@microsoft.com>
Subject: Re: [EXTERNAL] [PATCH net-next 0/5] hv_netvsc: make XDP propagation
 act more like bonding
Message-ID: <20261006190001.7fb79347@kernel.org>
In-Reply-To: <5636487a-31c7-43fb-8b27-a6a98b15200f@linux.microsoft.com>
References: <20261001014131.310771-1-kuba@kernel.org>
	<LV5PR21MB4704E9960B2B82028F2FB51DCA892@LV5PR21MB4704.namprd21.prod.outlook.com>
	<5636487a-31c7-43fb-8b27-a6a98b15200f@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 6 Oct 2026 13:59:05 -0700 Kameron Carr wrote:
> If you are worried about the performance impacts of this patchset, I can
> do a comparison of performance with and without the patches.

Thanks for testing! No concern about perf, changes should be purely
ctrl path.

> Looking at the Sashiko comments, many of them look valid. It is at least
> worth taking another look before merging. I am not providing a review
> sign off, only the results of my regression testing.

Ack, looked like follow up material when I glanced. I need to double
check them, but haven't had time to do any real work last few days :(

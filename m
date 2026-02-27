Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9B682853F3;
	Fri, 27 Feb 2026 19:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772219193; cv=none; b=i042b2pP7bQC5yTHDyflDqg/UwZFUyiWeh1veoCE4XFCRkKk2Hlh98/2153fUUIdy56hFcHalZJAunytWlE2iZh8SCuq4BQntWSOOTt5Bh1E2plb1F0Y3/06LBlJ/SGqhwlW84/HVRf3+zcLQzryE6nuFTUPp8lKCcEwzUxmvV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772219193; c=relaxed/simple;
	bh=uJV34xJ/ItAlRvFSNVWHwdcZv4U4xqZCnTOiHj5BnL0=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UvhAA9bdXU3farSoSQIyhn4fXXQ4QImzpRjjB88Vjn6giSv8VDGJbcczBuNkAU0x4j9qonSvLicZmA+uoSP9kkN0dAIAKk2/3SNR5tyVZ0d8mL0r0MzsxUxIUbibc3xzJr8fR5CIm5VVaz8Hwe499ywTuDqcMKVV9hNgk6Yc9Gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=L1xwxdcq; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="L1xwxdcq"
Received: by linux.microsoft.com (Postfix, from userid 1173)
	id 8DD8520B6F02; Fri, 27 Feb 2026 11:06:31 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8DD8520B6F02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1772219191;
	bh=2A4+HE+cA4atSCRSkIarD8j6TjcnoyFIsKuWVjakw1c=;
	h=Date:From:To:Subject:References:In-Reply-To:From;
	b=L1xwxdcqtQxjTPGPRw7SFGYPC57sRd36ePvCjekSXGoUmzM2fGlG3EUvA7wbA8DQb
	 TdVD8OkW2OHFyHGxvUqxrT26eArvGKy2FzL7M9oba4vOPzfrbmbFyPtUcD+OrMCqDm
	 do9/cwKCk4iEWS1lIZbkLZ5/FL9WQ/Thybaa2m3M=
Date: Fri, 27 Feb 2026 11:06:31 -0800
From: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
To: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, longli@microsoft.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, dipayanroy@linux.microsoft.com,
	shirazsaleem@microsoft.com, ssengar@linux.microsoft.com,
	shradhagupta@linux.microsoft.com, gargaditya@linux.microsoft.com,
	linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v4] net: mana: Add MAC address to vPort logs and
 clarify error messages
Message-ID: <aaHrN+spIIaswoX6@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20260225192252.943534-1-ernis@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260225192252.943534-1-ernis@linux.microsoft.com>

On Wed, Feb 25, 2026 at 11:22:41AM -0800, Erni Sri Satya Vennela wrote:
> Add MAC address to vPort configuration success message and update error
> message to be more specific about HWC message errors in
> mana_send_request.
> 
> Signed-off-by: Erni Sri Satya Vennela <ernis@linux.microsoft.com>

Gentle ping — I sent this patch on 25/02/2026 and would appreciate any
feedback when you have time.  
Happy to rebase or add more details if needed, thanks for your review.

Regards,
Vennela

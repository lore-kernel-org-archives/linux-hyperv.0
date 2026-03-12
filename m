Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5051135958;
	Thu, 12 Mar 2026 04:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773289960; cv=none; b=r5Itsr2iqCuwejWl29Lxt2TrQi195bNqqdcRngwpuDGsQ2gtMItoGZKcaD0yuMP8C6uImFwcwsab2NjKmtIJFxNZSNNdRfPwr/A3jzk3iLD0I/g9yv/tGKaId3GVzDjZ90LdS9xV1rAXxWPm0ui2KmbsTVzQnnjuqp8HfSyksZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773289960; c=relaxed/simple;
	bh=hpw2+vDL5BOPpArwqmcQrmc1rkiHLIkUX08nB7J0wtM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M75EklcMLUoVJUlk731av64kxi0HF36u1uTIOneWNk2QfIrNxKLveu7jRwvrMhMOz0K2a7uFQlemCXavSnI4cJdlBm66sp8zvaMB6ADv1M54YSTKh2kJy8o0EhyKFj2gs7Sn5ChKnxfoX0rJw6Adla2Kb2uxDOpBcm/ZmQ87Ths=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HAe/SUB7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HAe/SUB7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9C0CC4CEF7;
	Thu, 12 Mar 2026 04:32:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773289959;
	bh=hpw2+vDL5BOPpArwqmcQrmc1rkiHLIkUX08nB7J0wtM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HAe/SUB7mi7aX14GcGG3oeGTS7xVncl6S9jBT9E2mWJhTVEho9LETOrLDRq79iz4N
	 3mKAJiTGjs7Sq7oyKW73pgW3yVSDemCkpLfKDUKovzzo0aH+XuK1SS5UIRyqnl7ViO
	 JuBoXsEGIHCLQgVU3Oh/+ts3YChHmpkCWWC53PdqCdA4f0C4J8x9vnTsK2Ar17Ci8r
	 6zbMTmDDg1R2tChqsEa8UzIH0l/ypp1jxvWJH8X75K/PehqnVRPO0oatIJHc+Dfn6B
	 ScXTMKMRs5/3qZMqkHfUcaA2IH43pVopEvz3r7ZvuOnVHotqR7S9a8NMF0vGJtifGC
	 vW0UdmwDtRilQ==
Date: Thu, 12 Mar 2026 04:32:38 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Michael Kelley <mhklinux@outlook.com>
Cc: Mukesh R <mrathor@linux.microsoft.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>
Subject: Re: [PATCH V0] mshv: pass struct mshv_user_mem_region by reference
Message-ID: <20260312043238.GI3612627@liuwe-devbox-debian-v2.local>
References: <20260304000251.2625375-1-mrathor@linux.microsoft.com>
 <SN6PR02MB4157FBAE767E7563898DA0BDD47CA@SN6PR02MB4157.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN6PR02MB4157FBAE767E7563898DA0BDD47CA@SN6PR02MB4157.namprd02.prod.outlook.com>

On Wed, Mar 04, 2026 at 06:45:12PM +0000, Michael Kelley wrote:
> From: Mukesh R <mrathor@linux.microsoft.com> Sent: Tuesday, March 3, 2026 4:03 PM
> > 
> > For unstated reasons, function mshv_partition_ioctl_set_memory passes
> > struct mshv_user_mem_region by value instead of by reference. Change
> > it to pass by reference.
> > 
> > Signed-off-by: Mukesh R <mrathor@linux.microsoft.com>
> 
> Reviewed-by: Michael Kelley <mhklinux@outlook.com>
> 

Applied to hyperv-fixes.

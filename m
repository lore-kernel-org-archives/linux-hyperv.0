Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9E895D8F0;
	Wed,  5 Nov 2025 19:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762369386; cv=none; b=ixMe4gAX3JdavBU/ovn695VzkYCf8yfOttm+sUwCTxwMB795Smrc8xH7hSnf/zN+aocIMW1OQlL2xKLk+G4ms/X00Z7KQkIrrV9GZLbjdyJUkl8qbss2er1k60cVJ/QqORMpu9uZgk6KvEqYoyaUoXc4ORrCCMv5nvjFTpDUqz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762369386; c=relaxed/simple;
	bh=GDAevW6w/y+3rqc0Ck1EDJiUVmQOGyeWqjKim6BaXQ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=spv3mPsrYA8jSES+a0VvXepapu1co7oknZiLu7L6N6nm/vAj45nlUsFjr7CXWU4tS8x0NI9tTH+Wp3dcYu2jGdwnXV+FeD7Qk/5r8q5XdLUaJEfkc6f/hPkfskeu96Hy2IYgthOfgZcHFFYV9PzAtPUwcNQ3oqn49GnDeR4od7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=rcUF9Jqx; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="rcUF9Jqx"
Received: by linux.microsoft.com (Postfix, from userid 1173)
	id 65C3820120AA; Wed,  5 Nov 2025 11:03:04 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 65C3820120AA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1762369384;
	bh=YbKE89r8BFgFqnTov8DjL11BVscXMrXLQpMT89FgTrw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rcUF9Jqxft8mXl0OqK+b+Bzb1TfUqlgMRgXfUsS5uZ3XafnuqE3VJNrerKFyO5hM1
	 b9ngONkIhESsolb7EwxnimROCJeaA6zlK4rWFYMvIr31l8b6bp92o1QFxHXqAMg0e0
	 JntEvcvewDmPo0eeHRz7V3NphN4lp/KXlXV1Q4eE=
Date: Wed, 5 Nov 2025 11:03:04 -0800
From: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, pabeni@redhat.com,
	shradhagupta@linux.microsoft.com, ssengar@linux.microsoft.com,
	dipayanroy@linux.microsoft.com, shirazsaleem@microsoft.com,
	kotaranov@microsoft.com, longli@microsoft.com,
	linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2] net: mana: Fix incorrect speed reported by
 debugfs
Message-ID: <20251105190304.GA31854@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1761735154-3593-1-git-send-email-ernis@linux.microsoft.com>
 <20251029185228.0c2da909@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251029185228.0c2da909@kernel.org>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Wed, Oct 29, 2025 at 06:52:28PM -0700, Jakub Kicinski wrote:
> On Wed, 29 Oct 2025 03:52:34 -0700 Erni Sri Satya Vennela wrote:
> > Fixes: 75cabb46935b ("net: mana: Add support for net_shaper_ops") 
> 
> I've preferred this without the fixes tag, TBH.
> It's debugfs, nobody is supposed to be using it in production.
> -- 
> pw-bot: cr
I'll send v3 without the fixes tag.
Thankyou for the pointer.

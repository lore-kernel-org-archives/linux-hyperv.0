Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=13.77.154.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793251441;
	b=tNdD2zlW91lGPFa95fTPS3yLqlqV7ileMQySoB5NDSGtXluzmsMErNIeRqN5YOGABcl4
	 5wLcgyw1OM6f23Rat2OwNScyJcUzNHMDxLbw2k3RmvtNKUXJW3dc4YvYDKkbmmGlRa1hk
	 QNFLSHlRdRlX/MrYosxPs2Yky8w4UdCoP6kzzElSk9gBxvDoN4bDeqcYJa39+s7vldKQu
	 QIkpeiaHw50m3kc6KrIZ87uC3BWbUED2hs7G9ZjnSZqCBCT38PqIZnwKuu2c15+uNUUW/
	 NHbJjiKDeyrYYHFQPxXkmfJmj5/W8sVFC1+9ED+8SV7iS+CcSymKUtiTt4Q8yZi+G2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793251441;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=EZ9krrmyXuASs89K4CPP99Wi4EuB53GtTrhUzLw9d0o=;
	b=2zzoBG5yyIKJ/NoF5Xb1V3NKNQIW4qfl/QaH9TSx/otPLDykRXBsHYbgowOHiuDJyQnD
	 Jf+hUc6aJScN6HFPBv/7gx+cLaTLAD87frW9GjiazoVjreDlYtKq87B41r9zmLeWv7eo4
	 JT5zfgqE4DNcoOPMD+7trAiuRfz9Gafk0okJLBoIxvHJRhHsouTB/OamA7HEsvB1QbQHm
	 jlhudSii/At2025KpolOHFg5MU35zQjnm4G4FYqiN1ROwIfIfnxgv41fNYh1gwD6Ydhn0
	 xWoRIxDauBOm4oe8qmFWHgkjXSlTil+y2xAqeLFpxuoQSGsgkPcMWJEPjFKdCTr487Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.microsoft.com;
	spf=pass smtp.mailfrom=linux.microsoft.com;
	dkim=pass header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=a2llNXzA;
	arc=none smtp.remote-ip=13.77.154.182
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD861606A31C;
	Thu, 29 Oct 2026 05:24:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CD861606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=a2llNXzA
Received: by linux.microsoft.com (Postfix, from userid 1173)
	id BB65B20B7167; Wed, 28 Oct 2026 22:23:48 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com BB65B20B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1793251428;
	bh=EZ9krrmyXuASs89K4CPP99Wi4EuB53GtTrhUzLw9d0o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=a2llNXzABWfksMXN6X3W1+lvpHiFQ2t/OSIcU0VRa1XArutmjclJZukVYwjiwKiQA
	 fQGTdKxREZMD2f/nQ5YlOAUS0g+kQMjdc3zvXdB8lLDHDpdYHCHg2OZCNpO4Agwv3z
	 Yr406mLGR5z59TqyevaBDNqAUIpuu5ZTb0gHKY/A=
Date: Wed, 28 Oct 2026 22:23:48 -0700
From: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
To: netdev-bot+sinfo@kernel.org
Cc: haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
	kuba@kernel.org, pabeni@redhat.com, lkmlabelt@gmail.com,
	parri.andrea@gmail.com, linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Wei Liu <liuwe@microsoft.com>
Subject: Re: [PATCH net] hv_netvsc: Stop PPI parsing on invalid metadata
Message-ID: <auLYZIDErjpJYglF@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20261027164722.3393397-1-ernis@linux.microsoft.com>
 <179311981545.3327.1468271838360668962@kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Post: <mailto:linux-hyperv@vger.kernel.org>
List-Help: <mailto:linux-hyperv+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hyperv+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <179311981545.3327.1468271838360668962@kernel.org>

On Tue, Oct 27, 2026 at 04:50:15PM +0000, netdev-bot+sinfo@kernel.org wrote:
> Hi!
> 
> This is an automated message. This series looks like a fix, but its
> commit messages seem to be missing some information:
> 
>  - How the issue was discovered, e.g. hit in production, hit during
>    development, syzbot report, manual code inspection, LLM or static
>    analysis tool scan.
> 
>  - Whether the issue was actually triggered, or is only theoretical
>    (e.g. found by code inspection). If it was triggered please include
>    the symptoms, like the stack trace or error messages.
> 
> Please do not repost the series just to address the above. Instead,
> reply to this email with the missing information, so that reviewers
> can take it into account. If the series needs another revision for
> other reasons, please include the information in the commit messages
> then.
> 
> The evaluation is done by an LLM so it may be wrong, if you think
> that is the case please reply and explain.

This patch was prompted by a bug report received through internal bug
tracking system, and I have also confirmed the faulty control flow by
manual code inspection.

I have not independently reproduced the pre-fix hang.

- Vennela

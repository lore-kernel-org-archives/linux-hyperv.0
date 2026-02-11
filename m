Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D3712E7657;
	Wed, 11 Feb 2026 05:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770787210; cv=none; b=YBoKa823nOMuGxF6UgYyyPdfCgPcJnfn0AymMUCgWWkZU9JTRs08QyeoCooumofj0+n3Cz5Sw/ZYnQjlBPknaXmpEt9X6Jfsq9ZJCcqz+ntzZLThWTWhnj+/v+WTj8LHN8CY4S53s8LXhuqun3brs0B7JLTciKoiDwDNdKpdsnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770787210; c=relaxed/simple;
	bh=Vj8FSnOHIKKKA7z7j5V3sImfDEdojSJnMH8nghspUaw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qLYdi9rm0y/HSu4XLjuuua5xWIPUU4SsR4Of/sKy+brLQuLboLKe4uPK1LNFHPe2Bx6TUYman2oTql4f4M0WhIM1jMtn7WR4fDn9Wa2ZnI3t4x6tbCPXZH0zkj38htkIrA9oK/cejwu6RYTAMg+SXt7doWtTL99QKhZdA0RRtwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=fD1jqLQA; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="fD1jqLQA"
Received: by linux.microsoft.com (Postfix, from userid 1173)
	id 32F1220B7167; Tue, 10 Feb 2026 21:20:09 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 32F1220B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1770787209;
	bh=Vj8FSnOHIKKKA7z7j5V3sImfDEdojSJnMH8nghspUaw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fD1jqLQAVDFpW9PBvhkQX0AKkerZ8rgPFmuSvva/LP1S2MDzEam0ls6dRXkc7bHXL
	 ogzTE5XMKL6ZNO/mCv/t53HiEA3tmnXEWlrcW7Jlsea/cDgHQcDqqnkbJ6kIlUneaE
	 SF05BA6NrdwMOpraIkKHJpz38lIzdl/UaHHBFhGY=
Date: Tue, 10 Feb 2026 21:20:09 -0800
From: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Jakub Kicinski <kuba@kernel.org>, kys@microsoft.com,
	haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
	longli@microsoft.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, pabeni@redhat.com, kotaranov@microsoft.com,
	shradhagupta@linux.microsoft.com, yury.norov@gmail.com,
	dipayanroy@linux.microsoft.com, shirazsaleem@microsoft.com,
	ssengar@linux.microsoft.com, gargaditya@linux.microsoft.com,
	linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2] net: mana: Improve diagnostic logging for
 better debuggability
Message-ID: <aYwRifmi3eQFD5gm@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20260121065655.18249-1-ernis@linux.microsoft.com>
 <20260121201412.179f9b37@kernel.org>
 <aXJhzi58GqLKtui4@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <20260122180745.3b5607cf@kernel.org>
 <20260126195850.GO13967@unreal>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260126195850.GO13967@unreal>

Hi Jakub, Leon,

Thankyou for your comments.
I will be sending the next version with updated error logs only
with MAC address reporting in Vport Config.
Additional information will be added into debugfs in a different patch.

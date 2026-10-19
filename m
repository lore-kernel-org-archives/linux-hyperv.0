Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD8FD3D0BE5;
	Mon, 19 Oct 2026 10:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792406803; cv=none; b=Fp1g1bQCxaIjbXe/ASScqJodOqV9Z6JZBKggGzLSXkiEE0KvybeLWTk5Z0x1c7K11sbH7BGx/lcjheA56a4S7BZ0d8C+yJuIOXXnAYy/GUB1ANlJNL6m91sjVbGIsZV0sVvhzvnMMvkwtBIZBfRuvdTFCcw9mdw1kzKTmJ6QXro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792406803; c=relaxed/simple;
	bh=7EahbaIvSNoStgd3GuvS9Sej9J5K4CVxbTqbLWV91h0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C6OqNCEfoaSnCmIxdJswzqqLUBnxSOGeby2/MatqsC+XJm/ShgR4iMe/fN5aAfP/c3SN6en1T3MJD1TzL8vWhkDMQd6oOe+vk7KYl+Whsq03OqfNGuoIofXpMoK3wMQBG/11qBUBZ5WNYkV9Ulg73UV3qHRM7ttMuDdI5rGaugA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=EDQWET1g; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="EDQWET1g"
Received: by linux.microsoft.com (Postfix, from userid 1173)
	id C8C9420B7168; Mon, 19 Oct 2026 03:46:27 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C8C9420B7168
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1792406787;
	bh=bpfPV1+6zKyTa71p4GD/3mudHiMgZCQ8hMtEVkuM3rA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EDQWET1go83y0F2TuyoKEV+PWWR1qrPlaoZwR+BxPnlYzhOrynZLRoaWy8sfsE9hC
	 Dt/0Nl/UJg4dLxi+wHViSO08agRvKCzi6Ms5la4TO9c2RyDbgz2Wi0fg0McQLnTe8C
	 h68UzJEBBi1kBkb2w4rqUyyUJkXvpoVnelB4Oll4=
Date: Mon, 19 Oct 2026 03:46:27 -0700
From: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Haiyang Zhang <haiyangz@microsoft.com>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"edumazet@google.com" <edumazet@google.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"horms@kernel.org" <horms@kernel.org>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>,
	Dexuan Cui <DECUI@microsoft.com>,
	"longli@microsoft.com" <longli@microsoft.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"hawk@kernel.org" <hawk@kernel.org>,
	"andriin@fb.com" <andriin@fb.com>,
	Saurabh Singh Sengar <ssengar@microsoft.com>
Subject: Re: [EXTERNAL] [PATCH net-next 0/5] hv_netvsc: make XDP propagation
 act more like bonding
Message-ID: <atX1A9+2R251mM1m@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20261001014131.310771-1-kuba@kernel.org>
 <LV5PR21MB4704E9960B2B82028F2FB51DCA892@LV5PR21MB4704.namprd21.prod.outlook.com>
 <5636487a-31c7-43fb-8b27-a6a98b15200f@linux.microsoft.com>
 <asgJo+PasN8D+C/p@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <asgJo+PasN8D+C/p@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>

On Thu, Oct 08, 2026 at 02:22:43PM -0700, Erni Sri Satya Vennela wrote:
> On Tue, Oct 06, 2026 at 01:59:05PM -0700, Kameron Carr wrote:
> > On 10/2/2026 12:38 PM, Haiyang Zhang wrote:
> > > 
 
> I am continuing investigation of synthetic fallback with an
> independently programmed MANA VF and rejected-replacement restoration.
> 
> Regards,
> Vennela
> 
> Tested-by: Erni Sri Satya Vennela <ernis@linux.microsoft.com>

I tested an arriving VF with its own XDP program while netvsc already
had a different program attached.

On both MANA and mlx5, netvsc refused to join the VF and preserved
both programs without overwriting the VF's program. With the
unjoined VF independently brought UP, VF received traffic directly
through it. Both drivers supported independent reception before this
series and are unchanged by these patches. Ownership protection therefore
passed on both, but refusal to join does not establish synthetic-only
delivery for an independently UP VF.

The commit message in [PATCH 3/5] says traffic stays on the synthetic
path after refusal; does that assume the rejected VF remains down, or
should it also hold when the VF is independently brought UP?

- Vennela

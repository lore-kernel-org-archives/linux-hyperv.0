Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4F7A37F8DA;
	Fri, 30 Jan 2026 17:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769794676; cv=none; b=ll4gQ+IonLNEIeRVKwm3QKaA++G/iz3L0bnNvcouMP7PO7RKbfAOolKeITL6dOFeyhM9NoPyRMC4q5aQiGhnN7dLIAHiTp5H0yFfb6epcRCTq7/MdRkYdyFo5NOKHzcJmqQNMNXE/78QuoBzKnkKCAiAH70y+bUZ6iD+dhfShzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769794676; c=relaxed/simple;
	bh=Kp43aeOrmWm2Tj+NQSMvYnRpmZMjeJ7jb+EOUkIw9Ko=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GpK9mdCuAvyX0U8hmirZvvIo0x9hk3jIjfRlStS7RVskupbknq7cHMEhkGCE9Bc6N0EGZO5puDfKRCvsj/V2Lq7um4m1R9lewCxlcBoRKoWJZyzJWjz0l79v5VREJHh/t/WEB6dxCihIgRZvJuvf+nIc68QKv9UEwrkBaHIfiU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=sYZhe7s7; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="sYZhe7s7"
Received: by linux.microsoft.com (Postfix, from userid 1173)
	id C028A20B7167; Fri, 30 Jan 2026 09:37:54 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C028A20B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1769794674;
	bh=Ced02JqsdMOXdpl+3gOHWLgk7vkUuuy1N4DnGGgJd9o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sYZhe7s7nvoekEvj3PiowdevAC4arZFQNRDr7XkuiBbj6CgWjuGBrYBn+ZU1Ur5v8
	 T6pebwWFGNfk9RPEFXr+FfQuoBrPLxXykuIdCorCsGLz199BibNw4dityM1eHbZWKT
	 AiaIH21gl5t7kFC1gCeRe//Lx2shIJ1UUTG6pBXo=
Date: Fri, 30 Jan 2026 09:37:54 -0800
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
Message-ID: <aXzsckNbI1FLdA+l@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
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
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260126195850.GO13967@unreal>

On Mon, Jan 26, 2026 at 09:58:50PM +0200, Leon Romanovsky wrote:
> On Thu, Jan 22, 2026 at 06:07:45PM -0800, Jakub Kicinski wrote:
> > On Thu, 22 Jan 2026 09:43:42 -0800 Erni Sri Satya Vennela wrote:
> > > On Wed, Jan 21, 2026 at 08:14:12PM -0800, Jakub Kicinski wrote:
> > > > On Tue, 20 Jan 2026 22:56:55 -0800 Erni Sri Satya Vennela wrote:  
> > 
> > You will have to build proper support tooling like every single vendor
> > before you. Presumably you can also log from the hypervisor side which
> > makes your life so much easier than supporting real HW. Yet, real
> > NIC don't spew random trash to the logs all the time. SMH. Respectfully,
> > next time y'all "discuss things internally" start with the question of
> > what makes your case special :|
> 
> +100
> 
> Interesting. Completely independent of your comment, I provided the same
> feedback on their mana_ib driver. They added debug logs to nearly every
> command, even though those commands already had existing debug logging.
> 
> https://lore.kernel.org/linux-rdma/20260122131442.GL13201@unreal/T/#m51e8a12f4bca4a6c1377c5531c8a6d94a43af1e5
> 
> "In order to simplify things for you: unless you can clearly justify why this
> print is required and why you cannot proceed without it, I must ask you to stop
> adding any new debug or error messages to the mana_ib driver. There is a wide
> range of existing tools and well‑established practices for debugging the kernel,
> and none of them require spamming dmesg."
> 
> Thanks

Hi Jakub, Leon,

We agree with the concerns pointed out by adding new lines of logging,
hence we are planning to get the soc logs required for debugging issues
from customers by modifying the existing logs itself and would not be
adding any new lines.

Old Logs:

mana 7870:00:00.0: Microsoft Azure Network Adapter protocol version:
0.1.1
mana 7870:00:00.0 enP30832s1: Configured vPort 0 PD 18 DB 16
mana 7870:00:00.0 enP30832s1: Configured steering vPort 0 entries 64

Modified logs:

Initialization:
mana 7870:00:00.0: Microsoft Azure Network Adapter protocol version:
0.1.1 Max Resources: msix_usable=33 max_queues=32 VF version:
protocol=0x0 pf_caps=[0x1d]

Module load:
mana 7870:00:00.0 enP30832s1: Enabled vPort 0 PD 18 DB 16 MAC
60:45:bd:7b:76:30 Vport Config: max_txq=32 max_rxq=32 indir_ent=64
Device Config: max_vports=1 adapter_mtu=9216 bm_hostmode=0
mana 7870:00:00.0 enP30832s1: Configured steering vPort 0 entries 64 MAC
60:45:bd:7b:76:30 [rx:1 rss:1 update_indirection_table:1
cqe_coalescing:0]

Module unload:
mana 7870:00:00.0 enP30832s1: Configured steering vPort 0 entries 64 MAC
60:45:bd:7b:76:30 [rx:1 rss:1 update_indirection_table:1
cqe_coalescing:0]
mana 7870:00:00.0 enP30832s1: Disabled vPort 0 MAC 60:45:bd:7b:76:30

We considered this approach because we wanted to support older kernels,
which the customers are using and it is an easier way to backport these
changes. Is this approach acceptable? 
 

Received: from sender4-of-o52.zoho.com (sender4-of-o52.zoho.com [136.143.188.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A18E3FA5FC;
	Mon, 11 May 2026 13:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778507888; cv=pass; b=nLs2TrDf0RZ/E2BZ1VsZv2WxLUNCnVLt7OMlaOKD8nfsYxajx64rkXV3fchc7JK6uaezRT3j0Xp7ftQkQEiw11tlLNyUayaeEbv3a04brnfCI5MQGayEmXJowwv0RjV6/vQ+5Jt7qmmh2EecNhpBchC6wRCYnM1M9lXNMOoqLOA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778507888; c=relaxed/simple;
	bh=Jcet8KyEkYiGBBVzYuhoikSoMWX60iw/0P0kcVi0sQw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BqAsmWbr52gOwJsga9+sxXZOPJqiRe1P1bHB/nKDYl3k7FIJC2iiSOWyYn2JU9vJ1tVwsNo/VitssTQOPd7q2krKbB/C9kki0RL0iyHTxwG1/ectnDHt2d7CTlipeGhSwZf4/+ZG8Dg7AyClK3oD3n9x6itqAN0WfTJgcANTpBQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=anirudhrb.com; spf=pass smtp.mailfrom=anirudhrb.com; dkim=pass (1024-bit key) header.d=anirudhrb.com header.i=anirudh@anirudhrb.com header.b=Nl1D/aFa; arc=pass smtp.client-ip=136.143.188.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=anirudhrb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=anirudhrb.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=anirudhrb.com header.i=anirudh@anirudhrb.com header.b="Nl1D/aFa"
ARC-Seal: i=1; a=rsa-sha256; t=1778507872; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Bu8tC1HUXmpfyGk7mU+DHIMsuSjxWwssFDVXJrfMxnGRIrILotkQzYvsojF4wui0G9AGumalf1LYjviJw8iq1J2Ys2m1+FYX401UfCbyVLXC0cRxLK/NXv76/Q9eKFMNQP7BodmERXzaJmGhHEgDvh83C38LPPknFJzjl3p/kj0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1778507872; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=548LBP5jmiXtlRUysLGtYQXqCB1ATh62gSExfU6lrXQ=; 
	b=oIa6zdP0TGkzvd+2cO4sRRTQVN1ehxacg4U1NcmlNJMmJeXMgwAZ41Kz+LIjZBJ5mu+CHPzYnGbpDSAT0y3LIH2CVtyXZDdG2wwMptUIF4D3lyQcapmlI8qPM4ew9IRTIxW7NSTwabs6gXL7GU/37uts59D8EWOhrBw34rN3Li0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=anirudhrb.com;
	spf=pass  smtp.mailfrom=anirudh@anirudhrb.com;
	dmarc=pass header.from=<anirudh@anirudhrb.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1778507872;
	s=zoho; d=anirudhrb.com; i=anirudh@anirudhrb.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=548LBP5jmiXtlRUysLGtYQXqCB1ATh62gSExfU6lrXQ=;
	b=Nl1D/aFazJIgy8e3N4g63oCwrX52+gzyHU7mo4AqpybBG8HQh7zUgttkhgAyQeCg
	yRl2+0xtgZe4z57Gl9Fcldl+W/DcwOXL2iYc9JCcxqcW1RPv7njeQvfXcViMCvpTo2V
	Dy+iUXeu5xcJlUIkCZxqqdgaPce/a8lPi0C4MF2M=
Received: by mx.zohomail.com with SMTPS id 1778507868832481.82317095544613;
	Mon, 11 May 2026 06:57:48 -0700 (PDT)
Date: Mon, 11 May 2026 13:57:42 +0000
From: Anirudh Rayabharam <anirudh@anirudhrb.com>
To: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, longli@microsoft.com,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 03/18] mshv: Fix race in mshv_irqfd_deassign
Message-ID: <20260511-musical-discerning-stoat-cbacce@anirudhrb>
References: <177816592843.21765.4364464279247150355.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
 <177816859556.21765.6200058614819106223.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <177816859556.21765.6200058614819106223.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
X-ZohoMailClient: External

On Thu, May 07, 2026 at 03:43:15PM +0000, Stanislav Kinsburskii wrote:
> mshv_irqfd_deactivate() and the hlist traversal of pt_irqfds_list
> require pt->pt_irqfds_lock to be held, but mshv_irqfd_deassign()
> omits it. This races with the EPOLLHUP path in mshv_irqfd_wakeup(),
> which does take the lock before calling mshv_irqfd_deactivate().
> 
> Additionally, mshv_irqfd_deactivate() uses hlist_del() which poisons
> the node pointers rather than resetting them. Since
> mshv_irqfd_is_active() relies on hlist_unhashed() (checks pprev ==
> NULL), a poisoned node still appears active. If a concurrent path calls
> mshv_irqfd_deactivate() again on the same irqfd, the guard fails to
> prevent a double hlist_del() on poisoned pointers.
> 
> Fix both issues:
> - Add the missing spin_lock_irq/spin_unlock_irq around the list
>   traversal in mshv_irqfd_deassign(), matching mshv_irqfd_release().
> - Use hlist_del_init() instead of hlist_del() so the node is properly
>   marked as unhashed after removal, making the is_active guard reliable.
> 
> Fixes: 621191d709b14 ("Drivers: hv: Introduce mshv_root module to expose /dev/mshv to VMMs")
> Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
> ---
>  drivers/hv/mshv_eventfd.c |    5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

Reviewed-by: Anirudh Rayabharam (Microsoft) <anirudh@anirudhrb.com>


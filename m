Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=13.77.154.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794435808;
	b=aYNwaUEOKJ1C7XBkMY35h1ZdWMKr5tdnK7EtesH30ULq1B801m53F3fu/AMbIiV1pghX
	 3TlxHK/QK+SKg9DVFN1AKRQYs/PErAuXcNv7Y1vwOkiNiRKJAE0D7EwChNd4JmjFNZ8Xb
	 ToFdh4siFPvUoqDNkFvX7y0+/AIDAO0hyDN1ZrJHJki1cytns3cnKNyx+GzvZaQsubH8S
	 TEvTrW/B2NCvQH1vSkkGtjcY1ES7415anj0W9fKMbagL2f0oJKC/eKYmpG894hAzQMJlk
	 PAoJ1+BzOoiKQYMfyBuoxf9bvbsN0wzgc3oZbkbG2LTd0A3OMgObvHOVwDNzeg301UA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794435808;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=hvquHGNKpZYfNxNT5iFeEwYz9fPyaoA22FVHTaUGTG4=;
	b=YtKAtnwl3XtvPPdM005Fx70JGDxNnP41ZcM4x3xeogCrAz/QDB/gtBCg2oc5a8KvRiW4
	 qIA5On+n2YYbyd2gDzDMMC02OLG/XDZB1AvqJ4jC1Z6FlIlbN4q1ZrhulKo4rwCkSdzgg
	 pXXNMpjoivGpj3ytIPCkPj9J2OcqWoynoIOisHHKHExDTRb9EPdJyu2flqgpzSSAGfBIr
	 9t9f+btHfeBAmZPNifsPwZ1Y7orNhCMq07pIqp1EaeL/ML7stDABIx6MgAw/+jl0lC4qk
	 fYb0XIauaMlxbBWuA7pmjVZFgclzivFv1/YRvVG+/lwoUnwO9rLZwuL4UPo3pbj5G3Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.microsoft.com;
	spf=pass smtp.mailfrom=linux.microsoft.com;
	dkim=pass header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b="I/45b0sT";
	arc=none smtp.remote-ip=13.77.154.182
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 453B2606A326
	for <linux-hyperv@vger.kernel.org>; Wed, 11 Nov 2026 22:23:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 453B2606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=I/45b0sT
Received: by linux.microsoft.com (Postfix, from userid 1216)
	id AEEC820B7166; Wed, 11 Nov 2026 14:23:24 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com AEEC820B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1794435804;
	bh=hvquHGNKpZYfNxNT5iFeEwYz9fPyaoA22FVHTaUGTG4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=I/45b0sT+f3CpRcZ69BhwRgNTQZb7Eec337vNPbndQRHZX/FCLuNEicDzqpWw6bs8
	 OTacXMsc0MfvZnFmCtZwlenF1oS85ebs20BKLr8wC9i4Hoqyf208wWlcd/zMdKIcyV
	 1RCTStcfN4eWHmax+wP5pY6lgwHPdMw0MPYsBfDc=
Date: Wed, 11 Nov 2026 17:23:24 -0500
From: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
To: sascha@eder.earth
Cc: Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>,
	Saurabh Sengar <ssengar@linux.microsoft.com>,
	linux-hyperv@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: drm/hyperv: pointer lag on desktop guests - host cursor is
 supported by the protocol but hidden
Message-ID: <avTq3OCNdDeyn/La@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20261111121316.Horde.3cW0nxv09zUHPZiYh0D0t3G@webmail.your-server.de>
 <avRlw+MtVNtwojJk@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <20261111220506.Horde.EkRyYI2MJXvhgTT5Ojgh9r0@webmail.your-server.de>
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
In-Reply-To: <20261111220506.Horde.EkRyYI2MJXvhgTT5Ojgh9r0@webmail.your-server.de>

On Wed, Nov 11, 2026 at 10:05:06PM +0100, sascha@eder.earth wrote:
> Hi,
> 
> thank you for the speedy reply :)
> 
> > Cursor plane support is a WIP, you can test out [1] on your end.
> 
> That is exactly the fix I was hoping for.
> 
> Which tree and commit does the patch apply to?
> 
> My guest runs Debian 13 with kernel 6.12, where the driver still has the
> hyperv_ prefix and the simple display pipe,
> so I would build the tree you name with the patch on top and report back.
> 

Development for the driver is done on drm-misc-next[1], so I would
suggest testing it on there.

[1] https://gitlab.freedesktop.org/drm/misc/kernel/-/tree/drm-misc-next

> If you happen to have a version for 6.12, I can test that as well.
> 

Quite a lot has changed in the DRM subsystem since then so I doubt my patch
applies cleanly there or works as expected.

Hamza

> regards
> 
> Sascha
> 
> 
> 
> Quoting Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>:
> 
> > Hi,
> > 
> > On Wed, Nov 11, 2026 at 12:13:16PM +0100, sascha@eder.earth wrote:
> > > Hi,
> > > 
> > > I am a Windows developer porting some of my own desktop tools to Linux, and
> > > I use a Debian guest on Hyper-V to judge how they look and feel there.
> > > 
> > > The static picture is good, the mouse pointer is not, and I think the cause
> > > is small and fixable in hyperv_drm. I am writing because this is the first
> > > thing a Windows developer notices when trying Linux on their own machine: as
> > > long as a Linux VM feels sluggish next to a Windows VM on the same host, few
> > > of us will move a repo over and be happy about it.
> > > 
> > > Setup
> > > - Host: [Windows 11/26H2], Hyper-V, Generation 2 VM, basic session
> > > (vmconnect), 3840x2160 display
> > > - Guest: Debian 13, kernel 6.12.113+deb13-amd64, hyperv_drm (Synthvid 3.5),
> > > KDE Plasma 6.3.6 on Wayland (KWin 6.3.6, libwayland 1.23.1)
> > > - 4 vCPUs, about 7 GB RAM
> > > 
> > > What I saw so far:
> > > 
> > > - The pointer trails the hand by a small constant delay. Fast, long
> > > movements (taskbar to top of the screen) are visibly laggy, not just
> > > slightly off.
> > > 
> > > - A Windows guest on the same host, same viewer, same mouse is smooth -
> > > directly, and even when the host itself is reached through RDP. The Debian
> > > guest lags in both cases.
> > > 
> > > - While moving the pointer: kwin_wayland uses 35-50 % of one core, a kworker
> > > (events_unbound) 13-21 %, and the VM is about 80 % idle. Adding vCPUs
> > > changes nothing, so it is not a lack of CPU.
> > > 
> > > - A smaller cursor and disabling KDE's shake-to-enlarge effect helped a
> > > little. A plain color desktop did not.
> > > 
> > > What I think the cause is (from reading the driver, I have not patched it)
> > > 
> > > 1. hyperv_drm exposes only the primary plane. There is no cursor plane, so
> > > the compositor has to paint the pointer into the framebuffer, and every
> > > movement goes through compositing, the "blit to VRAM" and the dirt message.
> > > 
> > > 2. hyperv_pipe_update() uses drm_atomic_helper_damage_merged(), so the old
> > > and the new pointer position become one bounding rectangle. For a long or
> > > diagonal move at 4K that is a large part of the screen per pointer step,
> > > which matches the more noticable lag (much worse) on big movements.
> > > 
> > > 3. The protocol already has what is needed. hyperv_hide_hw_ptr() exists
> > > because, as its commit message says, "Hyper-V supports a hardware cursor
> > > feature. It is not used by Linux VM, but the Hyper-V host still draws" a
> > > pointer; the driver hides it by sending a 1x1 transparent ARGB shape with
> > > SYNTHVID_POINTER_SHAPE. So the host does accept a shape from a Linux guest
> > > and does draw the pointer itself.
> > > 
> > > Proposal:
> > > 
> > > Add a cursor plane to hyperv_drm (up to SYNTHVID_CURSOR_MAX_X/Y, 96x96,
> > > ARGB) that sends the compositor's cursor image and hot spot through
> > > SYNTHVID_POINTER_SHAPE instead of the transparent pixel, and re-sends it on
> > > SYNTHVID_FEATURE_CHANGE where the hide call is made today.
> > > 
> > 
> > Cursor plane support is a WIP, you can test out [1] on your end.
> > 
> > [1] https://patchwork.freedesktop.org/patch/761562/
> > 
> > Hamza
> > 
> > > With cursor hot-spot support for virtualized drivers, compositors would then
> > > leave the pointer to the host, as Windows guests do, and pointer movement
> > > would cause no framebuffer damage at all.
> > > 
> > > Independently of that, handling damage clips individually instead of merged
> > > would reduce the cost of the software-cursor fallback (cursors larger than
> > > 96x96).
> > > 
> > > A second, smaller item found on the way:
> > > 
> > > With Set-VMVideo set to 3840x2160 (Maximum), the guest offers modes only up
> > > to 2560x1600. The connector's modes come from drm_add_modes_noedid(), and
> > > 3840x2160 is not in that table, so it only appears with
> > > video=Virtual-1:3840x2160 on the kernel command line. Adding the host's
> > > maximum (or preferred) resolution as an explicit mode would make 4K hosts
> > > work without that step.
> > > 
> > > I can test patches on this setup and report back. I am not in a position to
> > > write the kernel change myself (drivers are not my field of work at all).
> > > 
> > > Thanks for maintaining the driver.
> > > 
> > > Sascha Eder
> > > 
> > > 
> 
> 

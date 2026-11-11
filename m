Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=13.77.154.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794401735;
	b=bLPBFwtnI6LDMJoSk1G490XGRs1/i8jpNFCuPwRyp5R9YiK/Z9Jkxp9QUDKhl3f3Snvm
	 zc8LsY0tVEFxkcy4NA8YHTBiDXFERJdXBSdPjcsP2+rJ/ZVZ/QiXWahyRIFqqFQ56MIpP
	 e+iPVwqi8udFuL0hnYKB6e7RZp/6fP5N4F1IgKku/TsWo5JNhL8BSywzcpevrMMXU6x1N
	 xLj18nWHYZbyAUUIoVWjhuMUGhAATpWv2GPRzeWBflBNGTAgtm8NMe6FwU/H/4SqXqvQr
	 YoTVcy9/YZAhI9ITqAphoyqSSXkmcXjRoay9f954CdNiVlmN39QNxN3n8NpYsZ9WiuA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794401735;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=Rp4oRefPckgdd2ejj4XRpLMgWf1AJCTEN2khTqd0gE8=;
	b=I9h7AHgXHCf3G1bLwZ7inLqJ+tZDWhkme741SWrtc0mhwHfeQPJofzuj7CdoxIkc3QOP
	 fDwwEI9Y7AeGeT4C6KsNX+oQnf5ltv7BikMG/oCjktkZTTz4PY2SfrFogmrKACsoqXkS+
	 0VVBMRFSo9+eRFw5Fqjpv2kGP9lIXojEPfA8FWsQK3YgrnPEP5I1+cjNEeXc5OW04l5ZD
	 upaYc8Mukcjr4BkL76RTYJX0o+xSf9dp8WFOQPyBAqsxwy9seIkuoGHdgsItreI3Hy6MC
	 0iU68VXzDLJ4hVT+LnLX4NUx5hRTxYGU7h/FXbDpiIfR3Z6o72WRbjNtDEUb1YeYtAA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.microsoft.com;
	spf=pass smtp.mailfrom=linux.microsoft.com;
	dkim=pass header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=bO5lIcan;
	arc=none smtp.remote-ip=13.77.154.182
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D950606A321
	for <linux-hyperv@vger.kernel.org>; Wed, 11 Nov 2026 12:55:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6D950606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=bO5lIcan
Received: by linux.microsoft.com (Postfix, from userid 1216)
	id 0978520B7166; Wed, 11 Nov 2026 04:55:32 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0978520B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1794401732;
	bh=Rp4oRefPckgdd2ejj4XRpLMgWf1AJCTEN2khTqd0gE8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bO5lIcanmhozDex0FDmgWco/p7S92G+PjikJ6E2r2eRauUnUVNP1LQVEfjYUAOD6H
	 7kTaPgkJU26s58XYag5glWoORW+b8aVHUOLbSVmdiUwA2zW7J84tM2MYJG7Izp1t5i
	 +pzaYsF5noNd4kK7wOH3z6q5+WonUyrJv9zTVDjU=
Date: Wed, 11 Nov 2026 07:55:31 -0500
From: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
To: sascha@eder.earth
Cc: Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>,
	Saurabh Sengar <ssengar@linux.microsoft.com>,
	linux-hyperv@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: drm/hyperv: pointer lag on desktop guests - host cursor is
 supported by the protocol but hidden
Message-ID: <avRlw+MtVNtwojJk@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20261111121316.Horde.3cW0nxv09zUHPZiYh0D0t3G@webmail.your-server.de>
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
In-Reply-To: <20261111121316.Horde.3cW0nxv09zUHPZiYh0D0t3G@webmail.your-server.de>

Hi,

On Wed, Nov 11, 2026 at 12:13:16PM +0100, sascha@eder.earth wrote:
> Hi,
> 
> I am a Windows developer porting some of my own desktop tools to Linux, and
> I use a Debian guest on Hyper-V to judge how they look and feel there.
> 
> The static picture is good, the mouse pointer is not, and I think the cause
> is small and fixable in hyperv_drm. I am writing because this is the first
> thing a Windows developer notices when trying Linux on their own machine: as
> long as a Linux VM feels sluggish next to a Windows VM on the same host, few
> of us will move a repo over and be happy about it.
> 
> Setup
> - Host: [Windows 11/26H2], Hyper-V, Generation 2 VM, basic session
> (vmconnect), 3840x2160 display
> - Guest: Debian 13, kernel 6.12.113+deb13-amd64, hyperv_drm (Synthvid 3.5),
> KDE Plasma 6.3.6 on Wayland (KWin 6.3.6, libwayland 1.23.1)
> - 4 vCPUs, about 7 GB RAM
> 
> What I saw so far:
> 
> - The pointer trails the hand by a small constant delay. Fast, long
> movements (taskbar to top of the screen) are visibly laggy, not just
> slightly off.
> 
> - A Windows guest on the same host, same viewer, same mouse is smooth -
> directly, and even when the host itself is reached through RDP. The Debian
> guest lags in both cases.
> 
> - While moving the pointer: kwin_wayland uses 35-50 % of one core, a kworker
> (events_unbound) 13-21 %, and the VM is about 80 % idle. Adding vCPUs
> changes nothing, so it is not a lack of CPU.
> 
> - A smaller cursor and disabling KDE's shake-to-enlarge effect helped a
> little. A plain color desktop did not.
> 
> What I think the cause is (from reading the driver, I have not patched it)
> 
> 1. hyperv_drm exposes only the primary plane. There is no cursor plane, so
> the compositor has to paint the pointer into the framebuffer, and every
> movement goes through compositing, the "blit to VRAM" and the dirt message.
> 
> 2. hyperv_pipe_update() uses drm_atomic_helper_damage_merged(), so the old
> and the new pointer position become one bounding rectangle. For a long or
> diagonal move at 4K that is a large part of the screen per pointer step,
> which matches the more noticable lag (much worse) on big movements.
> 
> 3. The protocol already has what is needed. hyperv_hide_hw_ptr() exists
> because, as its commit message says, "Hyper-V supports a hardware cursor
> feature. It is not used by Linux VM, but the Hyper-V host still draws" a
> pointer; the driver hides it by sending a 1x1 transparent ARGB shape with
> SYNTHVID_POINTER_SHAPE. So the host does accept a shape from a Linux guest
> and does draw the pointer itself.
> 
> Proposal:
> 
> Add a cursor plane to hyperv_drm (up to SYNTHVID_CURSOR_MAX_X/Y, 96x96,
> ARGB) that sends the compositor's cursor image and hot spot through
> SYNTHVID_POINTER_SHAPE instead of the transparent pixel, and re-sends it on
> SYNTHVID_FEATURE_CHANGE where the hide call is made today.
> 

Cursor plane support is a WIP, you can test out [1] on your end.

[1] https://patchwork.freedesktop.org/patch/761562/

Hamza

> With cursor hot-spot support for virtualized drivers, compositors would then
> leave the pointer to the host, as Windows guests do, and pointer movement
> would cause no framebuffer damage at all.
> 
> Independently of that, handling damage clips individually instead of merged
> would reduce the cost of the software-cursor fallback (cursors larger than
> 96x96).
> 
> A second, smaller item found on the way:
> 
> With Set-VMVideo set to 3840x2160 (Maximum), the guest offers modes only up
> to 2560x1600. The connector's modes come from drm_add_modes_noedid(), and
> 3840x2160 is not in that table, so it only appears with
> video=Virtual-1:3840x2160 on the kernel command line. Adding the host's
> maximum (or preferred) resolution as an explicit mode would make 4K hosts
> work without that step.
> 
> I can test patches on this setup and report back. I am not in a position to
> write the kernel change myself (drivers are not my field of work at all).
> 
> Thanks for maintaining the driver.
> 
> Sascha Eder
> 
> 

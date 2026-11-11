Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=168.119.26.117
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794431110;
	b=ndYoYipYh8a/i6VP4SHPrkOtSd+gRrocn5hKvl7oF5bRAQySqSp25Q1iZ/7+wjC2/kvr
	 4Bz8f64Tc0yT/eH5pR0z+PIOZRV3uDkXI1CGC992tzaAVu50DAQKRqUkDzLSKE/ZM/yxe
	 pHTDEe/EQ2rNYq3rR0Wt1x7ouqzxQebwoSvoUxC3K+JR9GyUJzPh8ThUcY9DUSIIgUggA
	 e7L+R+Fd+ahPcmDF7x8yqbR662ctEUVd8ELKSWyB1a0yDepzdj9IjDVIsaIMcZemKOJ0+
	 dCPuUQyDgPy9+Y3I3RQBF7iZnuxzJEvyw5Zx33bgRh6uQaEhbGxz3vYTop9dPncZbFg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794431110;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:Message-ID:From:
	 To:Cc:Subject:References:In-Reply-To:User-Agent:Content-Type:
	 MIME-Version:Content-Disposition:X-Virus-Scanned;
	bh=hHEDgV/fa4BQ56gOOscGjyGb7lZU1XBFJReEF+WJASA=;
	b=qbEDte3iOCeODVEAFWUitsX2ESBkJs5YQ+Abdgql0QBJOeJbLSzYZR09TBx58bq8KDzB
	 fpewYNV6gyoifEJG4G3KwsAvzBimSvWW8fdhIoOPNgtnkWbvPzrwJDQ2ZzjmigTuGgRYE
	 tFNyOhIQMM5b5vkJtYYoNh/TpIvho78Lp0x90dosS3/3KwUSC9wOygaH6ZbbBEkf8/xV3
	 rYRy/K/DTQUm5dOn1Nqo097qFp2HxS4AfiQ13GFHpAfHav/oXlsuvwhizYzcOm7cVa8W9
	 QO9RPzNFhaFnqx6jzH3ScPiYXwuxR5dyNnkUZ4ThlDIAQhRz/TfujGtXo/BHQ1VPIjg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=eder.earth;
	spf=pass smtp.mailfrom=eder.earth;
	dkim=pass header.d=eder.earth header.i=@eder.earth header.a=rsa-sha256 header.s=default2410 header.b=WxcUkUjr;
	arc=none smtp.remote-ip=168.119.26.117
Received: from www637.your-server.de (www637.your-server.de [168.119.26.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 391B0606A326
	for <linux-hyperv@vger.kernel.org>; Wed, 11 Nov 2026 21:05:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 391B0606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=eder.earth
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eder.earth
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=eder.earth header.i=@eder.earth header.a=rsa-sha256 header.s=default2410 header.b=WxcUkUjr
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=eder.earth;
	s=default2410; h=MIME-Version:Content-Type:In-Reply-To:References:Subject:Cc:
	To:From:Message-ID:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID; bh=hHEDgV/fa4BQ56gOOscGjyGb7lZU1XBFJReEF+WJASA=; b=WxcUkU
	jrQN+pq5e/bzjPF/O5kfpdcxIIf2C0vtJ0/X2sUN4eoR9vsL2MWhO4PEaX0I2a+yVrPTIP27xEVyj
	48z22jTTHL9NT6b/dbdhHIuDorjr4Xv72R/GC1+4dbOsFPxp2uS8ugKd0fVXDhYNz1Yi4Bh1tNaWh
	fmMJ6kDGzFMdeNH01gpAyrqaLbxR3qNOZAw77PfGU88+AOeM6bcBs6HeVsxZs1JuXvvEm5r6Iguib
	c6sMmZVxQ3yXeapDbKzbg5BuP0dKtXTwCr50vv4qs6EtwWdtSM03nMis7RZXYcPfNpck4OZaypIBl
	pl59+rymyS4KZKqJe9uPdz/6lffw==;
Received: from sslproxy03.your-server.de ([88.198.220.132])
	by www637.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <sascha@eder.earth>)
	id 1xRFVC-000DVJ-2v;
	Wed, 11 Nov 2026 22:05:06 +0100
Received: from [192.168.0.32] (helo=webmail.your-server.de)
	by sslproxy03.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <sascha@eder.earth>)
	id 1xRFVC-0009MJ-0j;
	Wed, 11 Nov 2026 22:05:06 +0100
Date: Wed, 11 Nov 2026 22:05:06 +0100
Message-ID: <20261111220506.Horde.EkRyYI2MJXvhgTT5Ojgh9r0@webmail.your-server.de>
From: sascha@eder.earth
To: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
Cc: Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>,
 Saurabh Sengar <ssengar@linux.microsoft.com>, linux-hyperv@vger.kernel.org,
 dri-devel@lists.freedesktop.org
Subject: Re: drm/hyperv: pointer lag on desktop guests - host cursor is
 supported by the protocol but hidden
References: <20261111121316.Horde.3cW0nxv09zUHPZiYh0D0t3G@webmail.your-server.de>
 <avRlw+MtVNtwojJk@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
In-Reply-To: <avRlw+MtVNtwojJk@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
User-Agent: Horde Application Framework 5
Content-Type: text/plain; charset=utf-8; format=flowed; DelSp=Yes
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Post: <mailto:linux-hyperv@vger.kernel.org>
List-Help: <mailto:linux-hyperv+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hyperv+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Disposition: inline
X-Virus-Scanned: Clear (ClamAV 1.4.6/28180/Wed Nov 11 07:24:27 2026)

Hi,

thank you for the speedy reply :)

> Cursor plane support is a WIP, you can test out [1] on your end.

That is exactly the fix I was hoping for.

Which tree and commit does the patch apply to?

My guest runs Debian 13 with kernel 6.12, where the driver still has  
the hyperv_ prefix and the simple display pipe,
so I would build the tree you name with the patch on top and report back.

If you happen to have a version for 6.12, I can test that as well.

regards

Sascha



Quoting Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>:

> Hi,
>
> On Wed, Nov 11, 2026 at 12:13:16PM +0100, sascha@eder.earth wrote:
>> Hi,
>>
>> I am a Windows developer porting some of my own desktop tools to Linux, and
>> I use a Debian guest on Hyper-V to judge how they look and feel there.
>>
>> The static picture is good, the mouse pointer is not, and I think the cause
>> is small and fixable in hyperv_drm. I am writing because this is the first
>> thing a Windows developer notices when trying Linux on their own machine: as
>> long as a Linux VM feels sluggish next to a Windows VM on the same host, few
>> of us will move a repo over and be happy about it.
>>
>> Setup
>> - Host: [Windows 11/26H2], Hyper-V, Generation 2 VM, basic session
>> (vmconnect), 3840x2160 display
>> - Guest: Debian 13, kernel 6.12.113+deb13-amd64, hyperv_drm (Synthvid 3.5),
>> KDE Plasma 6.3.6 on Wayland (KWin 6.3.6, libwayland 1.23.1)
>> - 4 vCPUs, about 7 GB RAM
>>
>> What I saw so far:
>>
>> - The pointer trails the hand by a small constant delay. Fast, long
>> movements (taskbar to top of the screen) are visibly laggy, not just
>> slightly off.
>>
>> - A Windows guest on the same host, same viewer, same mouse is smooth -
>> directly, and even when the host itself is reached through RDP. The Debian
>> guest lags in both cases.
>>
>> - While moving the pointer: kwin_wayland uses 35-50 % of one core, a kworker
>> (events_unbound) 13-21 %, and the VM is about 80 % idle. Adding vCPUs
>> changes nothing, so it is not a lack of CPU.
>>
>> - A smaller cursor and disabling KDE's shake-to-enlarge effect helped a
>> little. A plain color desktop did not.
>>
>> What I think the cause is (from reading the driver, I have not patched it)
>>
>> 1. hyperv_drm exposes only the primary plane. There is no cursor plane, so
>> the compositor has to paint the pointer into the framebuffer, and every
>> movement goes through compositing, the "blit to VRAM" and the dirt message.
>>
>> 2. hyperv_pipe_update() uses drm_atomic_helper_damage_merged(), so the old
>> and the new pointer position become one bounding rectangle. For a long or
>> diagonal move at 4K that is a large part of the screen per pointer step,
>> which matches the more noticable lag (much worse) on big movements.
>>
>> 3. The protocol already has what is needed. hyperv_hide_hw_ptr() exists
>> because, as its commit message says, "Hyper-V supports a hardware cursor
>> feature. It is not used by Linux VM, but the Hyper-V host still draws" a
>> pointer; the driver hides it by sending a 1x1 transparent ARGB shape with
>> SYNTHVID_POINTER_SHAPE. So the host does accept a shape from a Linux guest
>> and does draw the pointer itself.
>>
>> Proposal:
>>
>> Add a cursor plane to hyperv_drm (up to SYNTHVID_CURSOR_MAX_X/Y, 96x96,
>> ARGB) that sends the compositor's cursor image and hot spot through
>> SYNTHVID_POINTER_SHAPE instead of the transparent pixel, and re-sends it on
>> SYNTHVID_FEATURE_CHANGE where the hide call is made today.
>>
>
> Cursor plane support is a WIP, you can test out [1] on your end.
>
> [1] https://patchwork.freedesktop.org/patch/761562/
>
> Hamza
>
>> With cursor hot-spot support for virtualized drivers, compositors would then
>> leave the pointer to the host, as Windows guests do, and pointer movement
>> would cause no framebuffer damage at all.
>>
>> Independently of that, handling damage clips individually instead of merged
>> would reduce the cost of the software-cursor fallback (cursors larger than
>> 96x96).
>>
>> A second, smaller item found on the way:
>>
>> With Set-VMVideo set to 3840x2160 (Maximum), the guest offers modes only up
>> to 2560x1600. The connector's modes come from drm_add_modes_noedid(), and
>> 3840x2160 is not in that table, so it only appears with
>> video=Virtual-1:3840x2160 on the kernel command line. Adding the host's
>> maximum (or preferred) resolution as an explicit mode would make 4K hosts
>> work without that step.
>>
>> I can test patches on this setup and report back. I am not in a position to
>> write the kernel change myself (drivers are not my field of work at all).
>>
>> Thanks for maintaining the driver.
>>
>> Sascha Eder
>>
>>




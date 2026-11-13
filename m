Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=168.119.26.117
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794532744;
	b=banz91IVQV+AHNZVn96ny45Dn8/Ufq7/ta8+1OxCu2p6o+8FGVMimLe4X/fX0B0h3WCl
	 PfkYnFPq8XV1kOL1DNJ6OB+OBgO8m30ghjLEKLQi7MC6XLp8DoJuWQbCLdrp6cXbN1PHq
	 sZfvvt562qu6UL45L+EeWyl9CG+DiZcJ3IbIfWBrJCVOKU8zZNVshkrxbo08TC4cn+ToL
	 14FTNCQPcpcHSG/5FUQgUwzTKBHUWsBqnvJWzaMBaHmIvTYsiFifJhlBCKMd9eZCEilwC
	 RpcD9k/WwIWw/BXjfQoQ4N1V/XRIgCsi1MsPRpklC9x5Mz8L1SAi8uxXJSF+FEWwHdg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794532744;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:Message-ID:From:
	 To:Cc:Subject:References:In-Reply-To:User-Agent:Content-Type:
	 MIME-Version:Content-Disposition:X-Virus-Scanned;
	bh=1Lw/Kzjiv0IN55Jlqr16UXw1b64lX/C/R/gduT4UeyE=;
	b=S57lMS+MAEtwTaDT02PIGM26Q/iOYKgFba5fUsFA+NX2xEBs0XMY/NhqK4zkPlvO8uEf
	 OFT3IpJPKrbK8SO71CN4WTWUDoMJ0tqlt/AEPDWCL01pvGWn2bd728mzeRBqEDGJfsTJy
	 pSvS0948fV4qIzUITj/NwgIV4LVBF44YlZWpIH1Giruxl7OOa7X8ezj8dFIv1fy5AEPiN
	 WeKgGVA79rI7bm1Ecsa8AnOx0W9mw9SnxgkQS+3ZKVIBwPcsMpuCRwdS2Wmq14b3IKEfT
	 2vCde4idOFGZLIMIn9nwWU+wnpIWbO15fCu8GbT6Urx2PBQdge+cPBajGHk3AuW70kA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=eder.earth;
	spf=pass smtp.mailfrom=eder.earth;
	dkim=pass header.d=eder.earth header.i=@eder.earth header.a=rsa-sha256 header.s=default2410 header.b=P3GrrqdF;
	arc=none smtp.remote-ip=168.119.26.117
Received: from www637.your-server.de (www637.your-server.de [168.119.26.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FF6B606A323
	for <linux-hyperv@vger.kernel.org>; Fri, 13 Nov 2026 01:19:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3FF6B606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=eder.earth
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eder.earth
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=eder.earth header.i=@eder.earth header.a=rsa-sha256 header.s=default2410 header.b=P3GrrqdF
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=eder.earth;
	s=default2410; h=MIME-Version:Content-Type:In-Reply-To:References:Subject:Cc:
	To:From:Message-ID:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID; bh=1Lw/Kzjiv0IN55Jlqr16UXw1b64lX/C/R/gduT4UeyE=; b=P3Grrq
	dF2U2uxMia6KeJ6mCn+VtKS938xPtUhoH8eLeG4Z9HZIUqMLIZl36pHm/6QooAAa70G46EAb8jMoH
	Bfaw7LFg/6+P8g1F/YJjzv8ifguiz8U335yZIQQzSjgc3lmyQtrg+t3yKFWbwXh/8Pq0P8v6Al6oL
	Fudhh0isETfjdn/ajyzwGQYdTfxChKfv6AAAp16aEMtDNxwgkJQ1Z1HnfXMzZ4tQCJ3tOl5YaJZLu
	tGra4gcPxWhz7i7kHoITV8vfBvLMHkqOSF4jF5tLDvSS9v9fBqlGqxai8ixc0g8CsM1K8cny+i/KR
	9oMyR5pRwT/SkJRhmVpE1zz7ouZg==;
Received: from sslproxy04.your-server.de ([78.46.152.42])
	by www637.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <sascha@eder.earth>)
	id 1xRfwM-00065g-2t;
	Fri, 13 Nov 2026 02:18:54 +0100
Received: from [192.168.0.33] (helo=webmail.your-server.de)
	by sslproxy04.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <sascha@eder.earth>)
	id 1xRfwM-0004YX-1k;
	Fri, 13 Nov 2026 02:18:54 +0100
Date: Fri, 13 Nov 2026 02:18:54 +0100
Message-ID: <20261113021854.Horde.oyp74rgk0-Wh2hQXybP5yVq@webmail.your-server.de>
From: sascha@eder.earth
To: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
Cc: Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>,
 Saurabh Sengar <ssengar@linux.microsoft.com>, linux-hyperv@vger.kernel.org,
 dri-devel@lists.freedesktop.org
Subject: Re: drm/hyperv: pointer lag on desktop guests - host cursor is
 supported by the protocol but hidden
References: <20261111121316.Horde.3cW0nxv09zUHPZiYh0D0t3G@webmail.your-server.de>
 <avRlw+MtVNtwojJk@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <20261111220506.Horde.EkRyYI2MJXvhgTT5Ojgh9r0@webmail.your-server.de>
 <avTq3OCNdDeyn/La@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
In-Reply-To: <avTq3OCNdDeyn/La@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
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
X-Virus-Scanned: Clear (ClamAV 1.4.6/28181/Thu Nov 12 07:27:14 2026)

Hi,

> Development for the driver is done on drm-misc-next[1], so I would
> suggest testing it on there.

Done. Short version: the pointer is smooth now, the lag is gone,
but the host-drawn pointer shows up three times side by side.

What I built
- drm-misc-next at c88084027d0e ("drm: Discard
   pm_runtime_put_autosuspend() return values"), 7.4.0-rc2

- The tree already contains the cursor plane code: git am of your
   patch failed and patch(1) reported it as previously applied, so I
   built the tree as it is. Please tell me if that is not the version
   you want tested.

- Config: Debian 13's 6.12 config through localmodconfig, with
   HYPERV=y, HYPERV_VMBUS=m, DRM_HYPERV=m


Setup
- Host: Windows 11 Pro 26H2 (build 26300.9711), Hyper-V, Generation 2
   VM, basic session (vmconnect), 3840x2160
- Guest: Debian 13 userland, KDE Plasma 6.3.6 on Wayland (KWin 6.3.6),
   3840x2160 at 200 % scale, 4 vCPUs


What works
- The pointer follows the hand without delay, also on long fast moves.
   KWin picked up the cursor plane without any configuration.

- Cursors too large for the plane fall back to the software cursor
   correctly: one pointer, drawn right, with the old lag.


What does not
- Whenever the host draws the pointer, I see it three times: the real
   pointer, and two extra copies of it to its right. All three have the
   same shape, are evenly spaced in a row and move together. Clicks land
   under the leftmost one; the other two are only images. In phone
   photos of the screen the three look striped, as if only some of
   their lines were drawn or those "ghosts" were meant to render as one pointer

- This is the same for every size that uses the plane and for every  
theme I tried:

     Breeze, 200 % scale   size 12, 18, 24, 30, 36   plane, three pointers
                           size 42 and larger        software, one pointer

     Breeze Light          same as Breeze

     DMZ White, DMZ Black  three pointers

- The count is always the same: one real pointer plus two copies,
   whatever the cursor size.

- Host is on build 26300.9711 (the 2026-10 security update);
   the November update is not offered for this edition yet, so I could not
   check whether a newer host build behaves differently.
   I will retest when it arrives.

I have photos of the screen and could send them off-list or put them
somewhere, since the list likely does not take jpg attachments.

Tested on the setup above; I would hold a Tested-by until the copies are gone.

regards
Sascha



Quoting Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>:

> On Wed, Nov 11, 2026 at 10:05:06PM +0100, sascha@eder.earth wrote:
>> Hi,
>>
>> thank you for the speedy reply :)
>>
>> > Cursor plane support is a WIP, you can test out [1] on your end.
>>
>> That is exactly the fix I was hoping for.
>>
>> Which tree and commit does the patch apply to?
>>
>> My guest runs Debian 13 with kernel 6.12, where the driver still has the
>> hyperv_ prefix and the simple display pipe,
>> so I would build the tree you name with the patch on top and report back.
>>
>
> Development for the driver is done on drm-misc-next[1], so I would
> suggest testing it on there.
>
> [1] https://gitlab.freedesktop.org/drm/misc/kernel/-/tree/drm-misc-next
>
>> If you happen to have a version for 6.12, I can test that as well.
>>
>
> Quite a lot has changed in the DRM subsystem since then so I doubt my patch
> applies cleanly there or works as expected.
>
> Hamza
>
>> regards
>>
>> Sascha
>>
>>
>>
>> Quoting Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>:
>>
>> > Hi,
>> >
>> > On Wed, Nov 11, 2026 at 12:13:16PM +0100, sascha@eder.earth wrote:
>> > > Hi,
>> > >
>> > > I am a Windows developer porting some of my own desktop tools  
>> to Linux, and
>> > > I use a Debian guest on Hyper-V to judge how they look and feel there.
>> > >
>> > > The static picture is good, the mouse pointer is not, and I  
>> think the cause
>> > > is small and fixable in hyperv_drm. I am writing because this  
>> is the first
>> > > thing a Windows developer notices when trying Linux on their  
>> own machine: as
>> > > long as a Linux VM feels sluggish next to a Windows VM on the  
>> same host, few
>> > > of us will move a repo over and be happy about it.
>> > >
>> > > Setup
>> > > - Host: [Windows 11/26H2], Hyper-V, Generation 2 VM, basic session
>> > > (vmconnect), 3840x2160 display
>> > > - Guest: Debian 13, kernel 6.12.113+deb13-amd64, hyperv_drm  
>> (Synthvid 3.5),
>> > > KDE Plasma 6.3.6 on Wayland (KWin 6.3.6, libwayland 1.23.1)
>> > > - 4 vCPUs, about 7 GB RAM
>> > >
>> > > What I saw so far:
>> > >
>> > > - The pointer trails the hand by a small constant delay. Fast, long
>> > > movements (taskbar to top of the screen) are visibly laggy, not just
>> > > slightly off.
>> > >
>> > > - A Windows guest on the same host, same viewer, same mouse is smooth -
>> > > directly, and even when the host itself is reached through RDP.  
>> The Debian
>> > > guest lags in both cases.
>> > >
>> > > - While moving the pointer: kwin_wayland uses 35-50 % of one  
>> core, a kworker
>> > > (events_unbound) 13-21 %, and the VM is about 80 % idle. Adding vCPUs
>> > > changes nothing, so it is not a lack of CPU.
>> > >
>> > > - A smaller cursor and disabling KDE's shake-to-enlarge effect helped a
>> > > little. A plain color desktop did not.
>> > >
>> > > What I think the cause is (from reading the driver, I have not  
>> patched it)
>> > >
>> > > 1. hyperv_drm exposes only the primary plane. There is no  
>> cursor plane, so
>> > > the compositor has to paint the pointer into the framebuffer, and every
>> > > movement goes through compositing, the "blit to VRAM" and the  
>> dirt message.
>> > >
>> > > 2. hyperv_pipe_update() uses drm_atomic_helper_damage_merged(),  
>> so the old
>> > > and the new pointer position become one bounding rectangle. For  
>> a long or
>> > > diagonal move at 4K that is a large part of the screen per pointer step,
>> > > which matches the more noticable lag (much worse) on big movements.
>> > >
>> > > 3. The protocol already has what is needed. hyperv_hide_hw_ptr() exists
>> > > because, as its commit message says, "Hyper-V supports a hardware cursor
>> > > feature. It is not used by Linux VM, but the Hyper-V host still draws" a
>> > > pointer; the driver hides it by sending a 1x1 transparent ARGB  
>> shape with
>> > > SYNTHVID_POINTER_SHAPE. So the host does accept a shape from a  
>> Linux guest
>> > > and does draw the pointer itself.
>> > >
>> > > Proposal:
>> > >
>> > > Add a cursor plane to hyperv_drm (up to SYNTHVID_CURSOR_MAX_X/Y, 96x96,
>> > > ARGB) that sends the compositor's cursor image and hot spot through
>> > > SYNTHVID_POINTER_SHAPE instead of the transparent pixel, and  
>> re-sends it on
>> > > SYNTHVID_FEATURE_CHANGE where the hide call is made today.
>> > >
>> >
>> > Cursor plane support is a WIP, you can test out [1] on your end.
>> >
>> > [1] https://patchwork.freedesktop.org/patch/761562/
>> >
>> > Hamza
>> >
>> > > With cursor hot-spot support for virtualized drivers,  
>> compositors would then
>> > > leave the pointer to the host, as Windows guests do, and  
>> pointer movement
>> > > would cause no framebuffer damage at all.
>> > >
>> > > Independently of that, handling damage clips individually  
>> instead of merged
>> > > would reduce the cost of the software-cursor fallback (cursors  
>> larger than
>> > > 96x96).
>> > >
>> > > A second, smaller item found on the way:
>> > >
>> > > With Set-VMVideo set to 3840x2160 (Maximum), the guest offers  
>> modes only up
>> > > to 2560x1600. The connector's modes come from  
>> drm_add_modes_noedid(), and
>> > > 3840x2160 is not in that table, so it only appears with
>> > > video=Virtual-1:3840x2160 on the kernel command line. Adding the host's
>> > > maximum (or preferred) resolution as an explicit mode would  
>> make 4K hosts
>> > > work without that step.
>> > >
>> > > I can test patches on this setup and report back. I am not in a  
>> position to
>> > > write the kernel change myself (drivers are not my field of  
>> work at all).
>> > >
>> > > Thanks for maintaining the driver.
>> > >
>> > > Sascha Eder
>> > >
>> > >
>>
>>




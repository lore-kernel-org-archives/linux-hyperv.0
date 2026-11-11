Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=168.119.26.117
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794395606;
	b=cW/LvoBT3R65rNA8HHujncE9X2FkkeMNYtaheLPq32hka19Fj8x2fl0SD2sG0k40oIcF
	 Lopn+v52y/zIG5g67/NntComGGsHyYVst/VElGv/G0puOy983BQ7K3JP6LfET54pCZtLE
	 lcVazy71rhPqe/cOv8ML+8t7CIv4V8XNZKFrcNnyKH1msuf0au5F28QE4qtx+TwwSAnE6
	 h8HzyWCnam3fpUPUEq2zbIGmsAnQa6mPE5/l/txwPjlcrp9ENUbndgbilgRE7bWuDbCK1
	 1bZJdfao5+q1TN6+4nEFhRO2l18AjStpQW+oAtTGs34erMpGsDri8OVFMDG66zDiBMA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794395606;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:Message-ID:From:
	 To:Cc:Subject:User-Agent:Content-Type:MIME-Version:
	 Content-Disposition:X-Virus-Scanned;
	bh=KVw4V0BFyKGxlUWfRRyHrdXrNVEmnXUCsWp7xz2NFcU=;
	b=TamJcPQSNlSD6kzEOU19BswXWMM2pOVmugv4tX7G/1U9xhDtPOPk7bio76fonDFIljLB
	 ttrJzaxmTJd+coDvYUq3HuwSn0WqzCNXtZndJQpwp+E30LM3K0k6a5YN9iFYPIWy3K5uo
	 wl2Zjqx5ID1L0uQ+I4VQd2Q4PC08J3RoH0UHCfa+rhhR02xRccsbJiFWS+1x76GE+90zf
	 3SXR5XPPSnr8Ubsyybw1Q5i8VGcqCvaQx+V+IJymLkpAVAb02OeYtbsMr/wDwqGbWYJvT
	 UvXWIglQ3Kkb/3+q4QlAiMTP5oPKuMgTwFD0Iu5uH6/j8rV3YxhJvooKRFPanGMW/lQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=eder.earth;
	spf=pass smtp.mailfrom=eder.earth;
	dkim=pass header.d=eder.earth header.i=@eder.earth header.a=rsa-sha256 header.s=default2410 header.b=JTUPk9A9;
	arc=none smtp.remote-ip=168.119.26.117
Received: from www637.your-server.de (www637.your-server.de [168.119.26.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5E1D606A321
	for <linux-hyperv@vger.kernel.org>; Wed, 11 Nov 2026 11:13:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C5E1D606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=eder.earth
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eder.earth
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=eder.earth header.i=@eder.earth header.a=rsa-sha256 header.s=default2410 header.b=JTUPk9A9
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=eder.earth;
	s=default2410; h=MIME-Version:Content-Type:Subject:Cc:To:From:Message-ID:Date
	:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References; bh=KVw4V0BFyKGxlUWfRRyHrdXrNVEmnXUCsWp7xz2NFcU=; b=JT
	UPk9A9u5e0NYzPnUTYYnvab7O7w9Fvb7lz3Xz/rytplTf3OV0L62EAQToyeIw1Ohe0Fl2N/RQ4UAM
	BP/a2h2eet7igVNDbayvPEegcVbkXwLuuskmE8pZJjc0WU3CnPFg4w1JiUcPZqJXAHISk625vTtH4
	2Y4o95AD7e7zsGKX3k1NWp6M5B648zJhstM2qqQcu8Gql7AsyngrQT9myAr0Vc2PFBOF3cl0bsc7w
	iYlllTi7oC2IxF+8YklwZOqIUHl4BRJ9uSsT91zxfMhJUB2dXuA0w5KTsY0iaqk1tebMPOJPypfKN
	NpSgkjxxvBcATS6A7AKq6MW05U868lqQ==;
Received: from sslproxy04.your-server.de ([78.46.152.42])
	by www637.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <sascha@eder.earth>)
	id 1xR6GS-000Gw1-23;
	Wed, 11 Nov 2026 12:13:16 +0100
Received: from [192.168.0.33] (helo=webmail.your-server.de)
	by sslproxy04.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <sascha@eder.earth>)
	id 1xR6GS-000M86-19;
	Wed, 11 Nov 2026 12:13:16 +0100
Date: Wed, 11 Nov 2026 12:13:16 +0100
Message-ID: <20261111121316.Horde.3cW0nxv09zUHPZiYh0D0t3G@webmail.your-server.de>
From: sascha@eder.earth
To: Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>,
 Saurabh Sengar <ssengar@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: drm/hyperv: pointer lag on desktop guests - host cursor is
 supported by the protocol but hidden
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

I am a Windows developer porting some of my own desktop tools to  
Linux, and I use a Debian guest on Hyper-V to judge how they look and  
feel there.

The static picture is good, the mouse pointer is not, and I think the  
cause is small and fixable in hyperv_drm. I am writing because this is  
the first thing a Windows developer notices when trying Linux on their  
own machine: as long as a Linux VM feels sluggish next to a Windows VM  
on the same host, few of us will move a repo over and be happy about it.

Setup
- Host: [Windows 11/26H2], Hyper-V, Generation 2 VM, basic session  
(vmconnect), 3840x2160 display
- Guest: Debian 13, kernel 6.12.113+deb13-amd64, hyperv_drm (Synthvid  
3.5), KDE Plasma 6.3.6 on Wayland (KWin 6.3.6, libwayland 1.23.1)
- 4 vCPUs, about 7 GB RAM

What I saw so far:

- The pointer trails the hand by a small constant delay. Fast, long  
movements (taskbar to top of the screen) are visibly laggy, not just  
slightly off.

- A Windows guest on the same host, same viewer, same mouse is smooth  
- directly, and even when the host itself is reached through RDP. The  
Debian guest lags in both cases.

- While moving the pointer: kwin_wayland uses 35-50 % of one core, a  
kworker (events_unbound) 13-21 %, and the VM is about 80 % idle.  
Adding vCPUs changes nothing, so it is not a lack of CPU.

- A smaller cursor and disabling KDE's shake-to-enlarge effect helped  
a little. A plain color desktop did not.

What I think the cause is (from reading the driver, I have not patched it)

1. hyperv_drm exposes only the primary plane. There is no cursor  
plane, so the compositor has to paint the pointer into the  
framebuffer, and every movement goes through compositing, the "blit to  
VRAM" and the dirt message.

2. hyperv_pipe_update() uses drm_atomic_helper_damage_merged(), so the  
old and the new pointer position become one bounding rectangle. For a  
long or diagonal move at 4K that is a large part of the screen per  
pointer step, which matches the more noticable lag (much worse) on big  
movements.

3. The protocol already has what is needed. hyperv_hide_hw_ptr()  
exists because, as its commit message says, "Hyper-V supports a  
hardware cursor feature. It is not used by Linux VM, but the Hyper-V  
host still draws" a pointer; the driver hides it by sending a 1x1  
transparent ARGB shape with SYNTHVID_POINTER_SHAPE. So the host does  
accept a shape from a Linux guest and does draw the pointer itself.

Proposal:

Add a cursor plane to hyperv_drm (up to SYNTHVID_CURSOR_MAX_X/Y,  
96x96, ARGB) that sends the compositor's cursor image and hot spot  
through SYNTHVID_POINTER_SHAPE instead of the transparent pixel, and  
re-sends it on SYNTHVID_FEATURE_CHANGE where the hide call is made  
today.

With cursor hot-spot support for virtualized drivers, compositors  
would then leave the pointer to the host, as Windows guests do, and  
pointer movement would cause no framebuffer damage at all.

Independently of that, handling damage clips individually instead of  
merged would reduce the cost of the software-cursor fallback (cursors  
larger than 96x96).

A second, smaller item found on the way:

With Set-VMVideo set to 3840x2160 (Maximum), the guest offers modes  
only up to 2560x1600. The connector's modes come from  
drm_add_modes_noedid(), and 3840x2160 is not in that table, so it only  
appears with video=Virtual-1:3840x2160 on the kernel command line.  
Adding the host's maximum (or preferred) resolution as an explicit  
mode would make 4K hosts work without that step.

I can test patches on this setup and report back. I am not in a  
position to write the kernel change myself (drivers are not my field  
of work at all).

Thanks for maintaining the driver.

Sascha Eder



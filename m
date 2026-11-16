Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=13.77.154.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794841361;
	b=YDaD+ttQqDlhzLU0zj4GksxNCbPF43s+9RHGOjnmttqJ6WR6rrk0T1ZGFYsgp8lgGDTJ
	 VINgYm1FUk/Hq6F5/XXGxCsNpQClnmddfNnVgWgLkTCBRQ+Gq6UQkNSddF4lvZ0XGy3bB
	 KnW/V0p27+/2FfJXGzWIOz0iALkdFj/ifD+MDh01qymyo7D0Qu0hGyu8azQ4QuAMi5FM1
	 uCKzIF9NdzwtVL4iExYVnXOLjBsn0zSkmcgLAwyO9cQui9k2fAld+JrTn3xEsFPvI+JV4
	 cmWWOfTkBztrGfOqtWQ7xsLnGIOmRVI5ff3rZozhFWZW15Q5cLZW5dbDpIDZ1zkQIHA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794841361;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=UrYcNCnPwkCr55f9wx8oAre7u+b0LDqMaAoFyZ5VaPg=;
	b=Gs/3/k2D1AiLNmT1VeS1adxSDZOcRDcuvtgTsM+YkrnwCSzz3nReH+xZTNMizpMRp2xP
	 +jt1uGt3UGvTtLYCWfE/QUGni2glNWemgJTlXq6kTIc2hrU3YLWwD+P9gNNGawZtZSYhl
	 OIHZS5ZLL3ZsLA3fMiplrd/mRRGCI4MnSgo/dSulhQMsM3HX6nNyWKlc6oWjyoX01fE2z
	 6yeNMcJtXlCywmD2XH5IofhNTp1uMKjILjmZiAuN64VZ+PO+eVO96Lu68t9XngzMLrHtF
	 uS2FIqzorUhc5MDgEYMYHxY2o1DN1TS5erQU3cXoz00CAF+SfzuXtvrn/s4jzVn+7Bw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.microsoft.com;
	spf=pass smtp.mailfrom=linux.microsoft.com;
	dkim=pass header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=ERypDUVe;
	arc=none smtp.remote-ip=13.77.154.182
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40A8C606A89B;
	Mon, 16 Nov 2026 15:02:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 40A8C606A89B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=ERypDUVe
Received: by linux.microsoft.com (Postfix, from userid 1216)
	id C1DBF20B7168; Mon, 16 Nov 2026 07:02:29 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C1DBF20B7168
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1794841349;
	bh=UrYcNCnPwkCr55f9wx8oAre7u+b0LDqMaAoFyZ5VaPg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ERypDUVeu4NV1skzpf8c34AAAzQIG3PkRJQtWby0OLSkQ3SY2aKbeQhqT/Dm96/en
	 QBTevP16cm96ExjC3d+nw/C85+oOk2rhax6ilL9H7pHsMuKWWdKczebjbxfa/YpNm1
	 C5WCyZWbv2VYosYIY9eN6Z7Wtq1XqTTfLgniRwhg=
Date: Mon, 16 Nov 2026 10:02:29 -0500
From: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
To: Michael Kelley <mhklinux@outlook.com>
Cc: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	Dexuan Cui <decui@microsoft.com>,
	Saurabh Sengar <ssengar@linux.microsoft.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>
Subject: Re: [PATCH 0/2] drm/hyperv: address worthwhile gaps
Message-ID: <avsbBTsIoo09yr9L@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20261113215843.1939889-1-hamzamahfooz@linux.microsoft.com>
 <MN2PR02MB68638ED8E06516AFFAE4B218D47E2@MN2PR02MB6863.namprd02.prod.outlook.com>
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
In-Reply-To: <MN2PR02MB68638ED8E06516AFFAE4B218D47E2@MN2PR02MB6863.namprd02.prod.outlook.com>

On Sat, Nov 14, 2026 at 05:43:06PM +0000, Michael Kelley wrote:
> From: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com> Sent: Friday, November 13, 2026 1:59 PM
> > 
> > I was doing a deep dive into the host spec and noticed some gaps. So,
> > I went ahead and hacked together the patches in this series for items
> > that seemed worthwhile to address.
> 
> Are you (or someone on the Microsoft side) testing these changes
> in a Generation 1 VM, as well as on back revs of the Hyper-V host?

Ya, I have smoke tested all of these patches on WS2016 (both gen1 and
gen2). Also, I have it on good authority that they should be good at
least as far back as VMBus v3.0, so it should cover everything that
is currently supported.

> Testing should go back to Windows Server 2016/Windows 10 for
> both Gen1 and Gen2.
> 
> Same questions apply to your earlier cursor plane support. I just
> did basic smoke testing of the cursor plane support on both Gen1
> and Gen2 VMs using vmconnect.exe on an up-to-date Windows 11
> host -- no obvious problems. But I don't have access to older hosts
> like WS2016/Win10 to do the back rev testing.
> 
> There are multiple frame buffer differences in Gen1 and Gen2 VMs,
> but most (or all?) are in the lowest layer in how the frame buffer is
> allocated and mapped. Hopefully these higher-level changes you are
> making are agnostic of the VM generation, but thoroughness would
> dictate testing both.
> 
> I'm less sure about what might have changed in current Hyper-V
> versions and WS2016 from 10 years ago. My general impression is
> that very little, if anything, has changed in the Hyper-V frame buffer
> support, but again it would be better to not get a bad surprise after
> the code has gone in.
> 
> Michael
> 
> > 
> > Hamza Mahfooz (2):
> >   drm/hyperv: add modes for all resolutions offered by the host
> >   drm/hyperv: batch dirty rectangles
> > 
> >  drivers/gpu/drm/hyperv/hyperv_drm.h         | 15 ++++
> >  drivers/gpu/drm/hyperv/hyperv_drm_drv.c     |  4 ++
> >  drivers/gpu/drm/hyperv/hyperv_drm_modeset.c | 32 ++++++++-
> >  drivers/gpu/drm/hyperv/hyperv_drm_proto.c   | 79 ++++++++++++++++-----
> >  4 files changed, 110 insertions(+), 20 deletions(-)
> > 
> > --
> > 2.56.0

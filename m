Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 058FB238159;
	Mon, 25 May 2026 15:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779723141; cv=none; b=KDRjeYzcywSC3pbmf2OZpO4n3DeFiwgn60vqAtNqI91JxHuBV+er+Nslk6qxMD2CSJnaqnk+HlFE2x4+Tah7buE1jj/RI/m5x8Tco8sH5MjwhqHH8yX0J6duBwAQH2eslsXSOnyja9bdvY9pYZdkZMFtNIO8MgwBRW6Agoo5kOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779723141; c=relaxed/simple;
	bh=4Qc5CsRmwQt6pJnHqGWkb5bQB0iWdCR+1i+buvZaoAI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YH00xTgyrIw2a18h7Q+0uP7zFECxqLoBqU5CzQlDBmg9KqF6VM2ne0iT61nKoMgAU8zSHNevvRqS3gVxRUhrEErrxY0xASDLQX9J52PKyanuQpmdeVnaWFU8U9W1nwQSvUSu9ABz84jZm1qkr+Ams+cHWGhfj41F7OCq68ZSsA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=E/6AMGVo; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="E/6AMGVo"
Received: by linux.microsoft.com (Postfix, from userid 1216)
	id 59B8D20B7166; Mon, 25 May 2026 08:32:10 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 59B8D20B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1779723130;
	bh=bwMuIe2pYJ9lckE+M2axekk85mrakFk9ZnH9KNYYavA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=E/6AMGVorOZ3AXYjoUxkF9z/jlIXSHy+Rt01CpmS+2Uoew8uCOtiDeJ5QvIbh7z9d
	 ACcD2sm7tXjyB4LqTt9zY+DR9IBJ2cZDlL3H7XDhEEn4ZNAooNpvEisH6sRV+mmBbm
	 Ddo2q8/ZTD2RzL1sLbyqaXDtE2If2A8bx+aoyOFg=
Date: Mon, 25 May 2026 11:32:10 -0400
From: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
To: Michael Kelley <mhklinux@outlook.com>
Cc: Berkant Koc <me@berkoc.com>,
	Saurabh Sengar <ssengar@linux.microsoft.com>,
	Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Deepak Rawat <drawat.floss@gmail.com>
Subject: Re: [PATCH v5 0/2] drm/hyperv: harden host message parsing
Message-ID: <ahRrehOc3ypcxOpY@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <cover.1779542874.git.me@berkoc.com>
 <ahQ0NS1jrfU8ms1U@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <SN6PR02MB4157F72302D2B4B86ECE553FD40A2@SN6PR02MB4157.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN6PR02MB4157F72302D2B4B86ECE553FD40A2@SN6PR02MB4157.namprd02.prod.outlook.com>

On Mon, May 25, 2026 at 02:57:24PM +0000, Michael Kelley wrote:
> From: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com> Sent: Monday, May 25, 2026 4:36 AM
> > Applied, thanks!
> 
> Hamza -- which tree was this applied to?

drm-misc-fixes

> 
> Michael

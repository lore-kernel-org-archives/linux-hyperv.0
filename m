Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 248773E95B1;
	Fri, 16 Oct 2026 20:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=204.191.154.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792181543; cv=none; b=uHqXeWSgtz/By45i/SoedJnLyjvQMfMCx9Y3/tKm64xu7Bi6LnmTHX8K/sUDUcYt4DbbYIq1Fk57gPdyqkT+jRZubw7QZLYqygrNPN0K84cgWiywWUVuzdQj4U9kiv83TOPAg+nPhi+2CkmvG97/AZLOlaXGGLwXsFTCXppmsRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792181543; c=relaxed/simple;
	bh=frQbdMeqfT3iVzHUO53VKHE3fVx+XEIDlfmA6XLFAxk=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:From:In-Reply-To:
	 Content-Type:Subject; b=hVQ953t/X8F3omQdt1Cf4Iy3w/Fh9RkVRqMccbf9rNWVj12r0mLuZ55xGDYNdqUZNjilya9eLvopQ5iR/PJyN46HbM80ev95ZPgTxPwaXH+I3gikV7wZwL65O3edIi8O/Yr86RzGMARHZuO31319beGCqMTizVMzxJrtHgd8fmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com; spf=pass smtp.mailfrom=deltatee.com; dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b=mvspbEK2; arc=none smtp.client-ip=204.191.154.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deltatee.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="mvspbEK2"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
	MIME-Version:Date:Message-ID:content-disposition;
	bh=wtdAQptKrqycD2VywERsAjBpDeEa1De9Zkj3MUtqTNQ=; b=mvspbEK2ee4odC+BIxpLwOXj8Q
	hzN60UX9dMxZalkHUsUXge5kcBNBeXurXeZwo+Xbj69xK4/L8JzlQ+Rw0jFNfaUjaqa7m2mKqDLcX
	6NnCK3CscVe3AgRi9qRHZmLjceW6Di5QDcMBKZO+yXgLSsO4LhH6eZ1AmGzCNq9YOt9snP2bVwZxt
	P507ARY5Ny+OqnOiK9q8LFkayF/2VKOrEMgCKo1cYf3WhA6lbG2tFajfOZGQWgXbVoaqjetwXhuCv
	BHotQZobDcfo9cJkTONlPeT/cdgUz1aNCasBv4weONy1q4f/Mb+9Ix7EYhvnAvoKgHvH/QpP3TR9X
	6MU3pqig==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
	by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.2)
	(envelope-from <logang@deltatee.com>)
	id 1xHoHj-00000007oQj-0K0C;
	Fri, 16 Oct 2026 14:12:12 -0600
Message-ID: <4af82730-44ff-4ca7-a126-fba78cbf34f4@deltatee.com>
Date: Fri, 16 Oct 2026 14:12:08 -0600
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: "Popov, Pavel E" <pavel.e.popov@intel.com>,
 Bjorn Helgaas <helgaas@kernel.org>
Cc: Leon Romanovsky <leon@kernel.org>, Jim Chow <jim.chow@broadcom.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Radu Rugina <radu.rugina@broadcom.com>,
 Alexey Makhalov <alexey.makhalov@broadcom.com>, Wei Liu
 <wei.liu@kernel.org>, Michael Kelley <mhklinux@outlook.com>,
 Lukas Wunner <lukas@wunner.de>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Nathan Ciobanu <nathan.d.ciobanu@linux.intel.com>,
 "bcm-kernel-feedback-list@broadcom.com"
 <bcm-kernel-feedback-list@broadcom.com>,
 "virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20261009184923.GE11438@unreal>
 <LV2PR11MB60707DAD12BFBEAB681463B7B2922@LV2PR11MB6070.namprd11.prod.outlook.com>
 <20261011054700.GF11438@unreal>
 <LV2PR11MB60708F76EB7D6E5A40E82853B29F2@LV2PR11MB6070.namprd11.prod.outlook.com>
 <20261012162410.GH219304@unreal>
 <DS7PR11MB6064DA61339B9AB0F52EBED4B29F2@DS7PR11MB6064.namprd11.prod.outlook.com>
 <20261012182120.GJ219304@unreal>
 <DS7PR11MB60647FA80C6BE1029982222DB29F2@DS7PR11MB6064.namprd11.prod.outlook.com>
 <20261013122002.GN219304@unreal>
 <LV2PR11MB60704D89055FBC471FF81B31B29B2@LV2PR11MB6070.namprd11.prod.outlook.com>
 <20261016153147.GC219304@unreal>
 <LV2PR11MB6070D328D5E6A538DB6370B2B29B2@LV2PR11MB6070.namprd11.prod.outlook.com>
 <006effed-576f-4aed-b3ac-c335d8d51106@deltatee.com>
 <LV2PR11MB6070A3BB8BCB592EDFAFC261B29B2@LV2PR11MB6070.namprd11.prod.outlook.com>
Content-Language: en-CA
From: Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <LV2PR11MB6070A3BB8BCB592EDFAFC261B29B2@LV2PR11MB6070.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: pavel.e.popov@intel.com, helgaas@kernel.org, leon@kernel.org, jim.chow@broadcom.com, bhelgaas@google.com, radu.rugina@broadcom.com, alexey.makhalov@broadcom.com, wei.liu@kernel.org, mhklinux@outlook.com, lukas@wunner.de, rafael@kernel.org, nathan.d.ciobanu@linux.intel.com, bcm-kernel-feedback-list@broadcom.com, virtualization@lists.linux.dev, linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Level: 
Subject: Re: [PATCH 0/2] PCI/P2PDMA: Allow P2PDMA in VMware and Hyper-V guests
 on Intel hosts
X-SA-Exim-Version: 4.2.1 (built Sun, 23 Feb 2025 07:57:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)



On 2026-10-16 13:45, Popov, Pavel E wrote:
> 	X86_MATCH_VFM(INTEL_SKYLAKE_X, NULL),
> 	X86_MATCH_VFM(INTEL_ICELAKE_X, NULL),
> 	X86_MATCH_VFM(INTEL_ICELAKE_D, NULL),
> 	X86_MATCH_VFM(INTEL_SAPPHIRERAPIDS_X, NULL),
> 	X86_MATCH_VFM(INTEL_EMERALDRAPIDS_X, NULL),
> 	X86_MATCH_VFM(INTEL_GRANITERAPIDS_X, NULL),
> 	X86_MATCH_VFM(INTEL_GRANITERAPIDS_D, NULL),
> 	X86_MATCH_VFM(INTEL_ATOM_CRESTMONT_X, NULL),	/* Sierra Forest */
> 	X86_MATCH_VFM(INTEL_ATOM_DARKMONT_X, NULL),	/* Clearwater Forest */
> 	X86_MATCH_VFM(INTEL_DIAMONDRAPIDS_X, NULL),

I think this list would be pretty easy to approve if we know the two
Atom parts work.

> If you still prefer the kernel command line option you suggested, v3
> can add it, per-endpoint or global. It works without a patched kernel,
> but puts the burden on every VMware user to know about and set it,
> where v1 or v2 just works.

A kernel command line option probably wouldn't be a bad idea independent
of this. But up to you if you want to try to implement it.

Logan



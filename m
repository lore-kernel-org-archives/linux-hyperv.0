Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5B9146D092
	for <linux-hyperv@vger.kernel.org>; Tue,  4 Aug 2026 15:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785857852; cv=none; b=QKmOD4D1wPsJPzXtFqQGpRhAxPIYI/jHANUVybEHxAyqPQH0IreG/cZTTHhbhn1ZQfURRZQuyI05TgeHFrWoROfFF2namrHbp7p6j76O8iD92cTUQCoLyVz8LrlxO28SBm66xUHccSfi5AIkbqd17FfyqjKX1LaUnTng1AskVJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785857852; c=relaxed/simple;
	bh=gjrVDFzMFPA76v231W8P+9Ba4GP9F9+nK7yh6nwf4vc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mjcFK+LoIXLxT6i+0jXhdsnFD2hb0yn5kOtgZC7R59vjzDQM+zgMLKXqkYKSoK0RW2TMJMRc0fQU1Sl0+fPZvEb1KpbdcVxGSwnzeguvZ2Re7MJdsXqC6aCvuuvmM9ljbJt0jk0TtGW9uY5461lg2redNPO6lVKrM6rgMvOHY/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ikjjrtWP; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=NyBHoxnQ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ikjjrtWP";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="NyBHoxnQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785857848;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gjrVDFzMFPA76v231W8P+9Ba4GP9F9+nK7yh6nwf4vc=;
	b=ikjjrtWPEMzvLjOvQbhlxM1/5Pv4LCOYd6aid+G7UebGMM0IcN6Muq+rSeMV+mSqkYjMZd
	nheo+IMy2nEZFkw/h7gqo4VU6ZXNqBKnlpv2O1n6speiHG8TrI3wPS5+oMtRaa2meHDxnQ
	V3dBImigWxGeekgOEH3Bwm8Y6ymyO58=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-394-6BRiejpZMcmUWca2vty-pQ-1; Tue, 04 Aug 2026 11:37:27 -0400
X-MC-Unique: 6BRiejpZMcmUWca2vty-pQ-1
X-Mimecast-MFC-AGG-ID: 6BRiejpZMcmUWca2vty-pQ_1785857846
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-8ee593a5a2fso326126d6.1
        for <linux-hyperv@vger.kernel.org>; Tue, 04 Aug 2026 08:37:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1785857846; x=1786462646; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=gjrVDFzMFPA76v231W8P+9Ba4GP9F9+nK7yh6nwf4vc=;
        b=NyBHoxnQLVBXdsrEfxFuhEvstVIY8cALF0xh+RvV7k9v4JHb2gMIX1L6L5qqTyfFjA
         hZwo1yrgfqR0CC5aLdrs0ClRTmHrg6XcbURVBICq2/uIq6PyC2eVP/BSrtHG6+zavLUL
         8or77g9GwfalnpA4IWpMLWkulrBajjXJWRxOiwoIuJW2Nut/mHyWm6dwPkw9Zz0lJ4VJ
         e9LouISz0oM4PxFvAiC+RNRi81QozDYfyzc8C+JxQUDBd3CWxA/j8xEQyiXa7f0wBNg2
         T6PmdlVgQ5ynv63G9Y3iwXEyZC8sSuns+255HfxfEiZ2mZExROlSiqWC3HM3Ftt8JS+n
         zzPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785857846; x=1786462646;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gjrVDFzMFPA76v231W8P+9Ba4GP9F9+nK7yh6nwf4vc=;
        b=NmnvdkM3n7yKYRjsmp1MenHRTY1mc/oGPp7JLpMKD8KylL1nPsOezbx2jr7ivdlE8h
         vHi+Dprwi6Ey89wID/VQhk3EuiXMzZVs2Oam1sRaZwJ5vCYEqJAzAOIKtLd0cNmeMpk+
         pjUr87OlZGUDcnvnDIK8oSKvNX9KipQN/9SV4Y+byn93tniawULRRpmdffjp7SOx0TkB
         daVq0VvgLRDIMCweCw7guE+I42lmEUCmyOU9CZGLxEe6tijZKR8MehJXjIKmVehDB3jx
         tjjEJeDPewG7JQq0pqHly5TTaGq54ACjNlsnPcZyOBNY88tN96ykA6sxINfw1hCgVSGm
         KhKg==
X-Forwarded-Encrypted: i=1; AHgh+Rr54eIOnq7vTeNurjCK1EDtXJ65/R8YPLWbik5IJCp6CkmBemu8cxywvAoefkm+2+o4vI6W1C+0RvghhVk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9OzC/8+9/vqBJ0NDjLmGOXN70wh4jDrIu3fG6kLcsMioDBJC6
	rnA/SH7MnoUd/pmfck2ATd7KqIz0fcDUHWoTs2xhUsNOhqOagpgX5KbPVaBTWLzPkvtvHAHJcFL
	5kPYFUYfZ9qQtvpLpYtLxUcpNqA/sW7mmcUUzXcnwBDB43unbdXxFYq8bzGNlw7/Saw==
X-Gm-Gg: AR+sD11mVzDu+GdAxbD5J5KEAHrCNSnaPpAmoCLstMYvweyI3kC8B0JUSTmf1vr2SSU
	j1KIBDZqIUFIWAcrIOFeiRycRZviFnO+buCwshR44HIauVQvIClv14PAqbrSYL2K0Mtj7l9qAd2
	SE1T1H1XsUWWEkI3HiizECOhAEauWEcZcnxBmV98u2b9VyvNqe+CaBUVUc9wY+jzBnR/pU78eMR
	8J9gMcTxsXGQfSKY1BDslQRghyE2qH9jhR5/9seL+2j5PsaEhM3Zls3fTbNblxrtT+JrRW8dXuX
	l/njj+VKS/+VmAI92s842U06XUXwInQ6ifQKbuG4hXT84x3MoLOnuoHGJf6NXj1b2NmnwgdBkqr
	wj4s27SztP/9tmqDwlG5PFsCj4GgmFkAEgzkg
X-Received: by 2002:a05:6214:493:b0:8fd:b96d:195b with SMTP id 6a1803df08f44-90872c2b7cbmr80415946d6.15.1785857846410;
        Tue, 04 Aug 2026 08:37:26 -0700 (PDT)
X-Received: by 2002:a05:6214:493:b0:8fd:b96d:195b with SMTP id 6a1803df08f44-90872c2b7cbmr80415046d6.15.1785857845790;
        Tue, 04 Aug 2026 08:37:25 -0700 (PDT)
Received: from loberman-thinkpadp16gen3.rmtusma.csb ([2600:6c65:2440:d8c:dbb1:97f1:a6e6:766b])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-908800cb9basm3648296d6.45.2026.08.04.08.37.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 08:37:25 -0700 (PDT)
Message-ID: <fa5e8dd1591ada95ac3e7e371852d9d68cd33cd8.camel@redhat.com>
Subject: Re: [PATCH] scsi: storvsc: Support manual scans for all Hyper-V
 targets
From: Laurence Oberman <loberman@redhat.com>
To: kernel test robot <lkp@intel.com>, "K. Y. Srinivasan"
 <kys@microsoft.com>,  Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu
 <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, Long Li	
 <longli@microsoft.com>
Cc: oe-kbuild-all@lists.linux.dev, "James E.J. Bottomley"
	 <James.Bottomley@hansenpartnership.com>, "Martin K. Petersen"
	 <martin.petersen@oracle.com>, linux-hyperv@vger.kernel.org, 
	linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 04 Aug 2026 11:37:24 -0400
In-Reply-To: <202608032058.OkCwuEDu-lkp@intel.com>
References: <20260723151458.872265-1-loberman@redhat.com>
	 <202608032058.OkCwuEDu-lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2026-08-03 at 20:45 +0800, kernel test robot wrote:
> Hi Laurence,
>=20
> kernel test robot noticed the following build errors:
>=20
> [auto build test ERROR on jejb-scsi/for-next]
> [also build test ERROR on mkp-scsi/for-next linus/master v7.2-rc6
> next-20260731]
> [If your patch is applied to the wrong git tree, kindly drop us a
> note.
> And when submitting patch, we suggest to use '--base' as documented
> in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>=20
> url:=C2=A0=C2=A0=C2=A0
> https://github.com/intel-lab-lkp/linux/commits/Laurence-Oberman/scsi-stor=
vsc-Support-manual-scans-for-all-Hyper-V-targets/20260803-141419
> base:=C2=A0=C2=A0
> https://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git=C2=A0for-
> next
> patch link:=C2=A0=C2=A0=C2=A0
> https://lore.kernel.org/r/20260723151458.872265-1-loberman%40redhat.com
> patch subject: [PATCH] scsi: storvsc: Support manual scans for all
> Hyper-V targets
> config: i386-allmodconfig
> (https://download.01.org/0day-ci/archive/20260803/202608032058.OkCwuE
> Du-lkp@intel.com/config)
> compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
> reproduce (this is a W=3D1 build):
> (https://download.01.org/0day-ci/archive/20260803/202608032058.OkCwuE
> Du-lkp@intel.com/reproduce)
>=20
> If you fix the issue in a separate patch/commit (i.e. not just a new
> version of
> the same patch/commit), kindly add following tags
> > Reported-by: kernel test robot <lkp@intel.com>
> > Closes:
> > https://lore.kernel.org/oe-kbuild-all/202608032058.OkCwuEDu-lkp@intel.c=
om/
>=20
> All errors (new ones prefixed by >>, old ones prefixed by <<):
>=20
> > > ERROR: modpost: "scsi_scan_host_selected"
> > > [drivers/scsi/hv_storvsc.ko] undefined!
>=20
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
>=20
>=20
> Thanks for the report. This build failure was against v1 and was
> fixed in v2 by replacing the unexported scsi_scan_host_selected()
> helper with the exported scsi_scan_target() interface.


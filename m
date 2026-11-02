Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793621420;
	b=UDWUcD8ckNXnYTsqmTM+P5d5Jp2E4k8PDAF2NIj9WPQfsRni3KEtOCuRpHVWQ3MN4KBH
	 k8W3+wjinqjXMdGdH6pWfzsM/JEyy/301w93Xiaye1DO5yLdGINAlhrrXfZWm0uzIdks0
	 dyS+0qbP2S5UOgqOLC7SF0+kaLF9mVeqLHZ036qPNAoGkXdITvf40OkejDhiUTqlCBJ4b
	 0ijvLAuSv+JjYZN5UC9b1wKn4gIRSVThItN4zBpJAWgFQQH1vtsn/i9d03RgsxWMTUbBr
	 /E8qQS08m7km+dCfUaaPU7cc/hfV+4EuN9EdiPwPYS3HwOMTLn66wuebDVP6oV4vpIw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793621420;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=3RaNVpitPtQwc0pZksDRL8hgfwXn6BMG3yrnetP97t0=;
	b=gJN17I3rydr7NIiF+Ln6/iKTfF5fSbS5ELWQE5lM47ihvW+PFU4+C2Fk9DXdSqKYkTCo
	 B2L2hFcxbq8f5P1/Sn2QCCSdVLk/FEciJeg31UIMVeiUPVAEm5raLheUs7/Us4nwpK+Gn
	 MRLHuaxDKKdpy4JnDom9BRXhk+fk7eZsR4/0tnvnaDdS6pdSGYMCfFjtPwTr6lBvmgYnD
	 cjxQteyZ1dmt4WnS7AjkfcwlsBwpCBgjS0XxxprYirpfl58HK94Jbgcxnl2Z0MM34iDvA
	 QylVNL7y2Bbg73P8LBZYjo6kQOXzwcB/5jgkMsrP2oCzupwmFK46gGHZ7JAkICQzB7A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=VwC0qHuV;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4057360A2606;
	Mon,  2 Nov 2026 12:10:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4057360A2606
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=VwC0qHuV
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7C92B1FC4;
	Mon,  2 Nov 2026 04:10:15 -0800 (PST)
Received: from arm.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BF3B93F59E;
	Mon,  2 Nov 2026 04:10:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1793621418; bh=kH4wduj8rCU9JrOnkhZ6pZU1rzL9URyPOvDKS+QGHkc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VwC0qHuVb3TAXcufxcWHnvaPcBsK56AleG1Lpa9845YIDHNBw/EIEqriPowVEpX6T
	 XzCrwXx+5Lq2A415gJAGOLEd3LcGoSbJ+SYR1pllJGhbw4g2lHxWt9S5lqQPCqoM2H
	 GwNVzTOxVdnJu2vat6eT2F77+zNgSSZXSWQ3j3Bs=
Date: Mon, 2 Nov 2026 12:10:14 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Dexuan Cui <DECUI@microsoft.com>
Cc: Kameron Carr <kameroncarr@linux.microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	"mhklinux@outlook.com" <mhklinux@outlook.com>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>,
	"arnd@arndb.de" <arnd@arndb.de>,
	"linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	"Mark.Rutland" <Mark.Rutland@arm.com>,
	"sudeep.holla@kernel.org" <sudeep.holla@kernel.org>,
	"thuth@redhat.com" <thuth@redhat.com>,
	"will@kernel.org" <will@kernel.org>
Subject: Re: [PATCH v6 1/6] arm64: rsi: Add RSI host call structure and
 helper function
Message-ID: <auh9pgBvIDD1PjXr@arm.com>
References: <20261031001412.4150488-1-kameroncarr@linux.microsoft.com>
 <20261031001412.4150488-2-kameroncarr@linux.microsoft.com>
 <CH4PPF0966F22FCBBF24F0929E97AC69951BF6C2@CH4PPF0966F22FC.namprd21.prod.outlook.com>
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
In-Reply-To: <CH4PPF0966F22FCBBF24F0929E97AC69951BF6C2@CH4PPF0966F22FC.namprd21.prod.outlook.com>

On Sat, Oct 31, 2026 at 04:51:21AM +0000, Dexuan Cui wrote:
> > From: Kameron Carr <kameroncarr@linux.microsoft.com>
> > Sent: Friday, October 30, 2026 5:14 PM
> > To: Dexuan Cui <DECUI@microsoft.com>; Haiyang Zhang
> > <haiyangz@microsoft.com>; mhklinux@outlook.com; wei.liu@kernel.org
> > Cc: arnd@arndb.de; catalin.marinas@arm.com; linux-arch@vger.kernel.org;
> > linux-arm-kernel@lists.infradead.org; linux-hyperv@vger.kernel.org; linux-
> > kernel@vger.kernel.org; lpieralisi@kernel.org; Mark.Rutland
> > <Mark.Rutland@arm.com>; sudeep.holla@kernel.org; thuth@redhat.com;
> > will@kernel.org
> > Subject: [PATCH v6 1/6] arm64: rsi: Add RSI host call structure and helper
> > function
> > 
> > Add struct rsi_host_call to arm-smccc-rsi.h, which represents the host
> > call data structure used by the Realm Management Monitor (RMM) for the
> > RSI_HOST_CALL interface. The structure contains a 16-bit immediate field
> > and 31 general-purpose register values, aligned to 256 bytes as required
> > by the CCA RMM specification.
> > 
> > Add rsi_host_call() static inline wrapper in arm-rsi-cmds.h that invokes
> > SMC_RSI_HOST_CALL with the physical address of the host call structure.
> > This will be used by Hyper-V guest code to route hypercalls through the
> > RSI interface when running inside an Arm CCA Realm.
> > 
> > Reviewed-by: Michael Kelley <mhklinux@outlook.com>
> > Signed-off-by: Kameron Carr <kameroncarr@linux.microsoft.com>
> > ---
> 
> Catalin provided Reviewed-by to v5's patch #1, which is the same
> as v6's patch #1:
> https://lore.kernel.org/all/auPOxoaRbdOEHnv_@arm.com/

Yes, my review still stands.

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>

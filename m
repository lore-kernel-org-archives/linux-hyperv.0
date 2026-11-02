Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793620666;
	b=qOk6xEP2NHTBmxRjINmGJHtPCRGmNylJvR2Gb+DZ0hH0d0leDF4Mh1zFNk9w77tPUXy2
	 +k3sT8rthTRPhBwkR+bKatBbQnK3EDQuHqDu1Srw/ARAWkgAU8SG4AhXL06OPF5uDu7PE
	 j7K9MJIBUk9KH3rlXQUkGlCsmxgH2qWco6qSnqivf1lB8wSfQlSfVpfj+JnjQVvMHX3KT
	 rvenKHUlxO/9i4XRkF7nnDPsSRg+BNBWgJxvc5ouBqHoysLiH/JtjIeRtPxZiEuxT0MZk
	 Byf3Fa9iIChO3Sz54O9txj58kHYJGmzM5ACyeJmlVwjzO2fDnovNrB8/eCUCUAnlg1A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793620666;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=a+lxVdcflxyH59Md6E2MblMjFZPkYamJmvZNqoXT46o=;
	b=TNtDb8Tf8yE0jDS3nRbzQW3oSHj33bvN9OXtkywxLp1r8sEb901D0w8UMa0DzNEg77Lu
	 uqtG3Yc/VPtyNFpmtOCJUkvldtfKyM9rqDt6UcOUUVtnWEz/9cqzdRpgBslZ9SRmYUngA
	 +bLoqVWkb7iHI58LlN46ETYHAlWhxyLr7KvoCf43kg/hIFZNHp6Dem7YpOT81/5sK31Ui
	 yq6IWDEg1XeBrGyYAi9p+z7/cBu2l4QJjkfrgyrQisb1RfhVRu3YrcOMAJRe2CI402pdX
	 IL6Ib2AYFeNJC+ODz0GeJS6kto7JPOgQNyEXxRXLQtOurX3RvKNcTNBWhdcXpG3F/0Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=a45A7YzR;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 505D7606A332;
	Mon,  2 Nov 2026 11:57:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 505D7606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=a45A7YzR
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7ACC11FC4;
	Mon,  2 Nov 2026 03:57:42 -0800 (PST)
Received: from arm.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9D6C93F632;
	Mon,  2 Nov 2026 03:57:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1793620665; bh=YqQ0EI1oDh/HUj0/mvZSV2WfYlpip86rcsjzSKEAyQo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=a45A7YzRxXii7hkUN4U13CFuVd5h+Xv32KParPswsRdTy/3XNv4Mo5BbONhCRZsLV
	 3pjKnI8wTLHf1EMVmfa9yvsFbTLbVtY/WusJlGGmwshkQkkh/qCiaFmxs15vf9XElP
	 2hzbFxeijAot2yJ6elFOUEkpRxLMpGtrYIBfMV8s=
Date: Mon, 2 Nov 2026 11:57:41 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Dexuan Cui <DECUI@microsoft.com>
Cc: Kameron Carr <kameroncarr@linux.microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>,
	"mhklinux@outlook.com" <mhklinux@outlook.com>,
	"will@kernel.org" <will@kernel.org>,
	"Mark.Rutland" <Mark.Rutland@arm.com>,
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	"sudeep.holla@kernel.org" <sudeep.holla@kernel.org>,
	"arnd@arndb.de" <arnd@arndb.de>,
	"thuth@redhat.com" <thuth@redhat.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>
Subject: Re: [EXTERNAL] Re: [PATCH v5 2/6] firmware: smccc: Detect hypervisor
 via RSI host call in CCA Realms
Message-ID: <auh6tWHyMU15QbRC@arm.com>
References: <20261002215725.2015959-1-kameroncarr@linux.microsoft.com>
 <20261002215725.2015959-3-kameroncarr@linux.microsoft.com>
 <auPOnb_9Jfzh-oQE@arm.com>
 <CH4PPF0966F22FCAF3D8C6535743902930DBF6C2@CH4PPF0966F22FC.namprd21.prod.outlook.com>
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
In-Reply-To: <CH4PPF0966F22FCAF3D8C6535743902930DBF6C2@CH4PPF0966F22FC.namprd21.prod.outlook.com>

Hi Dexuan,

On Sat, Oct 31, 2026 at 04:47:32AM +0000, Dexuan Cui wrote:
> > From: Catalin Marinas <catalin.marinas@arm.com>
> > Sent: Thursday, October 29, 2026 3:54 PM
> > > +#ifdef CONFIG_ARM64
> > > +	if (is_realm_world())
> > > +		arm_smccc_realm_get_hypervisor_uuid(&res);
> > > +	else
> > > +#endif
> > > + 	arm_smccc_1_1_invoke(ARM_SMCCC_VENDOR_HYP_CALL_UID_FUNC_ID,
> > > +				     &res);
> > 
> > Is this meant to be generic? I'm not sure the trick to pass
> > ARM_SMCCC_VENDOR_HYP_CALL_UID_FUNC_ID in gprs[0] and forward it to
> > the host is a documented ABI. I think it even confuses other realm guests
> > that don't expect this (e.g. kvm_init_hyp_services()).
> 
> Regarding the concern about passing ARM_SMCCC_VENDOR_HYP_CALL_UID_FUNC_ID
> In gprs and forwarding it to the host via an RSI Host Call: if I read the code correctly,
> this pattern actually aligns seamlessly with the current KVM host-side
> implementation for ARM CCA (e.g., in the v16 patchset [1]).

[...]

> Because KVM deliberately unpacks the RSI Host Call structure and pushes
> it down the traditional non-CVM HVC servicing pipeline, the guest passing
> standard SMCCC Function IDs inside the gprs array of an RSI Host Call is
> exactly how the host expects to handle hypervisor services. It shouldn't
> break or confuse other standard realm implementations since this exact
> emulation block translates the RSI exception back into a generic HVC
> abstraction for the hypervisor layer.

My point is not the RSI host call itself to query the UUID but what the
Realm does afterwards. kvm_init_hyp_services() gets a positive answer
for the KVM UUID and continues with an SMCCC 1.1 invocation to query the
supported KVM features. The latter is not an RSI host call but an
ordinary SMC call, to which the RMM responds with -1 in res.a0 (all
lower 32 bits set). So we end up treating KVM hyp services as available
in a Realm but their calls still use the SMC conduit and are rejected by
the RMM.

Supporting such hyp services (e.g. KVM PTP) in a Realm would need a
separate hypervisor-service conduit using RSI_HOST_CALL. Both discovery
and subsequent calls would use the same transport without adding
Realm-specific checks to each caller. Not sure how feasible this is.

-- 
Catalin

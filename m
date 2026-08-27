Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D9D33F1069
	for <linux-hyperv@vger.kernel.org>; Thu, 27 Aug 2026 19:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787860591; cv=none; b=U9uewF+R2bzB72aYe5+s65zI70tkuSlZA8T/z3SsMTRUUarEDCFlNegrWRhGEbp2YnIPZcxEMDGGJcPsM4e36tg/135MyV9Sxi3kvN+XUD1Xclsed6tVezhmA3TnVJNoOLW7Mo2N+GyVEj8Bs+aeVD87rZ4k8xOPrHUIucPhb1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787860591; c=relaxed/simple;
	bh=1Xfp5vG7SEvsIG7w59jHWkXFdV3WgmwA1E2ly/GCYYw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=aWrS5p3Dm6SNnxg5mca0lFJTAWTRC3q++FDG+Q6TS93EtUBihBJ+/QhIANORlqwZP3PA99XCA+SHunX0J/jZme6Vz4r33RH7Yppce6BLOA+KdRWc0dcD3npjRox8HwegpwDi9ZHo+mDvkimm34a0RSo3B9ASiJrnSrUn1onqd/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mLFE83zn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mLFE83zn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85E5A1F000E9;
	Thu, 27 Aug 2026 19:56:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787860589;
	bh=bgkh4lrYYJfc/4MtEW/jOE5kNoek3YzZD9O9wMgKa5Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mLFE83zn2X5rlIDSa7XQlbnNYr1JNPnvWVoPxrA25it/cJZcSotwzrtm3p/oBhpB3
	 V8r4zpVgwt1wN0hBS9S/2pUVIllaXkrfGkk1BbPzObascBl3DNteFeaH37YYj8XSs/
	 Em8V+Dq0i+X5w8YsdcOViYMrM53HgpUphrMMXhGf6WxCZjQAza6+2Z4qqQNEsVxlCD
	 TfVeR2P/yVvCvHOlMta7riIexAwUx8UJ4FjHKiKBuMpPNjwtXVAHuyWnz4Y0c7cOLG
	 FiJUsJvtw8o87BkhL1N83QfM4iK9MCnOZDt6+V4Ai11FR+mg8Pn86rfk7kCiINiosD
	 kDEOFGNX1eBQw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] Drivers: hv: Avoid infinite retry loop in
 init_vp_index()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Waiman Long" <longman@redhat.com>
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <20260827193750.662623-1-longman@redhat.com>
References: <20260827193750.662623-1-longman@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 27 Aug 2026 19:56:29 +0000
Message-Id: <20260827195629.85E5A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but the patch attemp=
ts to fix an infinite retry loop while relying on a flawed assumption, leav=
ing a kernel hang scenario intact under CPU hotplug.
--

commit 357edd9f97074f4d93f3160be466a7aa7d20c7bb
Author: Waiman Long <longman@redhat.com>

Drivers: hv: Avoid infinite retry loop in init_vp_index()

This commit attempts to fix an infinite retry loop in init_vp_index() by
skipping NUMA nodes that do not contain any housekeeping CPUs. It aims to
ensure that a NUMA node with housekeeping CPUs is eventually found.

Link: https://sashiko.dev/#/message/20260422030903.E1BFCC2BCB0%40smtp.kerne=
l.org [1]

> diff --git a/drivers/hv/channel_mgmt.c b/drivers/hv/channel_mgmt.c
> index a044fd3b3c4e7..2e611d2de6d10 100644
> --- a/drivers/hv/channel_mgmt.c
> +++ b/drivers/hv/channel_mgmt.c
[ ... ]
> @@ -780,14 +781,16 @@ static void init_vp_index(struct vmbus_channel *cha=
nnel)
>  				next_numa_node_id =3D 0;
>  				continue;
>  			}
> -			if (cpumask_empty(cpumask_of_node(numa_node)))
> +			node_mask =3D cpumask_of_node(numa_node);
> +			if (cpumask_empty(node_mask) ||
> +			    !cpumask_intersects(node_mask, hk_mask))
>  				continue;
>  			break;
>  		}

[Severity: High]
This is a pre-existing issue, but the patch attempts to fix an infinite ret=
ry
loop while relying on an assumption that leaves a kernel hang scenario inta=
ct
under CPU hotplug.

Could this while (true) loop in init_vp_index() iterate endlessly without
sleeping if an administrator dynamically hot-offlines all managed IRQ
housekeeping CPUs?

Since housekeeping_cpumask(HK_TYPE_MANAGED_IRQ) tracks all possible
housekeeping CPUs, the early abort check at the start of the function will =
see
hk_mask as non-empty even if those CPUs are currently offline.

However, cpumask_of_node() only returns online CPUs. If the remaining manag=
ed
IRQ housekeeping CPUs are offlined, cpumask_intersects(node_mask, hk_mask)
will evaluate to false for every NUMA node, causing this loop to spin
indefinitely while holding channel_mutex and cpus_read_lock().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260827193750.6626=
23-1-longman@redhat.com?part=3D1

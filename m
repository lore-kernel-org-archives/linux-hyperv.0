Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CD4047CA78
	for <linux-hyperv@vger.kernel.org>; Wed, 26 Aug 2026 19:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787773235; cv=none; b=fDCc86TqD3576fFlccMjEFJzoeaGdztSGT/uLUq1+E7tpQUauiL9QRdJf32ejrU73Dp+klkOEQBVNgQavccHVw2RNGi82l94Ap+A27ltEqzVKgMlPQGLc5RYxEgDNf3AomREKOHMUlL7kmwqmgA6IFSUH7y75z6lwH12aTcKkRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787773235; c=relaxed/simple;
	bh=hE8L6Jykdl9Yivd+lEPl4xbqf5KP3wN8d/olLB7apBI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=s/ZNcG4P/3ZlmGgDDtWOomZQtL47+ay4q38yRr+PpGZCW2jjH7hZezjQcit37EpoBKLXk6bF8WWCR6L+XswTw0AW++2aH54wJljxAuwFPGL5TCt80UoukAXYqKhkc+FCrDceUEUctsqovoFpewBLYoUsZdAHm1PH+8bVecAW+pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bB6f9RSF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bB6f9RSF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B7351F000E9;
	Wed, 26 Aug 2026 19:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787773212;
	bh=d8R1xrm5k+YlD83gRknxWtRFfX35zoc7J7GZVg1YeZY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bB6f9RSFpkqCZj1SM7jcO3uHBpYbKsB1rzw/e5/m330WyjatS+/Y9C19ouWngPkOR
	 IIe3KKKSipo3Sf/TetnLhNME/zmu/6zdvgVaYBmRWhqNjJ1P9XEuwJfM7BbtJPyV9q
	 kSX4a0dlJcEL459FYjtJruHp97ebKSTHDLWh3TT1VfUFD1NuwKEnEIFHs/U7msqxcI
	 rIO1YIKcENf0IJy35mA+6Ci+SCY5Fp4PD8EsucM/IjVb9z89AWC3TW3LHWPsN/DhPm
	 qQ/iMFWUZ+cSnarxr+or/W99yLRKdXW2Am3OvqNdTtDhLaY7aqYfjEqNVyyGncAXos
	 JwcWLTj8aF6GA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] Drivers: hv: Avoid infinite retry loop in
 init_vp_index()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Waiman Long" <longman@redhat.com>
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <20260826192509.529838-1-longman@redhat.com>
References: <20260826192509.529838-1-longman@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 26 Aug 2026 19:40:11 +0000
Message-Id: <20260826194012.0B7351F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Incrementing the bounded loop counter when skipping empty NUMA nod=
es causes premature search termination, falling back to CPU 0.
- [Medium] When the loop falls back to VMBUS_CONNECT_CPU, it fails to regis=
ter this allocation in the hv_numa_map, breaking the round-robin distributi=
on tracker.
--

commit 5b552e920b17d64534cf7a69fd8a78145809498a
Author: Waiman Long <longman@redhat.com>
Drivers: hv: Avoid infinite retry loop in init_vp_index()

This commit fixes an infinite retry loop in init_vp_index() that occurs when
the housekeeping cpumask for managed IRQs contains no CPUs in a particular
NUMA node. It resolves this by skipping to the next node if the allocated
cpumask is already cleared, and falling back to VMBUS_CONNECT_CPU if the lo=
op
is about to end.

Link: https://sashiko.dev/#/message/20260422030903.E1BFCC2BCB0%40smtp.kerne=
l.org

> diff --git a/drivers/hv/channel_mgmt.c b/drivers/hv/channel_mgmt.c
> --- a/drivers/hv/channel_mgmt.c
> +++ b/drivers/hv/channel_mgmt.c
> @@ -793,10 +793,20 @@ static void init_vp_index(struct vmbus_channel *cha=
nnel)
>  		if (cpumask_empty(available_mask)) {
>  			/*
>  			 * We have cycled through all the CPUs in the node;
> -			 * reset the allocated map.
> +			 * reset the allocated map. If the allocated map
> +			 * has already been cleared, we will try the next numa
> +			 * node. Set target_cpu to the default VMBUS_CONNECT_CPU
> +			 * instead if the for loop is going to end.
>  			 */
> -			cpumask_clear(allocated_mask);
> -			goto retry;
> +			if (!cpumask_empty(allocated_mask)) {
> +				cpumask_clear(allocated_mask);
> +				goto retry;
> +			}
> +			if (i > ncpu) {
> +				target_cpu =3D VMBUS_CONNECT_CPU;
> +				break;

[Severity: Medium]
When the loop falls back to VMBUS_CONNECT_CPU here, does this bypass updati=
ng
the round-robin allocation tracker?=20

The fallback block earlier in init_vp_index() correctly calls
hv_set_allocated_cpu(VMBUS_CONNECT_CPU) to maintain the global allocation
state:

    channel->target_cpu =3D VMBUS_CONNECT_CPU;
    if (perf_chn)
        hv_set_allocated_cpu(VMBUS_CONNECT_CPU);
    return;

Could breaking out directly here without making the corresponding state upd=
ate
cause a load imbalance by stacking extra channels on CPU 0 without the
balancer knowing?

> +			}
> +			continue;	/* Try next numa node */

[Severity: High]
Does this continue statement prematurely exhaust the loop iterations when
encountering nodes with no housekeeping CPUs?

Since the loop counter i limits the total search across ncpu + 1 iterations,
incrementing it while skipping an empty NUMA node burns through the search
budget without actually evaluating any CPUs.

For example, in a topology with several isolated NUMA nodes, could skipping
these empty nodes cause the loop budget to run out early, incorrectly forci=
ng
a fallback to VMBUS_CONNECT_CPU before checking all valid housekeeping CPUs?

>  		}
> =20
>  		target_cpu =3D cpumask_first(available_mask);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260826192509.5298=
38-1-longman@redhat.com?part=3D1

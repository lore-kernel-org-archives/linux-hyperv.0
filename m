Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794907468;
	b=X80uFVMcS6aUrpS1zg+yNyKqBGhuL4FGuAe4yqm8GagzNOwTcMy6nnint8AP5atTzVGN
	 LgKV8XpP2Bzo5mUf3bNNvd+BeJMKclway8t3Sj2qmE+4NKXDOxtY+l3mZVrftTcKILXC8
	 NgTnT4Sxr1Yt5mNVfqjC8r14dx1knMmIJneQ+7Wpb9+ytjxlxfNZHYzq/xe2dSagYfsXh
	 oHaM1YbQrXrZClcDTyDecJpt7sUxq0ZrbzuZ4UoGRiassDEutUaCTZV1IhLECLuWqQ/Fz
	 hVJBwRXW1f0p5ILPmN5l/IPOcdiuvVZNJNVE50MJRDwHnjIqKDwnVK4/tUK2lD5Y2ag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794907468;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=LBCfgNOqOzPbVlsXnFPjOSdgLRRe9hXE5Xv4sfC2PZ8=;
	b=VoQcLGKRtw+igs9+yjqBHOI1SWHbk9JrGalqj04kGzIObLkG+pVKd3WXgKbn+V9jE8Wr
	 JSRcDVP0wErIGHJxndFhBmPmGc3aZamioK7ybyC39ZrvsCJvIfuuB6DFBLglKDK0xBZQX
	 NwvSxxrj5xuHWDA8fCV4cIJxmU7rzl/BiXKqk4fKbh4LL9X68Abzd2nRPyXdSsJgtIS3C
	 dTGg8SWLU4TIa0VeAk/7ACTY/cE8RU+n34Pw5l89wKhQCMwvz+clFokZ/waF6hPl2MoSS
	 ZlASGmyqWo/ZIVEdyasJch1tQyADYPhcd+xN7LadUtQK/52iQLAHHbxflYrY9KYuI8Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HJzKDlxq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38FCF606A31C
	for <linux-hyperv@vger.kernel.org>; Tue, 17 Nov 2026 09:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HJzKDlxq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A26431F000C4;
	Tue, 17 Nov 2026 09:24:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794907467;
	bh=LBCfgNOqOzPbVlsXnFPjOSdgLRRe9hXE5Xv4sfC2PZ8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HJzKDlxqCXuDYyItusqs+/Wxj951zySdNZ7JYWi6wATMld9hrNBTXKckyX3s2LFqP
	 22EDedoFHmHUm0ASXPGuaLVvYZH/mKprJojaxJqVDj1aDfhKz2xi/WL711M+LZh1OO
	 1M2ulY0SiyNGEcZYQuYPyfcUNWh53fSeBR+w33j0ydpH9ZBPZ5QMIeAAM2i/mDK6d4
	 MqheXg1Y03S5GQmHrvdzXks6QhX5vNw5d2VYsLnrknXhz4NQv0zsT/ZQiX/zR3PrVG
	 +LsbCdkTzbvwE1zxGJTwMHGR4Onttmk0fiQepycBfpbVTScbHAscDtpF9mclE7W8LT
	 rFslsKEw7C8nQ==
Message-ID: <sashiko-outbox-218478@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 4/5] x86/hyperv: Filter TLB targets before building
 hypercalls
Reply-To: sashiko-reviews@lists.linux.dev
To: "Naman Jain" <namjain@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <20261117091507.2088642-5-namjain@linux.microsoft.com>
References: <20261117091507.2088642-1-namjain@linux.microsoft.com>
 <20261117091507.2088642-5-namjain@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 09:24:26 +0000
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Post: <mailto:linux-hyperv@vger.kernel.org>
List-Help: <mailto:linux-hyperv+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hyperv+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] x86/hyperv: missing Fixes tag for commit 209954cbc7d0
--

commit b708a994017fe50fc481b9fcff6a341c5d843b13
Author: Naman Jain <namjain@linux.microsoft.com>

> x86/hyperv: Filter TLB targets before building hypercalls
>
> SuperBench's eight-GPU PyTorch LSTM training on Azure MI300X VMs regressed
> between Linux 6.8 and 7.0. Recreating DataLoader workers each epoch caused
> host-to-GPU copy stalls and timeouts. The reported bisection identified
> commit 209954cbc7d0 ("x86/mm/tlb: Update mm_cpumask lazily").
>
> That change leaves a CPU's bit set after it switches to another mm.
> Native flush callbacks remove these stale bits, but successful Hyper-V
> hypercalls do not run those callbacks. A CPU actively running another
> mm need not be in lazy TLB mode, so the existing lazy-TLB check does not
> exclude it. If the mask includes all present CPUs, the backend selects
> the all-processors shortcut before checking individual CPUs.
>
> Use the native predicate to build a per-CPU target mask before selecting
> the all-processors shortcut or either hypercall format. Keep the full
> candidate mask when freeing page tables. Retain the empty basic-mask
> check because filtering can leave no targets.
>
> This patch does not change when trimming is requested.
>
> Signed-off-by: Naman Jain <namjain@linux.microsoft.com>

[Severity: Low]
Since this fixes the regression introduced by 209954cbc7d0 ("x86/mm/tlb:
Update mm_cpumask lazily"), should the commit message include a Fixes tag?

  Fixes: 209954cbc7d0 ("x86/mm/tlb: Update mm_cpumask lazily")

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117091507.2088=
642-1-namjain@linux.microsoft.com?part=3D4

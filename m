Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2278A3F6C39;
	Tue,  4 Aug 2026 07:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785829128; cv=none; b=i6LQqNU2lrs+UUk4qgB/qhIUAgkZXtQVaOJp8UMnNFHMFcn8SWJ9E24s261HONedJsplJ2wbL7yEh6e3b/siC9gxtZ5WsUYDr/aCeydTtv5tntlJMS2xaxGODj5hsQjFEUbvuMO6VEMouTGa5ZwmjejuBVM6Zb/3sYtiS3ht8yE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785829128; c=relaxed/simple;
	bh=eeZjZ0YEJxuHnvpQAWe3JhbLBHDSFLGRIpHeQqAxtEo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=EXKMKF02V511Wv6pRjZopPyb5t83QKvc/HpdQ1RwUobpw3IQ5bwo9P3DUy7/7PmFvTCA51yKxcN5tN4Rk/NkEVcNx+RrPIHalIuOUFAhpeKaALW5pZPva+jIjGCm+qfg+LweD20FQL2iiLGLy4vmyqLooY2qSAfK9iL9kItoPLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LwbSPJcy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LwbSPJcy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A86D1F000E9;
	Tue,  4 Aug 2026 07:38:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785829126;
	bh=GWSxS7zYHSNecdXKKlD6sEBfI22Upm8rim3DcZ2RNqQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LwbSPJcyI4z5PqSH2kivv3/2Bh36gXPInPN353+CAYYi1lBJ5Mr4oLrQ0l5GhwT3J
	 vum/3kbPHvjcb6D0ILtqLillcFWbOI/jdLnKFrsoOA8d5cf/0McHKz108/T+D5gV/b
	 TCtvNrR0/dtn0tRykPti8PGWAX/8zSL/MavRo7ZcZ8uKKb1ZwZMiexRK9f2b1MiqW6
	 Md4ud5OLk2xbwg5tCkZM3rFY+DObyi2KfrioWZ0DD4VIP8WHzuEgxmaMarYPMDlm/L
	 Niql+wkALBOrHCYjk39RtL6/3Elr4oNRUionXeAVjYwqaJ7VYN6XWJfgZuABAT5noS
	 h1mgvzHCCywTA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 5/5] x86/paravirt: Trace contended_release on unlock
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dmitry Ilvokhin" <d@ilvokhin.com>
Cc: linux-hyperv@vger.kernel.org, kvm@vger.kernel.org
In-Reply-To: <17fa67f9fa4cf93f1150725e89f5f916e41a9b6f.1785778551.git.d@ilvokhin.com>
References: <cover.1785778551.git.d@ilvokhin.com>
 <17fa67f9fa4cf93f1150725e89f5f916e41a9b6f.1785778551.git.d@ilvokhin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 04 Aug 2026 07:38:45 +0000
Message-Id: <20260804073846.8A86D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Paravirt queued spinlocks unconditionally trace 'contended_relea=
se' when the tracepoint is enabled globally, ignoring the CONFIG_QUEUED_SPI=
NLOCKS_TRACE_CONTENDED_RELEASE opt-out.
--

--- Patch [5]: [PATCH 5/5] x86/paravirt: Trace contended_release on unlock =
---
commit 1a2ad2e72bd14437a21c720ae7476112bc7cb8d5
Author: Dmitry Ilvokhin <d@ilvokhin.com>

x86/paravirt: Trace contended_release on unlock

This commit introduces traced variants of paravirt spinlock unlock functions
to trace the contended_release event. It dynamically swaps the static call
target to point to these traced versions when the tracepoint is enabled,
keeping the disabled path zero-cost.

> diff --git a/arch/x86/kernel/paravirt-spinlocks.c b/arch/x86/kernel/parav=
irt-spinlocks.c
> index ddc19dc28ba16..ca12b36553074 100644
> --- a/arch/x86/kernel/paravirt-spinlocks.c
> +++ b/arch/x86/kernel/paravirt-spinlocks.c
[ ... ]
> +int arch_contended_release_trace_reg(void)
> +{
> +	void *cur =3D static_call_query(queued_spin_unlock);
> +
> +	if (cur =3D=3D __raw_callee_save___native_queued_spin_unlock)
> +		static_call_update(queued_spin_unlock,
> +				   __raw_callee_save_native_queued_spin_unlock_traced);
> +	else if (cur =3D=3D __raw_callee_save___pv_queued_spin_unlock)
> +		static_call_update(queued_spin_unlock,
> +				   __raw_callee_save_pv_queued_spin_unlock_traced);
> +	return 0;
> +}

[Severity: Medium]
Will arch_contended_release_trace_reg() unconditionally trace the paravirt
queued spinlocks when the tracepoint is enabled globally, even if the kernel
was built with CONFIG_QUEUED_SPINLOCKS_TRACE_CONTENDED_RELEASE=3Dn?

It looks like this registration callback swaps the static calls to the trac=
ed
variants without checking if spinlock tracing was explicitly opted out in t=
he
kernel configuration.

> +
> +void arch_contended_release_trace_unreg(void)
> +{
> +	void *cur =3D static_call_query(queued_spin_unlock);
> +
> +	if (cur =3D=3D __raw_callee_save_native_queued_spin_unlock_traced)
> +		static_call_update(queued_spin_unlock,
> +				   __raw_callee_save___native_queued_spin_unlock);
> +	else if (cur =3D=3D __raw_callee_save_pv_queued_spin_unlock_traced)
> +		static_call_update(queued_spin_unlock,
> +				   __raw_callee_save___pv_queued_spin_unlock);
>  }

[Severity: Medium]
Similarly, does arch_contended_release_trace_unreg() also need to check the
CONFIG_QUEUED_SPINLOCKS_TRACE_CONTENDED_RELEASE configuration?

Without a config guard, this manipulates the static calls when the tracepoi=
nt
is disabled globally, even if spinlock tracing was intentionally excluded
during the build.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1785778551.gi=
t.d@ilvokhin.com?part=3D5

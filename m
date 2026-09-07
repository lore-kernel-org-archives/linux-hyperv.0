Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B63A3406822;
	Mon,  7 Sep 2026 07:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788764453; cv=none; b=DJC/pnxsIm9PSH7nE/jIzUTlJqn+wVx619LF0H+0SzM7kg9VGzM6CvAsdrOpQjof0TUD70G3TBnqXvL8Sb3JNVUV3lCOoxr6Dfduv4NLpZiQ5p8zWPV4jdsFTwa5xYseMhVgzTkKv9DFRnClWLo2bEe+rC6mGT2HN5mSh1EQWh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788764453; c=relaxed/simple;
	bh=BFOG41tX+yoWX1wcO/VEfKHByl0odbw2vCjC6C3ucz8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Dp24zTb+mJdaENzqx3FxRIbVE3KlEAYDCoc0C5X/IF0ia3KLiE1drvDtfElhlzRe2S/RUhgNMEGu6Op/DwqifsMFf5fIMCj2u2iEz9Dc/cUByiEyMypPxQ85aChfeyMhlxK25yMeL0xzqT1yVQcMNX7Xh/MKXY1SAG+W48cyVCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T1zn+NWp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T1zn+NWp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CDC31F00A3A;
	Mon,  7 Sep 2026 07:00:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788764451;
	bh=BFOG41tX+yoWX1wcO/VEfKHByl0odbw2vCjC6C3ucz8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=T1zn+NWpgzC61X6w7QObzZlGmoGehYooVXwWEkHgVwnpVes0onuxsoWOknpeh/aCW
	 YgHlIgM88k2bbUO85mc1pVU5B3e92I8i+I3u3B+R3AhUsJuXE7VhtFegTZe8yGfRKb
	 stDs/KotQA1gpF/wCCs/3YP9Io5/ip3PjWU76/Q/3mjmHKEQ6XHwUrDvHwXfezdbTz
	 ScA/zGpnZiBpq/WA4vUq7d7DakNJY5mh39pdHRFzkQ07KPc7+RivgNrfnrWW4C/DbS
	 O1yWuoChdLWDRbm86F8RTeeJdVZtx7MIEvEYKn8VpRNl0CUJygE9nFqkiQ6wlzGrof
	 dW8vz9XRMSg+g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/3] x86/irq: Fall back to
 irq_chip_retrigger_hierarchy() in fixup_irqs()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Naman Jain" <namjain@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260907065129.269262-3-namjain@linux.microsoft.com>
References: <20260907065129.269262-1-namjain@linux.microsoft.com>
 <20260907065129.269262-3-namjain@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 07 Sep 2026 07:00:50 +0000
Message-Id: <20260907070051.0CDC31F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

> fixup_irqs() re-injects a pending interrupt on its new target CPU by
> looking at the outermost domain chip and invoking its irq_retrigger()
> callback directly. When the outermost chip does not implement
> irq_retrigger(), the pending interrupt is silently dropped, which can
> lead to lost interrupts on CPU hot-unplug.
>=20
> Keep calling the outermost chip's irq_retrigger() when it is present,
> but fall back to irq_chip_retrigger_hierarchy() otherwise, which walks
> up the interrupt hierarchy until it finds a chip that implements
> irq_retrigger().
>=20
> While at it, use a scoped guard for desc->lock. VECTOR_RETRIGGERED is
> now set only when the retrigger succeeds instead of unconditionally,
> which is harmless today since apic_retrigger_irq() always returns 1.
>=20
> Suggested-by: Thomas Gleixner <tglx@kernel.org>
> Reviewed-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
> Signed-off-by: Naman Jain <namjain@linux.microsoft.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260907065129.2692=
62-1-namjain@linux.microsoft.com?part=3D2


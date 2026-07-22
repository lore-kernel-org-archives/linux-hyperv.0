Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AD7F33ADA3;
	Wed, 22 Jul 2026 23:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784762528; cv=none; b=eEhMXc5tgeKm8iB3ytFeU4LUwNMOntwKNYnsKYj+gwv1gjPh1fJ6hFr5bRPprgRYuXOfH+mS8wffxaMcDfWVJKOvT3wG1xiAfGB1UYLbjR2wlypj/70PI12om5IJNCV44SbZB3WHrv6oRk7NdokP3v99v3f7+ufOr9pPxDFYAMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784762528; c=relaxed/simple;
	bh=43H+KKmpK6uoxVlUxy8N9Und1o/MvCDa0g3h0MIXWOw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bCMMsV2Scnx/r4Ij/8S32KuVTr0pRCTiUY59icU7Svbkrlw/5N2EToMjtBN72BIFy0yuKAOdRWMeR42wEErzmNqmCuRbNlawzxkNUjiekn3UxVJJ0K5ue6WBgjXxTA5eTEB7sY+MbGDKf0l0WTS3eIf/NCqoH5KTRBPVs/SzjO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FXuasIg9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FXuasIg9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F08BB1F000E9;
	Wed, 22 Jul 2026 23:22:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784762527;
	bh=sPVHij/+2N1V87sIfDQGRTX48N9ZP1hIViXC6cb3Ib8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=FXuasIg9ZPhKM+HI3zh8peg3df48ux73yKHK6k6Zm2kpBL9XP4dpTjXaj9U4uK1UM
	 yAkHeez2xK5IV8hTBSd+I19dTFELGGkdmQjPGi91Y6oe+0bwPGDEHfN+KpSbC4Ywi+
	 12D0tpVT9EWilwceb7XI0iYVfxaepkRTyrCDOeEKJNwFjjwEkZTMjr6JJd8yFI/FBR
	 oww/bN7oMGAZjNXwKss3SOZhMr3TpapZ1J/MroELA7o5WKBrVMhP5IIn7h3Pnci8Zr
	 AjzUJpia/7lOabwSVBJWfXo93dYa+U0nqnhsGYYUNsd5WHUucaC3yaUQFQicft8S1x
	 mPHsYWoLxDUCQ==
Date: Wed, 22 Jul 2026 16:22:05 -0700
From: Wei Liu <wei.liu@kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-hyperv@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Dexuan Cui <decui@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Jan Kiszka <jan.kiszka@siemens.com>, Long Li <longli@microsoft.com>,
	Michael Kelley <mhklinux@outlook.com>, Wei Liu <wei.liu@kernel.org>
Subject: Re: [PATCH v2 0/2] Drivers: hv: vmbus: Small cleanups
Message-ID: <20260722232205.GG2020652@liuwe-devbox-debian-v2.local>
References: <20260721153216.382536-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260721153216.382536-1-bigeasy@linutronix.de>

On Tue, Jul 21, 2026 at 05:32:14PM +0200, Sebastian Andrzej Siewior wrote:
> Replacing the lockdep_hardirq_threaded() annotation which does not
> belong in drivers and removing the vmbus_irq_initialized which seems
> redundant.
> 
> v1…v2: https://lore.kernel.org/all/20260401151517.1743555-1-bigeasy@linutronix.de/
>   - Added a comment next to the invocation of __vmbus_isr()
>   - Added the "Drivers:" prefix to the subject line
> 
> Sebastian Andrzej Siewior (2):
>   Drivers: hv: vmbus: Replace lockdep_hardirq_threaded() with lockdep
>     annotation
>   Drivers: hv: vmbus: Remove vmbus_irq_initialized
> 

Applied. Thanks.

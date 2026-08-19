Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F524430305;
	Wed, 19 Aug 2026 10:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787136126; cv=none; b=vBudvNmuc+iUWX3n8tBJZNqGU6/7WpI2aLgR4zK6zewGcLaClePACsxwBMTEyBCOdl8KUR7Bg2RbBW7dlJB9+POnIsmVoJcLPMywlGmPscLewQFdb4CuXQC2gVpZ82oYn7pUb034B7Oj2kdkzEpu6VjoueWrGgTBZxa4RR6RcBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787136126; c=relaxed/simple;
	bh=5TFnR25BvBdgQ2g/toKw8fCJ9sueF9LRHd0wMjCBdNI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tWTWQ6jKYWuUkJnd2SZklb9BEIRBj8RnB38R8o93gqQUI4qcCzWy5GzhLOno+VpKsafXvGOFxgofg0mpvGKd8H23P0YavdyLCcp+VaVjZ+/h6v+Rjr3vITqp9A1+4Kcxpu6woLdHhirSv+prEdJRvfDQn0uw8QGwxtn82xlgN50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hjADkH+Q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hjADkH+Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CDBB1F000E9;
	Wed, 19 Aug 2026 10:41:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787136119;
	bh=5TFnR25BvBdgQ2g/toKw8fCJ9sueF9LRHd0wMjCBdNI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hjADkH+QqDM1IP00zU9bJYyNfi1xU7i7FPOP4RYQ2vEaDzQ44lt6p64vyi5Yzb9pF
	 X1THeMOkO72zBMdRZ6v0G+x1H+M/JMpCHa1sQKDNM6z7sLIIAk7zDSD9t1BIec21AR
	 v38zC0oPVqzZc5imeck8g1YTiTg9lmUJ9c1miwdMYOlJQxf2nM1jA59sJcPr/R9qjM
	 xraJXYXPFmffYFS/P8d90G9b77NznKcQVUsc1EqIcn0nCxq3NVHZTuNNLOZoPZAdqu
	 TPMsIfuahH2p3Vb4aODcV1ctsKF0p9CF6NxGP7oGgEWvP6RgekqA0/AFyLnP1Ij0Gw
	 u/COt1tc6kZWA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 13/13] x86/msr: Simplify some rdmsrq() use cases
Reply-To: sashiko-reviews@lists.linux.dev
To: "Juergen Gross" <jgross@suse.com>
Cc: kvm@vger.kernel.org, linux-hyperv@vger.kernel.org, linux-perf-users@vger.kernel.org
In-Reply-To: <20260819102314.1499258-14-jgross@suse.com>
References: <20260819102314.1499258-1-jgross@suse.com>
 <20260819102314.1499258-14-jgross@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 19 Aug 2026 10:41:59 +0000
Message-Id: <20260819104159.9CDBB1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

> After the conversion of rdmsrq() to an inline function some use cases
> can be simplified by dropping an intermediate variable.
>=20
> Signed-off-by: Juergen Gross <jgross@suse.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260819102314.1499=
258-1-jgross@suse.com?part=3D13


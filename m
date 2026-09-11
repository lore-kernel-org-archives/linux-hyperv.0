Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 532A2457E49;
	Fri, 11 Sep 2026 07:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789113405; cv=none; b=IAGZRt6xLSn2Q+D7kArA+dzOjDPiWtFFQRScBOc4sx7L0kM6CH9WU7+avt3eORcHcWkcXsZ09/d4cKtsv/XDiKTrT6yYQnN1Qf03IWcMJaqQop0xlHpL6Vc8wjlKWtQTV5rCgR3Doll//QsT1BBTe1uEkjYYX66XguRV8sGXq3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789113405; c=relaxed/simple;
	bh=+jH46SCHQXwO/0TpEgVtdrceCiq3XHkzF0OX2oGZ+vQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WH7QOUGjSdin9xCgjC039n8ERATw0kDM44VnMNMn2W8QCd9qqEPkfmGpYtIuIQ26wE0ocsJRsM4Ghb4ag67R3Sr2tOJbDemFzkkzK40Kicr6rDWGJVvZdFU2m+UlBALoqjd5CsNkpGGg/q4926+3mwn6JBNdvTbpDcDukbXdVyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CeRP6umq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CeRP6umq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7B001F000FF;
	Fri, 11 Sep 2026 07:56:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789113402;
	bh=+jH46SCHQXwO/0TpEgVtdrceCiq3XHkzF0OX2oGZ+vQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CeRP6umqL3OChNxbMh/son03qUdnwOaZbzzYj6raQRKEb8J9g4YQozPUuwPADnX43
	 AFaIqktTbLw0L9XvfAWG5tQ7lvssFMIF7EBbOahUne7KOJ9ZhhHQqOz65Vrk6RfMIy
	 mEfI/0zklF+aQP59QCNcoxUvat0uCtvrCKSBw/vESABcI8p25sl/vh/d2rKwL6XWY3
	 +6y3CMHCBkU+73Yt6WOEO1nxVJLK2N6GGqzeIuTSxid6+iqPZ0s4hRw98Xsg4tkoDH
	 tNKnYbpWnDFSCmsO+bJTy+slirX+OKNXjFWC90kPQF9G9MuYwS2uSXk+M5z+LE2hB0
	 +gH0y2Cg73WSg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 13/13] x86/msr: Simplify some rdmsrq() use cases
Reply-To: sashiko-reviews@lists.linux.dev
To: "Juergen Gross" <jgross@suse.com>
Cc: kvm@vger.kernel.org, linux-hyperv@vger.kernel.org, linux-perf-users@vger.kernel.org
In-Reply-To: <20260911074530.3140830-14-jgross@suse.com>
References: <20260911074530.3140830-1-jgross@suse.com>
 <20260911074530.3140830-14-jgross@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 07:56:41 +0000
Message-Id: <20260911075641.C7B001F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

> After the conversion of rdmsrq() to an inline function some use cases
> can be simplified by dropping an intermediate variable or by
> eliminating the inline function completely.
>=20
> Signed-off-by: Juergen Gross <jgross@suse.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260911074530.3140=
830-1-jgross@suse.com?part=3D13


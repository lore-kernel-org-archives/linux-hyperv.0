Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8DAF3FB04E;
	Thu,  8 Oct 2026 07:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791444683; cv=none; b=rzwQAF6MpxwwsWpXKEG2Yg8PEWgAMbOU7rF/zgf03PI8YWW9Si5z8VrAGtzUYpRtaj2oEi7tf2nFBmsqo+Cpfxjc7XwKR5k9wzROPRvoUNWb/3isvKtcw6hiDSIkDfMMafDTGfeEhXMPdjf6gOC1xXZnI12fp8tmB/bicI4pqmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791444683; c=relaxed/simple;
	bh=6Gx+LMzB+YQ7SWAwZAyRRROvAjOCrsC7IzfNxN8iGt0=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=F0C3NFsVLe97Ec0U9SEt5vHFYAP3r5AsSv/FWrYyRKhBRAM4xaoFNGvlkrksOwoBlhhWgZIikobuGP+KM01MU2lpIGs+uX9SfOf/l1+bc701VBvJTSuZcK9FlEaNLBltttgUsz00UeJu/ybbG4OFxlKotOFvZBNROYDixP8c2xI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SBLzg+eS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SBLzg+eS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C75C51F000FF;
	Thu,  8 Oct 2026 07:31:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791444678;
	bh=6Gx+LMzB+YQ7SWAwZAyRRROvAjOCrsC7IzfNxN8iGt0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SBLzg+eSn/nXWdb5Gib0xEwa4IoMWuc+U7S8WZtl9hGh5FV7h65HTMBjBI6csuOvZ
	 T/UxEU+nABRLyisgAb0ztaZeGXs3VxnvLjwwicjBKZDbFREVEDeWhv9QI3ad0E/dvC
	 89zO/5Ld8FXAMUe7fRXq2+EcNrQQx9CcgNdms10JNsqiq+Bq20IhkHeyPur++OBnlR
	 0AwOlCYLmUvFrdHUPhG0lyLACnDGAl3JGIavGb4papZ5rPAEbf1H0kb2yMIi/vukMt
	 x88kyVg2cOVsYF7yQmJ4KQswyjsIuYGR6DvG9hV227HjGfPdZdJBgzmyMulI6f7+/O
	 WhfCZrQE1U1gQ==
Message-ID: <sashiko-outbox-163764@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 13/13] x86/msr: Simplify some rdmsrq() use cases
Reply-To: sashiko-reviews@lists.linux.dev
To: "Juergen Gross" <jgross@suse.com>
Cc: kvm@vger.kernel.org, linux-perf-users@vger.kernel.org, linux-hyperv@vger.kernel.org
In-Reply-To: <20261008071839.2247074-14-jgross@suse.com>
References: <20261008071839.2247074-1-jgross@suse.com>
 <20261008071839.2247074-14-jgross@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 08 Oct 2026 07:31:17 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261008071839.2247=
074-1-jgross@suse.com?part=3D13


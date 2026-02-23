Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD79434D3B8
	for <linux-hyperv@vger.kernel.org>; Mon, 23 Feb 2026 09:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771838747; cv=none; b=jGvI6d190jhkXdw1e0zxN1D7qtLpDKvzBatHlKgCZYcR8PNLAGFnyTFa9yiK759qv7hxz9sekSUgkl2XQ5mobjTNQYNYPNw0EPZtzsQD0ex7fwhhxba+4xbkelNaHVGDtAVHnlA0eTbJ6KYMjwUyn0za9JTrJi5F7fe+ANDHKNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771838747; c=relaxed/simple;
	bh=5QIF4M53izuNtsmGswVWqyvCsRe0tA47V+jCPS605bs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ufa5O+GFq0pUwtYhaXIMJ2J2phqc0ob1BtSQwAMWLim8sV1J9GgPuDkTKgjurYQ3wa5hI4sOdJBHjGsggsUn8S+vnz8bZpHGmHk64fLITItb1LIfeyxbz0C/gvzdOFCHui5bXDSQ87ex/jNw637a84hVg+9fi4KEJmYvfik1eHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=AcRaMYXo; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="AcRaMYXo"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 46ADD4E41030;
	Mon, 23 Feb 2026 09:25:44 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 190EA5FD43;
	Mon, 23 Feb 2026 09:25:44 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 19415103686FA;
	Mon, 23 Feb 2026 10:25:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1771838743; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=5QIF4M53izuNtsmGswVWqyvCsRe0tA47V+jCPS605bs=;
	b=AcRaMYXo+S1r7u+Fc8nNxzkEuvY3eLKn0agBAwXR+fTOMpzu/hYsmspVCGsHBAFuymFuWb
	pz6wCq7c/Pa8IWxpk/qIa+cxYOZpFQDHR6GS9hL7Kb7hK0uYd5U/Dh5BrjN0ov1GRUiMxn
	3ejzl81Bq1B8DLsKawpqFDhCU0S76e1ezBlCpK+CO6A1xbNk6Tux0of/1OQSLn8QG/SMfI
	ngvFVTKNq8NtZk0+uaxqD9ivVV8+kE4mfD2qsdVaWAskZd5Ff1SrDDO058xNoq6oywRGRk
	W81YqS/s9PtzTEMTGaYz91HfsudQLb12JcbaphXPwsV6afQy2xrIbje+RmTjhw==
Date: Mon, 23 Feb 2026 10:25:34 +0100
From: Kory Maincent <kory.maincent@bootlin.com>
To: Haiyang Zhang <haiyangz@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org, netdev@vger.kernel.org, Andrew Lunn
 <andrew@lunn.ch>, Jakub Kicinski <kuba@kernel.org>, Donald Hunter
 <donald.hunter@gmail.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
 <skhan@linuxfoundation.org>, Gal Pressman <gal@nvidia.com>, Oleksij Rempel
 <o.rempel@pengutronix.de>, Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 haiyangz@microsoft.com, paulros@microsoft.com
Subject: Re: [PATCH net-next] net: ethtool: add COALESCE_RX_CQE_FRAMES/NSECS
 parameters
Message-ID: <20260223102534.0a87ed4c@kmaincent-XPS-13-7390>
In-Reply-To: <20260222212328.736628-1-haiyangz@linux.microsoft.com>
References: <20260222212328.736628-1-haiyangz@linux.microsoft.com>
Organization: bootlin
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

On Sun, 22 Feb 2026 13:23:17 -0800
Haiyang Zhang <haiyangz@linux.microsoft.com> wrote:

> From: Haiyang Zhang <haiyangz@microsoft.com>
>=20
> Add two parameters for drivers supporting Rx CQE Coalescing.
>=20
> ETHTOOL_A_COALESCE_RX_CQE_FRAMES:
> Maximum number of frames that can be coalesced into a CQE.
>=20
> ETHTOOL_A_COALESCE_RX_CQE_NSECS:
> Time out value in nanoseconds after the first packet arrival in a
> coalesced CQE to be sent.
>=20
> Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>

You send this patch one day before the official reopening of net-next.
Not sure if this will be taken into account by patchwork.
Else:
Reviewed-by: Kory Maincent <kory.maincent@bootlin.com>

Thank you!
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

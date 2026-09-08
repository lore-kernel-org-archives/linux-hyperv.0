Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21B5B52D2A1;
	Tue,  8 Sep 2026 11:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788867512; cv=none; b=cWzDFU1kwEetkO8edpT1SBb3S5mhMoWMFtjZXAnsz8li/Kav0gsF0A1nbRVrFXdje+IdteROtNiiFdRFgmhzpSRG0roHDijaOlOv7jWkUzYEEcW4dHyMPdlpM8gxP5i3KjvfzvZI0eHT2vP6kJfAwj3Z0dhGmyFgaOV9R6Wi35c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788867512; c=relaxed/simple;
	bh=14cN6VB6dyLgCS2z/TieCcvZEIdFDmdVLU9P41dMTqQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jyfhpNTxNBA6oVlvJFnhfHOcDwwsfK6alg7UqMsXFSTbBP8xETZW72rRp4Hgp0GCoRQ5+JocEovNboeEFnjp+/yxPXpzS3d5qSfjqlLLcdxquU87QfEpX2hd016/1zsszOu9rWSyR50bTlmMqyIwEuvRXmlzJ5r+7rI+rKoeydQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SSMVzYKl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SSMVzYKl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82BB91F00A3D;
	Tue,  8 Sep 2026 11:38:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788867502;
	bh=14cN6VB6dyLgCS2z/TieCcvZEIdFDmdVLU9P41dMTqQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SSMVzYKlcLmtq+/H7E/fKmhkMSL4qq2f8IF/69kNrFsRWlYOrDiB6Z0UW9Kyapg/o
	 nSleU/u+zIN7oFKrkTvo+fWJZddNfP7dcmlWAK9dG3CXggrS20f02SSO4/uE9cHq7V
	 17o7SRhtjyAKngRISd+6ADCPL+qi4loceD3XIYSHyy2RtRsfM83y2qLCZjf9p2fpeN
	 Mj2Jlt1jbEZRW7cbwkfvQPuFaawSjv6WLOjVJiCSYkL2lixdEPScASTakOZ9PYpGsA
	 t4suSQ9q0T8hKC/n1PPpyzsDnnUfePRyo2ioqf7MJx8SuGaIq0+k5S9ZeWEFfsJQOq
	 ZD7troXPgGplg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] PCI: hv: Warn when wait_for_response() waits
 indefinitely
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sahil Chandna" <sahilchandna@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260908113009.3005964-1-sahilchandna@linux.microsoft.com>
References: <20260908113009.3005964-1-sahilchandna@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 11:38:22 +0000
Message-Id: <20260908113822.82BB91F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

> A guest can wait indefinitely in wait_for_response() for the host to
> send either a rescind message or a packet completion. If the
> host does not send either, the guest can remain blocked with no
> diagnostic indicating a reason.
> This was observed during a guest kernel upgrade in which the
> host-side application handling the PCI channel faulted, causing the
> guest to never receive the completion request.
> Add a warning in wait_for_response() when the wait exceeds
> a timeout so that such a hang is visible in the guest's kernel log
> and can be correlated with host-side state.
>=20
> Suggested-by: Michael Kelley <mhklinux@outlook.com>
> Signed-off-by: Sahil Chandna <sahilchandna@linux.microsoft.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260908113009.3005=
964-1-sahilchandna@linux.microsoft.com?part=3D1


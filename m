Return-Path: <SRS0=Kt8c=UX=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3FFCC48BE4
	for <linux-hyperv@archiver.kernel.org>; Mon, 24 Jun 2019 02:47:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD29E20652
	for <linux-hyperv@archiver.kernel.org>; Mon, 24 Jun 2019 02:47:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="STw7GXtd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727260AbfFXCr1 (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Sun, 23 Jun 2019 22:47:27 -0400
Received: from ozlabs.org ([203.11.71.1]:39711 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727239AbfFXCr0 (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Sun, 23 Jun 2019 22:47:26 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45X5sS035Qz9s7h;
        Mon, 24 Jun 2019 07:58:35 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1561327121;
        bh=OEzrTpMB7aWMwD/2sS5vZldGTePP04H0y9EeyaLzovc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=STw7GXtdl0hhKZc7avfNGQZx8rjA2X4imUkcFt/0Xu83toQpsqKVjKCQXMHBai2f0
         qbBHXM/MCOz3fVJ7rNM/Wb2oHZfWbYtRCCc/4X4LgFqXlK9V5WlxvXxPLx9OPxsm7z
         55mtFkcA7IYAGWZXVhWGTZ9gqYXYnlgz5A/UARAcW1kEWWON76Mu9gyMagsKrLaaep
         Cu7z/0WcoztngBuqPWNlkbEcOKlDNWDHC5QBiIPl69aLQde3WfZq3+ITIUGaTpIcVH
         cP38mBIcP0BVFLC++foZruiHor0YAMOzUyGUOCGVReL4fch6yyq6tK3wqamP01pjIM
         ieWL9SnCN88nA==
Date:   Mon, 24 Jun 2019 07:58:34 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Sasha Levin <sashal@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Michael Kelley <mikelley@microsoft.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Mark Salyzyn <salyzyn@android.com>,
        Peter Collingbourne <pcc@google.com>,
        Shuah Khan <shuah@kernel.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Huw Davies <huw@codeweavers.com>, linux-hyperv@vger.kernel.org,
        Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v6 18/19] x86: Add support for generic vDSO
Message-ID: <20190624075834.2491a61a@canb.auug.org.au>
In-Reply-To: <20190623190929.GL2226@sasha-vm>
References: <20190530141531.43462-1-vincenzo.frascino@arm.com>
        <20190530141531.43462-19-vincenzo.frascino@arm.com>
        <BYAPR21MB1221D54FCEC97509EEF7395CD7180@BYAPR21MB1221.namprd21.prod.outlook.com>
        <alpine.DEB.2.21.1906141313150.1722@nanos.tec.linutronix.de>
        <20190614211710.GQ1513@sasha-vm>
        <alpine.DEB.2.21.1906221542270.5503@nanos.tec.linutronix.de>
        <20190623190929.GL2226@sasha-vm>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/CR.if9_1Fi5MEdkDk1BLyhb"; protocol="application/pgp-signature"
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

--Sig_/CR.if9_1Fi5MEdkDk1BLyhb
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Sasha,

On Sun, 23 Jun 2019 15:09:29 -0400 Sasha Levin <sashal@kernel.org> wrote:
>
> Appologies about this. I ended up with way more travel than I would have
> liked (writing this from an airport). I've reset our hyperv-next branch
> to remove these 3 commits until we figure this out.

But not pushed out, yet?

--=20
Cheers,
Stephen Rothwell

--Sig_/CR.if9_1Fi5MEdkDk1BLyhb
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0P9goACgkQAVBC80lX
0GyfOQf+KDEXgXOC5E+iMk6d4D73wD02MBcwff9B0zoCSHO7wBwHMfcazt0CBgJn
kDTyqzDFLcuCIPrA89xcZybdoNMg4aIooHEbEzdjaXFpm/Fs7d+jo+KVC0CoYEw5
pqOio0r0q85NiYk6eENxVa+j+yfmvnxKcVJO5s+T2ifWbWq06fhziMUkf3ZEytHl
1n48f9Hc2L5Zp4SoYWSF27Ro4Mo0H9aUH7RPvlt1tZkHN0OdfRS3NR84FN+w+KVU
TZpFLuislCHo8QKh/5OMv1AxaWP/RX2vJael9DguO+6hZyYBglxTK6+E1IIYe9C/
h0h8OPDTSELsQJmcd9Mda8F4vKV6qA==
=/eNi
-----END PGP SIGNATURE-----

--Sig_/CR.if9_1Fi5MEdkDk1BLyhb--

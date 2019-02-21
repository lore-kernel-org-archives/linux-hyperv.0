Return-Path: <SRS0=8B77=Q4=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74031C43381
	for <linux-hyperv@archiver.kernel.org>; Thu, 21 Feb 2019 16:16:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B50D20836
	for <linux-hyperv@archiver.kernel.org>; Thu, 21 Feb 2019 16:16:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550765789;
	bh=v9xDVUBTK08QUQcXTR6Pr8Nz7zXjlzQy9pXFj77RKQg=;
	h=Date:From:To:Subject:List-ID:From;
	b=idP9+LXtgEzgYJ0CNM0ph677bLtD+QIzk60tN8unOBeFrPjqeq2H4jrMaBKddOPwC
	 PmRTTJh96FBlehW2UYMn1ExjFlwza0D2OAg8sMWUMG83mZTZbr+QgVTazxxMTu4+ht
	 0FS/APwARjGjUIwpEmvbMRHhW0HQzYbdl5Ce20e4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725932AbfBUQQ3 (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Thu, 21 Feb 2019 11:16:29 -0500
Received: from mail-it1-f177.google.com ([209.85.166.177]:54961 "EHLO
        mail-it1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725943AbfBUQQ2 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 21 Feb 2019 11:16:28 -0500
Received: by mail-it1-f177.google.com with SMTP id f10so23200228ita.4
        for <linux-hyperv@vger.kernel.org>; Thu, 21 Feb 2019 08:16:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=v9xDVUBTK08QUQcXTR6Pr8Nz7zXjlzQy9pXFj77RKQg=;
        b=ToP4EYTaPzgjeuJjIUkXkZrzO8ZqtbR3iI9MPbkH7B5EkQ/7LdIb9N6Ga8rbEp6mcP
         iI3J4VzwLQ2jWFsj+sSK2RXOFBTs5mnkaONUq5KzAxO4kpaW9GWu/2kuBbkS3XqR/vtN
         lhJUiML3dL1EvbQzNgHMRV3ag+9nyXtgEb2YE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=v9xDVUBTK08QUQcXTR6Pr8Nz7zXjlzQy9pXFj77RKQg=;
        b=qonoPk6HERhuflEpiODIjdCQA9n428gdPYYgRA+OvFKNfV+8UcBUlHx4LuKZQdboF2
         8IQfCIDF2DcE9vVRqfyi7Xsp4fqXPxJhsXVWW5fZVH8Jagos4LWYEh0reCUiQrlv9CJd
         Z+v6udU1O1KdWpSFWFNbXnuh5wonEXiA2d0U8LWyjt7IXfJqFK5V+81DD1jDB6lp73gi
         Qdv6e07CmFUsXUlBrcTKBM6ReoEgRYzO33fLYZtpHvyHnvNbAneMCIQ/V2meWDL9LmsK
         J8gEfpon3saqh2LNLynOUsHzdxWt6HHkMN1mTk9Odx+t5/MCMiTEAaQwV9zCi7ihMuWa
         Id8w==
X-Gm-Message-State: AHQUAuZo8eBSU3famhWxt9Ruj1rGwximAEZF9QmWizTm44NKMOMDD7ZR
        TyHcSMUNeuaJA54jxPE1N3HvJ4EdD7Y49Q==
X-Google-Smtp-Source: AHgI3IYBWApmzu9YB03tIWgRihwxvOq8D/sjAm0PBw5BnNXwBQQxYD3Vtg4g7uuuM7t8//Hokc4weA==
X-Received: by 2002:a24:3acc:: with SMTP id m195mr3370031itm.38.1550765787653;
        Thu, 21 Feb 2019 08:16:27 -0800 (PST)
Received: from chatter.qube.local ([199.66.90.113])
        by smtp.gmail.com with ESMTPSA id t69sm4335192itb.26.2019.02.21.08.16.26
        for <linux-hyperv@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Feb 2019 08:16:26 -0800 (PST)
Date:   Thu, 21 Feb 2019 11:16:24 -0500
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     linux-hyperv@vger.kernel.org
Subject: Testing delivery to lore.kernel.org
Message-ID: <20190221161624.GA7492@chatter.qube.local>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="zhXaljGHf11kAtnf"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org


--zhXaljGHf11kAtnf
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

This is a test for delivering to lore.kernel.org/linux-hyperv. It is a=20
required step for initializing empty archives. Please ignore.

-K

--zhXaljGHf11kAtnf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQR2vl2yUnHhSB5njDW2xBzjVmSZbAUCXG7O2AAKCRC2xBzjVmSZ
bGcSAQCZXQidgC+R9UKbWZlXq1U/YdOwmYOlrYRBRmlHJwPbGQEAki6IPagZ/g36
6kh9NibTufjwk9s+G8JEE+PNB2gy+QA=
=cB/B
-----END PGP SIGNATURE-----

--zhXaljGHf11kAtnf--

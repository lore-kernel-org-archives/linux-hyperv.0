Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.144
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794491878;
	b=BiMVUCLvJyPmoiHZ8PW3Xs2MPUySDh3Ren+Rggb4bz02cmqNv/34dGOUv+DBgt4yvcsJ
	 tU4afVE031njJDicOoUeOY4llExnEnWpobLFL6PtyrwiTqJwFl9ba/XaztCMr10qNfWD5
	 tQDS46rso6Nv96JLRYBH1ovpYA35QgshqIVG48diNsVsx3zokcU1KYE54+EBQga9zmXv5
	 1qkfkssGceX4ktYxfKJUzPlPXNYDU/GO3dGsxTcFmZFRjOE4/lqyQX5M22hy1g+6gs2Qs
	 MB+qgXCv3WfuysuaRinuF2ud1L6m8ccHKD72cB+QyEXiGq6xfVLs9BlqbXPZnDapMVg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794491878;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:X-Mailer:
	 MIME-Version:X-ThreadId:Date:From:To:Cc:Message-Id:In-Reply-To:
	 References:Subject:Content-Type:Content-Transfer-Encoding;
	bh=eoVPrBJ4tURN+QM6vq2ZTCOjSmSxNf9fZYcJKAVOqpU=;
	b=sHPPm0c9nPqqKEDxl5wEI1om7nB0ZcZlLoaVh0HstqVPCP3yS1wFQObZVdq/fuZrTxym
	 30zIAfyS511BLays8lK41ytfWc0O8T39Txe7RGBX8iNIfkWuQTFqT2GP2794J1ON8ViK/
	 l0jW4TFwFTsFoYbOA71rzifx+1UL/jTQtlCqwF0Xdh/SX2XP0zTYjPhZ31ZZQw2gEofjr
	 iG2HEmENs3H91VfV0QwEbQeIqTdQHn/xWaD78RQdiAJQl4gIcWh/fBMVU5/bWmr2aJI1b
	 eFyv7WxcZsuR8Dov6Rk4BKpdsmZ30pboQqR+SXO+XTcKV/kPk3RYnlrvO9tM1fb9FQg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arndb.de;
	spf=pass smtp.mailfrom=arndb.de;
	dkim=pass header.d=arndb.de header.i=@arndb.de header.a=rsa-sha256 header.s=fm2 header.b=UZHTSMBm;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b="w3I/NPyn";
	arc=none smtp.remote-ip=202.12.124.144
Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 119F9606A886
	for <linux-hyperv@vger.kernel.org>; Thu, 12 Nov 2026 13:57:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 119F9606A886
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=arndb.de header.i=@arndb.de header.a=rsa-sha256 header.s=fm2 header.b=UZHTSMBm;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=w3I/NPyn
Received: from ams-compute-02.internal (ams-compute-02.internal [10.64.2.62])
	by mailfout.stl.internal (Postfix) with ESMTP id 4D97B1D00095
	for <linux-hyperv@vger.kernel.org>; Thu, 12 Nov 2026 08:57:57 -0500 (EST)
Received: from ams-imap-03 ([10.64.2.23])
  by ams-compute-02.internal (MEProxy); Thu, 12 Nov 2026 08:57:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1794491864;
	 x=1794578264; bh=eoVPrBJ4tURN+QM6vq2ZTCOjSmSxNf9fZYcJKAVOqpU=; b=
	UZHTSMBmiNlLbeyzJSM31bww8ECg7DYP3ME/gIcumSkeq4tA+lhhl/mI191u5LRo
	l0vTQsRmmnZp0mgNoXwv1bx+Tk/L8WLAvkF7YJ5q4i/qNLgqeWU0cQIkN+LtMIQd
	GZ6jDNI5x87tcxUATqr6xe4hfQkbgzUOtAjJqwS54TnRRosu1tc/9auKlOAsoObg
	BwB+9W/80/pIaHjBi+nk2zqVyd9ghALWfQAGTOCbRuo5UirR5ztH/mpRo1WsM1PV
	JXE62YUDioTj3nV6fzAQhDsIWF+MfqOL2scFNDzErj1ZB/p1KoeTKHsoV+zY3X6V
	lGUHJ9mVecGcJV4LYIuErA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1794491864; x=
	1794578264; bh=eoVPrBJ4tURN+QM6vq2ZTCOjSmSxNf9fZYcJKAVOqpU=; b=w
	3I/NPyn+0b9ox+whIlNKVZfmVgXjZSFlgoy2pipfU9rRluX6oUSlOqvOAv25QGws
	F62OpHF1qc8cKKxSSReVPv+tg/jXh6jQu8zPOqIfqUfrA70bwowX8G13ex3RC802
	UbUnotIhhPa63ZADYTv9R19vyTf4IeHywI0+YOVE7RNBdGZbibmgwZQ+gFyM5oJ8
	9FNW+1TUbTQXvEgtwRId2tZEO0BoLaFWCbbxVqGM4sr+kmOUiQoPk8Lp6wP+aPTT
	0+AVHMoQ3oRc3gHRLJy+OxYjKNldYotlz2Hm+jo8C4Luz5uI5RTkECva6Yya8o9N
	b0gud2jh5WTA3JFMxFvPw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=arndb.de a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794491864; d=arndb.de;
	mf=PGFybmRAYXJuZGIuZGU+;
	rt=PGxpbnV4LWh5cGVydkB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:GDlLvBaznQ5iehXLrj+Hs8aVr4e9OEJRmSBwTkB90UNhiqK
	+CfpKmV4d7NK/5izTE7Ws0PwugqvK2Ubww6nEHrh0eoE6RhxvIrxyv+6kthA9ipj
	9uvAGnDcHHPB51VYMFJuPbUXoBKSkPOl3EB6ZEINkLdPaLej37zo6RmBKYkFTaQg
	RGF95chZbXYu6VURJ8uh2Sxa4o6it66fJfyIBeUc6ipjLwfMRJDVD9X2hmYig3gW
	Po+idoU/b/MJ8fJJP/YXJhvM6wrL9nn9jOsIt0iUos055pyIsjGUv6LDOQSRJzq0
	1+t4/D5suVOGrYj2RmLALzSqB4msDmJTCeKiXLg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:zEYnVMaStdy6u3NueFvbJ+hBxgS6XKa9u1fwlhczQCc=:R0gQaAeNfKNVjeBHZqL7VomuTg+ilakhZNJ0xy34LrI=;
X-ME-Sender: <xms:0cX1ajusonkUhQR5zeGCA3kQeL7A-s496JdRBeES9UIUvmns2OBZwQ>
    <xme:0cX1avQq87z7x13sx9_SKrij6gto_cwSMOwV-gFxTo9iK0uOcUpCbLKf1A2dVhc_k
    Ku2mUSK8GyRJVOI7e_9bOXkckT1oLKi8BGFa1lIm3M0e2YrKtX_zal3>
X-ME-Proxy-Cause: dmFkZTFkk1Kn+8HkXIkYEVOWC2vGr84s9l8C7UUlnEQK82Pov3hCQjBNV4gV/2kHXje/xF
    em831/oDMuGjB5BvUfbioDeZuMzP5CZK6SAUDxx1eKP9wUvlfp6n7WKOnUuOTge4jUhnbn
    DaFpTNPfUdbFCKrLNqGPMRoSndsW8LSwRyx8TUMwRXNkHAyCpdnt4ImpjItux89MDxMkuV
    Ega1unt3VaZIUGsXdNdfHhNga9r1qIulZox9WeX03gXCFey6N0WrxScWyQ3uKFMAxw5KF1
    Y6P0JH00ghD+EKLiHE0Ta+Zd6hZJb6FNlBYaBaIzfyiD/gkOtc+faMgm1mAVhvZV/6R3Ah
    xh+eZKGyD3yA+Ez77/LZmBvsAtYHXQceM1Vw/PRlVSIqakVszggLyrOOGUOjmaKHlgJpIw
    FRIiGyAHMvWBQfmnqIZAFjnyvH+kFAr+AZRid3wtNzWZWMc5JtwyqaDr0JjHkZu+c4k9Hy
    y/xh/sgkHLnlzEauUt/2TiV9nIIUYoACKofvCDhcuIRVj322eW3F6IcU2Ndf6adVJQ0MN+
    e5/RNLLOlbn9e12r713Gga/YIn8fhKC7qLyjh3MKEJ5F0zTxNkPtErrUs0QUJDt++ZwrsN
    wrASM8q/LqDC/Fl71D3jGC5I1D3erHB5RXIwZKZesXpHtvK865GOxTxel8Gw
X-ME-Proxy: <xmx:1MX1aqUZUaL-Ydv-DegnjcfAxiOO-clYJAHH5eY3nMkpbd_M7SReKg>
    <xmx:1MX1ahU62gurVb_82o1ijP1q8WRzUN-GEVnw9-wg4s7VP5nNQIh6GA>
    <xmx:1MX1atRoGOo5GzeZZ4eMNKQjgkcLiaS2Vs2BEEEKOpzdVDbJOimGSQ>
    <xmx:1MX1aoFzS7LESg3xr2W8MuuBYHtQ3Gqzt9fGuk_3zOtHNB_8bebanA>
    <xmx:2MX1aoNzcLMo3NB5fp3IXUNAnriKVDrt02NuKOldRNBm1YXVNTkcWe6s>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id 1062A32A009C; Thu, 12 Nov 2026 08:57:37 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Post: <mailto:linux-hyperv@vger.kernel.org>
List-Help: <mailto:linux-hyperv+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hyperv+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-ThreadId: Al4kXH1AuRa-
Date: Thu, 12 Nov 2026 14:56:46 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Pavel Popov" <pavel.e.popov@intel.com>,
 "Bjorn Helgaas" <bhelgaas@google.com>,
 "Logan Gunthorpe" <logang@deltatee.com>
Cc: "Leon Romanovsky" <leon@kernel.org>, "Lukas Wunner" <lukas@wunner.de>,
 "Thomas Gleixner" <tglx@kernel.org>, "Ingo Molnar" <mingo@redhat.com>,
 "Borislav Petkov" <bp@alien8.de>,
 "Dave Hansen" <dave.hansen@linux.intel.com>, x86@kernel.org,
 "Jim Chow" <jim.chow@broadcom.com>, "Radu Rugina" <radu.rugina@broadcom.com>,
 "Alexey Makhalov" <alexey.makhalov@broadcom.com>,
 "Wei Liu" <wei.liu@kernel.org>, "Michael Kelley" <mhklinux@outlook.com>,
 "Nathan Ciobanu" <nathan.d.ciobanu@linux.intel.com>,
 bcm-kernel-feedback-list@broadcom.com, virtualization@lists.linux.dev,
 linux-hyperv@vger.kernel.org, Linux-Arch <linux-arch@vger.kernel.org>,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <61d483e3-d1e0-41ed-9210-081a4ce60382@app.fastmail.com>
In-Reply-To: <20261111234439.4098-2-pavel.e.popov@intel.com>
References: <20261111234439.4098-1-pavel.e.popov@intel.com>
 <20261111234439.4098-2-pavel.e.popov@intel.com>
Subject: Re: [PATCH v5 1/3] asm-generic: Add <asm-generic/cpu_device_id.h>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, Nov 12, 2026, at 00:44, Pavel Popov wrote:
> <asm/cpu_device_id.h> exists only on x86, so generic code that
> matches on x86 CPU models has to wrap the include in #ifdef
> CONFIG_X86.
>
> Add an empty generic version, so the header can be included
> unconditionally. The CPU match tables themselves still need
> CONFIG_X86 for the model defines.
>
> Suggested-by: Leon Romanovsky <leon@kernel.org>
> Link: 
> https://lore.kernel.org/r/25a0cdb4-9c4f-4531-bdf2-8d09eedd0883@app.fastmail.com
> Signed-off-by: Pavel Popov <pavel.e.popov@intel.com>

Acked-by: Arnd Bergmann <arnd@arndb.de>

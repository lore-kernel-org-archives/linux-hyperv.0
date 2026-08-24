Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BCDF314D1A
	for <linux-hyperv@vger.kernel.org>; Mon, 24 Aug 2026 07:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787555363; cv=none; b=DIkPunCRhYxSkHyHa0yMBrthI6LxBFMfTwPAiYPFfiv0bDFj2ah5/Eu1mmfrH+3MN6t06N8pjG9bSyLK2/ljlBxe1UgAo6GBfXi8pJf5XEbcEYQ991XQH6XWBZDQUBvuGxUt/9TXzsxIIfsCfXXjDo+SPRk8D/Z8r3/vctwdXxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787555363; c=relaxed/simple;
	bh=T3Znx85+wRAnG9rsNvo9Z30hf5HBN/a8hUHQ/NtsWcA=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To; b=Td85+EDWV88rC3lv3SJZzZqbm+70dgl/YLv5DPIXcs+WrTV+tewcuN/jDmDX7xR/4Jv+tmoFlAT8k4ptiIxJY2NhnzWzVePzd/MNw/XQyAjgK+rpLWSFwJ78QKgWMb70TcvP6IjXdSnV+wpM1TeST314hL9DBup6doC5Jdp4ymc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MNFGA+KK; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MNFGA+KK"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-cbe6295f05bso2772830a12.1
        for <linux-hyperv@vger.kernel.org>; Mon, 24 Aug 2026 00:09:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787555361; x=1788160161; darn=vger.kernel.org;
        h=to:from:subject:cc:message-id:date:content-type
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JQN40EZErL2DHTXaUSRxFDwWdzQHo0e1wBH6G70Kxos=;
        b=MNFGA+KKQ/GzWEmOBj6yvmVGQcC3mZcQiL6wx2lHaxRCiAEQ5Y2PFocep+uSvQKfMV
         Wjcd1dIuI+WdlrrtPeRrsFCIOf4HhGqfD1Aygd2C7aMbIKP5GitmTO2RxlW5NnjBpk3q
         Fx6yTekRZp79SokuY5HgsIHlChXKHHynuYYdtS/po47Yt4EtbWWGXAfyfvqzNGECSg+j
         DIHgaGlt8T5eS4vOYIHm/icW1/l4LCyi6KqXxTpxNHJdgDjGOzaU8Yqv/nj2QFTD+u9F
         Y9ILxxzbrlGqZmUHgVGMRPqTUe72k5Wh4XIPYev8BvO9ISxynvsZhKI2oyjPojrQWu81
         mHZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787555361; x=1788160161;
        h=to:from:subject:cc:message-id:date:content-type
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=JQN40EZErL2DHTXaUSRxFDwWdzQHo0e1wBH6G70Kxos=;
        b=j5zcnh4F0fR22Ntbsh3LIw/5qY3oE8wexoVXISOj4PG0Xs/FHr+gF6ZrXowWdos60d
         IDET9vTB9mhR1wHA5/kVTIg8R8BleEsOCGgz7gZOq1lAsczjgCnM7kA0ueI/r9E4Uk/a
         3etuRk8zAF2T6ncfnK1wNYScw7uKa7EJuli+K7CShTiYc9TVfaGHffVpRZWsNZWC95YH
         cdKCrbbTdFxgQG7ZCt1z53s61/kKSP0vZkiyWDdDXMTw3haG9vNoI4j1+liK22uFxmrP
         BOFr/N988+iUuCRDWaJ7Heuye0xGeRpF7QImRq3zASlaT3c8v4J2pA5diayf1rSfKjHl
         TDtw==
X-Gm-Message-State: AFuF++kLff9crlbfsXVs5EIgPLlWbzH7sbc0cmc+70XPU2CaKbdqs5+x
	sBdnDk80jhlnSVmz6Qevxe0twKGo3GG/Y9dzctF+7a2ZSOJGvTflwXV5
X-Gm-Gg: AR+sD1136k+9skksLQI2fU7tBt0TraaFYmGpmE75GteCVGfsPD7AIsJgC+PF3gSH+5D
	RqeslEpEIiMxKkChRePuOryWFmWL8y4A9xzWuSljWXz8/KUMq5c2Nkygo4jr8vVLMzx83Q8ogDV
	yEQ1axB59L6cuWF0wfnjGNaLLL4+0zgMfksQu4OqoHmJcrN6eOg+YyNlfg5sBnVpC7279wO1i3j
	GPpuYzohIlzbzP83CRg6Hlmfh+7xgpqGSNZo3nPP7UrL3C/3YsnhtEgVpw1EtaWCQkZtUkmgQgN
	XndmUPzeJdeQ8a1OV6ErJ/2iDTy+sRLz/SkE7PdcKvfykRYPgV+f1oEX7yqWH9OuqUeNJ6Ys4AL
	DjrvLvvpprj2rLKbhvYKpFBdlVOSz6r7RvpDkrrBER5dKqzKDydhtDtUcIfru+32pG5eaf4+NYf
	ARMpohGCcdPKittrcXh+8gFWlVZBobdL8uyboGC+1zXmlXjD1rN5i1zJNTv2YhxmDSR3opPfz9o
	GH75qk+bHUi4h7PSUzGpLo=
X-Received: by 2002:a17:90b:388d:b0:387:d9cc:7dc3 with SMTP id 98e67ed59e1d1-395a074a348mr40512016a91.21.1787555361491;
        Mon, 24 Aug 2026 00:09:21 -0700 (PDT)
Received: from localhost ([2401:4900:8850:f081:3f06:139b:b140:eb29])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3280782f09fsm15279067eec.20.2026.08.24.00.09.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Aug 2026 00:09:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 24 Aug 2026 12:39:06 +0530
Message-Id: <DKWZHHOFA1F3.1EL2DMFNGMP0Y@gmail.com>
Cc: <linux-hyperv@vger.kernel.org>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>
Subject: [PATCH net-next] net: mana: remove unreachable dead code in
 mana_bpf()
From: "Muhammad Falak R Wani" <falakreyaz@gmail.com>
To: "K. Y. Srinivasan" <kys@microsoft.com>, "Haiyang Zhang"
 <haiyangz@microsoft.com>, "Wei Liu" <wei.liu@kernel.org>, "Dexuan Cui"
 <decui@microsoft.com>, "Long Li" <longli@microsoft.com>, "Andrew Lunn"
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>

mana_bpf() declares an uninitialized 'ret' and falls through to a
trailing 'return ret;' after a switch statement whose every case
(XDP_SETUP_PROG and default) already returns unconditionally. This
statement is therefore unreachable dead code left over from an
earlier refactor, and it would return an uninitialized value if it
were ever reached.

Drop the unused variable and the unreachable return.

Signed-off-by: Muhammad Falak R Wani <falakreyaz@gmail.com>
---
 drivers/net/ethernet/microsoft/mana/mana_bpf.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/net/ethernet/microsoft/mana/mana_bpf.c b/drivers/net/e=
thernet/microsoft/mana/mana_bpf.c
index 53308e139cbe9..70bb8c9dc3413 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_bpf.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_bpf.c
@@ -253,7 +253,6 @@ static int mana_xdp_set(struct net_device *ndev, struct=
 bpf_prog *prog,
 int mana_bpf(struct net_device *ndev, struct netdev_bpf *bpf)
 {
 	struct netlink_ext_ack *extack =3D bpf->extack;
-	int ret;
=20
 	switch (bpf->command) {
 	case XDP_SETUP_PROG:
@@ -262,6 +261,4 @@ int mana_bpf(struct net_device *ndev, struct netdev_bpf=
 *bpf)
 	default:
 		return -EOPNOTSUPP;
 	}
-
-	return ret;
 }
--=20
2.55.0


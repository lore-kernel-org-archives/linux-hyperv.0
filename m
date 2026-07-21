Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0A773EB10F
	for <linux-hyperv@vger.kernel.org>; Tue, 21 Jul 2026 00:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784594426; cv=pass; b=mABzcJkwtMvzNxJUUD0lMqf/2y6PEXvnd6qG6SC/3X0HBw0Cph4qOUGIfTLdHUPlCXsm/yn7hOSI1NkHsRDOkso5dXVL6H5R6Uho7Ey3P7esB0IywOI3CKXfy6UTYLWlsdI1hIM47wUN+A15FLtRhoqboqVO20zg2v8ZEi/KDH0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784594426; c=relaxed/simple;
	bh=NP4m/7FFeb4FM095XmhQvw1OvTgPqido2XDAs76IywY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qz6VB2ggHds/aWwPki1YTRmYCtl5+ppLxhV/BM33KUavS6GEDk0IsixVXGFpLsxd3nzvF5W/I7EaP49fQWO0RphqiYZTAeW+mkcfzfQ8Vfzau5MCbEVzG42d55duCJBmUw+EvvZvSQxJDnDv4avw3oyrOi3SAbZPXSOn2wXJxP0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jfpwS/G8; arc=pass smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jfpwS/G8"
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-667971437d6so14272662d50.2
        for <linux-hyperv@vger.kernel.org>; Mon, 20 Jul 2026 17:40:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784594424; cv=none;
        d=google.com; s=arc-20260327;
        b=KokMZQuP55bopizs/H+xvJ0C4tYpC5gLScu2VsMAmMVcfTyrzZcXoiayrldoQNauLG
         l34FHKuGI7j/IeM97U1wUBlwWAfrks0NhrZ7ENAyEG6j49W/yA3CmLtz7pBnWRemH1rg
         Jq8nvdVidOuJ7Ok+kG9xVn1aYASvvxHaC7OEX0eoQYSDJXccHOwPYTR0JK+awI+7Uu4e
         9vWqkYqO9nsOMoMNdAz8CYP8KChB3OYrd6u+vzW6aOK1dGt81BS86wrlm6KC5qFh4GVT
         LWVElPtuHUvVt1zZ3tos7PCUn4UkEp5WMc0swTPZel4K8V1FV+P+hBg0q1NErENSseKv
         Od9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=u/PmhXiNkweZnLEwDItIiLzlyIxV8P+S1Yml54aMj6Y=;
        fh=W20oin3ovIpmQJk9sfq9my7l5RXaaHCylCgjOeACODA=;
        b=b0+bgfqoH4uR8VrH1TFl8Vd4uEJqopOmqNg7vnL1rH9A0Rt1iTNcfaN6y+O6BaBOr+
         ZH5q4c2wEUvsyfk9QaE45V86RiPvcpr4ehOwFoqzVrmTfaCyE4cvwPbvP8mI9qPGLVwf
         RFO8Wa3t0meMSqKNy+x6D4PfkzSIMBiIlmW5U36mE1Dklsbszau1mq1LBL/uFkXG2vCj
         8qdInnq5HQmLunLfWasD4JL/ZOqi4Or0Ta9wLfQYhQ52XWfF/dZT03dlgHpSCoZScRfs
         q1Tm3aeHK9lqaElVVsMCgD3zoyKyhZYXG0iMmneWFFnROOwrevLyP4mkZTve971YAXm/
         +AHg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784594424; x=1785199224; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=u/PmhXiNkweZnLEwDItIiLzlyIxV8P+S1Yml54aMj6Y=;
        b=jfpwS/G8k7N3hFHsUasjmad58pwaSVGiAud/NwZ9b+iAaNHyJQyUiXnL/xj4vpcPzZ
         GwvLLBxSsNhoWGT0JbINk9CCluGk05kaZw6RM+yA1UjePVtCaz4kpuppIwJ4QJru4zS9
         QD4msmAMUFiqpubkxWDYFv9n5lcYusLYRdnO0fjFDZjQsShekKXwyBif368AT6DVFBG/
         dE61Xge9k1k6PhTHlzJMYliCqJx0+34giBTpyPuNAm+BAvn23o+wQzkGc1vWt/rTHJiU
         kbgmxgdv/Z5xs+CHpBtU6bmEAqjugrRCa+D5aRUlMahYyKNSUtHMJQpAl2N+bwTxaNeu
         FIMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784594424; x=1785199224;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=u/PmhXiNkweZnLEwDItIiLzlyIxV8P+S1Yml54aMj6Y=;
        b=klMhrgzRkPRsNAr3JaROBFucjN+Sd4f228B5gixG0Yoldl1bcYEduVUauUzQAYrB4I
         0HmQV3vvO6UGgThE47jLLOnw+5tM5n2LVpl0zEQ0UOWlvFTCZkalPtTmFNN+9mpMMat+
         7AwlEqcwKBs/KR+CCoSxi7dN4qQqy4Pntpyb7rdvWnAC/CJg1gMQiJgDcUBM7EsEREai
         AAMgIRU4d5TgJY1yGqaW83h097hTua1BYVL5JX+erQDJLIRg94Doe4mwPzGJtaewGtIT
         G/ev+Vi0KkYf9llI9HqVuh7eQB7n7BJOhJ/nCYWJ3b7rXzbquoL4mFJSGKAJwqHc9dm0
         W/Zw==
X-Forwarded-Encrypted: i=1; AHgh+RpUvluE0eAU9bHG8NM72zWhlAmyQNTpR4wIGUlGi9ovp+KCMIMQNpF+lOR+9+S+KlaIMFX+s6QlBIyzO6U=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeTT+5RgL0C/++3MDcjyipAJ0sLk42GyXgByU7f0bCSld0vPF4
	ZkO6ljMVILiQzhT3Na+fN54Xhc+x8I8LnrdllCYymSc4oI5T1TyvKQf7k8DxMg/VbJhuOvdo3Fr
	/AkyoXOR/OHxhphSDWiusCx93DCxnP0w=
X-Gm-Gg: AR+sD11ZQKTVNKBh4T0p4ss0usOISN6Qu9n6fQNHN2MegiXyCBSER7oE/cN2Mb1x2kZ
	IkFmjtfY0WkmCy36i6L9x74bkXip1M/DXmUnCDo+iE22X0+KLKQHf0t2uGGtPLTWPlfJs/HaodJ
	eHLa3fUWOCDTuKtS7tpHMaUp9EqoAHhCqypgPYVNTMOk6xoKiFuh5LCe6V7mArm6IJuxZQldXun
	bM9jMSMrplLzZM1SdeKK/fld4AZqnfmw8qEt6g1UXNrS0obuTVlRJlMZIASrh98HPnWx8PmNYtg
	0r75+0eZIE3+OWZmcfB01eKRZA==
X-Received: by 2002:a05:690c:305:b0:81e:b7dc:3dce with SMTP id
 00721157ae682-81ef26c0dffmr49886907b3.63.1784594423836; Mon, 20 Jul 2026
 17:40:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260711150628.2914205-1-michael.bommarito@gmail.com> <al6ABAMHeE76yldL@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
In-Reply-To: <al6ABAMHeE76yldL@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
From: Michael Bommarito <michael.bommarito@gmail.com>
Date: Mon, 20 Jul 2026 20:40:11 -0400
X-Gm-Features: AUfX_mw36s0y2ormAOkosI4vBsNzUhY8gfCuww9ShBgf2r8MUtPCtf_7IW_q48E
Message-ID: <CAJJ9bXzMNRvPKDUMBrryaWAjF1WqHS2vS1qwOqOOm--5+YSSqg@mail.gmail.com>
Subject: Re: [PATCH] net: mana: cap HWC init max message size to HW_CHANNEL_MAX_REQUEST_SIZE
To: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
Cc: Haiyang Zhang <haiyangz@microsoft.com>, Dexuan Cui <decui@microsoft.com>, 
	Long Li <longli@microsoft.com>, "K . Y . Srinivasan" <kys@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	netdev@vger.kernel.org, linux-hyperv@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 20, 2026 at 4:07=E2=80=AFPM Erni Sri Satya Vennela
<ernis@linux.microsoft.com> wrote:
> I don't think the described data flow actually
> exists in the current tree, so the security framing looks inaccurate.
> Please check the comment below.

Agreed, I got mixed up on that.  Sorry for the noise

Thanks,
Mike

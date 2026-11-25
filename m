Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.169
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795649244;
	b=ijBdAu70AROnYXMYKn/oWUesI7bzxjE+uPoHthLogw16qECd3S1/B3RclLrCDBQ1KRbr
	 2afb2fGfBEjaxscZn/XdfsLj+ibC/ninqECGlv2MSdADVlUkxYO0gIILJF7f8vQ/t/p82
	 Tja6y3cvrGbGD4T4UEmkYk2NDT/dnHTme/zZoUIrhtS1IKhPPU01p3vqM1yUoIOP4pdu8
	 /BpfvoOIZzaYPsxmwE8INVpcJQClBwdJyVBVe8VIXwFwkgvdJVMAFcmkmjW0M2E6cfwcp
	 3RhPkq1kCp6RIxxauOAsPObzvbtLYwzbq+uWYmJv+C0aiG3Y6BS0U3t0whqQWp0A/2g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795649244;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=sp9Gu/ag0sWDcDK/oXTqpJzOnSAhjMt/opO5ZXrPuXU=;
	b=4XcI46KgaqUurQijtbAN08IhcTsq4QFs5ucXGxUgYXWLkQtncga2FBy6UwxsqsuA/2IB
	 leHTCNPbvGK2x9pTtWMFVsdFf6PC/TwDu/dolwi0MF9nJFvLidqj1/edqVDTBz6wW+IqQ
	 VPXs8/bMQgKyC8NLT3kPeFz72V6/xX6oqEH8eH1pyUcNzEKaq4a86JHFmF9Na/giikGDq
	 mA0sbSAFO6LCewQkNuIJd0G0nTPJwYwXt8E5GU3Qut1duk/HTxDKbtN5lE/a08WxOw/EU
	 VV8mvQMpjE58Dxb95MO8syU85qURYsFF613gHQlSsNkJpB2+iQuwIWtb4mU5VJX18kQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NIZMZwqW;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.169
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AD47606A321
	for <linux-hyperv@vger.kernel.org>; Wed, 25 Nov 2026 23:27:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4AD47606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NIZMZwqW
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-3863db981d4so8981747eec.0
        for <linux-hyperv@vger.kernel.org>; Wed, 25 Nov 2026 15:27:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795649243; cv=none;
        d=google.com; s=arc-20260327;
        b=H9SL7D0zXD+1D20YtW5KB6UvUr0/EYVLyNzwdKYFGQ7y9FYhDaasNIDIP0NLByblb+
         ZZMX0a3BX4xMjMazmzS8MB6veFJ/y4LZ4vhbNYrxmCVRCf5wt2ReIlq8pjZR55r+R9Jw
         xxPJQY6AmbYaj1pmTLI7HSXrXzUDcfNWK6m6yqEBE8V9ZhheiP7bURbisHg74vlSQm6K
         SBKozUOaLXZ1reuS//8deL49n13RaEvoHOuGg+5YFgaHuFg9YBzlkc24bAZ901n4tOZQ
         XlgyFg0Q80blLyZQvAmZkInLjjCcCD1htjRBuMvE7cgC4/sztjStLMLKlDBlU40plPG1
         VdTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=sp9Gu/ag0sWDcDK/oXTqpJzOnSAhjMt/opO5ZXrPuXU=;
        fh=O2RfzjLl6jQoohdW3FBnrPOoe13bXyz+w8ZLN1vMRQ8=;
        b=GoTrLZtGUa06skHwgagG6lTXBcPkQC5/QRY8cJUcCBrF0RpG71Arw5vJ833KMcERsl
         vtbDniDT3jlePbmBrzszf1/blh/jxsTV8zgZ/uaGmxsADI9MSrzzF8GpGLZn+J/Ho+2Q
         lYe5lmXVBKB8F6zPsDhx95P5yh6M0O1lXctW4viVn+7fxWDwPEYTp9loKAmbZO423jdP
         b/n/aj3D5TfjsaxOqwa8p/x05PUKRfOGpazw+6PGsAwIu0dyCe84eS+P7VbxqPOUwbh2
         NJV0dgprw67indMON9NEscSfdUarGTZuEKi8ySCm7BLQ33s8YqNRffctKweEFCd0iOvU
         GfcA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795649243; x=1796254043; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=sp9Gu/ag0sWDcDK/oXTqpJzOnSAhjMt/opO5ZXrPuXU=;
        b=NIZMZwqWfa/J5ul+qbcnkdRDZQuRIZOA9hBsJp/Ok5ad0bKzCAbStgOUKqZ3BlePug
         s+QBF0y5ERsSSKHSbJj2P93EEJybf2lkwaabtHEbV8PtMiJROMZKnAfjpgXmTDhb6PYL
         vmMKrLgDnlNPIy/8/Md21f5K3kAMEQfd4AtxJ4BgUhkZxWxCF76M3/BXwo/30dVr/2W8
         U1WMSAgTouOobAUuou7QSQWQyUsrDD6LbstC2L4jqAVSmm4OPnvo7pww1muvkP9gbN8G
         TfODmn9VF04xuoJBQBvpsX0BKQDv1bIxicJYr1vDm+voed8uD2YWZg/g7DbCEJAAysW6
         inOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795649243; x=1796254043;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sp9Gu/ag0sWDcDK/oXTqpJzOnSAhjMt/opO5ZXrPuXU=;
        b=F9+NsfIcm5WNNFowtO/CkFx2dXwx0vxQsO66Id/nB6xCjK1MEtMwB1hqUhQxkGhvMu
         Dt9CMUcRAnO9VZaatUGtjfFbrIWf9qurTbqfUGrrNwoIhcu990GW31VGI1+nwYxd17N9
         x1wUe93sSQa4uphfPR2i7jq4n1jMFZXNT0K4j97Ro79LT3EtBwYSY975RI4Qoq16YHaT
         TaSk21AON3FelhlWiNYifVo0A6bIAa6arftZoZFyZQ2XJL68oHiOnfqBzeXOI9JJHBfU
         ZZgskUKnSpIGSwSlNz5LUFBFihOLuQApbIfeE40M9kJBJrRJdsRnLUYafEjJ71fbNL/P
         UBbg==
X-Forwarded-Encrypted: i=1; AL+hErHnoB5bt5blDdpgZbRiOz7RihYSczOJVOvFCSNu5PC2XOr9nYNyWnM9LCRyYBqHHcRWJIc1l7nWZSpvgRg=@vger.kernel.org
X-Gm-Message-State: APuU4Z+bwvBQvBG/dWl506gxLNvNwKzq+MFKSLewPpY0YT0Xu+2R2cTy
	ZmJhLoBsGStgKm5GCQ2j7qEpCqgQl7THuMdziRDtozB/oldtvl50iVAOhWjtl89yy4C/TejT6/e
	lASN3eSwTO/Wm8Mifkb8t/ms61HZAcOg=
X-Gm-Gg: AZFdTZc8tUwfj3+IroiVxk2dVNaZJVvFV5T2qYh1VldA8ZPiaLOVJ1UCYYqoIJOWH/a
	oKkE7M6yKsZeX7v3jLk2i3JJostezt0HraPbo/gYv8FnnmZxfwzZsLcWOi4T8iz0z0m0H3BvH96
	AtbpYIILcxUgrOONAuXo8Yjve2oAT0aCgaPY8ZGFHRTNClAQnLWNrHHlki3r4NfkiMg/SxoF2T8
	3XPojPyc0Yv25uHzi/vkh3f9dKHihq4t23mdHuQovfLA89RTn41d7/9Aiq+vJVDpfvSPGChTmlU
	Kq5JLbKQeZQJ6RVN4aB64Dc0/0WjTG1mNnraPPh5e7YsDaHZarkamY8F5lGsLcU3WonQkGx/xVI
	zH1MXRB8KTr/29oI+EFWZCZPfEd4DejP7ZCyLug7dIiurVZxUSBeXbnbB
X-Received: by 2002:a05:7300:dd46:b0:385:7762:e1a3 with SMTP id
 5a478bee46e88-3857762e729mr18890931eec.24.1795649243401; Wed, 25 Nov 2026
 15:27:23 -0800 (PST)
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Post: <mailto:linux-hyperv@vger.kernel.org>
List-Help: <mailto:linux-hyperv+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hyperv+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261125074331.25190-1-zhangyu1@linux.microsoft.com>
In-Reply-To: <20261125074331.25190-1-zhangyu1@linux.microsoft.com>
From: Tianyu Lan <ltykernel@gmail.com>
Date: Thu, 26 Nov 2026 07:27:07 +0800
X-Gm-Features: Aa3M54r4mxIQgvryDnL-qX8IuFUHHV-JKb0OjIRrToyrlQrT6deJuQHPpw72yiw
Message-ID: <CAMvTesDUqyoayJwGVRT93cF=mC876n+8fwvpPK9TVTH=8AjkyA@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Add dedicated entry for Hyper-V IOMMU
To: Yu Zhang <zhangyu1@linux.microsoft.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@nvidia.com>, 
	Jacob Pan <jacob.pan@linux.microsoft.com>, 
	Easwar Hariharan <easwar.hariharan@linux.microsoft.com>, 
	Tianyu Lan <Tianyu.Lan@microsoft.com>, Mukesh R <mrathor@linux.microsoft.com>, 
	Thara Gopinath <tgopinath@linux.microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Dexuan Cui <decui@microsoft.com>, 
	Michael Kelley <mhklinux@outlook.com>, iommu@lists.linux.dev, linux-hyperv@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 25, 2026 at 3:43=E2=80=AFPM Yu Zhang <zhangyu1@linux.microsoft.=
com> wrote:
>
> Changes under drivers/iommu/hyperv/ are merged through the IOMMU
> subsystem tree, while MAINTAINERS currently lists the directory under
> "Hyper-V/Azure CORE AND DRIVERS" pointing to the Hyper-V tree.
>
> Move drivers/iommu/hyperv/ into a dedicated "HYPER-V IOMMU DRIVER"
> entry pointing to the IOMMU tree, with Yu Zhang as maintainer and Jacob
> Pan, Easwar Hariharan, and Tianyu Lan as reviewers. Keep
> linux-hyperv@vger.kernel.org on the mailing list entries so the Hyper-V
> community stays copied on patches.
>
> Suggested-by: Jacob Pan <jacob.pan@linux.microsoft.com>
> Signed-off-by: Yu Zhang <zhangyu1@linux.microsoft.com>
> ---
> Easwar, Tianyu: please let me know if you have any other thoughts or
> suggestions.

Please keep Hyper-V maintainers also in the Hyper-V
IOMMU driver maintainer list. The Hyper-V IOMMU driver
patch also needs their review and approval.

--
Thanks
Tianyu Lan

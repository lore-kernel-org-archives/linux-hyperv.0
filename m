Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26290489FDB
	for <linux-hyperv@vger.kernel.org>; Mon, 19 Oct 2026 07:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792395286; cv=none; b=aELCaQKrwVpjWrLFo7KeE71NK2VzFLX3vzfhF+qKdpklxo0nEwEV77jI5MEXQfEA8/DcK8PaaO4C4DAbCmHWAAP3ItH94OSjfyJtriundbBia4ZGexEU9qpIpamu5v5eFxyKO/NL/vnJYcn7vU0mnV+e+fLie6OJJEY1NfGfby0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792395286; c=relaxed/simple;
	bh=7gaVL9tBLX4l9fAN3Lr+WQ0o9ncAIpOMIR67agIWONU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I/9uljFJ3am2kGrHTpPOfTZtSy1CTWZzUoua1jtJvgPAJ4lSWWU2vNloFnJfTXfvG/GwTvIskahL2UUaa+nh5VFGzRjRy6VGk69tt6OuO6KHjLRLwSBSbEUKoFZ2ZSe06PoGsasOV5OfIeAy74QBQdTWbzynwDzwKcg/AlaDXbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kvvm3jOV; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kvvm3jOV"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-8a06b44bd01so290073b3a.0
        for <linux-hyperv@vger.kernel.org>; Mon, 19 Oct 2026 00:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792395284; x=1793000084; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7gaVL9tBLX4l9fAN3Lr+WQ0o9ncAIpOMIR67agIWONU=;
        b=Kvvm3jOVh0QuSWD/0E5P9KXkp2wKcEPsxhPFdNv6Wazd75WFLvTJIVVRlqjlFzwSnC
         v6qZDkc4HSxa0H6/hPzaGq6Hi5EcAuNp9EQK5P+E04S6jsa783/UsoMmiwtR8beoN33W
         6TODThq5t4YDYwCmcrDGtfA1mw4HHzYqzOsQ7B6mYBm74QwLjIShEuvKaPzznQWpQ54O
         rJ5CRl1dUJN9r38w8EKypvnHgmZ6LZKjSXtAyrMpUVAAzJsB0cXFE1sDngegZ5HQlut1
         nIYle/06Q4tpIVG11CGpX8bMdOWV7gwjyIGSkTYeab+9UBb4kU39re3CF4dHzFxbECnz
         kCfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792395284; x=1793000084;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=7gaVL9tBLX4l9fAN3Lr+WQ0o9ncAIpOMIR67agIWONU=;
        b=Dl8d5tRmViWwdNzxZyogmTm4FA7ezTybz9D7ywJqg7fQdhqRtvDntYaDQD7Abjwhzd
         fpPRA6hKjqnEbQLNxSonkr9me3R+SIqXe1uGysP0aEwNUm9Kxda0Pz2jpFSwr+LB8RyT
         Dcf15wto7Z/JLthCWszqIV06Ve9nec+SQOR/azi3iQBEtiV8R8E8y71NKI8BwmV78dkz
         v3oS6YOBb+xLk9lBy+10jkTnNWd9Qfi4mjuhfMoKWS36NqrOp6hFyn4xeMLbMOSuo8jN
         9RPrW9iOv2GDz/XknXF6slxrFx5n9klPvVeWHXcon8ZXubVJ7V3ppA2hb6lEpw9LVKnA
         A+cQ==
X-Forwarded-Encrypted: i=1; AKwUvBzaSo7FSXcvLNdnvvOt8+WUlpiz9Sw9mRJPzccH+FV1lccgxTEGVNioWgUG/kd53Esd9+N8TM7Pt0s0q64=@vger.kernel.org
X-Gm-Message-State: AFq9FYK4gVk4K/T1cZtYrWHXAsLxK03QlO0Qs5MyQMjX7UsmJO4Lkvi+
	6Ymvky924OyptrJ1RRmxx/RkYi0Ko/yRwxB8zxj3OLwb3B7hnMIKnf8KWBUd1ETt
X-Gm-Gg: AYBFou1mf/u0eSOWVtpVtyEq+m2bPm7mk0RZxNk7JgxwMF24HWkHKLJy22CEaaIErCv
	sRxLMtD6APM3d+i29J6X2IOy46Ps/Fivz/o72Z5EiViaWVsnksgprtINV6s1EjVWwHoZxxzmN22
	iFBZnbpwPVqj0IaIiqt9knhM4RvusWuDUReAG9DR9py7rGGjgW4R5C/jPeS5UPPMGLWGpjFOj2U
	Qb3yEjK2CB6xNTZcgEzAhAMfLKYzQeEoyq5chdArHOLIlar697J3jwJETQnUIFppjpCZG9xv6LB
	X+LpN8Yg/Hr6KH7tjtnekWOjXvi0xeSUTpcuORu1qyAkf1NvwlN6Ig9Ddpq5Q36Tk7wGbjGpmDD
	u6/J7AB07/Zer072/mQBEV6oq+y0qLhw1Jdr2Nv73B4wMPpiRstZrM/1Yau8cNyEz97ZDtzkHEn
	Nzv5BuTjZhAnbDOwLhsLEwqhbLJOpJR6Rg2AClLlqk5FpsCvJwh3bKuAe8yPw0DSRgMwDw9wybp
	g5DPL6W/S9QSVGRvFnFNg==
X-Received: by 2002:a05:6a00:4c93:b0:888:2b10:e26b with SMTP id d2e1a72fcca58-8a04be69ee1mr5551236b3a.18.1792395284387;
        Mon, 19 Oct 2026 00:34:44 -0700 (PDT)
Received: from ancienth-X870E-Nova-WiFi ([125.186.72.2])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-89f5820b344sm3526404b3a.53.2026.10.19.00.34.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 00:34:43 -0700 (PDT)
From: Daehyeon Ko <4ncienth@gmail.com>
To: Naman Jain <namjain@linux.microsoft.com>
Cc: Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Saurabh Sengar <ssengar@linux.microsoft.com>,
	Michael Kelley <mhklinux@outlook.com>,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mshv_vtl: reject poll files with multiple waitqueues
Date: Mon, 19 Oct 2026 16:34:32 +0900
Message-ID: <20261019073432.3912222-1-4ncienth@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261019070438.3732624-1-4ncienth@gmail.com>
References: <20261019070438.3732624-1-4ncienth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Naman,

I sent the standalone v2 before noticing your follow-up on the POLLFREE
patch asking that the two fixes be combined.

Please disregard this standalone v2. I will rebase both fixes onto the
latest tip and send them as a two-patch series, with the common waitqueue
removal helper shared as requested.

Sorry for the confusion.

Regards,
Daehyeon

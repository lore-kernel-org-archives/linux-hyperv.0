Received: from mail-pj2-f25.google.com (mail-pj2-f25.google.com [74.125.227.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A5C33D75A4
	for <linux-hyperv@vger.kernel.org>; Fri, 18 Sep 2026 02:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789700222; cv=none; b=srNAazBT9XWXHTY1iKMzs0jQIN/0KysF6za4mrWXSkQidIr5AGpEOnoZzUgHi64zeceAEl1orI4cygkozDipRGP91k11qoHSJnb+meLMQjLQOsGbVXzVGArjBeOD2yhl1b4+pdpqgBjr9CMbc0599pSPGJXcDy3MGkL8KKDSUlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789700222; c=relaxed/simple;
	bh=WH/rnE12a+uaVlNTry7gwUg4MsviWYt1nqi8WX9vXi4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=szBAm78iTDAStS9flJjw9m2y6sXfl3wEh/TU4OCHo7BEiPwSQ/xP27PV3Uw7q29Bf3t9MtJHeyLbvcAtuOn7ui+XOzvfX3+/94kr16Cv3ngnOL+XcIvMaumjrX9GqonZ6jBGLSDfPEjNE4S8vcPVrcpyjHFfmiSwNix/64MVr58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=clNNZkJG; arc=none smtp.client-ip=74.125.227.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="clNNZkJG"
Received: by mail-pj2-f25.google.com with SMTP id d9443c01a7336-2dd4b43b20bso1628985ad.1
        for <linux-hyperv@vger.kernel.org>; Thu, 17 Sep 2026 19:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789700216; x=1790305016; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WH/rnE12a+uaVlNTry7gwUg4MsviWYt1nqi8WX9vXi4=;
        b=clNNZkJG562ToNrLE3Cu8NKoJn1kjRqSfvGdob1UUiHd6STXZr07fKOScqWbTRiEjI
         Ehp/KSeIyKyNcJsmKl+x/+kh8BOL644uLZny57bf0uAhnjr7MmT3wvHIY0ODSk1tm7ab
         +haxeFBVHP/+MQR3+7fxX2/JfI5i9OUbtgJl1Z+WCY6UbT+atHc2cg/qaMpRCdfJb0PV
         /HcvpA0ml5TJekYHepfVcZSB6y7MD2F1rEcmI/oI4RINHu1/tH4EBRkxNRK7m3Q4jLkU
         GadmRjScFiTxatV6lzGyP3QGkNaqWALY7Ti2jUbJvaCSuROXrDD2Ii1BYudA4GjTdhTH
         rZ/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789700216; x=1790305016;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=WH/rnE12a+uaVlNTry7gwUg4MsviWYt1nqi8WX9vXi4=;
        b=PeAYoCFsAXOvchUpErh8g4jnyW4IMJLTNY+L50fjWNH1klDryNTM2w4xc7NC7lGMOX
         nn4kxYBXI0nlgdOfqoe8rXROwxJPeT+hFiOCoECTbNlkj0dg/7PdyBOJQyoMTMkXfu7j
         04R0WHDn8aUWBkK9SS6VQe0WdI19cHqGkNhMYgHP4J2m/2Fnt2uLRF3W+TR43AAg1gGI
         lj+6iyHtw8iT/oiWm0PuzivA6S0FecSrirHtAow+Z8vXrYcSW2PEdz4xMJLgyzLcXseo
         bCqcWMVJYiRpL+iLidCrL4IneM4bWeZiAM7KvmEttJEHyVzW2m7wKGGGCUdIARERBBWL
         Eazw==
X-Forwarded-Encrypted: i=1; AKwUvBwPjbT/4+iwXuZqwekQgAbKpLNT1887CEY66PT5gNLcGfTHXbnTZK5YOPugqgoGJ+u2m4aNaMolcsqemdY=@vger.kernel.org
X-Gm-Message-State: AFuF++n71bZwRjw4l+dZZrIFT1MZaWHLHEEfw1HLoKqep+9QCRZq73oO
	Apdr3fRwdbZOiSXjzwlXIlAG4PijnK74DzWP0hg5WdfYvf672VXz1Ppa
X-Gm-Gg: AYBFou0OsKjirQgfMoHsVa23VVxMszqAZOnu9EZUhxVJsaDaMpQZ4dthsDD9Zr3Ux/C
	TLDkLVuFzQAaRL4q1bpy5e06kAvgKkI+5ZmhDIBfGYRcBI5mOdAmdYGvp4+OOhOJWz7oX/9wvUK
	TBF13bA3v38tjXzVWRXWOk6mmuRu0X3v3ZlVkoUlI9gGXBWjvwSVgFOrELx2k3Q3b1HppYwadHA
	+5KAitO3sTGorIliBY501edBU4qMWqN7p9ZrpOAJPyoCuOoP4Fi3CBKoiFCRh4nkzaR9WdtGunB
	S56hIrKZT4fMJiq26t3XdrA4TDcWyNdUnzjCicuG83ltT1Kj4TBPVenPsHaUOOIU9Eljy63fTzg
	MN/2gJCuJnWKf53apl8vjxcZZUweJhNawLSc/gOHFZ/umaNmK4t3MAn+UjxZkOGHQyNosQ0k29l
	xw0ZhWKD7FFoaUR7ASpqedETPwZ+k939cnfW/x220KsvmjMKFnhAqY9Xp872+fB8rX
X-Received: by 2002:a17:903:2f8f:b0:2dd:ad74:ac32 with SMTP id d9443c01a7336-2ddb1baf0a0mr24255345ad.27.1789700216039;
        Thu, 17 Sep 2026 19:56:56 -0700 (PDT)
Received: from bloom.localdomain ([2604:3d09:178e:e100::c570])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ddb75b52e2sm734085ad.60.2026.09.17.19.56.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 19:56:55 -0700 (PDT)
From: Ivy Lopez <skunkolee@gmail.com>
To: kys@microsoft.com
Cc: haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	longli@microsoft.com,
	sgarzare@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	linux-hyperv@vger.kernel.org,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vsock/hv_sock: fix socket/table leak when rescind races the delayed close
Date: Thu, 17 Sep 2026 20:56:50 -0600
Message-ID: <20260918025650.15990-1-skunkolee@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260917220213.56102-1-bartlomiej.dmitruk@isec.pl>
References: <20260917220213.56102-1-bartlomiej.dmitruk@isec.pl>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

LGTM.

Should this need a Fixes: tag and possibly a Cc: stable@vger.kernel.org?

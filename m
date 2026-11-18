Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795032766;
	b=PZkT6GUu/V8R8GBEUieYNcVrWZlf7NTusiOwcRFc79X7T02ju4klYTCjtOGfJDi+bSvu
	 58pvg8z4MBKTyyLiv0Szs7IxkYjgdKPPnQt0KuDCmQKvixSVoeOpCXgHCR9dkms2x3p44
	 Flh7Hi82fGufsSqNdreTYxWBkZMjTQaShiO5fVVgISiAltZc5359uIrT87qOghO33uh5b
	 BkDOdUlGPOjXerkXlEyTkSm6B994IHGYwC8R9gKUHFcTuNvI6qpUQLel5lN9pMMQgaKh+
	 Z+8+kk6N59KXofgUDY5zwQjreMW/9LCTydFB0Y14smZvtL6hWlTMjWoAdLfh8rQZCHw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795032766;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=Pjuff7q7uzbEL6ANRmv3ID5+cImAFU4IO3TNfZpMezQ=;
	b=d8QzdoS3smvHjtOXLrGDkauK9PnCCYdei1eIvj+IwdTXSkrvQeR4YYukbfjz0IBtSPn0
	 RAjoUzM3dENo1gkQIisiJPTiS+wSFCFSwcX9fNsnJAYIJQZ3wj/aloGIECvzqmixPjXFH
	 +4oTA8W8gpIJa+XKcj+CrPR084G+vBd0fWkY/yqIwJhlT8s5mXkRhLsnXQXBpicI/tysT
	 TcUxJondsVBgaAE8ebG74UEhpBA4KBMIggoHrskJ2VIDY8TUIo6gvXZN8tUuopl2Nkr5b
	 P/7+7zuGz33/xvTJapOCNDcViz7nGc2/QAqPZsAmUqJrkUxSr98slGmueSI+2zewT5Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=YZ7d3lcY;
	arc=none smtp.remote-ip=209.85.160.54
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB8AD606A32A
	for <linux-hyperv@vger.kernel.org>; Wed, 18 Nov 2026 20:12:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CB8AD606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=YZ7d3lcY
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-4a77dcc4ca0so709899fac.2
        for <linux-hyperv@vger.kernel.org>; Wed, 18 Nov 2026 12:12:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1795032765; x=1795637565; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Pjuff7q7uzbEL6ANRmv3ID5+cImAFU4IO3TNfZpMezQ=;
        b=YZ7d3lcY633MpPdzjWfeEyddVT+G02tld5QoTSdv291wxWB0jwFPK6qsBfYsuUz9cX
         kAkzP3LUouv2tijYjJr8sJHC4NjR5gdQsOpn7qWo+6lPhvfvcrw03ejYxDZEH4Qoaj1E
         RNiNTK0iXxczAY7HrtLO+bVjz6OOX+BM/PNjokwUt860VRPz84en7wkjjhhDbx3F9pX3
         w6Yh/fYPUTTL5naOyUHHAu1UBrc2k1NL2FrhfcmUIJPSRgHJznmsQZIZd3Buanai17Jp
         OgDO+LiHyBJp13h4BnLLXG1ojjUnUNoxNhdRWQw+8khp2DEx1JaEO95Dv4tx34KBKU0i
         Ym1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795032765; x=1795637565;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Pjuff7q7uzbEL6ANRmv3ID5+cImAFU4IO3TNfZpMezQ=;
        b=z47YX3Y1j9RKh+bT/yfcWZl6IWSiZs9QSkX8mi5tOblKt/qygoMEXulHWi1TPOsMwr
         3Wz4x311+IDhSPHuOGtxiq7+m84Cr/nnSZzP4xJDG6klq8P3sVedE/4eNbL/HgUebYTG
         PpDHFwZdPGs//j8w4oYOLXZuAyc3/qEAIFwmhY2P6YYjTOr0jc4xbqbwUHUVMtm2htjA
         Su2aL7Qwr/1DnKGo30qlw5hcxs32P1NjbFk/224Q+JE0NchFZCt4hmpqjavBGYowflff
         qV2nP9osRBMeR2KJNVjZxXjQJ1Gf4hCpXd7Kk13fmjD/hiDoHPGu3QTkA9WNry7MPjGn
         9aoQ==
X-Forwarded-Encrypted: i=1; AL+hErGVRT8EzmpNTEFQV723CEFbun6X9rmnZ7Hz2e3w6GNhpR6saGKb6EaaQHr8f4f8n+Yebg8tlojoncdleHk=@vger.kernel.org
X-Gm-Message-State: APuU4Z/SaaniLxagAyXRCR0anlm90mjNYc2bLhQLlP4OmGm4zNOFadcK
	pvvp5MiedxvrxKIKtOjXjOY9u7alzlk1LUJPcZdywRkIun9s1/CoD07rU/rQbJlGiOI=
X-Gm-Gg: AYBFou2mdxEDzDZGiqu3c71FCrT8MGdfYEREb0v88Bue5pkDxP+Njw8eqYVCtJceqib
	QpfoGxZAZbU+cWiJaTBIvYH7ogfN/y+ZZbndFodyj9bR1HzNvASi9VHPSvJhEd86g3epZjYD62m
	iVJ7wA3Un3BOFgKCkVC+jkOj26O8hMMF3WbctuQ5pw4afbi51W0KZcshSdDJeHKc6nIYzTMs71u
	bCMTzn7QyyOAazLeAO/dLHoVgJG8BNscrnxz78PNm0LES2YJLtsiRD/ceTXbG64ytuJEJVjwmnW
	oSH6zd6gh1nREnckb5TTVS58JWTFmBdSqzuEuiGdsLS1Rf12HheCxJrPnWbqRzIOo3Clq1MTt37
	001MXocN4TZART1TIs3m+WLwo443SFlEO4P+Bretq9NxVyypqsP3w2eVWScX6AsaRlluATLQCO8
	6Oas8T50+OMdAZSVNt7lkE7i0pYS7Vj1A3VnUprJrYslLl34k8LgYpUik8vkhw5nT0hSmiRFQqh
	BnBmsZ/jDiso6OdPuJnZJCVuHkCx+GPhnBuS/ciBNVAK8GiO8kOZ2E7D9cc++AplPxCff+4qyWA
	mmQJcAOqzkBVhVmk0SFttEYeHW3U4i5zUB6HBly12EHHnMv0r92eDTxRsvc03r6VMAGFEYnlYTy
	lzEGABPZL+qipaTvc6XBcaLreeEj1N+2GKDRHS6jJAf+kauE=
X-Received: by 2002:a05:6871:5826:b0:494:75ba:c6d2 with SMTP id 586e51a60fabf-4b75f1206c7mr3688243fac.13.1795032764761;
        Wed, 18 Nov 2026 12:12:44 -0800 (PST)
Received: from [192.168.0.102] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4b74372cb6bsm2987383fac.4.2026.11.18.12.12.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Nov 2026 12:12:43 -0800 (PST)
Message-ID: <17a2244d-010e-425d-acc7-ce8601982a10@kernel.dk>
Date: Wed, 18 Nov 2026 13:12:42 -0700
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Post: <mailto:linux-hyperv@vger.kernel.org>
List-Help: <mailto:linux-hyperv+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hyperv+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: Fix NULL pointer dereference in
 blk_mq_complete_request_remote
To: "Srivatsa S. Bhat (Microsoft)" <srivatsa@csail.mit.edu>,
 Daniel Wagner <dwagner@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hyperv@vger.kernel.org
References: <20261119-fix-blk-mq-null-ptr-deref-v1-1-9bcbcfcfaff8@csail.mit.edu>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20261119-fix-blk-mq-null-ptr-deref-v1-1-9bcbcfcfaff8@csail.mit.edu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/18/26 12:28 PM, Srivatsa S. Bhat (Microsoft) wrote:
> Add NULL pointer validation in blk_mq_complete_request_remote() to
> prevent kernel crashes when block drivers pass freed request structures.

Please stop this nonsense.

-- 
Jens Axboe


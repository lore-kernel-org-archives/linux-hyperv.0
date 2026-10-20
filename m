Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792474154;
	b=H2SgYzL7LF9EVoYY6xsAlvs9tzeSV9Ab8ZmU6trgV7Qp6mqbCGT+b/nhGV1zkTl233pD
	 R9n/nR+NQbMplG0BM5Kz67uZbruURMPIJ+t3Ut4dew+83rlhClDfa3cKJ3hS3YEbomqWe
	 BH63gP5CH0Uz7TMV1/TztTFkIE0qKe0ZyG2i1x114htJfG8zuXX+XQew4e/+XZock5sbc
	 DQhsrAH57kyI4m/TsGH8prtIQzeNEJtTTPe0iclLX9i/HUJ8rI7kjK1k6yKmrh2E2Z14v
	 Qqn0ophoZ3iV9RgLGdyOI8ADUaTfAOi2qT97KVNl4pxziQhK03fa764tUpwwl6KJATw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792474154;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=c9R77y7CmEav0rC77XG2mhErQJ4vnSWiNFq8rafLmTg=;
	b=uXw7J8fh1CUPwQMmwABwr08W0G7jtzFZ6ij2sd/QWLcNec00mYEHNqD9VzWvqv1PLe9k
	 isJJ5ftWdd+oBaP4CdM2LlcdP/AVEwWXN+vHATArJnH1+7PwmAhNW9CpwfudXcA/CjhIp
	 JZftj4ZxCV2VNPLCogZadKquH2yi55vHK6eTwWXgCI6CzQVIf/8v7OYf1h9K3vCuUbvJg
	 3bBrvK2D3uAtk61gGRuLlHDjQfWafG+oZmlUcfDhwphv5eacy7lUkSMTIKLyZbDGTJtXk
	 K3qGoI2Dd28Sb0/AE6AngkZa8BGa/es18MSK+CdBlh6/Ax+iKMR8cggUmX56Rys6gQw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=IQBUBur3;
	arc=none smtp.remote-ip=209.85.210.182
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD664606A31B
	for <linux-hyperv@vger.kernel.org>; Tue, 20 Oct 2026 05:29:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CD664606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=IQBUBur3
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-881269371acso153990b3a.0
        for <linux-hyperv@vger.kernel.org>; Mon, 19 Oct 2026 22:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792474153; x=1793078953; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=c9R77y7CmEav0rC77XG2mhErQJ4vnSWiNFq8rafLmTg=;
        b=IQBUBur3C3ooYTg5kvhTecuHSB1BGpjp7yAA0mIKn1KXQvvi8yjEcRmkxmKnWdeE7E
         0wnTYdvYGnwAqgAO0varwi/dIYQYYwS3hLf3CcXVW5HdtDxHqnKocb23lWaeCrUyzVkJ
         V9ibknii+z+WI7x7BKoDF/F29SvU+LcIdoAmsK8L7WcmZWt1ZJB/VGooD2EisfUsIgbL
         XmWCcBxoRhup+qP1okUxUbtANYOkhCdiB1wdmC4hnz7h0xaFqxHtmI5p13UXlGNVD8R1
         P6ePeijdS59iYgsFsWSMB8pgwiovwod371lTewAs2HI3HiUZMDA7nQOeT12z8cOB757r
         9ONQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792474153; x=1793078953;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=c9R77y7CmEav0rC77XG2mhErQJ4vnSWiNFq8rafLmTg=;
        b=tQqGY75dlykmhHYI+5LwbmRhHfuzsgFtJaV7+7mEHhxQwk0CTwnvFvUZPCti/e+uqw
         gdz0euGuH9LffaRUJnZbircQJwr2slbuYXqqHldfzOdc+5LA0aqRyXWOohz9t5ektT9t
         VsoxVyuUnwIlSa27APHuVAsysZbp2dr+AJB9cM2bum5f9YiWjuLQeCqopqRRcf2TZKmw
         nSYCjCJsITmtC6B+Fb8Kfw5SWCO8Modpbe9WtSKoFisnM0vhVV++PSqBntoBbpAux5n3
         JLRX2uwRwXR8yrFRW80DDymmIk6Dw/cehURdiCJk9eKFFZYLtNP7r+zlc5s0euH5uxNh
         bhlw==
X-Forwarded-Encrypted: i=1; AKwUvBzBDdJGw7QB4b8OvrUXbKnPlZSwfjecz5fRBa7C1GSySOGSrsRUYzuOgKzv0hov0QENmefK0oZtCG8+Xh8=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ9v0s5x52/b22xEEsIwf0qEQXnAcYMOUcUjk69ZpsILUdFSuJK
	XAVYZt9xihPJkaUetptpAuFfrIi6uJIHVZRsXqVcoECovTzwQmVWXo8R
X-Gm-Gg: AYBFou1kkvv9LtpJWQoZ1ygCUQivhgR/9yHE96+uYeWI0UVc59XEg6buisSHEWu6+4d
	ZemoFybzqJSv8jRuqo4+gc29EyAA0nvyBvdJllWgOYvjsFYj2YtOG6iTQpKjp3KR9BTD6/hGfLY
	qrea10eeLtgeMkGDkJMoLpM6O0Km/KXnYgLTuZ3ESO3IBnvw0WPDXBc6IeECPucfPgfsABNrvBg
	zr5mlSAWaBGAOVjnGQhKI0Ge7aDYEDkLvsJlA/gjTacN2lUuJilzuwpYhHNLFVRLcheKhvzxEbI
	VoVl0Mbz4XLVHa924nHx4QQqJ6c1LWkDGHCP1H1wnpuwcGr/VQXeN21FGdjHlOfflIsxDN4oyb5
	i613+FaYQ1Zzujj5CTGzyUYNshv/YLx/8X2i3Vuhyz2SPgqZVl+FlhOm0GbXtyivfKmcYdmqU37
	+MeX6SdsxUzu7QjVXnZfqXT6O6RouiuJtVADcu4LICROtoVljT/ZFkK8EPPjEMuqv2aHTYkq48g
	qfj
X-Received: by 2002:a05:6a20:c885:b0:3de:57da:7fa6 with SMTP id adf61e73a8af0-3e26fb93cc3mr773371637.39.1792474152912;
        Mon, 19 Oct 2026 22:29:12 -0700 (PDT)
Received: from hachimi ([101.5.175.4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cd654eaf4e3sm4406759a12.26.2026.10.19.22.29.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 22:29:12 -0700 (PDT)
From: Lanfeng Wei <xlfylawarthur@gmail.com>
To: hamzamahfooz@linux.microsoft.com
Cc: airlied@gmail.com,
	decui@microsoft.com,
	dri-devel@lists.freedesktop.org,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	longli@microsoft.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	regressions@lists.linux.dev,
	simona@ffwll.ch,
	ssengar@linux.microsoft.com,
	stable@vger.kernel.org,
	tzimmermann@suse.de,
	xlfylawarthur@gmail.com
Subject: Re: [PATCH] drm/hyperv: add a parameter to disable the vblank timer
Date: Tue, 20 Oct 2026 13:28:47 +0800
Message-ID: <20261020052849.9241-1-xlfylawarthur@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <atZjtSlZAocUWYBS@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <atZjtSlZAocUWYBS@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Post: <mailto:linux-hyperv@vger.kernel.org>
List-Help: <mailto:linux-hyperv+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hyperv+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 19 Oct 2026 14:38:45 -0400, Hamza Mahfooz wrote:
> I actually have been working on cursor plane support for hyperv-drm.
> I'll post a patch soon.

That will be great. When the patch is ready I'll validate that the
problem at hand is settled.

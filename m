Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792474491;
	b=OgiXrntVdVS611jDKhwVJFgS08Irmm896QgVAsK91mshun7Bq68Kqk8woufoykIRYy1s
	 dsAz1IewzRnjLOjjKDpmRJVn0XrfWEb6D/RLMaBJRrZmg2PblrQZOFkBq8Vqa+V+FcpWu
	 ocCrKkxtU6gvIz/A80WAKSW5eIrVN5Oy6lLCuq8bQetGhhLDCyaogRgco5jjQvofzLeKg
	 FNMldWDycnyv7DnV+NkLWX2fBTaiRM75HzxmvoPbyadgv1L7iht/M0N5HnU0jiFUufjCd
	 JBIcTsrxZvtbGTLpVZY3F9gA1aKkiacpc46bxghP039wbkXeHM9/gsMyorqnLAFsSyA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792474491;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=aQfHHrXMXLY2j/M6I94/T8E0vvM8q6x0cxn+YnCDD4k=;
	b=JCQbNwXGyCMZog2T7eAU9IK6GTEzr6oDTFaG+G8MajhpGtt5tECHhmSXzuDo4akE3V8G
	 6r0J7wbUcVb5MXscrWb8x8oakHUgWq0oo3LiTzYfnDepOi4RWZD42qy8bVVeqfVC2u4bn
	 4+MZ4vGiZGRO0xO+ipIvWm+TU0Al98qtpeDp7hWhIekT9dnRHIfdSBhp/T2exTKfp5pUG
	 yJ8SC/Q6Lb4YFoUgWtFUIlZyRXtjb9hOoQ7r3WKZkkZ032VxBo3cfc4rMEYW5UjfLQj9T
	 rOPJM+Gcv3TTCaDiwFtc2+Y0fmJVLkaJkfJ+XC0ut1904qK6fWkAcj4eRlLLjrGB9/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Fs5p+QqU;
	arc=none smtp.remote-ip=209.85.216.42
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4E0F606A331
	for <linux-hyperv@vger.kernel.org>; Tue, 20 Oct 2026 05:34:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A4E0F606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Fs5p+QqU
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3ac7c7b3a90so1331020a91.3
        for <linux-hyperv@vger.kernel.org>; Mon, 19 Oct 2026 22:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792474490; x=1793079290; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aQfHHrXMXLY2j/M6I94/T8E0vvM8q6x0cxn+YnCDD4k=;
        b=Fs5p+QqUCKPcdPkITuqn2vGo9SkU7aHtyOKb5qh0D2/mN6+uLCmUXq+UbtxKt+kpT8
         /y/IRsdvzo7lZneeJbbqB80oks+9KC4Tt3+RfSEL/5jCNS5zJJ882fDri/zAEP4c6V4b
         18U5Hx12o6dO5vfmMnuijVlFHKfI3XiFsJ+yqmEM5bonPPOW1YU7l5t/TD8MN3pH95Vq
         /pguadP4d5v/I/pQKKuuwevLO/et+ZlVlDR90StAShUGfSfscvpcPoKVzIpZcq8B8Wp5
         pbfHenTBqUpwDJPqE6OM3QWreyjDqqQAustBE69mnwZYGvGG1KhQVMqD9zt7uJAftN1x
         qo7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792474490; x=1793079290;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=aQfHHrXMXLY2j/M6I94/T8E0vvM8q6x0cxn+YnCDD4k=;
        b=M5nP7Ap81MbWC9i1+bhmz/4IRbDJ4AmDMZaAdEBnZy3+uUlNx3mgpg7GJ/Cqlbei83
         x2JMG+UbyVMEjGa6o9TgXONam277TMiEXVKJYD6YMA5A6jDZa7lB3g/k98TYK84eBNbl
         vtdw2o9/iiTzKK3hI9QycQqx4i4QzfJVgSObQLwa+SO4f/BWzHmbimxscEITismPzCTP
         hzKpnn+eZ2y3HD4lvLYtZVifO9nwfyDWc+FWRZPMVnryZzcmLvZXzmp9AwADF9GwIPCH
         A93vx9Hvxl03AVldfyERMxN4KlhWdL+ulcryynpisW3NfvLDhKD8JV/diYzfaHH9F6+Z
         l9dA==
X-Forwarded-Encrypted: i=1; AKwUvBzzUUwu4ilSprqlpV3zxpkXHsjPJG++Nfc1Nn4viWLxTg4EL+GEEHQ6oJvBaUeTH2ZC+OoxQFYFBcwjU/k=@vger.kernel.org
X-Gm-Message-State: AFq9FYIHd/UUbmcEfBMvu4vim+bFTLkFHPXH2PU80WGjIxD1ABA/25xP
	bSYw2u3JoJN+PG/h6DOEZt1SgaU0tPWLwk8k+S6Zn4eCMIZ0mHg8XS/A
X-Gm-Gg: AYBFou1vUadP7dhgBn5EsfcbxLzGrqAJwEo23KZphJ0ZT4q8pnKBpV1rkvSme3V3p+F
	XCLm/NEfs77cqrUHpdYmyfc34gdoY4ADXFV9my7Z5mO+kcIiSkDubLLWllkhfz9dODUWPc6IrYp
	vjQSMOTN1cm+v6oRRjgtNQ5DFl2IXOISDsf3HiawMzrCoN5aiIBrmfKGJQnMANw6sQsL8hMEr6k
	09Uexy0YOmtnjreWFwPwCs/whMQxKlDo23w4LoNQVofHA6HymikiH/9LcatGdaaFtDZ3m6/T2dG
	eMo9SsV7aigeR7JP0AW4een7WRZkYycaPyrHRbg2vx3ZpGDZoMI6NPNeZ5ornngZgYgdmR6aSkj
	ZcADQR+YhdZjUAnVwGPkIkFcQlFPHBVtOtuXgaQkDqiihcQHMK1cdXmmuV6zTwFLh4EyJ3G6BhC
	enRU/2lrQj21sn5Y15/PGaQzstf7O2EXIz38uign6gFEhzOsImd/I9PDFhOLIQnY90mQ==
X-Received: by 2002:a17:90b:582f:b0:3aa:f4af:1e0b with SMTP id 98e67ed59e1d1-3acee98d90emr8576204a91.8.1792474489983;
        Mon, 19 Oct 2026 22:34:49 -0700 (PDT)
Received: from hachimi ([101.5.175.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ad60102ebdsm2216041a91.1.2026.10.19.22.34.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 22:34:49 -0700 (PDT)
From: Lanfeng Wei <xlfylawarthur@gmail.com>
To: tzimmermann@suse.de
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
	xlfylawarthur@gmail.com
Subject: Re: [PATCH] drm/hyperv: add a parameter to disable the vblank timer
Date: Tue, 20 Oct 2026 13:34:09 +0800
Message-ID: <20261020053433.9419-1-xlfylawarthur@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <8e91baa4-1ca5-43b8-bb04-9b5e3630bc2b@suse.de>
References: <8e91baa4-1ca5-43b8-bb04-9b5e3630bc2b@suse.de>
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

On Mon, 19 Oct 2026 18:03:55 +0200, Thomas Zimmermann wrote:
> The problem is that module parameters are impossible to remove in 
> practice. Once in place, someone always depends on it. They also 
> increase the number of states to test.  Avoiding them is usually a good 
> idea. Especially as workarounds for bug or regressions.

Understood. Since Hamza is working on an implementation of cursor plane,
I think this patch can be dropped for now.

Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AC6449CF4E
	for <linux-hyperv@vger.kernel.org>; Mon,  7 Sep 2026 11:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788781336; cv=none; b=Q2twJy3TepZVDCvwipLNhXKRNGQ02xNEnDTKggwVYeqCb1Ubpt/CdiLjEbSS60GmO7jFahCcDmKAhAr4smjZDRI82V1vvjRMZwQya8mF8qnFFw2bUPro4jrHcKdZ0tRj/MYrWBnWAoyu2QeC+Vrcu+JrKuFEefAgqZMe4A6Ghls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788781336; c=relaxed/simple;
	bh=hHeiRqmB1FRpX+KG71zvP3RGgMVickO36D/WYtf2o1I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XQuPN+q8xE+ru5EEafjQzhZi2d5lZtdk4/isRix/JokmwmM+68D5uu3gsU/h/yS+USjgM1il+BR9BoyVId+yuJAfS0sMx3qdvx6RWdQb6zcczkdDbX9OMiKrOETT4h/Xi7nleNF/Uch7jP3ecDyAk5Uk/qNdmZ60/xeeKyPYOAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oyrUwi7+; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oyrUwi7+"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-cc1cc97b84bso2599768a12.1
        for <linux-hyperv@vger.kernel.org>; Mon, 07 Sep 2026 04:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788781334; x=1789386134; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oqStjuc2LDPUV/Q2Nk12Wd/b6K/JeFHmcf3IRlK3lXc=;
        b=oyrUwi7+WQsCr5e+q+D0l5Ir59jMiPK9ATkIEGb3yH37DCQrW9t1vKhCO+g0+RutN2
         eAYHxp403PB/snN47pqKcE8mBr2WpSn4Qg2zJJIUwwhqRJM0VslRFqqJkpRbDACaYn6R
         KdMIPSpphw0jADLuHXKN9ikMk5qkp9IGU8ap445dBT1DKf/aD+IwggqTOTQaXvnl2nsn
         wsKpm09o2l8lSC88EaybFaj52xU0F4TitjQDiWv2Ie6Jr8fx7+YN4UXawv/6vxsuWDws
         GCem7w1XNsaI1cFaYcaNc5pFAB6FeTKyUNk7CJtyK8ITPmOwBvJOq5bFI9hRRPNYn9Yz
         KF7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788781334; x=1789386134;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=oqStjuc2LDPUV/Q2Nk12Wd/b6K/JeFHmcf3IRlK3lXc=;
        b=pXhzB0+muUlIiIW+Ws1MlaoEBMBRG+hSVKXlGXsWG/lBCENlB6Qp4mPrGCq7t8Q04N
         IacUrT7Hs9oeA6Z6hfo1EoE2dZwQhv1GWV4hKLBwY5zeP2ZkzDySn7bgvwAt5mpEkKwF
         y+lNVw8Ob3kMYyTF/vzPdXU0SrTzve8e84qSqmeQVvjlpzKAoZAHQp397iyuuu2hfcxd
         tLj9wSpVr6ojMtiPycu1nSFuCwPZWzEiJsTkO9WP9+f/sBStGpNVXA2RGIxQapQUkv7J
         /c9+1nOaEbsR5NOvgrdGQQ8a35hG/3KOLNJer1ZQdyg+a9tWcXDlM7NcJ/LZ2gfTaF9s
         /KHA==
X-Forwarded-Encrypted: i=1; AKwUvBxCqX7Fv6c/CaKwQeq3zuIzeANIQf1AWcBvj4AnNDCCdx/5tZPgelNdU/povbhzavOmbr7YseG+K9tjRBQ=@vger.kernel.org
X-Gm-Message-State: AFuF++kaXgXj+ZHDjgMequ5zjWJ9NFfd40v46JMCpu3h/H/KCjHiFky4
	JeCIeGqyP5JwWDVDzAZaU2hvS/U8/IDzjXIN3vQTquP++1HcvN9WOdyS
X-Gm-Gg: AYBFou1fK1UhDGNM4dg6i7YoygbadxyCGwOxJfhVn7ALzGWmwimuccoePsyDkY+CzRQ
	qnH22KqM9cdrihamdha7rHdzxBgpGimwWZhOay6XhpsXRPY2UQZgK/fNnI2qDCXARR+2Ezjp643
	1VWKBbsGXHkEgtW5MKPh9/gJ5+GcTsxYfcVpBaM+YbmuSxEAF63HiZQlIURWlkgNnqfZhmPdWH0
	u4191mMH8gCl35gYNo6lBR1mweYy+iDK4F7bw4yNu5CQ6SwC+2rrhH4Rql4aL8uXjbGCVN+Y+sq
	lVeBi/Sxw20lJgQQmv1zbdVgjFB1k4m+736eO2QkjJwDFtt7yjOZ1hcb4G5+pcfcs88gGXqtHG6
	OWGPRr1Yf01wsLxbWlng/8xvJZqXB64XIyz74jO/iA2kl6NCQ6AOYQOk5O4V0YYa+2nndL8Jxaa
	H8RzcVBBQGK1eCRL61e5dineBQSd7vR7bjJ33R2MlyXhUoGt9madYYdeNHH927PQua+JR/YN5yS
	mvdGz6/WxqXTw==
X-Received: by 2002:a17:90b:35cb:b0:398:a486:81ec with SMTP id 98e67ed59e1d1-39b261ae617mr38801924a91.11.1788781334237;
        Mon, 07 Sep 2026 04:42:14 -0700 (PDT)
Received: from volcano9f6e-hostos.amd.com ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33825669695sm5249874eec.3.2026.09.07.04.42.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 04:42:13 -0700 (PDT)
From: Hemanth Selam <hemanth.selam@gmail.com>
To: Naman Jain <namjain@linux.microsoft.com>
Cc: "K . Y . Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Michael Kelley <mhklinux@outlook.com>
Subject: Re: [PATCH v2 1/2] Drivers: hv: vmbus: fix typo "substract" in comment
Date: Mon,  7 Sep 2026 17:12:03 +0530
Message-ID: <20260907114203.40171-2-hemanth.selam@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <f307de11-8915-47f9-a743-250296f10804@linux.microsoft.com>
References: <20260907044946.10813-1-hemanth.selam@gmail.com> <20260907044946.10813-2-hemanth.selam@gmail.com> <f307de11-8915-47f9-a743-250296f10804@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 07 Sep 2026, Naman Jain wrote:
> The change-log (these 3 lines) go after "---" line as a comment so that
> these do not get propagated to the git log in kernel tree.

Understood, thanks for the pointer and the example.  The changelog belongs
below the "---", not in the commit message.  I have moved it there for the
respins that went out after this one.

Since the diff itself is unchanged and Michael's Reviewed-by still stands,
please just drop the three lines when you apply it.  Happy to send a v3
with the changelog in the right place if you would rather have that.

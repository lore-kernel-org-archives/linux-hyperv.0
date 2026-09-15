Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21B94411FB8
	for <linux-hyperv@vger.kernel.org>; Tue, 15 Sep 2026 07:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789455719; cv=none; b=d1D5RYhDzKjdlcZ5eWO7yTCP3POMsEYBeE9y6BR/0Jv0UFFWinXczg4CfWY51/uONoF4X9DXRqQctGZEilWgTXump+RoB1/fQYFzkavWp0CgIHSjz+MuBAe/gPqv+Qk/LPO6uEkxTIjQdG2IsPHtkYbRGwEfXwSyRJPS9aqXg+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789455719; c=relaxed/simple;
	bh=ABFOqz8UGc+zjPjHLhOhSBB0474o5YlUncpSARnh6QE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NytHlrNZBWsVVGKcqibvsob1+Lh3gqLczLJ06v13pS7QcrFtv6zxaB8YIaUkMY/zQMM+908ZeRUl3pcP3/PFxLoUOiksB/eH69opaDZ+wcVHzINcsu4aBQxTTfeE4KA9/UJnktXauNObpLwQM5F89IUNQMfpOB9EuwlXxJfvvjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c5FcIRae; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c5FcIRae"
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-6c1983dfaffso3445659eaf.2
        for <linux-hyperv@vger.kernel.org>; Tue, 15 Sep 2026 00:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789455717; x=1790060517; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QlLsnBAMZpYcEf/Y8Ex2NqI4my9dQsnrWeEoJz1UkLY=;
        b=c5FcIRaeaYzWU3nHfwC1tLoeU88ipu1tOReXbSs5vXcsbFBWP1XBR5JJyzMaiL0De2
         kJyrs3o9uv3Q+6vGHdf5EstpJxsGVr0nrUZzmUNOYr772jZ6lrkXK35IMDsALf3K8O4I
         NV33JStmgbhkPiwd3E1whHtW9l//vgVRLw0qXyPItd12rz7Oj7z8Rh34wCuFvGEjlp8W
         o2t1QGspkHmn06B0DGa+G1H+pjDk9hSSs7HJ9GMCE0VaZkOEw7nzf6qbOABzWWf7cflP
         FeGi9neFs61VOBOq7IYuaEp3MjjMZqC6CPCpf5nNCsv47qoz5VDqAn0fUQbJcE5YBm9S
         T6kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789455717; x=1790060517;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=QlLsnBAMZpYcEf/Y8Ex2NqI4my9dQsnrWeEoJz1UkLY=;
        b=Hlo1CW4SOs/CdsdjEsALDxVa89i7haIK/ZyNb/8uZisKw4rXvChrfIYJnaKiyuZ8jQ
         JmFvkyD/6MYFwXuDagjohg9+n6UehxCTJ+UjaNhpCDjYHCLen7maP6CEh/dxz2lmXPR4
         ly90ClNKrUj6UQ2C/N1qRVW+OLmvKd2w0f+JY1hozum9O9hucXYdT9tJc8Lc1S52FuK9
         YRNU08puy1aBj32GSbvBUDUROo7nt+AGOXOuogMbcDHt3EYQ+JvyaQwC0eC4ohkNqD5f
         x9Rjz3YYY2RIakdcZpayEk/72LVO+7gm9IAbSLz2Cdiil9j4BsER+Z3dVuX+92yyUWYS
         y/TA==
X-Forwarded-Encrypted: i=1; AKwUvBwRcAPG3LEdsHacgqtXFVS96830FV3N7R5RjtgJi5kP7Enrk0FtxwcxbyN+JutDW2eeVPVVZ8GyEpGB8kk=@vger.kernel.org
X-Gm-Message-State: AFuF++mv5jw1nblTeP8v7irgH9etiSUoPEJW+9w310t+0aeApdJE+OXv
	jialHomHrvRHEG5x8gb5928iSbqSDXWn1D8/dSt5ibbuxaHXkXoAAQNI
X-Gm-Gg: AYBFou1Zsv7hLdR2AED4hRE6JSqP5Yt7/p95aKTLuco/AsuHY+RZoi2wHz0G+e6hEBO
	YBBMyaU+QuNqkDtnMs5NlBNJIhWrghqbkmiWg3WSBR9lFJw6Gyh1Eesn1UqKRKIp3dMGIA+HVaN
	xG1v2XkHI1ejS88fR0EIMscBW02L9NmM80UzLOZ8nnrWuK19mdgQLYl7vh9afJGhzmTUiuQep/z
	CE9DsVDVdZn/nz6o596IPMZ/L22Alq9L4MV3kWN3O2UOvjAnPL66F6JRzSamzqxlNwAx5qoup1s
	rFMN4x7J4+Dyp+M4f3DlB3Ek7U/e5YwjrZmGxYOn5HkdvcTUZDZJg26qI3ooY8Tzbsh/8Jn06c0
	ON+FlpVSpc1K13A8xGqASViKgJYEEFayNh/6kOVq9OxzvoDEzGb47EC4uhbSHi7qFKt9k3twIti
	le1hwsKPeIbxtS+x6dpAiXiVtmdhVRLdDZc8o/SFJ9fA2rmEDo5/mpoUwm+62k0COcK3wdF8KmF
	tlm56v6qGrjB5eki3uFzo4J
X-Received: by 2002:a05:6820:4de7:b0:6c0:5d5a:e0e5 with SMTP id 006d021491bc7-6c540772e7fmr3296040eaf.29.1789455712197;
        Tue, 15 Sep 2026 00:01:52 -0700 (PDT)
Received: from volcano9f6e-hostos.amd.com ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14365b97994sm56553791c88.12.2026.09.15.00.01.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 00:01:51 -0700 (PDT)
From: Hemanth Selam <hemanth.selam@gmail.com>
To: Wei Liu <wei.liu@kernel.org>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Dexuan Cui <decui@microsoft.com>
Cc: Michael Kelley <mhklinux@outlook.com>,
	Long Li <longli@microsoft.com>,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/2] Drivers: hv: fix typos in comments
Date: Tue, 15 Sep 2026 12:31:43 +0530
Message-ID: <cover.1789455635.git.hemanth.selam@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260907044946.10813-1-hemanth.selam@gmail.com>
References: <20260907044946.10813-1-hemanth.selam@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Two one-line comment typo fixes.  The diffs are unchanged from v2.

v3:
 - Trimmed the commit messages down to a single line each (Wei Liu).
 - Dropped the Assisted-by trailer naming the model.
 - Moved the note about the v1 -> v2 subject prefix change out of patch
   1/2's commit message and into this cover letter: the prefix became
   "Drivers: hv: vmbus:" to match the subsystem's history, as Michael
   Kelley pointed out.

Michael Kelley's Reviewed-by is carried over on both patches, as neither
diff changed.

v2: https://lore.kernel.org/all/20260907044946.10813-1-hemanth.selam@gmail.com/


Hemanth Selam (2):
  Drivers: hv: vmbus: fix typo "substract" in comment
  tools/hv: fix typo "retrive" in comment

 drivers/hv/channel.c        | 2 +-
 tools/hv/hv_get_dns_info.sh | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

-- 
2.48.1


Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6561E37DABD
	for <linux-hyperv@vger.kernel.org>; Mon,  7 Sep 2026 04:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788756600; cv=none; b=ls7cASzcBTYkVMHQ0tKjB+2gCb5pgL84hGXR35XDVEkR1YuX6Rlf5ORnVpliPUOAF3bgIgmW/5A2sAgvar+5NI2sH+pmFahcH2mBYumuUXFn3r+hBgJVKonSv3qQHgMiPBTzDTFqeoz/j9QpJ9tm1gcm66Ie/YERFROmIjVTaRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788756600; c=relaxed/simple;
	bh=a5vKky6NbLyr38oXxq7MIKbruEkJYLJZsO73SUtrQdU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XOgfxMHIR4VMtmoWRE2cyK2R3SFl9iBO5hcYqKdO+x9QzT4WA8qYcE5TdOA33UtmKbaRn5w3w8eNb6PlaUd0+ZX9n8doXAfo5hkYCiNNgeCGxwBeTTr6yEdNq9qk3CbYrkgUCFsWS5Sg06yaVlLbieGNypOGVzyY8yL2NpVQq+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UJb6subl; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UJb6subl"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-cc1c3c90074so2529915a12.2
        for <linux-hyperv@vger.kernel.org>; Sun, 06 Sep 2026 21:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788756599; x=1789361399; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wGucqe92yoJCxfRYePeuZqTvKX2vXvu73cS4wSZKByY=;
        b=UJb6sublkLIlOeo2vKiwFbcvqDQr74v/vQOH/QnkAydv3Ezw/3f3MqVRUXMaZa98BB
         nOwycU6mb7JAhhnj7+XN3mT6Y/VYnlhhWrzaR4EdATxy7VOfekfp7pMDUp0pt31L7ovj
         TXQAxhrkzEalNWlboAgmJEENB0fekQnr5T2tClgYRr9MUfifxYisanY73X+ZG+Y+SE8e
         /RBZOEfq9gAAkJKonf1fLbp5zxhD4W8E8zSBic3KWW9cGYLw2NNCkhZvQT1pUS3svwSO
         d2Sb2Ogli8Pdw5sksMY7OslQ0XlbzQLq1TmZC5VIJ5oxQ5mL/Pp7ORZ0ptTVbYQhTo4K
         mpJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788756599; x=1789361399;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=wGucqe92yoJCxfRYePeuZqTvKX2vXvu73cS4wSZKByY=;
        b=UtrddX881c4+0ylhUXGp0inAAemiNyVqyOtfBzY8tG+lmvbPm4wONLi0Yn1K3QqCko
         jfRmFTMWWKGQW8bmPLAOD92iRhUb9VwlpUY9u8bI2ApJqBB95ljynuqujkIwMHIUpq1X
         vZxImJvKlPyZSdLWlmZen5IrhsEI73A2QEQwhTIopV5AwYgK2pQTztH8hjRy63idi7UK
         EGI4Z/8Or1xXhsaPoR3FQ6GNxobYDVBMUsTMk7AjLLNg0KJKvgoQyDtlRe6vov5Xr4LO
         RW28HvxO4dRqxMAFRhsWAXLwLAOdlgIwo/zXwAry6I8FkoVyIU7ZJ57/L1pjyEIHQY4w
         G+tA==
X-Gm-Message-State: AFuF++nq8hPJak+z7GWr1bbN2Stp2MDXzh1j6Bc73H5V6F8uZI71bWAK
	fxUmTVV8tb50wcWW833Ck9a5LAiqsQRKscnzGyaHjHyoe2pi883X2fRY
X-Gm-Gg: AYBFou0WiIfqyhIpQhzcrIoRfeOXrNHFEbsDC/aPRxkjttyo0gnYXOZJ/4IH8R4OUw6
	bbX98QCHlet3rGwZwwzcLfCtO1zmuT55rmtfUHVpGXKyDD8kw/tvi+36AQs4it+/ksAZjanD8h0
	CZqBStK9l+lmDfQEDy1vPGA0fsonYp2zD7/b9luH5m1/ROXi9/Ivs29LhXha0L2N6lGuZ7tC1WY
	EM6+8tkC3X4/fFGNId+RahGmu884N6sV4+clZeYVbyWvseRfgQmK6ZQgB/A2bVHjtguWTm4M+E4
	kXo38UzBbYO9QXHFkbL5oBR529ynAmE0UTDV0NhAHw6JA6WlVC+xQ/rHHXb3jIHjykbyPgUnsep
	K9QGe3iA6cWEyWdkgLRAMiBEncHi/HvlMcYuSWtn8KZpFZjZ6VumvHdQPoKsMWz7qSM3aT18jgX
	5Irrkk6ETxV5wwvI3KbtnptPQhHj5vKmyY8astxUKYqGK65352T2loi0wx8CrE+nwwqY6bGRbAK
	EcznzJulNAjfw==
X-Received: by 2002:a05:6a21:3a4a:b0:3d3:ad3c:49a7 with SMTP id adf61e73a8af0-3da3a1ae36fmr36693461637.21.1788756598703;
        Sun, 06 Sep 2026 21:49:58 -0700 (PDT)
Received: from volcano9f6e-hostos.amd.com ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339a62be87sm21501484eec.6.2026.09.06.21.49.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2026 21:49:58 -0700 (PDT)
From: Hemanth Selam <hemanth.selam@gmail.com>
To: "K . Y . Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>
Cc: linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Michael Kelley <mhklinux@outlook.com>
Subject: [PATCH v2 2/2] tools/hv: fix typo "retrive" in comment
Date: Mon,  7 Sep 2026 10:19:46 +0530
Message-ID: <20260907044946.10813-3-hemanth.selam@gmail.com>
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

Correct "retrive" to "retrieve", reported by scripts/checkpatch.pl using
the misspelling list in scripts/spelling.txt.  Only touches a comment, no
code changes.

Assisted-by: Cursor:claude-opus-5
Reviewed-by: Michael Kelley <mhklinux@outlook.com>
Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>
---
 tools/hv/hv_get_dns_info.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/hv/hv_get_dns_info.sh b/tools/hv/hv_get_dns_info.sh
index 268521234d4b..288821565eee 100755
--- a/tools/hv/hv_get_dns_info.sh
+++ b/tools/hv/hv_get_dns_info.sh
@@ -1,6 +1,6 @@
 #!/bin/sh
 
-# This example script parses /etc/resolv.conf to retrive DNS information.
+# This example script parses /etc/resolv.conf to retrieve DNS information.
 # In the interest of keeping the KVP daemon code free of distro specific
 # information; the kvp daemon code invokes this external script to gather
 # DNS information.

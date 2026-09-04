Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D68CB47D473
	for <linux-hyperv@vger.kernel.org>; Fri,  4 Sep 2026 12:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788523750; cv=none; b=KxBzxlo0db8EUwEF4IQCtC0w4F4VScsFZYyFLHjx3N4xqROyjhdDTd+DWSeXF459oiVjBF3cKFUZ6IKH90pyE/nkxQ5hp15KzjuICcsYAIiN9O5W+yyPtPKRrtCQ09kQ0Iyd42vl3Llht4fgnAmGAiVirV0hhcNXveMS9dVwMUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788523750; c=relaxed/simple;
	bh=QDbW+PP7RmEGFUx5i7K/d9Z75hrQRBhakSjU3DZDJmk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KO2mL15kDyp1OsQk2l8UzUcuZCuqFgdSE5stcw4xrf2h5Bhrg3DjxAhpgA8O6DGKNgUKg9fTBkiS1d9mIEbOsxZZfZnEfmxLlDEK9R9gRkkrTG5uZyLBvvydLKIehC3Usl+Cvoacli4pT9e4x3EGoLQy9wgiwLFdwZXmwtEZOtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=folFgJRo; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="folFgJRo"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-395cf2535acso1019541a91.1
        for <linux-hyperv@vger.kernel.org>; Fri, 04 Sep 2026 05:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788523748; x=1789128548; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Bi/TyPhd7e1pxmGeouC4FIAlsi+yXBXw89IpRah4BD0=;
        b=folFgJRoHzimU0LTR5b9uuQJQXfJy589U133D8FwiFPM33vd6/7crtLxErJPIrJTIy
         3gUXanVT5rqMu+zHHNL2NleQUu4qwKmBRSr89n7kSwZvrTEarE6GiwoBj51Eq53ieH0N
         aGDU18naaLZsUiekxXjA4IoNF1rQH6dQrbC6HzT67ddYdAq4ktlRJ8aMR+IDJBTa0Wk/
         9Vbwe1lg4rrR/thWjJBTR2+dgc/qRggWq0Fr7LyUQWxrwN5BOBS3zhlvpOPzfeTBqK/P
         vQYu5yFBw0o1sTJnhFg6PYdGw3uB/pJkFxMJiTaXEFeYYFn3PpSz2zj/uwBBAkhA4jGf
         Xegg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788523748; x=1789128548;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Bi/TyPhd7e1pxmGeouC4FIAlsi+yXBXw89IpRah4BD0=;
        b=XY8TKbfeQCm/MNFhx4X/g9a0r7ztCe9h8CIn/TKbx/lKzzUws+pR3DgoZvSsEzbZji
         1AvvZ4koI27mAr4I8D2mTeZqB9rov+tZVZ8FM0Kh3Wo+xpmmF/CRKdS1Gba8H3gg43fq
         jWDuiJnaNcbvnx8977TPXxbC48FdjHn077AvgourVVAHj6UheOJ2wzzjUfXXdGik/OyR
         dUPdjZkzctfEJPoICuPtxiv9cE7IIst6FeHvMclW5sl1WaNQlWByZuB2VsNP/MwNzE4Q
         7U2AvJXKuZH1txvc+Xm7YbWcWUDJviOcOKJ6GAxet0RUuyWMPsrcok5sTx1UNTYolomS
         5l1A==
X-Forwarded-Encrypted: i=1; AKwUvBytxZplhHXZj0HhH8N12f1mRyNTM6/NuhG84icnRuZMb13ZxfPfoQel/k2Nul8zxXFacs+i9r7lSXx26Ys=@vger.kernel.org
X-Gm-Message-State: AFuF++ncYMIYBrW2cLxAUcNoRnFNoMJYuMe4Rj6KxtoH1f6VnrlRjp6k
	UbC0p7OiEjCAIGYMBJScOcHh4DHUC2FoM6iRq34TmnjyNnCTZcBz1bIyw7eyGVcqkVc=
X-Gm-Gg: AYBFou2Yu9PMvV6Ix/a6R/DCo7ar1bm4In9tTDyKEItDtLf+H4hS/g32UmlpqxLMZ1t
	H9eQrqHVDjJiphvYT/ffjlMTtNgLPfXzU0yhfcqdHnPSzP+F2E7B3TmOOCcQFTmJ5pqiASx4MMA
	LN44SqOGiNyzDvtEma385mdPgo++SC1Fsh+j4ePzxd/IHFFc1PZdaujDHKFzMRWAvtTmyMuVrXZ
	EtqvGT+NtKgyPjyyi3dAVznQc8iKJ94gwsu5/yEAxzuQOBvWJp1XtaCqA9ro+7Sin4fbnGpqaXR
	BRjhFfod6ndogOuDw7nerGbQpC33pbyWjpjJj4Rmgx9wXuk3OiRDYNVnbipTsji2z8S00E4QSEl
	J7pzjDQzM8VtlGkxoA/h+IUoSEgv2OvDQGS1EN5+28K3uk0tiSC49VInZgAcEoHCd6XpnyDclrD
	PZH/zgWBTJphUXOfL0hZTZ9M7vVynAuYm3Ljw14zhw3iRv+OJf4+XZ2GxVrCdlulLi6DiC+5tXS
	C2yI8q8MTk2klE=
X-Received: by 2002:a17:90b:2e46:b0:38f:a81:15b1 with SMTP id 98e67ed59e1d1-39b08653554mr16439244a91.19.1788523748053;
        Fri, 04 Sep 2026 05:09:08 -0700 (PDT)
Received: from volcano9f6e-hostos.amd.com ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339a62be87sm5730826eec.6.2026.09.04.05.09.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 05:09:07 -0700 (PDT)
From: Hemanth Selam <hemanth.selam@gmail.com>
To: "K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>
Cc: linux-kernel@vger.kernel.org,
	linux-hyperv@vger.kernel.org
Subject: [PATCH 2/2] tools/hv: fix typo "retrive" in comment
Date: Fri,  4 Sep 2026 17:38:55 +0530
Message-ID: <20260904120857.20431-3-hemanth.selam@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260904120857.20431-1-hemanth.selam@gmail.com>
References: <20260904120857.20431-1-hemanth.selam@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Correct "retrive" to "retrieve", reported by scripts/checkpatch.pl using
the misspelling list in scripts/spelling.txt.  Only touches comments, no
code changes.

Assisted-by: Cursor:claude-opus-5
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
-- 
2.48.1


Received: from mail-oo2-f40.google.com (mail-oo2-f40.google.com [74.125.231.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6933043C7C4
	for <linux-hyperv@vger.kernel.org>; Tue, 15 Sep 2026 07:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789455722; cv=none; b=eymLESlRcWolYz2kCE0/DPpnTe32NmDkFyyxqI1MqEOBFWSiupl679UxlQBWD4JhqVRChJ78quOzNyA+22R569e3nfvzbT6h/TZiYoyh7jSXa3CCTfvcdAiq1oMPEwQ0MteFptrPXRHltLRTyyimeP50QuptNpy6mdBVBPBHhSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789455722; c=relaxed/simple;
	bh=wADxDyewyOsUCJtETMgNzxY4kTMGU5c75K1QgMa7kRI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lMwnZhIS1Dm4vWpP16EiRCR6nxUPdbeYDG3aiHQoGkNhobxTPp65gFt8VcHvvEZpL/ziaU0fnDt4/VM10oI1Bebey4j97OC7wfDn6erb6R3pBVPwK5e8jlx2Xq9m/FJsNhEoPe8K7w/500sfxwT1nrdzh9PAPzQl4XayJH4Yhk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ASrZACSW; arc=none smtp.client-ip=74.125.231.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ASrZACSW"
Received: by mail-oo2-f40.google.com with SMTP id 46e09a7af769-80527255583so1042966a34.1
        for <linux-hyperv@vger.kernel.org>; Tue, 15 Sep 2026 00:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789455720; x=1790060520; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3xCHSjyHMTeilTTEs0go6U5us28HnZkS/RTQ6nrFEXk=;
        b=ASrZACSWJVqC7i0y1vkBujh775pAeuK01EOXVaRE28KwwOdQVDBvJrk9aIqDh0C/2H
         vDTbj4t9t+sa3ZuhdbQhCubDxv8nSPnANuRjSFVy1d5IDdgqPkEe/e3/ej9z6Yvh0vty
         DPkkO8Snn5+6wZdfiSRqImtbe3IFJIZTmY6ybi4qE/eBzGY1f8gJJ0pOyCvirBycqXOf
         kEmoMi5D/PXbInuyihvmYKiyqpO/XXPiPxGBI7eSQG7M/HlQHxhC3jJXaj8WBjbj1F+T
         9m0rUb55knfgJeHyMyXM1Xj4iMVwPTvD2Gpr1Z4iK3h/gxwrcoQUt0HVf8RgXM2IjoOw
         65jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789455720; x=1790060520;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3xCHSjyHMTeilTTEs0go6U5us28HnZkS/RTQ6nrFEXk=;
        b=jpY4fqUQPW2J3IeAilagsBHnjQwT7/jG3UZs8fMKRFdjoMnj7LJcmPcAaxrmufN1a1
         8WP6EZeHg/W+4oiRtf4Z+5z0xgfKvUOrCjAm91IZiiTv7QKScZjSLCJNE1nA98vKRnjZ
         iP98LZ6dcNt+FKuPV4Y09rSkDojFo3j1SQ9DSSWLhc/tZj/+eQ9airLDdV60ie0b0tV6
         VUP5pyQ5AKdlIrlEkarSx3S7EMvedbmB6dAHSgacClNHU6W5iJX1uz+Ebje/9GJ4aF7r
         xwT7DtPa8i843eHwEwwk59FJt376ERzl0GWaNNS7FvgfhScI3/VC4qCoQYwxOg2kGwcJ
         8lqg==
X-Forwarded-Encrypted: i=1; AKwUvBy4INOTkfm+yL4JnJP7sEeoTQXov5CiB/7vH2zLqFLmX+VIE0NyXvFosHr1M9+ouVnnCGDAwatWndGAR3A=@vger.kernel.org
X-Gm-Message-State: AFuF++kHM7/0RMvppFq60VIE8UfqbtCByOiBlIlQDWfiBT4aNFUmrjFj
	KfI+4C/08Wu3jagFSfO8T9GYAQrQzZOeroJPA/Utqs7S9vTEJXrd4mvd
X-Gm-Gg: AYBFou2NZ7wdDHMXEgJo003b1jfQEY0YUyf6R+0VEEzLBRG/qnA9uElX4XomY222phi
	pQfRwmbMOs+Nfx26cOIEw3GC5zsnqiZnykYpxFToVF49Ym4a44KieSf5CPMYg08Hj3tCThlszgO
	6nXsn4F3XSQJGWsdpYRDrYM6c/R57hk2IGOo269KsgmYa/cgyjQeNwpceq8geOYEZH6yAB5LNqt
	RAzlzLRqGQLsbdUj05uFHW0nMeUUKF/Xuw6lNnJ+l4sJ3b0p4s4oz/PO2SmHT0ras9D0Hf/Qd9S
	KTqEmHDbb2lzviKcoFJvCyAvsPBKzk+1zZk2OVk/CmdENrBWzIR9SBrOqfP2BQsBhdCNSfZIRRK
	+V0rOHRZseg5BPkAJ5u3kItoadpo5cnd4G6LNF6aOmXojNli4gs7A5UiEy+Gij/TyzILFF13fJA
	I35HXGG2i/JNKaz8nLUU1iE1GycHhzEZfy2QcU1frAAgn0orgPgag28w5dH6m3SUtPgi53m7STk
	xGldcymchoVBCruoUGe/Aup
X-Received: by 2002:a4a:ee0f:0:b0:6b7:46e9:9706 with SMTP id 006d021491bc7-6c54155ca23mr3546006eaf.54.1789455715477;
        Tue, 15 Sep 2026 00:01:55 -0700 (PDT)
Received: from volcano9f6e-hostos.amd.com ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14365b97994sm56553791c88.12.2026.09.15.00.01.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 00:01:55 -0700 (PDT)
From: Hemanth Selam <hemanth.selam@gmail.com>
To: Wei Liu <wei.liu@kernel.org>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Dexuan Cui <decui@microsoft.com>
Cc: Michael Kelley <mhklinux@outlook.com>,
	Long Li <longli@microsoft.com>,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/2] Drivers: hv: vmbus: fix typo "substract" in comment
Date: Tue, 15 Sep 2026 12:31:44 +0530
Message-ID: <4209afe678a3a9c5930edfd3cc07b57cf897b256.1789455635.git.hemanth.selam@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1789455635.git.hemanth.selam@gmail.com>
References: <20260907044946.10813-1-hemanth.selam@gmail.com> <cover.1789455635.git.hemanth.selam@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Correct "substract" to "subtract".

Reviewed-by: Michael Kelley <mhklinux@outlook.com>
Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>
---
 drivers/hv/channel.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hv/channel.c b/drivers/hv/channel.c
index 7e4cc6f55237..a0883ddf32e2 100644
--- a/drivers/hv/channel.c
+++ b/drivers/hv/channel.c
@@ -79,7 +79,7 @@ static inline u32 hv_ring_gpadl_send_hvpgoffset(u32 offset)
 	 * therefore leaving a (PAGE_SIZE - HV_HYP_PAGE_SIZE) gap.
 	 *
 	 * And to calculate the effective send offset in gpadl, we need to
-	 * substract this gap.
+	 * subtract this gap.
 	 */
 	return (offset - (PAGE_SIZE - HV_HYP_PAGE_SIZE)) >> HV_HYP_PAGE_SHIFT;
 }
-- 
2.48.1


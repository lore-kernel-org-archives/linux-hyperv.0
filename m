Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18D323803E8
	for <linux-hyperv@vger.kernel.org>; Mon, 31 Aug 2026 20:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788206648; cv=none; b=E8ISY+3lOq1CnTS+SQOIxp6OVJ5sWPtSjfPvf+pstBp00V79dhieBck5768Yt5QWLHXVRj6LB6ejjY+8cVMqMbW+C/ejpoLyo92NOFafPQg55ksK/TMJ6D3R+hERPluMlGlr/A6pYgkTgxK0uh7gCK3d3s/j1PAKPi5S9+ROgCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788206648; c=relaxed/simple;
	bh=I4/G3HmEXJ4OVElGeCZxuKwSWS6iAiOY/MRgSX2ruGk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OnpoGkS4bbu41OC9I0CSmyyMgn+CiuBkoVTp0htzzkhWJiCYPJ0WzzeOjCCfQDLACUtaT3Yp6SWdjm3uu4beaJucayUffq3L+J8ZXum/rjFtnQFVpox2IUH46ARVfjbvHUWaL0VwEu8DfeHvW7VKecpTHrXIwmtldchvds7eAuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qgqzQ81z; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qgqzQ81z"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-482dd6ee390so130727f8f.3
        for <linux-hyperv@vger.kernel.org>; Mon, 31 Aug 2026 13:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788206645; x=1788811445; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=I4/G3HmEXJ4OVElGeCZxuKwSWS6iAiOY/MRgSX2ruGk=;
        b=qgqzQ81zhEJh2GPyiNOuPMkOGskPfeeAq0aULF0UsXs8suNQq3ozMHqKtz/JhIsT+7
         g1UsvfbXT5zDCc+ykExEY304yR/LHc+X7kbNv+vGf9VN3ZnCV9XV2CClZ9SEXGuFPXyw
         Yw3OUP+9AR5NdY74J/1iEt/WfSCXv9Y8XN44NWkN8rG55rpNN8Cl8bjC9TIh489pf6kG
         N5dpOgy92t7+BS6Bc/KSyPEnGFbE088CEWbwueLYd/ixrVqneD98Raqp1GnrAofgQc71
         IZZdKhH0Y7MV/aqGO1GGCeR91G9NzsuoQNT1PgyCVSbPv/jq5gYdvErmdRc6nxy68WBF
         6Wyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788206645; x=1788811445;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=I4/G3HmEXJ4OVElGeCZxuKwSWS6iAiOY/MRgSX2ruGk=;
        b=Oi++IQp5Zav+QaRF0bbqaGYAj4uNdSUVctcqvYFfn2wWp2NJIrNoMFXOmDnb42ysYt
         chfZEtKi+IpBRyDolu+eAqAEy0GAE5pNlPu+LrbBpPoeD2sBQtUx+7YBFhxEYGfGUz8U
         E/0U4IJmRhSGvS5HgFrLRNpMVFKV9Qupm/8nm8+Fwv291KUxv9rSPu1bz629s8otwfV5
         65Ui7hM8QgAB+LMIxYNulO02bsqSprH315jZnGGNph0frlwTI8MdTLzykVehQy2g9f8z
         u/drRNROhucbeAlZgsvQlsLfz6BfKR6ZZ+nknIJtP1ePKszVHmXTjciC4m+prmBKVHm4
         Rukw==
X-Gm-Message-State: AFuF++mbQCDVnfX7Ehn63mPufx50BLVSaveJykVW8EhIPUGmR2gdpEOU
	bw/qIX/AtSsqTP7kaFLuRPJsUSNYlxvXNc4OEGHljX0AWH6C5CBVGTnX
X-Gm-Gg: AYBFou1nE9sOfA4NcLdD3mjyIXwbYT/rJZrzFaX8NVYX+PPo+ydJMqCKqZ0y7iGWu1N
	b7BLMZB4m1G5TKUMN495W9s1hkoveHcOyymNnbdnufCWMF5J5mN9f2Lw7piRKpHpc327MtKcDHX
	0a75SPgTHZbPfgtCRF6t7orj6TkOG+7YZ5K3eNtFYUKFv52cRvq6GL6Lvzw7t04CfgsubbIp71B
	vMeTryCUyeRt/OHyn8ELZd2DNf9UmugEx+bnDTzKS6LcgT3B0GcyFPBYCor3BD2BEX2czWxCVUw
	uR0J+cLtCpfzi+cxFKDj/3Zoah9eUG68CBiJ+1lz4IS6r8YoG4KBIUZ0tAj6/nECZ/pIWEn8buw
	zkgHmQ0hsv6UsmETRnqN6Mex310E2ino9xvEm7HEWiUqCA3zCVaXPNE7SDH5elCURYjESZ8W2vV
	ZUbZII19Hha+fI/kdtgr0Sg7K1eyL1LiLkTii3AoV/JheUMnUTvsKgnDwanuKIqU1Dy2eLW7EuU
	y5i9c91kPGJudRl/oU=
X-Received: by 2002:a5d:5d86:0:b0:47f:773f:2d68 with SMTP id ffacd0b85a97d-482f79bac52mr39529891f8f.16.1788206644929;
        Mon, 31 Aug 2026 13:04:04 -0700 (PDT)
Received: from christian-ThinkPad-T470.. ([2a03:4460:170d:5700:b1a9:fd9c:45a3:43b7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48442d3d2eesm125783f8f.15.2026.08.31.13.04.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 13:04:04 -0700 (PDT)
From: Christian Melendez <chrismelnu@gmail.com>
To: Haiyang Zhang <haiyangz@microsoft.com>
Cc: linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: netvsc.rst: is XDP_REDIRECT still actually unsupported?
Date: Mon, 31 Aug 2026 22:03:57 +0200
Message-Id: <20260831200357.45390-1-chrismelnu@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Haiyang,

Documentation/networking/device_drivers/ethernet/microsoft/netvsc.rst
still says "XDP_REDIRECT action is not yet supported," but
netvsc_run_xdp() in netvsc_bpf.c seems to handle it fully -- calls
xdp_do_redirect(), tracks stats, and netvsc_drv.c advertises
NETDEV_XDP_ACT_REDIRECT. This looks like it's been true since your
commit 1cb9d3b6185b.

Is the doc just stale, or is there a caveat I'm missing? Happy to
send a one-line fix, or feel free to just tweak it yourself if
that's quicker.

Thanks,
Christian

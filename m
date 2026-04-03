Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D801118BBAE;
	Fri,  3 Apr 2026 07:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775200199; cv=none; b=MvFcqhWaKrUPfFZFNTo70u8nwddtWay/OCoIMyNXi4CAYXhdtQI2M5h9yIuClzxLI/57MHJnG65ymIc1E872lMw+X/oEiyvTJOrWten79cQ2y/QIrUJfaNPtQozyw7oIfu7vupBwvzyfhqHf1F0lOlJegTk6YuO3knCtvLbsygw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775200199; c=relaxed/simple;
	bh=AUy+XWB5d3RlFByTmPGkbI4H1702mGL/aEfm1qMgvmQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=N6NPEUAUoeYCLwu51axDYg9GTCxf/5Qao/+hj7+nsa1q1Nk9IQx7pAgFV+E3Y0bG5VgUHuBQXHqHXHw97lJHC1JPoOh7lPocIF9MgYtzKEnLR0isPyqR++PW0HqHcEBk9wIJYrJx09+MseC41FrGqxOjBCcti8O+ILOsGdlUmwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=kqbiZzJZ; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="kqbiZzJZ"
Received: by linux.microsoft.com (Postfix, from userid 1173)
	id 7044B20B710C; Fri,  3 Apr 2026 00:09:58 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7044B20B710C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1775200198;
	bh=LFGgEmHlBWcjLPGdbwtemKG7C1vt6eaiLUS2DdMC+Vs=;
	h=From:To:Subject:Date:From;
	b=kqbiZzJZfmg3HdkvE9K6N3kEjF6skUOAm7weCJT40W8jfpLGz+634Li6W9rpg3Nc+
	 ZXm2dqxo1TdQl6Z5j80UMG7RwW5RV8mHIl02m5UhA4eRPuOVTIEmFHr1lUGOWdpzbz
	 XENBjtGQO1Yg/5Y2oXxHXXO9zmB69Na07C9XUQEY=
From: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
To: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	longli@microsoft.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	ernis@linux.microsoft.com,
	ssengar@linux.microsoft.com,
	dipayanroy@linux.microsoft.com,
	gargaditya@linux.microsoft.com,
	shirazsaleem@microsoft.com,
	kees@kernel.org,
	kotaranov@microsoft.com,
	leon@kernel.org,
	shacharr@microsoft.com,
	stephen@networkplumber.org,
	linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 0/4] net: mana: Fix probe/remove error path bugs
Date: Fri,  3 Apr 2026 00:09:39 -0700
Message-ID: <20260403070948.9225-1-ernis@linux.microsoft.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix four pre-existing bugs in mana_probe()/mana_remove() error handling
that can cause warnings on uninitialized work structs, masked errors,
and resource leaks when early probe steps fail.

Patches 1-2 move work struct initialization (link_change_work and
gf_stats_work) to before any error path that could trigger
mana_remove(), preventing WARN_ON in __flush_work() or debug object
warnings when sync cancellation runs on uninitialized work structs.

Patch 3 prevents add_adev() from overwriting a port probe error,
which could leave the driver in a broken state with NULL ports while
reporting success.

Patch 4 changes 'goto out' to 'break' in mana_remove()'s port loop
so that mana_destroy_eq() is always reached, preventing EQ leaks when
a NULL port is encountered.

Erni Sri Satya Vennela (4):
  net: mana: Init link_change_work before potential error paths in probe
  net: mana: Init gf_stats_work before potential error paths in probe
  net: mana: Don't overwrite port probe error with add_adev result
  net: mana: Fix EQ leak in mana_remove on NULL port

 drivers/net/ethernet/microsoft/mana/mana_en.c | 28 +++++++++----------
 1 file changed, 14 insertions(+), 14 deletions(-)

-- 
2.34.1


Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1A02371045;
	Thu,  4 Jun 2026 08:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780560118; cv=none; b=KJO33mHGhLVTg0gezBmbPBb4us/WgCddu9/Qsvw1wGZa2H2Q5ZQPX7xZKSG5XdVUOI1RV3MQ11YU64gpGtdLYG52tIK8Vb0CjQyYiJm8r20uQwzhAveTWEnWSA3F8dxp3my/6LbSBalSpm5O9kzX+YW+f88PZEVUSx7AyQBDJmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780560118; c=relaxed/simple;
	bh=ts9jrAU57ltejvV2tgKn8Cfqk7RM1A/olmKnc253cX4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=TAVaITq4ghXsK6OTBIHJFdALE9Rgb29IrGyH2dS66V7BB2p8/DXYa7y88U0SEKx6Jx8hph2IUON+CuFvIsNY7I8N8rg1znrEDb7fVopT/vXsRaz3P8tMPnHgTTcvIpD0gThEccNcSrVoqqcUbyHQGQkm+OZb2jUKgyz6MUPFpEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=M0OAFG8c; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="M0OAFG8c"
Received: by linux.microsoft.com (Postfix, from userid 1231)
	id 2578220B7169; Thu,  4 Jun 2026 01:01:43 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2578220B7169
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1780560103;
	bh=6fqrlz32L/cPeUzKMaEmJOmXUcO099vvoAd3Gj4tEMI=;
	h=From:To:Subject:Date:From;
	b=M0OAFG8cE56HMjR7a0RtABXDysPWKojajLQ1bhQduW7W8urEabEDtLRALGgInbvs5
	 QiM92qUnf6WtIMJoFgsvNVaekSZ8LqdxBV/5OEE0dEaWy9XfJtlww34zGuNhIoIKi+
	 xP3DnheQP+4tU96qia4DyO/q5+w0Xwwu/rC1eEOM=
From: Aditya Garg <gargaditya@linux.microsoft.com>
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
	horms@kernel.org,
	shradhagupta@linux.microsoft.com,
	dipayanroy@linux.microsoft.com,
	ernis@linux.microsoft.com,
	kees@kernel.org,
	shacharr@microsoft.com,
	stephen@networkplumber.org,
	gargaditya@microsoft.com,
	gargaditya@linux.microsoft.com,
	ssengar@linux.microsoft.com,
	linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net 0/2] net: mana: fix error-path issues in queue setup
Date: Thu,  4 Jun 2026 01:01:24 -0700
Message-ID: <20260604080137.1995269-1-gargaditya@linux.microsoft.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Two error-path fixes in MANA queue setup, both surfaced during Sashiko
AI review of a recently upstreamed patch series.

Patch 1 initializes queue->id to INVALID_QUEUE_ID in
mana_gd_create_mana_wq_cq() so that a CQ creation failure before the
firmware id is assigned does not NULL gc->cq_table[0] and silently
break whichever real CQ owns that slot. This mirrors the existing
pattern in mana_gd_create_eq().

Patch 2 guards mana_destroy_txq()'s call to mana_destroy_wq_obj() with
an INVALID_MANA_HANDLE check, mirroring mana_destroy_rxq(). Without
it, TX setup failures lead to a firmware-rejected destroy of (u64)-1
and a spurious error in dmesg.

Aditya Garg (2):
  net: mana: initialize gdma queue id to INVALID_QUEUE_ID
  net: mana: guard TX wq object destroy with INVALID_MANA_HANDLE check

 drivers/net/ethernet/microsoft/mana/gdma_main.c | 2 ++
 drivers/net/ethernet/microsoft/mana/mana_en.c   | 3 ++-
 2 files changed, 4 insertions(+), 1 deletion(-)

-- 
2.43.0


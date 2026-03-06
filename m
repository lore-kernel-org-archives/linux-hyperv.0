Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76DB23469F5;
	Fri,  6 Mar 2026 23:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772839263; cv=none; b=k3ln2h+5mPcpmn9w1oj95Y1KVSEPx8bzxoX2+U0x+emlnQs5U7/64JLXwCFc1sm17nGUj2qrtx+X7EvEpGhtu3/7/FGJMDRLklEThZGaR8nhqykOlzlxvt2EdMskzD3r1G3idgRiYCCXEguyvNENbp4hpINFgEp4aWgCTroPS4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772839263; c=relaxed/simple;
	bh=6z8lnvVU9Ntjtg/bd8UHmXtKkAIM8UMzmoCHITggbjU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=d4qTNT70qpuR9YoAjC1WlwLGbnZNPzzpJGDJqHLST5axxdfakvRHaOe/XR2lIdLImsS7a8V0SBAt1CSrRGv1bUMMaX89Jlm9vf3f4vIB98YCl8ABu/qwrobnCl9lZoSzOpt9Rz3nivAnba6ECaUfCuPep64GHw+fWBN6ZQR07DQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=B3FUA/Oq; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="B3FUA/Oq"
Received: by linux.microsoft.com (Postfix, from userid 1006)
	id 28DB920B6F02; Fri,  6 Mar 2026 15:21:02 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 28DB920B6F02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1772839262;
	bh=1GoZH3sTHa0sjw0ojjAxqJi8o3hB7KTLUlldXpmSIFc=;
	h=From:To:Cc:Subject:Date:From;
	b=B3FUA/Oqu5Iv9lqSCQ0S9rc2aUdb/kHSS/0vP6Fl7fyS3E7JouPdoECBt4uI3E+Ws
	 4WEmYSY3GVe8HgMKS9lEv34gO4q8VH3H1dY/kzkhqI2UTbo2a8nEYY+vw6aO2yRsEZ
	 dR7xGDH4ucwwEtR31IJnMjV+KULP256GmUxCyE3o=
From: Haiyang Zhang <haiyangz@linux.microsoft.com>
To: linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org
Cc: haiyangz@microsoft.com,
	paulros@microsoft.com
Subject: [PATCH net-next,V3, 0/3] add ethtool COALESCE_RX_CQE_FRAMES/NSECS and use it in MANA driver
Date: Fri,  6 Mar 2026 15:19:12 -0800
Message-ID: <20260306231936.549499-1-haiyangz@linux.microsoft.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Haiyang Zhang <haiyangz@microsoft.com>

Add two parameters for drivers supporting Rx CQE Coalescing.

ETHTOOL_A_COALESCE_RX_CQE_FRAMES:
Maximum number of frames that can be coalesced into a CQE.

ETHTOOL_A_COALESCE_RX_CQE_NSECS:
Time out value in nanoseconds after the first packet arrival in a
coalesced CQE to be sent.

Also implement in MANA driver with the new parameter and
counters.

Haiyang Zhang (3):
  net: ethtool: add ethtool COALESCE_RX_CQE_FRAMES/NSECS
  net: mana: Add support for RX CQE Coalescing
  net: mana: Add ethtool counters for RX CQEs in coalesced type

 Documentation/netlink/specs/ethtool.yaml      |  8 ++
 Documentation/networking/ethtool-netlink.rst  | 10 ++
 drivers/net/ethernet/microsoft/mana/mana_en.c | 91 +++++++++++++------
 .../ethernet/microsoft/mana/mana_ethtool.c    | 75 ++++++++++++++-
 include/linux/ethtool.h                       |  6 +-
 include/net/mana/mana.h                       | 17 +++-
 .../uapi/linux/ethtool_netlink_generated.h    |  2 +
 net/ethtool/coalesce.c                        | 14 ++-
 8 files changed, 187 insertions(+), 36 deletions(-)

-- 
2.34.1


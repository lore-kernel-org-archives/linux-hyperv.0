Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41AC025A2B4;
	Mon,  9 Mar 2026 21:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773091278; cv=none; b=EhHpxgm4/cuXTn4HbETIftlAulCQL2+qrpM57juB5PGXbR18n6WMT56eZFuilwFiP7e3FEgy9ZZG5ymrO2bi1ZY+IPU6ISy2OPXVWVGuAtVdWpmrJV7+VstvCJ4Lnwji8idVBurHrLla48brgxIecW4+sM6IySdPPU4ABelZ+yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773091278; c=relaxed/simple;
	bh=nd/1n3VdfhJSGBvD3Xr7ncEBlNZMS5jiyOT7E7O689s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CZzOwiPtmVOMcfdo44+gjvYIeTDJ89E5rc43+fCRseAJnS/pii6TgAryhWOrwjlSvkdCAu42Pte1/H+1u1W3/YF5y0t/ZzAl5orFIEr1vhzSt+f4MjvJ8DxblzBaQkud1C/HceFM8AQFezK+zrl5sG85qjEeRn282RDUSmqW1fI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Qc2xbnpi; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Qc2xbnpi"
Received: by linux.microsoft.com (Postfix, from userid 1006)
	id 20C6220B710C; Mon,  9 Mar 2026 14:21:17 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 20C6220B710C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1773091277;
	bh=MAn2K1+Ub1L02MCyhWyLXhSTj3Aa/+L+stijV3Wcpio=;
	h=From:To:Cc:Subject:Date:From;
	b=Qc2xbnpikdM32h2rEuHMDmolnS1QrTX7KFoRuOO3/T7xn4NKWsro5hzwMsMosXWk8
	 hEdKlc2vPYB/OR8MbnA1EuTU6tdV1jK3tzEvKIMEzyUW15cB9l67HvAppiDEkdFaHX
	 2J+b5I4s/G4xFJwy5YXgJKuWWoGQ1RdJEBLuyY20=
From: Haiyang Zhang <haiyangz@linux.microsoft.com>
To: linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org
Cc: haiyangz@microsoft.com,
	paulros@microsoft.com
Subject: [PATCH net-next,V4, 0/3] add ethtool COALESCE_RX_CQE_FRAMES/NSECS and use it in MANA driver
Date: Mon,  9 Mar 2026 14:20:42 -0700
Message-ID: <20260309212106.764156-1-haiyangz@linux.microsoft.com>
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
 drivers/net/ethernet/microsoft/mana/mana_en.c | 93 +++++++++++++------
 .../ethernet/microsoft/mana/mana_ethtool.c    | 75 ++++++++++++++-
 include/linux/ethtool.h                       |  6 +-
 include/net/mana/mana.h                       | 17 +++-
 .../uapi/linux/ethtool_netlink_generated.h    |  2 +
 net/ethtool/coalesce.c                        | 14 ++-
 8 files changed, 189 insertions(+), 36 deletions(-)

-- 
2.34.1


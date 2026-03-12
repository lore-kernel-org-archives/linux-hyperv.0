Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D49D3AA51F;
	Thu, 12 Mar 2026 19:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773344263; cv=none; b=RPH81FMh+AAAUGdiYftST06AdYxlORtRfyxw4dNXu4SK8y9gqutqSMAjhH3DzkG7JZHJzAGgqRFpDV+7k7gmiM52hhfoj2PVhdrAwiCLRjEtIps+tXBVGNQRxaMYELI7hm0yaJXWAbG4IU3JmsoxK+Oiqt/WEmOjeNnjTONyUu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773344263; c=relaxed/simple;
	bh=wHjbItORtfxrbj1W+nJG5aI4L62TVfAOzg3ypTPnKCA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=URbLQYGL2ChCgK1HRzJ4PbeaRMgOUjwSTMpMXTATrpJm3knzGVUgo0tOXEdF70oiiGREwWD3wBiepJTtP+/3MtUew0F0xxFRRZ+b69WB3sUDPd2q5AGtyPjlQVLT8jlKngFVfOhKM2GCbDlmYZ+uFDKoCfSqu8AYDNu36LWw4Oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=bQdt2ivh; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="bQdt2ivh"
Received: by linux.microsoft.com (Postfix, from userid 1006)
	id D958420B6F01; Thu, 12 Mar 2026 12:37:36 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D958420B6F01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1773344256;
	bh=TwHY586fu/55yzvnlOgR8r+JHKdQtI7tdVfPxvmC2Wg=;
	h=From:To:Cc:Subject:Date:From;
	b=bQdt2ivhCHjhVXaErbb9GCsXRncOe7UMIgOzoco6UcV/V1BVOmiQdfjFyciE9dL7a
	 xWjTlkFnzg/wqGoNqxnuRxCVZX/DE5885PHmDOsu6YsHDbXmw1chusNa9noL/EN7oT
	 qMi4aL5yh9ZqV90DlJuvOn6VKlvWvGBSgwQQUizQ=
From: Haiyang Zhang <haiyangz@linux.microsoft.com>
To: linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org
Cc: haiyangz@microsoft.com,
	paulros@microsoft.com
Subject: [PATCH net-next v5 0/3] add ethtool COALESCE_RX_CQE_FRAMES/NSECS and use it in MANA driver
Date: Thu, 12 Mar 2026 12:37:03 -0700
Message-ID: <20260312193725.994833-1-haiyangz@linux.microsoft.com>
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
 Documentation/networking/ethtool-netlink.rst  | 10 +++
 drivers/net/ethernet/microsoft/mana/mana_en.c | 84 +++++++++++++------
 .../ethernet/microsoft/mana/mana_ethtool.c    | 75 ++++++++++++++++-
 include/linux/ethtool.h                       |  6 +-
 include/net/mana/mana.h                       | 17 +++-
 .../uapi/linux/ethtool_netlink_generated.h    |  2 +
 net/ethtool/coalesce.c                        | 14 +++-
 8 files changed, 180 insertions(+), 36 deletions(-)

-- 
2.34.1


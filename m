Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6909130E85D;
	Fri, 20 Mar 2026 20:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774038775; cv=none; b=BRvHvUqHhc1H6MC8HD9Ib5x26woztqeymImNNiwuUYSBePuXZh3Qq9RscmZYARAP8gJp44iWCT5Js3iHO2QH6PTugFZ7NN76WeW4xsSSwiG42YGp/TB3OYQTP3MsyzSjEt19Y+v7nzGPUeAxrBhix+cfUh6gjCRvxz3id8R0YZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774038775; c=relaxed/simple;
	bh=+U+Pxk+lyD8kQnLl2ai+nONzc3aDaui1n88vssgUmhQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Dhr4fT22krHePdIC1F1xi+E1kQmQayn0KwtX303OhfmTCdnMAuKmknjwDQM5hqGw82ZLl48q2YzdvKivzZwZIvFTdwhtzVkIfJCPYDnN8Yh2S8oMSDLrg26HS/pCdYy2T4CfMjUevNvl+laaH7IcOtrIXRLsnPC3XnQkEVPTupA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=bBKuFhGk; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="bBKuFhGk"
Received: by linux.microsoft.com (Postfix, from userid 1006)
	id 48E8720B710C; Fri, 20 Mar 2026 13:32:54 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 48E8720B710C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1774038774;
	bh=uSdV0QiDEoKezwvIEZNrcW3WBYAIDWGNnkCZgJMnt/M=;
	h=From:To:Cc:Subject:Date:From;
	b=bBKuFhGkEZgbKBa1bX3Ib5Vc1J5DgUfUdq/BMq5dwSKVcKMMrbDSzJ3rGVLVoQqXp
	 CngoXoaRiwjEZTU+4QKJpftuKQLml5KdspkvN5Gr8WIPigXr3SEJe1ThrJ4J9fQrii
	 GdxLbbyVah2oqIA2QGnKgQhkz+j+F8ooC5Eno5v8=
From: Haiyang Zhang <haiyangz@linux.microsoft.com>
To: mkubecek@suse.cz,
	linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org
Cc: haiyangz@microsoft.com,
	paulros@microsoft.com
Subject: [PATCH ethtool-next] netlink: settings: add netlink support for RX CQE Coalescing params
Date: Fri, 20 Mar 2026 13:31:59 -0700
Message-ID: <20260320203159.1590235-1-haiyangz@linux.microsoft.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Haiyang Zhang <haiyangz@microsoft.com>

Add support to get/set RX CQE Coalescing parameters, including the max frames
and time out value in nanoseconds.

(Headers: dc3d720e12f6 "net: ethtool: add ethtool COALESCE_RX_CQE_FRAMES/NSECS")

Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
---
 ethtool.8.in                  |  2 ++
 ethtool.c                     |  2 ++
 netlink/coalesce.c            | 17 +++++++++++++++++
 netlink/desc-ethtool.c        |  2 ++
 shell-completion/bash/ethtool |  2 ++
 5 files changed, 25 insertions(+)

diff --git a/ethtool.8.in b/ethtool.8.in
index e10a252..fe3c0ec 100644
--- a/ethtool.8.in
+++ b/ethtool.8.in
@@ -198,6 +198,8 @@ ethtool \- query or control network driver and hardware settings
 .BN tx\-aggr\-max\-bytes
 .BN tx\-aggr\-max\-frames
 .BN tx\-aggr\-time\-usecs
+.BN rx\-cqe\-frames
+.BN rx\-cqe\-nsecs
 .HP
 .B ethtool \-g|\-\-show\-ring
 .I devname
diff --git a/ethtool.c b/ethtool.c
index c9c1502..2444d85 100644
--- a/ethtool.c
+++ b/ethtool.c
@@ -5925,6 +5925,8 @@ static const struct option args[] = {
 			  "		[tx-aggr-max-bytes N]\n"
 			  "		[tx-aggr-max-frames N]\n"
 			  "		[tx-aggr-time-usecs N]\n"
+			  "		[rx-cqe-frames N]\n"
+			  "		[rx-cqe-nsecs N]\n"
 	},
 	{
 		.opts	= "-g|--show-ring",
diff --git a/netlink/coalesce.c b/netlink/coalesce.c
index bc8b57b..f36b8e8 100644
--- a/netlink/coalesce.c
+++ b/netlink/coalesce.c
@@ -96,6 +96,11 @@ int coalesce_reply_cb(const struct nlmsghdr *nlhdr, void *data)
 	show_u32("tx-aggr-time-usecs", "tx-aggr-time-usecs:\t",
 		 tb[ETHTOOL_A_COALESCE_TX_AGGR_TIME_USECS]);
 	show_cr();
+	show_u32("rx-cqe-frames", "rx-cqe-frames:\t\t",
+		 tb[ETHTOOL_A_COALESCE_RX_CQE_FRAMES]);
+	show_u32("rx-cqe-nsecs", "rx-cqe-nsecs:\t\t",
+		 tb[ETHTOOL_A_COALESCE_RX_CQE_NSECS]);
+	show_cr();
 
 	close_json_object();
 
@@ -292,6 +297,18 @@ static const struct param_parser scoalesce_params[] = {
 		.handler	= nl_parse_direct_u32,
 		.min_argc	= 1,
 	},
+	{
+		.arg		= "rx-cqe-frames",
+		.type		= ETHTOOL_A_COALESCE_RX_CQE_FRAMES,
+		.handler	= nl_parse_direct_u32,
+		.min_argc	= 1,
+	},
+	{
+		.arg		= "rx-cqe-nsecs",
+		.type		= ETHTOOL_A_COALESCE_RX_CQE_NSECS,
+		.handler	= nl_parse_direct_u32,
+		.min_argc	= 1,
+	},
 	{}
 };
 
diff --git a/netlink/desc-ethtool.c b/netlink/desc-ethtool.c
index 8289190..08d94de 100644
--- a/netlink/desc-ethtool.c
+++ b/netlink/desc-ethtool.c
@@ -249,6 +249,8 @@ static const struct pretty_nla_desc __coalesce_desc[] = {
 	NLATTR_DESC_U32(ETHTOOL_A_COALESCE_TX_AGGR_TIME_USECS),
 	NLATTR_DESC_NESTED(ETHTOOL_A_COALESCE_RX_PROFILE, profile),
 	NLATTR_DESC_NESTED(ETHTOOL_A_COALESCE_TX_PROFILE, profile),
+	NLATTR_DESC_U32(ETHTOOL_A_COALESCE_RX_CQE_FRAMES),
+	NLATTR_DESC_U32(ETHTOOL_A_COALESCE_RX_CQE_NSECS),
 };
 
 static const struct pretty_nla_desc __pause_stats_desc[] = {
diff --git a/shell-completion/bash/ethtool b/shell-completion/bash/ethtool
index 3c775a1..57c39c4 100644
--- a/shell-completion/bash/ethtool
+++ b/shell-completion/bash/ethtool
@@ -259,6 +259,8 @@ _ethtool_coalesce()
 		[tx-aggr-max-bytes]=1
 		[tx-aggr-max-frames]=1
 		[tx-aggr-time-usecs]=1
+		[rx-cqe-frames]=1
+		[rx-cqe-nsecs]=1
 	)
 
 	case "$prev" in
-- 
2.34.1


Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 800A517591;
	Mon, 10 Feb 2025 04:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739162403; cv=none; b=dAG/cQIgVvC7/J2zsDMuAOCgR+tKtqBVm6dQj17W0uVN+9racmQOISuVDyo1txpitAKiP/xcF56qWx8+RqVUDfz63znM+SQ+G42NmJcKK82cipzS3pkpY+eVs/fbq/lJOcOKP9VgE85d11WPvEv+KdU26W0J66RY5Mu8cFABESI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739162403; c=relaxed/simple;
	bh=d3pV3j43AsP8m9lPylMVzrWwG+gr6ukwWZ/O4CtjSFc=;
	h=From:To:Cc:Subject:Date:Message-Id; b=Ks/LBa9CZCsg4bFQbEWVdl1mvH0/HgUXZO7usAyjImEh0mNPghmjzEU8tdnSBBTxKwJR+dMNcc2MHkiXtv/rYoDezWa2GXr2tDlVdMVcgQad1HUVvKuXI68l+LDvbMa+/gVg+jdhF90wCsNcM6jIHVk0DosVIcW8WCeHlb6gh8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=qrYUg9xj; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="qrYUg9xj"
Received: by linux.microsoft.com (Postfix, from userid 1134)
	id 1D5FC210733A; Sun,  9 Feb 2025 20:39:56 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1D5FC210733A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1739162396;
	bh=Er+lXYAhcnUfPZM9iGtlwf9RnKEucLNECiLZQ1E0qjw=;
	h=From:To:Cc:Subject:Date:From;
	b=qrYUg9xjJFm0Ax1VL1i1U6JbwSslEAP95EUGqZ80kH6GALzfknJYkiwgUuVJoXQJd
	 DChX36Hl5AicneULGDJrHsSRt86/mVN5/WI9m2IS7JufoKqZ/TtIopepW0SJOAYadZ
	 fiNitoVuBbZ4SaQBLqzWSo8n6nvqCuirMwCdzr70=
From: Shradha Gupta <shradhagupta@linux.microsoft.com>
To: linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Shradha Gupta <shradhagupta@linux.microsoft.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Long Li <longli@microsoft.com>,
	Konstantin Taranov <kotaranov@microsoft.com>,
	Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>,
	Erick Archer <erick.archer@outlook.com>,
	Shradha Gupta <shradhagupta@microsoft.com>
Subject: [PATCH v2 net-next 0/2] Enable Big TCP for MANA devices
Date: Sun,  9 Feb 2025 20:39:52 -0800
Message-Id: <1739162392-6356-1-git-send-email-shradhagupta@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Allow the max gso/gro aggregated pkt size to go up to GSO_MAX_SIZE for
MANA NIC. On Azure, this not possible without allowing the same for
netvsc NIC (as the NICs are bonded together).
Therefore, we use netif_set_tso_max_size() to set max aggregated pkt size
to VF's tso_max_size for netvsc too, when the data path is switched over
to the VF

The first patch allows MANA to configure aggregated pkt size of up-to
GSO_MAX_SIZE

The second patch enables the same on the netvsc NIC, if the data path
for the bonded NIC is switched to the VF

 Changes in v2
 * Instead of using 'tcp segment' throughout the patch used the words
   'aggregated pkt size'

Shradha Gupta (2):
  net: mana: Allow tso_max_size to go up-to GSO_MAX_SIZE in MANA
  hv_netvsc: Use VF's tso_max_size value when data path is VF

 drivers/net/ethernet/microsoft/mana/mana_en.c |  2 ++
 drivers/net/hyperv/hyperv_net.h               |  2 ++
 drivers/net/hyperv/netvsc_drv.c               | 15 +++++++++++++++
 drivers/net/hyperv/rndis_filter.c             | 13 +++++++------
 4 files changed, 26 insertions(+), 6 deletions(-)

-- 
2.34.1


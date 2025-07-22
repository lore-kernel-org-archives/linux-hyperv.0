Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A90F2E371F;
	Tue, 22 Jul 2025 23:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753228266; cv=none; b=oGwwVxLSXRJGXzZ1WYcuAjK1IejIuPSXKvYIuuK/719QN6fmv76Bh4myYKN3lu0mqGLEkucKV87qpYpeL3UJBaFLmikzQmz3BLWVG5gKY8dt7ng6yMwJMSOkr9N2c+A82SX9+CpQ2dgXlcF/4STbbOWYI6PodFjM1xlWgkVjBTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753228266; c=relaxed/simple;
	bh=Q7rDaadWUaiFBWLQaOtVnTh5/YkO0Bd2ftMVkBR0SrE=;
	h=From:To:Cc:Subject:Date:Message-Id; b=oNWj93hOEwZF2p4u0+GNKa8UoJLX2SB5jh+kdMo55cdlAQM7LRItm9dOJXOi2xgWktdvZ+fAn7t26wJK8I5HTg8vRCLUa+Svj69MmsIEPb/D3Ne6ZwBJUwLop/pmGPoXEb2NOPyH1xvmgcjqfbImGbm1GUcETNKCxOb6C+oNLUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=MRl51+q8; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="MRl51+q8"
Received: by linux.microsoft.com (Postfix, from userid 1006)
	id CAF6621268BD; Tue, 22 Jul 2025 16:51:04 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com CAF6621268BD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1753228264;
	bh=XgRbQ4iYi0QXOMX0YcD9rS2ZxOfBzg6PE36kygAaWpA=;
	h=From:To:Cc:Subject:Date:From;
	b=MRl51+q8Fx7bJ/ZI1imlAB/gWxTUx8nfwKgpwjnez9zCq38PVzSnB8ZeP+4VL2kWU
	 1xFM5yF9UCtPhKJlfLxy+BBOrzLZIuyhgmHFu2UPQx8v62JcyFD651Vew9Phy0D1pB
	 xD0kzN4NMg0gLrLkLHYmKTcXrI6mAjgXgHutJZ5A=
From: Haiyang Zhang <haiyangz@linux.microsoft.com>
To: linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org
Cc: haiyangz@microsoft.com,
	kys@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	andrew+netdev@lunn.ch,
	sd@queasysnail.net,
	viro@zeniv.linux.org.uk,
	chuck.lever@oracle.com,
	neil@brown.name,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	davem@davemloft.net,
	kuniyu@google.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH net, 0/2] net: Add llist_node init and fix hv_netvsc namespace error
Date: Tue, 22 Jul 2025 16:50:46 -0700
Message-Id: <1753228248-20865-1-git-send-email-haiyangz@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

From: Haiyang Zhang <haiyangz@microsoft.com>

Add llist_node init to setup_net(), so we can check if the node is on list.
Then, fix the namespace callback function in hv_netvsc.

Haiyang Zhang (2):
  net: core: Fix missing init of llist_node in setup_net()
  hv_netvsc: Fix panic during namespace deletion with VF

 drivers/net/hyperv/netvsc_drv.c | 10 +++++++++-
 net/core/net_namespace.c        |  3 +++
 2 files changed, 12 insertions(+), 1 deletion(-)

-- 
2.34.1


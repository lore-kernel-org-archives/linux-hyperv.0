Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7C9D44A72C;
	Tue, 28 Apr 2026 12:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777380840; cv=none; b=rIKUsAKrnHyqvjVMVbjCwQ2InF9ziitQR22o8UCO+wKRA2Bfgnc2TB5bw1WZ5r9HRerhohytEL/warldryX/dALg7yiaygusOc2HEOOCJR6n7a+pm1wZCl8V2f5VuMFMCeNgBe54KLO5uGaqbibWwTzF2u1aiQmgbAv3WlSyAEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777380840; c=relaxed/simple;
	bh=tjkzSjK4bQCrikbIAslVe4/vmiGEXnZ3QDnOrPl9cuk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gBrTuJ344UGcdcclUD4JCrPWYdfKNGKPIoW0fVPeK0PZDUileW3INC4ElMa+/3FONiB9zIvsKjWjC2W6gsJV08AQEvF6XM7b6+wVkF+rWMAcls1U1wr73hiLomSEonl32dVpfTLyf0NR25DOUEZ4ITznujnUkajeaTFDu8inV8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=haI48wsf; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="haI48wsf"
Received: from hm-arch (unknown [52.179.129.152])
	by linux.microsoft.com (Postfix) with ESMTPSA id 25AD320B716C;
	Tue, 28 Apr 2026 05:53:50 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 25AD320B716C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1777380831;
	bh=+d4j3UI8KjnvndFqajKG/v3FQvgoX5uQK37+zEJ/g+Y=;
	h=From:To:Cc:Subject:Date:From;
	b=haI48wsfsny3FL74nbrGfxvd3frtywY+Z/ZZOMtgONexL0fduo0afpO9S7v3mFZGv
	 SHNyZar1osUpUzqM0T2dwp/RgN8LZP+bJABkzjVEz0BDaAe59byKRdes/n6dwR4FlN
	 RGjPC9cabV++XkOlS0ivLRwstYtXcsnFXVebGJTk=
From: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
To: netdev@vger.kernel.org
Cc: "K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Michael Kelley <mhklinux@outlook.com>,
	Himadri Pandya <himadrispandya@gmail.com>,
	linux-hyperv@vger.kernel.org,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] hv_sock: fix ARM64 support
Date: Tue, 28 Apr 2026 08:53:39 -0400
Message-ID: <20260428125339.13963-1-hamzamahfooz@linux.microsoft.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

VMBUS ring buffers must be page aligned. Therefore, the current value of
24K presents a challenge on ARM64 kernels (with 64K pages). So, use
VMBUS_RING_SIZE() to ensure they are always aligned and large enough to
hold all of the relevant data.

Cc: stable@vger.kernel.org
Fixes: 77ffe33363c0 ("hv_sock: use HV_HYP_PAGE_SIZE for Hyper-V communication")
Tested-by: Dexuan Cui <decui@microsoft.com>
Reviewed-by: Dexuan Cui <decui@microsoft.com>
Signed-off-by: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
---
 net/vmw_vsock/hyperv_transport.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/vmw_vsock/hyperv_transport.c b/net/vmw_vsock/hyperv_transport.c
index 069386a74557..40f09b23efa3 100644
--- a/net/vmw_vsock/hyperv_transport.c
+++ b/net/vmw_vsock/hyperv_transport.c
@@ -375,10 +375,10 @@ static void hvs_open_connection(struct vmbus_channel *chan)
 	} else {
 		sndbuf = max_t(int, sk->sk_sndbuf, RINGBUFFER_HVS_SND_SIZE);
 		sndbuf = min_t(int, sndbuf, RINGBUFFER_HVS_MAX_SIZE);
-		sndbuf = ALIGN(sndbuf, HV_HYP_PAGE_SIZE);
+		sndbuf = VMBUS_RING_SIZE(sndbuf);
 		rcvbuf = max_t(int, sk->sk_rcvbuf, RINGBUFFER_HVS_RCV_SIZE);
 		rcvbuf = min_t(int, rcvbuf, RINGBUFFER_HVS_MAX_SIZE);
-		rcvbuf = ALIGN(rcvbuf, HV_HYP_PAGE_SIZE);
+		rcvbuf = VMBUS_RING_SIZE(rcvbuf);
 	}
 
 	chan->max_pkt_size = HVS_MAX_PKT_SIZE;
-- 
2.54.0


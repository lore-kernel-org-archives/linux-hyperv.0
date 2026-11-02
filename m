Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793601808;
	b=oWfvsI8VIenWEPVsBzLIlh9tEG6dpCMbuNoNXFK/YjGDEwiz+bccN0ToSJRVx+hL666w
	 hGINc+tq1/TV8Sux7QNn1WuqfTVxH8X3h3hAcIR/OHJtB+oFJ7U8tfGk02cYpmnE0L0zR
	 xXjpMUfkHJrk1F1s7ztztsTQuYOXJgClBZjbOb8OTRKT0msFezNkobmPe3YfgOlfNJzCo
	 82hjRn1GJKtsgcUlSTpAtWNgmUGGqjsvt4qISaMApoaST5yGgtgBURZvPt3jpBNE+c/th
	 JhQjozpnsBaERuZqITH5EpkcgAeFLdEt7fiBtgLaAdvWQaw5qVLmxcy1eYtGalPL9kw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793601808;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=cch0bi9+NbFtuaXErBFOK272My4N6BW/oY3L9VqLD5s=;
	b=20nY176QuJHNpTa/GwG+3BZwtrxqMU+75SqkWGFitKn5oGBESqdUPk6YcGzAsrQ4qG5u
	 tcQD/5Cugnk72lIF79qXeoYVYADtk/K4YeXkEMMHzO3EDtCha2Imkc25FaCsO9zmgYEE2
	 5Ngx616g4JKh9WApDYLxTO+Pjl+rWjwjU8BBhIcvHKQiTAdPoczPKRQWl22rCPK0RBRSF
	 l74rHXgXZp/HPRTe1Nz/xjTQPmd+k2LrBdfRWKoDK8bF1w681WXdPn7dIc4ig9XLXImNe
	 eLrzVL6i9ddY0z/LN6auA3fJadJwW3f7OYMEiMguhX3FVKS0S2r/yT54zbenDWiNS5w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Fd2IgLOb;
	arc=none smtp.remote-ip=209.85.221.52
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E275F606A32C
	for <linux-hyperv@vger.kernel.org>; Mon,  2 Nov 2026 06:43:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E275F606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Fd2IgLOb
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-48e20ed3b9dso2331156f8f.2
        for <linux-hyperv@vger.kernel.org>; Sun, 01 Nov 2026 22:43:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793601806; x=1794206606; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=cch0bi9+NbFtuaXErBFOK272My4N6BW/oY3L9VqLD5s=;
        b=Fd2IgLObu+O8EIDuwqEXSbT+Lmt6lkFZ1vGgxdrQyksTyVsALvAxVk34TZsr8GH3zz
         PPGYvfq9SYbmsff5dWp45lus2GhoaISJMbYsdnZha8HNfZaY34MB7FP0S9OMebo1SWRX
         DoZF3bkpBFxfSpvqhRT/elcXplgxaCDqUPOLsR5JfJ+kwObifDHqlgAW3lFxdoR+JXMG
         7iv8IfRgEQZAI6nuskgCXTsP0D6+pudlZ15AW8IZRduFDjfUP3farFxaB5Dj48LMEr6C
         OpMyu699mFDJR+dwZcmew/L6JtiMvIfDKLHz6EzHcMUAcYMf9OZc5gDZovNxBxaXPG7p
         z0+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793601806; x=1794206606;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cch0bi9+NbFtuaXErBFOK272My4N6BW/oY3L9VqLD5s=;
        b=HcVOwk1LKnMydgdUdxcWUsAT0AfIc76xB2gD6vQWZnGiFih+/pUHU55hC/VcyiZCdO
         WwL0BONrOynlvMknPUKYciHc1Q4dmRvsNLp/tUz4uJX1nYLC/1o0Aat1HnJg5STwdLRq
         4rCj0qezy5i5mUPUrT7iI1tqlRG0HMjMyypIHJ4g9u0dudWhJJXTE3HWFqbCn1+bd3Wp
         7LDj9dUmNKnhuUmk02DW8E4N6bmG2OJBo/zrzO+TkbaJMLbWOu+M0GLHn1U922gCrg2r
         6RUofI+f6gh0VCVuBPVf5Xi7+nGFbdNXNAS+cRuMXMMqwq/oYT7OFslYuj2OTFRsQkLx
         A3yw==
X-Forwarded-Encrypted: i=1; AKwUvBzlx2HChZVaWf6M2NJ28XxvKdC4VaNQGLcU7m+TErkytSVt6T3FBfgBIk5lyRbTUyq9oRVzUNFw4UGEyS8=@vger.kernel.org
X-Gm-Message-State: APuU4Z+9cEVUQA3F6YTmKW99xIB4d/RXgHnw1gSDS27yI0cfWtdoFdcK
	+9RFfmRstuPhOAhPVMOQNe+MtndQDRqieTZ4snXVcN5IvPKtuKEivjkT
X-Gm-Gg: AYBFou1yoCPoS70xFxsF0232kofojfQeRy/u4N/r4P+RkvHm7h0h96fmC+B4NmkMHwG
	gmhePVNVx8+GE2Rzg0FFntZqF19ZkgPnTauVfGYCrKWEPyZRC7RPaor0z0e6S+ptRMqIxEry0OB
	8qxXnJWuBXSH3g+xzw+wLMfzZ7GkhX8k7jEsSKXa2vYW8nDOKUIxXP+ih1yKrsLg4AK0OnRt58w
	589in55kByjsk+lEYn/7D0WAnNt6V9dUYmvSoelI0jlhG8Vf1/EbtOp0lwO68OMS2J/3H1maBSn
	BzI267uBPu+al10sI0aRJiN1bhlhprGqVB0LQwtubStZojTa0Jr8exLk09n3nAJ3ubNrD/f+OXF
	P2R5MUOWeAIWs6LWDvy4r1P1OgkTq1ExuhSa2P0LudbCU3FRdO2XI2oDU1p9QSAi0qsfHT4aakE
	kyeJxtEgYArsVgtVAMva2luImtbtdpijL7KgxmRiNOuqmwUPGOgnuNMe+Y3d9cMAX015vlkKLxW
	2nZF99Rl18k6/bGWZozzPHZIbQ+/Vm+HAI98LXaIgD3tqexuj5VOn7kMC0WKk2N+cq0SeJxqtpg
	j9Uy0wVHMrtwowLcNFTE30fiyDX7Kkhrnhwtn80F6w/qtHe6LFo/xb3y7TYocnHPISIiVzkHoMC
	k36CVDvWzBRUpnpIFHdcoA0AA1tL/iva1dl7CP0jAhFz8EeaBQfNLUrbTVpbYdeQ9o16i
X-Received: by 2002:a05:6000:26ce:b0:48a:f454:3d4 with SMTP id ffacd0b85a97d-48e6e52a7e3mr19310220f8f.53.1793601805912;
        Sun, 01 Nov 2026 22:43:25 -0800 (PST)
Received: from center.jhjvjihww5qejoy14qwv1cc4td.frax.internal.cloudapp.net ([131.189.143.225])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71ba4ac6sm19305747f8f.52.2026.11.01.22.43.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 22:43:25 -0800 (PST)
From: Orgad Shaneh <orgads@gmail.com>
To: Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wei Hu <weh@microsoft.com>,
	Konstantin Taranov <kotaranov@microsoft.com>,
	Simon Horman <horms@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Long Li <longli@microsoft.com>,
	Dipayaan Roy <dipayanroy@linux.microsoft.com>,
	Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>,
	Aditya Garg <gargaditya@linux.microsoft.com>,
	Erni Sri Satya Vennela <ernis@linux.microsoft.com>,
	Muhammad Falak R Wani <falakreyaz@gmail.com>,
	Jesse Brandeburg <jbrandeb@kernel.org>
Subject: [PATCH net] net: mana: fix XDP_REDIRECT of pre-allocated RX buffers
Date: Mon,  2 Nov 2026 06:43:24 +0000
Message-ID: <20261102064324.806414-1-orgads@gmail.com>
X-Mailer: git-send-email 2.47.3
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Post: <mailto:linux-hyperv@vger.kernel.org>
List-Help: <mailto:linux-hyperv+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hyperv+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mana_pre_alloc_rxbufs() fills the RX rings with plain pages from
dev_alloc_pages() (from_pool == false), but the rxq is registered with
MEM_TYPE_PAGE_POOL and mana_run_xdp() builds every xdp_buff with that
rxq info. mana_rx_skb() frees a !from_pool buffer correctly on
XDP_PASS, XDP_TX and XDP_DROP, but a redirected buffer is freed through
its memory model: __xdp_return() hands the plain page to
page_pool_put_full_netmem(). This triggers the WARN in
include/net/page_pool/helpers.h, breaks the page refcount, RX refills
fail and the queue stops receiving.

The pre-allocated buffers fill the whole ring of every rxq created by
an MTU change, by ethtool -L / -G and, since
commit 730ff06d3f5c ("net: mana: Use page pool fragments for RX buffers
instead of full pages to improve memory efficiency."), by every XDP
attach and detach. So on current kernels the first ring of redirected
packets after attaching an XDP program always hits this.

Reproduced on 7.2.11, and on 6.12.113 after ethtool -L, on an Azure
MANA VF: an XDP program that redirects UDP to an XSKMAP with an AF_XDP
socket in copy mode gives WARNINGs at __xdp_return+0x249 (stack
__xsk_map_redirect, xdp_do_redirect, mana_run_xdp, mana_poll), then
the queue stops.

Give each rxq a second xdp_rxq_info registered with
MEM_TYPE_PAGE_SHARED, the model these buffers had before the page pool
was added, and use it for buffers that are not from the pool. Those
buffers are already DMA-unmapped by mana_refill_rx_oob() before XDP
runs, and page_frag_free() frees them whatever their order. Allocating
the pre-allocated buffers from the page pool instead would need the
pools to exist before the rxqs and to outlive them, a much larger
change.

Found, fixed and tested with an AI coding assistant (Claude Code).

Fixes: b1d13f7a3b53 ("net: mana: Add page pool for RX buffers")
Signed-off-by: Orgad Shaneh <orgads@gmail.com>
---
Tested on an Azure D2s_v6 MANA VF, net at cb284914e749 with and
without this patch (same config), XDP program redirecting UDP to an
AF_XDP socket in copy mode on queue 0, 25k pps offered right after
attach:
- without: 41 WARNINGs at __xdp_return+0x252, 0 packets relayed,
  hc_rx_discards_no_wqe 301470.
- with: no WARNING, 25k of 25k pps relayed, 0 loss; also over three
  more attach/detach cycles, two ethtool -L combined 1/2 cycles and an
  MTU 4000/1500 change before attach. MemAvailable unchanged.
W=1 build of the mana directories: no new warnings.

 drivers/net/ethernet/microsoft/mana/mana_bpf.c |  9 +++++++--
 drivers/net/ethernet/microsoft/mana/mana_en.c  | 11 ++++++++++-
 include/net/mana/mana.h                        |  5 ++++-
 3 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/microsoft/mana/mana_bpf.c b/drivers/net/ethernet/microsoft/mana/mana_bpf.c
index 7c55f8724441..494267b3069a 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_bpf.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_bpf.c
@@ -78,7 +78,8 @@ int mana_xdp_xmit(struct net_device *ndev, int n, struct xdp_frame **frames,
 }
 
 u32 mana_run_xdp(struct net_device *ndev, struct mana_rxq *rxq,
-		 struct xdp_buff *xdp, void *buf_va, uint pkt_len)
+		 struct xdp_buff *xdp, void *buf_va, bool from_pool,
+		 uint pkt_len)
 {
 	struct mana_stats_rx *rx_stats;
 	struct bpf_prog *prog;
@@ -90,7 +91,11 @@ u32 mana_run_xdp(struct net_device *ndev, struct mana_rxq *rxq,
 	if (!prog)
 		goto out;
 
-	xdp_init_buff(xdp, PAGE_SIZE, &rxq->xdp_rxq);
+	/* A redirected buffer is freed by its memory model, so a buffer not
+	 * from the page pool must not claim MEM_TYPE_PAGE_POOL.
+	 */
+	xdp_init_buff(xdp, PAGE_SIZE,
+		      from_pool ? &rxq->xdp_rxq : &rxq->xdp_rxq_shared);
 	xdp_prepare_buff(xdp, buf_va, rxq->headroom, pkt_len, true);
 
 	act = bpf_prog_run_xdp(prog, xdp);
diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
index 6b7c027e497e..7547aeb3235d 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_en.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
@@ -2157,7 +2157,7 @@ static void mana_rx_skb(void *buf_va, bool from_pool,
 		return;
 	}
 
-	act = mana_run_xdp(ndev, rxq, &xdp, buf_va, pkt_len);
+	act = mana_run_xdp(ndev, rxq, &xdp, buf_va, from_pool, pkt_len);
 
 	if (act == XDP_REDIRECT && !rxq->xdp_rc)
 		return;
@@ -2947,6 +2947,9 @@ static void mana_destroy_rxq(struct mana_port_context *apc,
 	if (xdp_rxq_info_is_reg(&rxq->xdp_rxq))
 		xdp_rxq_info_unreg(&rxq->xdp_rxq);
 
+	if (xdp_rxq_info_is_reg(&rxq->xdp_rxq_shared))
+		xdp_rxq_info_unreg(&rxq->xdp_rxq_shared);
+
 	if (rxq->rxobj != INVALID_MANA_HANDLE)
 		mana_destroy_wq_obj(apc, GDMA_RQ, rxq->rxobj);
 
@@ -3225,6 +3228,12 @@ static struct mana_rxq *mana_create_rxq(struct mana_port_context *apc,
 	WARN_ON(xdp_rxq_info_reg_mem_model(&rxq->xdp_rxq, MEM_TYPE_PAGE_POOL,
 					   rxq->page_pool));
 
+	/* The pre-allocated buffers (mana_pre_alloc_rxbufs) are plain pages */
+	WARN_ON(xdp_rxq_info_reg(&rxq->xdp_rxq_shared, ndev, rxq_idx,
+				 cq->napi.napi_id));
+	WARN_ON(xdp_rxq_info_reg_mem_model(&rxq->xdp_rxq_shared,
+					   MEM_TYPE_PAGE_SHARED, NULL));
+
 	/* Initialize the DIM work before enabling NAPI, so that a poll
 	 * cannot reach net_dim() with an uninitialized cq->dim.work.
 	 */
diff --git a/include/net/mana/mana.h b/include/net/mana/mana.h
index 71d726b1f784..11ceb5946ee0 100644
--- a/include/net/mana/mana.h
+++ b/include/net/mana/mana.h
@@ -420,6 +420,8 @@ struct mana_rxq {
 
 	struct bpf_prog __rcu *bpf_prog;
 	struct xdp_rxq_info xdp_rxq;
+	/* For buffers not from the page pool (from_pool == false) */
+	struct xdp_rxq_info xdp_rxq_shared;
 	void *xdp_save_va; /* for reusing */
 	bool xdp_flush;
 	int xdp_rc; /* XDP redirect return code */
@@ -695,7 +697,8 @@ void mana_xdp_tx(struct sk_buff *skb, struct net_device *ndev);
 int mana_xdp_xmit(struct net_device *ndev, int n, struct xdp_frame **frames,
 		  u32 flags);
 u32 mana_run_xdp(struct net_device *ndev, struct mana_rxq *rxq,
-		 struct xdp_buff *xdp, void *buf_va, uint pkt_len);
+		 struct xdp_buff *xdp, void *buf_va, bool from_pool,
+		 uint pkt_len);
 struct bpf_prog *mana_xdp_get(struct mana_port_context *apc);
 void mana_chn_setxdp(struct mana_port_context *apc, struct bpf_prog *prog);
 int mana_bpf(struct net_device *ndev, struct netdev_bpf *bpf);

base-commit: cb284914e749388eef402938bdb3115fe1f6d337
-- 
2.52.0


Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE0F84A0905;
	Thu, 10 Sep 2026 15:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789053531; cv=none; b=Bn60vIKaYVWtUwKnRZKsvvrZGiuYh3Deo3zOTa68m6/NHfROSfL5VQ51E+qjtxryPZAr/6WjelLU8R3txpqGlwiIeC47bD5JcFfWckXB5Ad+zbPZHY+C6+Jgs522iM4xEzjaVcqnkL8M8xFF5FVIcTTHaqb4JxMu+5ktsdpt3Z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789053531; c=relaxed/simple;
	bh=6tfqr90qp+Pt3hhDdxlIsSvQU6RFtqVvzJCVe/1d2rw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=QIouD+vMhctKmhR4Dedzfsqhj7Topcl9Gp1SlYfPHb+dCOVae1GSX2Dk/ny2X67h6tzmOjGzdzVL8LBchx8vuaNLEOl9oLimY/xJCqkFHjPCuHzb6yUW6YbBsBOY4vEQT8+B4w7NIuvWNSjDTz972/z/zzBQngV1bQUH7Va0Weo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eNgEda4j; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eNgEda4j"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 33D41C2BCC7;
	Thu, 10 Sep 2026 15:18:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1789053530;
	bh=6tfqr90qp+Pt3hhDdxlIsSvQU6RFtqVvzJCVe/1d2rw=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=eNgEda4jC8tpQhCZWS0+smJvOujWNlmX6TGiiiX+S9wbbKNRrzyRUEbpRzaeqRK/M
	 Uv+0jpWQMa8d8A86Zipg9mwMB8saMCDN6jstyu6Rvjwyl3m/RWuOtdxLolabHzbeVV
	 PZqW1qkfCv18BVBRRUdU66g+06gMfVEfgMldqGyYt6KE/crETJhs+xV3FdWRkBQ+Rj
	 FdoJwuu2FYTRwYGxDQwDXC4E5lXbKdGcP7rX2GzLe4fAJAWTKud4k2trKI6D1+c047
	 1a9Hf4Vkd0aUgukG65kPvA0J7iLHIMW18/vF/6ue3bBPsVfhUMGx6S7SV7DLpxe4ju
	 CPXFK/Q/r5ssA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08A85C79FBF;
	Thu, 10 Sep 2026 15:18:50 +0000 (UTC)
From: Gunter Woytowitz via B4 Relay <devnull+gunter.vcinity.io@kernel.org>
Date: Thu, 10 Sep 2026 11:17:47 -0400
Subject: [PATCH net] net: mana: never hand a non-page_pool buffer to XDP
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260910-mana-xdp-pagepool-v1-1-dab140d91fed@vcinity.io>
X-B4-Tracking: v=1; b=H4sIABrKomoC/yWMwQrCMBAFf6W8swtJkEr8FfGwbbZ1RZOQVCmU/
 rtRjzMws6FKUak4dxuKvLVqig3socN44zgLaWgMZ1xvvDX05Mi0hkyZZ8kpPSj0lk9Hb9zgJ7Q
 uF5l0/T0viLLg+pf1NdxlXL437PsH5/mPFHoAAAA=
X-Change-ID: 20260910-mana-xdp-pagepool-d61a74902b9f
To: "K. Y. Srinivasan" <kys@microsoft.com>, 
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
 Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Stanislav Fomichev <sdf@fomichev.me>
Cc: "open list:Hyper-V/Azure CORE AND DRIVERS" <linux-hyperv@vger.kernel.org>, 
 "open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>, 
 open list <linux-kernel@vger.kernel.org>, 
 "open list:XDP eXpress Data Path:Keyword:?:b|_xdp?:b|_" <bpf@vger.kernel.org>, 
 Gunter Woytowitz <gunter@vcinity.io>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789053514; l=3692;
 i=gunter@vcinity.io; s=20260910; h=from:subject:message-id;
 bh=t35EUXvqFJ2uE2i3MYOOcxmhW+Pix8QOFDeXbTpTRo0=;
 b=NKaAMktkjRymX7yeIUQMcFSX4xXFQO1p857Cw9i+09qUKmkP9XE+M6xbd3BtmFug/Js4+KWft
 qyu9RTS81xNCSgon0yLahJiPGi8+Qlqu6LQsm8RGoRCLk9sBeRnGX4m
X-Developer-Key: i=gunter@vcinity.io; a=ed25519;
 pk=6nOwIllYdhcDoigio1cuWODQHYf4rmE6FCJmKXcGH7w=
X-Endpoint-Received: by B4 Relay for gunter@vcinity.io/20260910 with
 auth_id=1021
X-Original-From: Gunter Woytowitz <gunter@vcinity.io>
Reply-To: gunter@vcinity.io

From: Gunter Woytowitz <gunter@vcinity.io>

mana_create_rxq() registers MEM_TYPE_PAGE_POOL for the rxq
unconditionally, so every buffer XDP can see must be owned by that
page_pool: on XDP_REDIRECT the frame is freed through __xdp_return()
-> page_pool_put_full_page().

mana_xdp_set() assigns apc->bpf_prog before calling
mana_pre_alloc_rxbufs(), which allocates with dev_alloc_pages(), and
mana_fill_rx_oob() prefers those buffers whenever mpc->rxbufs_pre is
set, leaving from_pool false. So for a port that is up when a program
is attached, the entire re-created ring is filled with pages the
page_pool does not own.

The page_pool then sees pp_ref_count == 0 when such a frame is
returned, so the atomic_long_sub_return() in page_pool_unref_netmem()
goes negative and trips its WARN_ON(ret < 0), once per redirected
frame. Observed on a 5.14-based distro kernel, where that warning sits
at helpers.h:269:

  WARNING: CPU: 3 PID: 0 at include/net/page_pool/helpers.h:269
                                            __xdp_return+0x2b3/0x2c0
  mana_process_rx_cqe -> mana_run_xdp -> mana_rx_skb -> xsk_map_redirect
                                            -> __xdp_return

On a VM booted with console=ttyS0 the resulting stack traces peg the
console thread and the machine becomes unusable.

Fill from the page_pool when a program is attached, using
mana_xdp_get() -- the predicate mana_get_rxbuf_cfg() already uses to
choose the XDP buffer geometry. With no program attached nothing
changes, so the pre-allocation still does its job of keeping
mana_attach() from failing on allocation.

Leaving the pre-allocated buffers unconsumed is safe:
mana_pre_dealloc_rxbufs() dma-unmaps and put_page()s the remainder,
and every caller (mana_xdp_set(), mana_change_mtu(), and both ethtool
ring and channel paths) already runs it after mana_attach().

The rxq->xdp_save_va reuse in mana_get_rxfrag() also leaves from_pool
false, but that cache is fed only by the drop path's non-pool branch,
which this change makes unreachable while a program is attached, so
it needs no fix.

Found and fixed on a 5.14-based distro kernel running AF_XDP over
MANA in copy mode: 24M+ redirected frames with no warnings, where the
unpatched driver warned on essentially every redirected frame. All of
the code involved is unchanged in mainline.

Fixes: b1d13f7a3b53 ("net: mana: Add page pool for RX buffers")
Signed-off-by: Gunter Woytowitz <gunter@vcinity.io>
---
 drivers/net/ethernet/microsoft/mana/mana_en.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
index 7a1ac853e..a2cb66753 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_en.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
@@ -2925,7 +2925,14 @@ static int mana_fill_rx_oob(struct mana_recv_buf_oob *rx_oob, u32 mem_key,
 	dma_addr_t da;
 	void *va;
 
-	if (mpc->rxbufs_pre)
+	/* The pre-allocated buffers come from dev_alloc_pages(), not from the
+	 * rxq's page_pool. With a program attached any buffer can reach
+	 * __xdp_return(), which returns it to the pool the rxq registered, so
+	 * fill from the pool instead. The unused pre-allocated buffers are
+	 * released by the mana_pre_dealloc_rxbufs() every caller already runs
+	 * after mana_attach().
+	 */
+	if (mpc->rxbufs_pre && !mana_xdp_get(mpc))
 		va = mana_get_rxbuf_pre(rxq, &da);
 	else
 		va = mana_get_rxfrag(rxq, dev, &da, &from_pool, &pp_page,

---
base-commit: 50d05c7c76c96b90462f24debacca971d2e86713
change-id: 20260910-mana-xdp-pagepool-d61a74902b9f

Best regards,
--  
Gunter Woytowitz <gunter@vcinity.io>



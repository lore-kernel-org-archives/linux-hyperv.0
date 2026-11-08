Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794117625;
	b=ha7D/WzwWCvSZoyFUQr0WitRCQcUw4DSl/F2oC//jEvB5YzspZmkFVdHxfbefNlTEG3o
	 RD0SjZrJv70VhIIGoa3wPt/34EkwPiPESAe7XcxWamxTyw/SxAr8x2Lb+0tM7kKuwFZ7b
	 ZPuPTyJZEzLB07rn4B6TB/1Ey5q07fCT90l8bnspRfJ5FlWYisEes9yXxcCDWkbcJgjIQ
	 JVSSrejd2fHX14SLL1ALB3W4Ybcti+CrnQwCBjspk+wBdvPKwIvn/owspEvNlKvX6nK0b
	 xhWuMtx3UXXgyKgPC5JT8RggDqN3/z9O1H0ht3MNpnzPSn+DC8YcUX+FwEYYPUXXEYQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794117625;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=zMjClMAhSRqoCMrDS5bvxCNb79WE0UiAP81MU3z8MjY=;
	b=FovuIqrYKgJqNVgj66wbTrguQhq8dEsx08FW5wY3Nt6LeNQFC6pG4058KCIJCmVWKmGD
	 ogjXRG/x6Za7A6KtBWPdf+GfcFwvWz2cPNYVVK2qpiGK1ObT3uqR7Ge5ihCwyb14KXaBp
	 jZQIa6PhUyDUgU6gO2/poe8Nsj2tV1gcocIj18PvcDamJK4Oqr/fYw1Dw887oM6o5ibwA
	 J4+3MTGs/cuzb4Pyl9vWBKM6r24Vyh1tS98VrG0plf6wzii301u6C/1KQKJnEm+b1cjrn
	 xzoO9/UqsnaC549vkCM0+sC9AfcQi6gekvaleqdrBT0ZALv8YbaIWRz1kS4iT3bnGbg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=AOOaqqZM;
	arc=none smtp.remote-ip=74.125.82.199
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B3CA6082BD4
	for <linux-hyperv@vger.kernel.org>; Sun,  8 Nov 2026 06:00:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2B3CA6082BD4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=AOOaqqZM
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-3724667bc16so345316eec.1
        for <linux-hyperv@vger.kernel.org>; Sat, 07 Nov 2026 22:00:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794117624; x=1794722424; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zMjClMAhSRqoCMrDS5bvxCNb79WE0UiAP81MU3z8MjY=;
        b=AOOaqqZMji7+Q/zfawmXGXQrs6SiqoHb+7qcTMXm0rg3z+I6ghj9F3xYJmzvMDyFpv
         ALBc7Hs3AMAja3g9vn+BJaKCrDWzc/upL3S97EJZxWgC8s1O57pq/38jERBrFiW+bwQO
         OkdeTyN3o1q8jAL0ea76rsmZIyMvKoX5x8ExceaupBwQDXjZukypdxJvHIDu+2mjymO7
         vW2U89hayazp910LZTzjdgclmEWw4XsHgCVof/zU851983splAEQmvGFKaQo8GobYFBM
         KTrrCyVvDIjy5YIuIgWnXyN+pjCOihCLbWxu0jWFHx69b1yuDfA5lqzkffR8uejQzovs
         IZyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794117624; x=1794722424;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zMjClMAhSRqoCMrDS5bvxCNb79WE0UiAP81MU3z8MjY=;
        b=C3Tmtvae5KoUjSeYS+Z8WElww/Bnvzf2V2EoFONao4g/Qk1UF+tuR9xvXU/n0DrKq9
         YdKIOu7+6DCfPaWxTrp+NqoNapl37hqW2V4DtYmp3l5rNTzktM6JZjuF45tu1/ghPzH8
         fTz0U3FQ+CE6Nt7JEAHLMs1PjiUMZkVWFG51r5YTo78hvFFHrpZR/zor/oU38i3Q1j0b
         FcjwxNSdjJYL5odcudZUxGyNNMdVLPBmhjICPyVIufffNVUZOK/ZXtcotcwvNWv/Hj2M
         2F4aFuKZtinBEMbZwIVKAlSHwVZJVgJ/ie6uKUw9iNn0OZqZqG8fox0aydrl+rR+linY
         ul0Q==
X-Forwarded-Encrypted: i=1; AL+hErGVqbhTpQpNnREZ5w4TsA8Rkv9F+ODwxQwDbjeDSfD9+RbZ7uVav8RxFLdoUiMZLAp4oAidYd5rVEX2g2Q=@vger.kernel.org
X-Gm-Message-State: APuU4Z9b00U+h/raP+3xiGe8nt/d8TxD9IhCrENxa5zm0uRB9bXcXKQo
	t6Gan7BwJeXcee6nM3W1sQvAr74qpcWoxels0SNLSLXWF2FfohDJIB40lFPW1BZECFv2IiA+1YB
	yRiOZrKw/6kCDIBAUXQ7yD0WX5g==
X-Received: from dycc22.prod.google.com ([2002:a05:693c:60d6:b0:36c:9a9b:3677])
 (user=almasrymina job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:693c:20c8:10b0:36a:2473:9b2f with SMTP id 5a478bee46e88-370f7f80e04mr5298946eec.23.1794117619069;
 Sat, 07 Nov 2026 22:00:19 -0800 (PST)
Date: Sun,  8 Nov 2026 06:00:12 +0000
In-Reply-To: <20261108060016.2131509-1-almasrymina@google.com>
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Post: <mailto:linux-hyperv@vger.kernel.org>
List-Help: <mailto:linux-hyperv+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hyperv+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261108060016.2131509-1-almasrymina@google.com>
X-Mailer: git-send-email 2.56.0.455.g6c5a503b38-goog
Message-ID: <20261108060016.2131509-2-almasrymina@google.com>
Subject: [PATCH net-next v2 1/5] net: skbuff: skip managed zerocopy frags in skb_frag_ref()
From: Mina Almasry <almasrymina@google.com>
To: netdev@vger.kernel.org
Cc: Mina Almasry <almasrymina@google.com>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Pavel Begunkov <asml.silence@gmail.com>, 
	Bobby Eshleman <bobbyeshleman@meta.com>, Stanislav Fomichev <sdf@fomichev.me>, linux-kernel@vger.kernel.org, 
	Steffen Klassert <steffen.klassert@secunet.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	Willem de Bruijn <willemb@google.com>, John Fastabend <john.fastabend@gmail.com>, 
	Sabrina Dubroca <sd@queasysnail.net>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>, 
	"=?UTF-8?q?Eugenio=20P=C3=A9rez?=" <eperezma@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@kernel.org>, 
	Lorenzo Stoakes <ljs@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Johannes Berg <johannes@sipsolutions.net>, Byungchul Park <byungchul@sk.com>, Zi Yan <ziy@nvidia.com>, 
	virtualization@lists.linux.dev, linux-mm@kvack.org, bpf@vger.kernel.org, 
	linux-wireless@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Lorenzo Bianconi <lorenzo@kernel.org>, Wen Gu <guwen@linux.alibaba.com>, 
	Philo Lu <lulie@linux.alibaba.com>, Justin Chen <justin.chen@broadcom.com>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, Vikas Gupta <vikas.gupta@broadcom.com>, 
	Michael Chan <michael.chan@broadcom.com>, Pavan Chebbi <pavan.chebbi@broadcom.com>, 
	Doug Berger <opendmb@gmail.com>, Nicolai Buchwitz <nb@tipi-net.de>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Satish Kharat <satishkh@cisco.com>, 
	Wei Fang <wei.fang@nxp.com>, Frank Li <frank.li@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>, 
	Joshua Washington <joshwash@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>, 
	Jijie Shao <shaojijie@huawei.com>, Jian Shen <shenjian15@huawei.com>, 
	Fan Gong <gongfan1@huawei.com>, Tony Nguyen <anthony.l.nguyen@intel.com>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, Marcin Wojtas <marcin.s.wojtas@gmail.com>, 
	Russell King <linux@armlinux.org.uk>, Sunil Goutham <sgoutham@marvell.com>, 
	Geetha sowjanya <gakula@marvell.com>, Ratheesh Kannoth <rkannoth@marvell.com>, 
	Subbaraya Sundeep <sbhatta@marvell.com>, Bharat Bhushan <bbhushan2@marvell.com>, 
	Felix Fietkau <nbd@nbd.name>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Tariq Toukan <tariqt@nvidia.com>, 
	Saeed Mahameed <saeedm@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Leon Romanovsky <leon@kernel.org>, 
	Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, 
	Horatiu Vultur <horatiu.vultur@microchip.com>, UNGLinuxDriver@microchip.com, 
	Daniel Machon <daniel.machon@microchip.com>, Steen Hegelund <Steen.Hegelund@microchip.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Yibo Dong <dong100@mucse.com>, 
	Brett Creeley <brett.creeley@amd.com>, Justin Lai <justinlai0215@realtek.com>, 
	Larry Chiu <larry.chiu@realtek.com>, 
	"=?UTF-8?q?Niklas=20S=C3=B6derlund?=" <niklas.soderlund@ragnatech.se>, Paul Barker <paul@pbarker.dev>, 
	Masahisa Kojima <kojima.masahisa@socionext.com>, 
	Maxime Chevallier <maxime.chevallier@bootlin.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, FUJITA Tomonori <fujita.tomonori@gmail.com>, 
	Siddharth Vadapalli <s-vadapalli@ti.com>, Roger Quadros <rogerq@kernel.org>, 
	MD Danish Anwar <danishanwar@ti.com>, Jiawen Wu <jiawenwu@trustnetic.com>, 
	Mengyuan Lou <mengyuanlou@net-swift.com>, Ronak Doshi <ronak.doshi@broadcom.com>, 
	Ryder Lee <ryder.lee@mediatek.com>, Shayne Chen <shayne.chen@mediatek.com>, 
	Sean Wang <sean.wang@mediatek.com>, Juergen Gross <jgross@suse.com>, 
	Stefano Stabellini <sstabellini@kernel.org>, 
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>, Jordan Rhee <jordanrhee@google.com>, 
	Ankit Garg <nktgrg@google.com>, Tim Hostetler <thostet@google.com>, 
	Eric Joyner <eric.joyner@amd.com>, Prabu Thayalan <prabu.ponrajthayalan@amd.com>, 
	"Nikhil P. Rao" <nikhil.rao@amd.com>, Chintan Vankar <c-vankar@ti.com>, 
	Nora Schiffer <nora.schiffer@ew.tq-group.com>, Alexander Sverdlin <alex@sverdlin.org>, 
	Kevin Hao <haokexin@gmail.com>, Karl Mehltretter <kmehltretter@gmail.com>, 
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>, Meghana Malladi <m-malladi@ti.com>, 
	Jacob Keller <jacob.e.keller@intel.com>, StanleyYP Wang <StanleyYP.Wang@mediatek.com>, 
	linux-doc@vger.kernel.org, imx@lists.linux.dev, linux-rdma@vger.kernel.org, 
	linux-hyperv@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	linux-omap@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

skb_frag_unref() and skb_release_data() skip releasing references on
managed zerocopy fragments (SKBFL_MANAGED_FRAG_REFS), whereas
skb_frag_ref() acquires a reference unconditionally. If skb_frag_ref()
is called on a managed zerocopy SKB, the acquired reference is never
released by skb_frag_unref() or skb_release_data().

Skip acquiring a reference in skb_frag_ref() when skb_zcopy_managed(skb)
is true so skb_frag_ref() matches skb_frag_unref() and
skb_release_data(), and disable share_ok in iptfs_output_queued() when
skb_zcopy_managed(skb) is true so iptfs_consume_frags() does not append
unreferenced fragments into a managed zerocopy outer SKB.

Signed-off-by: Mina Almasry <almasrymina@google.com>
---
 include/linux/skbuff_ref.h | 10 +++++++---
 net/core/net_test.c        | 10 ++++++++++
 net/xfrm/xfrm_iptfs.c      |  3 ++-
 3 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/include/linux/skbuff_ref.h b/include/linux/skbuff_ref.h
index b6f6da556ee90..e94c599ce83d2 100644
--- a/include/linux/skbuff_ref.h
+++ b/include/linux/skbuff_ref.h
@@ -36,12 +36,16 @@ static __always_inline void skb_netmem_ref(netmem_ref netmem, bool recycle)
  *
  * Acquires a reference on the @f'th fragment of @skb via skb_netmem_ref()
  * (pp_ref_count if skb->pp_recycle and page_pool-backed, else non-pp
- * backing refcount). Counterpart to skb_frag_unref().
+ * backing refcount), skipping managed zerocopy fragments. Counterpart to
+ * skb_frag_unref().
  */
 static __always_inline void skb_frag_ref(struct sk_buff *skb, int f)
 {
-	skb_netmem_ref(skb_frag_netmem(&skb_shinfo(skb)->frags[f]),
-		       skb->pp_recycle);
+	struct skb_shared_info *shinfo = skb_shinfo(skb);
+
+	if (!skb_zcopy_managed(skb))
+		skb_netmem_ref(skb_frag_netmem(&shinfo->frags[f]),
+			       skb->pp_recycle);
 }
 
 bool napi_pp_put_page(netmem_ref netmem);
diff --git a/net/core/net_test.c b/net/core/net_test.c
index 2b5080c226636..e20059a00003c 100644
--- a/net/core/net_test.c
+++ b/net/core/net_test.c
@@ -571,6 +571,16 @@ static void netmem_ref_test_page(struct kunit *test)
 	skb_frag_unref(skb, 0);
 	KUNIT_EXPECT_EQ(test, page_ref_count(page), base_ref);
 
+	/* SKBFL_MANAGED_FRAG_REFS skips both skb_frag_ref and skb_frag_unref */
+	skb_shinfo(skb)->flags |= SKBFL_ZEROCOPY_ENABLE |
+				  SKBFL_MANAGED_FRAG_REFS;
+	skb_frag_ref(skb, 0);
+	KUNIT_EXPECT_EQ(test, page_ref_count(page), base_ref);
+	skb_frag_unref(skb, 0);
+	KUNIT_EXPECT_EQ(test, page_ref_count(page), base_ref);
+	skb_shinfo(skb)->flags &= ~(SKBFL_ZEROCOPY_ENABLE |
+				    SKBFL_MANAGED_FRAG_REFS);
+
 	skb_shinfo(skb)->nr_frags = 0;
 	consume_skb(skb);
 	__free_page(page);
diff --git a/net/xfrm/xfrm_iptfs.c b/net/xfrm/xfrm_iptfs.c
index 103cf7c5dbfb9..04ef833074fc8 100644
--- a/net/xfrm/xfrm_iptfs.c
+++ b/net/xfrm/xfrm_iptfs.c
@@ -2258,7 +2258,8 @@ static void iptfs_output_queued(struct xfrm_state *x, struct sk_buff_head *list)
 				nextp = &(*nextp)->next;
 		}
 
-		if (shi->frag_list || skb_cloned(skb) || skb_shared(skb))
+		if (shi->frag_list || skb_cloned(skb) || skb_shared(skb) ||
+		    skb_zcopy_managed(skb))
 			share_ok = false;
 
 		/* See if we have enough space to simply append.
-- 
2.56.0.455.g6c5a503b38-goog


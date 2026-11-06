Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.49
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793993831;
	b=JXXf8HeuX/TSW0V2ZKQL11PAlB+eWUiBgQ0N3yRJu0n8pxen3/ytFHWf/PveFeFk4Q8D
	 VyG3BtOkTpck6KZDeRjTCt9VNLg8QF3jerQYH46RupJuW+MLdL/pXOj7YtssBBOLK/cVU
	 RlspDABwNeHDyIdqtYxzU5wM/yk0mD2HJ5WbPrBbfLTS4KT8BN8fY6b2ThlK0zynZW6nK
	 1RY15oRtMR2QtU3NrenrEvpj2Io4a7fucMPetxZjlkFFdlINf5VLftgO30hx0ApV0anUo
	 1h5Lv21LoryQNJ2RsH75e84q3JJfvDsWt29kkH/cCmv8tiKnXBjUO3XV5W6om/VUyyQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793993831;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=v077dxPdbR6B229Sx3h6EgyHNBd+S9MvYu+3WDhncOM=;
	b=ba2SAzUr5gSqrtbtkQeJuUkp+wYvd3dG4v3KBZevlvn3cq+GA1ZslUffK3gAZRJT1jEv
	 wWHjK9NHWKp4z5zFhKKTAHU1GdStfFfwuv0e2WqiZQ8MpFLJ77KWU+k+FbZEbAUGk8LE+
	 ++ZyEGb1gzG39y9vUTJ2u1gMPXXercCCy3KCKzrHmjKtE7q4N4F+3HbjF1jYfkyMRcGI3
	 gSVNuFmKlA2wqx9WTy5uKEI5/zUe2acS4yvgxphiD51ddxuV00Hrc6p1dFjSmd8PHZLwC
	 V6gPNU1yUtOdk+XvY4k5be7o3lfOddDHQAFoJ+9F8y9zW7qIPT5chxgEPtXHquHy6ZA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=dNYKX741;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.49
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9147606A338
	for <linux-hyperv@vger.kernel.org>; Fri,  6 Nov 2026 19:37:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B9147606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=dNYKX741
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-6b571a45a2aso333a12.0
        for <linux-hyperv@vger.kernel.org>; Fri, 06 Nov 2026 11:37:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793993829; cv=none;
        d=google.com; s=arc-20260327;
        b=fvxSitar5Zr3b1oHHUkBURy6Gxt8WDHBTV3+X9GDgF4Lw6o12d3KrHMwYadnZFVcNI
         2WePsp9Q+SC/ah9+CMJ2ltvVSrmSV+EYmOKY7945/Gb1x2Wyy0k8/T8H4TPLwUf86Y3W
         hK2mrr8sl3KUA+d3nARxxDQ3QX7Ve/Yqeb5uyPoWdqoKin69q92KrfL+TQZC7QVcGCiD
         eGCbmEOU8X2aIIio1Vf0ZTDzne9pMRKcttyBWOyG22976nkFOEBNR8XCamDBp1V/ExI/
         EHR+8sYzxNfj6VT+d/RUd2sDn9rQ5QGz6JcsldyCTM5FKQ/yWQCn8TeyPwSPFnm9WpvY
         z6Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=v077dxPdbR6B229Sx3h6EgyHNBd+S9MvYu+3WDhncOM=;
        fh=ErOh4GS+ZHs4E/b8OG1siTYtR+oaU7sdcRkUKVUjumM=;
        b=phUgA3efffI4dBTTJeonMw9e2J3E4lcfTnAc6VZRS+7wALs3Olv1Wv/XezdC2RFsse
         wj1NgRNEuQdpYOBvH6Fi5E//RbmYhmdXAgDB0IIENvfsRwIdH5gN74/dw2U+HiHhOq9Q
         fimfToYh04eBFAavD4k+TCOaLs1WbGSStYwwTB4L6CJnXw/Q9Eopv8dVzJw0E4ve5GdO
         9dHJYSiTp27I2cO26PjLdyzw9aT3CztLUojfJbujC8rExUDSSz4AnaA3xGBvYN2Q+ABr
         L7u0HE5UxiqsCI4qMvdqT3skxZQL8Y3Sdckzpdg8LrrfcNXNsv4AhhD1WTg07qD5W3+r
         /EgQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793993829; x=1794598629; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=v077dxPdbR6B229Sx3h6EgyHNBd+S9MvYu+3WDhncOM=;
        b=dNYKX741s1YqNe1FvA8HrV/YpGpoTnGJGFShNhnSitPQzFMAUPpOwNIQMFI2wQuupp
         Y3hUs2tFnqdC/VdRW0zFndWiN5AEQOPGp+56b9YRlp3KsWlNMpTSS8KsWRrwE1ANF2pq
         rqBZJYUR8FH+KjD7/HLOiENIbIrs3HrrM8TJb1M/BuyUNDbGddOYw2008Rdk4q5N0Uxl
         3EieS5hw2UL/IalHpELqKu13m9jSN1raX/4Zjd6KaK+E++zf5w71v7XhAlDRuezX6Udl
         f7kTAVTND9XsibslSTDmGJ+yIq9kviDckaPxMp7hBXFHpqA1f7fpqoKOW8Fvv9kEJQlq
         mUKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793993829; x=1794598629;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=v077dxPdbR6B229Sx3h6EgyHNBd+S9MvYu+3WDhncOM=;
        b=EM3Eohf+//JtW7dtziPg11/r0qdwsTDqBiqPZsXojIz7nzVIU5jlsxOLfaAcxrFYVz
         2OZgFYazjUuZYCk5pJWKsR/XaikfqcZSz8JFFwb47siZCfqEqbuNtF/8sOHTye+WlCh3
         F5C3RfeMFkbKwkPcM+1mkIeJ3XriXrF7Y8tIl3D491yofEq3vWc/70X0I01buqYnVr0G
         3Zby+3uR1IOwpLvzkSWb+2vSy5EM5ZpI8mglNFtugH2vwJk0KIV1QjO+W4XOW7flt4/i
         lEAp9HzaqhIKRg6653s+C/FDF13udj1jI0Ddij1GQGdcnL3g27hR8IjVLVRWUF3xd3kr
         HZNg==
X-Forwarded-Encrypted: i=1; AL+hErHkZh0rT/LCfc/5KuzzmDUwj/aqQbbVbSC3qisaIzTfi38npBe44Vix4ez4hJjwcTGffyKxAKx0N6DUluE=@vger.kernel.org
X-Gm-Message-State: APuU4Z9joqHFJw+HEM1j+ADrzQT/gTNLeLjsqe4NMdYHFzBKD9ioWtkA
	/E4huN1UgY1CMTr6oKNtDJVrVHDIRGmJBBCZ5OqX/0gbSBsaYqmnIEeX4ZRTFDEqui6o1gmvOW4
	3xgjhF2G2oWHZPeq6G/Zft+UrKnEs67A0Du1i/PQ7
X-Gm-Gg: AYBFou3aldudqIl9wHDvpNXTmquq+u/58QfKnwzR7ndWySB1z4tvkpylbp1cbh6YIum
	guhLUKfunpsuOVdLpeVS5YNe6hLovR1PrZr2xXU23fP8/i+EYj1g62rGFENHE+OHTWnDET/AYN6
	JCXwK3TbrrW2awgah6iM63+Fcb5Qo7wDvojwLHgx/88IYjs5q1LdT0N3u7DfylaM6duiRxNGSpl
	qoHPGR2sue+3tMjK8vkT5zj4l4LgKNzZbLqKBHiOTv4vB79eB1pwJlYc/vh0UdXwTbvQc1mIKwG
	6ksKPMLepSLfRvOVyT1qL4WLPcnxuI+onT+dDVf+ayeaisF0AYUfdh0MK/6c+529sBBmM1It6Kk
	WtCPTY26kncBFCL9yDmlO71KG9V2YC+JnYCi5n7RmhlUYZJ69VXDoPkVHp09CFQd8wE0=
X-Received: by 2002:a05:6402:23d0:b0:6a6:7dff:61ab with SMTP id
 4fb4d7f45d1cf-6b6f845ff3cmr14348a12.15.1793993828178; Fri, 06 Nov 2026
 11:37:08 -0800 (PST)
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Post: <mailto:linux-hyperv@vger.kernel.org>
List-Help: <mailto:linux-hyperv+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hyperv+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261103211424.127627-1-almasrymina@google.com>
 <20261103211424.127627-5-almasrymina@google.com> <sashiko-outbox-198073@kernel.org>
In-Reply-To: <sashiko-outbox-198073@kernel.org>
From: Mina Almasry <almasrymina@google.com>
Date: Fri, 6 Nov 2026 11:36:56 -0800
X-Gm-Features: AclHuK-XzQbdvaiv61WJyi_8ZqhwGRBCNFscgmlOjr77cMwMQUJZYeAEPiQPfDQ
Message-ID: <CAHS8izMDj5a0xyX4HAoAt=djt7As-Ko=LyEUfq9iJnPoCegXsA@mail.gmail.com>
Subject: Re: [PATCH net-next v1 4/5] net: remove skb->pp_recycle and
 consolidate netmem refcounting
To: sashiko-reviews@lists.linux.dev
Cc: virtualization@lists.linux.dev, linux-mm@kvack.org, bpf@vger.kernel.org, 
	bcm-kernel-feedback-list@broadcom.com, imx@lists.linux.dev, 
	linux-rdma@vger.kernel.org, linux-hyperv@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Steffen Klassert <steffen.klassert@secunet.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	Willem de Bruijn <willemb@google.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Pavel Begunkov <asml.silence@gmail.com>, Bobby Eshleman <bobbyeshleman@meta.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowangio@gmail.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Sabrina Dubroca <sd@queasysnail.net>, 
	Johannes Berg <johannes@sipsolutions.net>, Byungchul Park <byungchul@sk.com>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Lorenzo Bianconi <lorenzo@kernel.org>, 
	Wen Gu <guwen@linux.alibaba.com>, Philo Lu <lulie@linux.alibaba.com>, 
	Justin Chen <justin.chen@broadcom.com>, Florian Fainelli <florian.fainelli@broadcom.com>, 
	Vikas Gupta <vikas.gupta@broadcom.com>, Michael Chan <michael.chan@broadcom.com>, 
	Pavan Chebbi <pavan.chebbi@broadcom.com>, Doug Berger <opendmb@gmail.com>, 
	Nicolai Buchwitz <nb@tipi-net.de>, Satish Kharat <satishkh@cisco.com>, Wei Fang <wei.fang@nxp.com>, 
	Frank Li <frank.li@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>, 
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
	=?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>, 
	Paul Barker <paul@pbarker.dev>, Masahisa Kojima <kojima.masahisa@socionext.com>, 
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
	Erni Sri Satya Vennela <ernis@linux.microsoft.com>, Eric Joyner <eric.joyner@amd.com>, 
	Mohammad Heib <mheib@redhat.com>, Prabu Thayalan <prabu.ponrajthayalan@amd.com>, 
	Chintan Vankar <c-vankar@ti.com>, Nora Schiffer <nora.schiffer@ew.tq-group.com>, 
	Alexander Sverdlin <alex@sverdlin.org>, Kevin Hao <haokexin@gmail.com>, 
	Karl Mehltretter <kmehltretter@gmail.com>, 
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>, Meghana Malladi <m-malladi@ti.com>, 
	Jacob Keller <jacob.e.keller@intel.com>, StanleyYP Wang <StanleyYP.Wang@mediatek.com>, 
	Frank.Li@kernel.org, wsa+renesas@sang-engineering.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 4, 2026 at 1:15=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 2 potential issu=
e(s) to consider:
> - [Critical] page_pool: TOCTOU race in page_pool_unref_netmem() non-RMW f=
ast path
> - [High] tls: page leak between netmem kTLS records and mlx5 tx_sync_info=
_get()
> --

Real issues.

pw-bot: cr

--=20
Thanks,
Mina

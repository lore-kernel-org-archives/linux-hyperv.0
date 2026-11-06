Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.49
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793987600;
	b=eiazvKMNFGx/udiQqDumxuzWInU4Q5lPKsDGtzpSbQIQtbHXTLSTXZr++S0fdjIuV1AK
	 I4SZ+4lcwp1siE0pIBH/u7zR1JWaSdnILyrbteSIpKFPlB0RiZlsSF/LfVcDNWjj5NRgw
	 4bnWo4HeEVEJ8G5ShwIn+TEZMx79crs0Xph0cWlPnv2b6sBxfYpOtrwfnC1/QgVhX9XC9
	 q5XaLFWt+g8F8uR8oNoTwUQCNxhogDRHHfcbQTpzZSumr8dPlBU1NlzlLsXHrfVry1DgK
	 LATyXb92ZSUX+/NhC/NfZlZYwgmbH3fDC9i7nzXfy/v50iDV+48G3D/dfX4j++Wdzkg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793987600;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=5pDupBwR2/7t1JImpr59IJwI8nCk2i1PzTMP7JDf060=;
	b=kDSgH57fNq/HGHUQS+TXuw8vr94hZncs7uoh4T7nVqdJOt14A9cdEw6sgTMdbAUFZjD7
	 FUcPoznbRljgnxqnJuD3xSWeYO+ApwzYOzv1yt2wMz3AJjq9wXpyL7ydDuq52qfg9rckY
	 Eee0ooRjMhttzQv2koRd8iU3hfam+/hCwRb1c/SvGvjLUm43ANyX2g+q3y1p4bHRUOUU3
	 VBFFexyApj2CY65MxXCBKQmdmYhV2z+2ZLT+Q4lADxOKgfSIRCqSQ6ZWYWYFJ7Qz3fCST
	 P5J+JVwVKmSy7jPL+ztxRULgTyN66XcurKU74xXGeSs/fYAAZBPTbrRpVvQ0+FZeMmA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=jlcDAy1q;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.49
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67150606A32E
	for <linux-hyperv@vger.kernel.org>; Fri,  6 Nov 2026 17:53:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 67150606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=jlcDAy1q
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-6b6966d9508so781a12.1
        for <linux-hyperv@vger.kernel.org>; Fri, 06 Nov 2026 09:53:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793987599; cv=none;
        d=google.com; s=arc-20260327;
        b=pK5qHjD3V91oeL00PCgSSY6NNakwPeBQrmPY2VSAjTJ+EmWJpQGo45sa+5XvQBitTN
         6eEw43iGUMGYGht3S5FRHUBvI0SbMTkcP1vFeEX/L20eE0z7v7xTuU3f1uG50KQeXafC
         uDJsz4j74wVgTHdAFfWmqiAxgzphzFaybxSGSuMv5FmOavdHZfZLwDybZWmp8qKBW93Y
         nYSmqUGjOrogY9cwc9+KuKKg9FmapIMFuq4tCH5kNcuYYDdDuwweJxT6GYyKIZ2n0CTp
         ec7Ea2ZCmPzEGrcO5Z+dkQ9cI6icfIx9ZzbDbJemgGyFv0R/1doiwsoXvzZSLoLaE+om
         y0mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5pDupBwR2/7t1JImpr59IJwI8nCk2i1PzTMP7JDf060=;
        fh=kNURqJdXec7ozEzVXCj56LJVIhIT9hEwfr+uALmf0Y0=;
        b=frO3m9/IktE/eI4053etWwl/O+0HFTdKN/4y5CTM4RGjdQHKiUxA1Q4Xr0NTFeVONc
         tN6BMru0pQ7TR6jcKusS0cefxI7XgRdi/wYAP+3Cp1LgwXTTlBHGjHh/2Y9+Dy0q+oJg
         /d+KBZkqbJl3EceQedqPmLBiYaLnJadG71snjcG9Bgl48VPniODNhVIMvmjviqjJyLd8
         eKOpuF9T/n1Jhv1OK9dLW9w3brBV5KjX1RweyxR3yo0kmWOoANne0p1PQHCADm/ff7RH
         L6LzflGDkKbdSwtrE8raYswBHoc01jbXU5VUGgNm34pnTRH43A8cVm/OHC1iX6dmrBkc
         Uc5w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793987599; x=1794592399; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5pDupBwR2/7t1JImpr59IJwI8nCk2i1PzTMP7JDf060=;
        b=jlcDAy1qwlP8CV/J8ziGOhM7zgiwe1Yqasgt18zZ9BLFfbdjvFbOPJHelnnlWn7/NF
         Iv0y6BvcfswTFEAK+vaTKFWw4pm1SC9i7SkbSqJgyIWek4Oq+yCZaP0CXyGrm6BTXeAy
         PMZhXc8r+FCA+Uan8Tn54ozp3MQPEOEFZdVxBH5ggJzVX08faCYPNZDo3xsJ3VF8tmEg
         pX3urwYaX0msYCvMLpruaNTx6NxqPVTVZ/iC58DSiI1w9TNgPQSmlsdvsWkpbFzggva5
         DeXnKd9qGJxbmFLWSsqwsQR8pJQE3NG/l6oFkjRU8+PfaF5R3/yJ38vi2guHN24z+b5U
         +fdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793987599; x=1794592399;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5pDupBwR2/7t1JImpr59IJwI8nCk2i1PzTMP7JDf060=;
        b=iyKKer38tDMQUdT7RGBuP9wZRz953K764a3KYm6rABJ4tnMdzL5YjQhsehAedQXu7y
         S680XUe/r4pA80WICyiusHL3n28k3PRqZxgoHl+V92RAWuaS9tc4o9d6JEwA7xiIX6UI
         GxqRh4vGR00+7/60tNUaWFywggEe4JNryJhCUqi387706f2B5qjVuWdAGZ4UT2UlePmD
         VSRPmmZ5ZJo+DjubiUw5wD5fHyd2OwE2/OhNPAX1ZBUk9JRhMo1HdLroG5VKMlajYsDX
         /r3xj78aktzlaJXx4EnNbGAdViBd3C5TeGHe1FNf7/Whu6f+jtZQDY7tOVLA3bzKVy3s
         Lsmw==
X-Forwarded-Encrypted: i=1; AL+hErHimrE0Fsaxxa3ed/m1Ll8O0RVJdulHTwmZJTq+dAffu7dhYjIUd0ygvK6wwUvm1uz4e4dSvKTV1VtcK10=@vger.kernel.org
X-Gm-Message-State: APuU4Z/DeJVj3g7yAyp6bKx5aNPwceKU4NytD+Z+524Jbht0OyL2qeTE
	RIpCbl0K2Nxspv6WfLh2gwCESAuA+IOBsKjWgjaf+pnZNmF3cDvovQUV165DgW2LQ1SkBErUpdk
	gdRaoMeU7bzCWBgmXN4dxggjsE13+KjsUN9WOoSy8
X-Gm-Gg: AYBFou3/QuBV2C+ynBDm+l69AOng/pTpLgPA2eXTBJN6S2zPQtgQSH1nd1ZGsyOdFDG
	gcaTZoiNN/TCmcdlczVQUztrZsksPxcuIy5rW7Vnhp9wJ+yoMovVfkrFLbM8vZpVEF+aI7e/kly
	ceiB3RBKClu8lCjoXWj759PRi3hUnby+LREVhD+e1aTKN1y48zLnxPgFHGkzrbvDeYtJQp7F7jJ
	zAhS/EEeXqwVfFnop7xXPRo2di027YxEudsdgikWO8B/soOeR0yKyUX2Ro7PXyldgyki0eNe/U/
	7iIuAZZQwtSuniC8q5a/vRYihMTW0m2q+6G73wkOmS2NOGz8Mro2DuqoPyBtKYf1JESFXOBRQ0w
	KzQnratUvP+D5ZRSNYZDGYcISY9t4FgerYSspMsX3zIZ0AUUXpYS4/wcyu38eakxydTE=
X-Received: by 2002:a05:6402:20d2:10b0:6af:97c0:ce51 with SMTP id
 4fb4d7f45d1cf-6b6f84514ccmr6722a12.13.1793987598073; Fri, 06 Nov 2026
 09:53:18 -0800 (PST)
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Post: <mailto:linux-hyperv@vger.kernel.org>
List-Help: <mailto:linux-hyperv+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hyperv+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261103211424.127627-1-almasrymina@google.com> <cf2e3292-d591-42a4-bf6e-76f4567604c6@kernel.org>
In-Reply-To: <cf2e3292-d591-42a4-bf6e-76f4567604c6@kernel.org>
From: Mina Almasry <almasrymina@google.com>
Date: Fri, 6 Nov 2026 09:53:06 -0800
X-Gm-Features: AclHuK9NbTvBEPfZwCm6iqd7sXh-jqNYXp8FMPv7QJO9bGGBVmf4WllHJrUhzyo
Message-ID: <CAHS8izO7QmD1qp=QfUsCq-R+p7OuOVUtqPJZh1k+u7H1J3KnoQ@mail.gmail.com>
Subject: Re: [PATCH net-next v1 0/5] net: deprecate skb->pp_recycle and skb_mark_for_recycle()
To: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-mm@kvack.org, bpf@vger.kernel.org, 
	linux-wireless@vger.kernel.org, linux-doc@vger.kernel.org, 
	bcm-kernel-feedback-list@broadcom.com, imx@lists.linux.dev, 
	linux-rdma@vger.kernel.org, linux-hyperv@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, linux-omap@vger.kernel.org, 
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
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Sabrina Dubroca <sd@queasysnail.net>, Johannes Berg <johannes@sipsolutions.net>, 
	Byungchul Park <byungchul@sk.com>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Lorenzo Bianconi <lorenzo@kernel.org>, Wen Gu <guwen@linux.alibaba.com>, 
	Philo Lu <lulie@linux.alibaba.com>, Justin Chen <justin.chen@broadcom.com>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, Vikas Gupta <vikas.gupta@broadcom.com>, 
	Michael Chan <michael.chan@broadcom.com>, Pavan Chebbi <pavan.chebbi@broadcom.com>, 
	Doug Berger <opendmb@gmail.com>, Nicolai Buchwitz <nb@tipi-net.de>, Satish Kharat <satishkh@cisco.com>, 
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
	Jacob Keller <jacob.e.keller@intel.com>, StanleyYP Wang <StanleyYP.Wang@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 5, 2026 at 8:36=E2=80=AFAM Jesper Dangaard Brouer <hawk@kernel.=
org> wrote:
>
>
>
> On 11/3/26 22:14, Mina Almasry wrote:
> > Remove the per-SKB skb->pp_recycle bitfield and skb_mark_for_recycle()
> > helper, and reference-count netmems directly by their underlying type
> > via netmem_is_pp() inside netmem_inc_ref() and netmem_dec_ref().
> >
> > This series simplifies SKB and netmem reference counting:
> > - Reclaims 1 bit from struct sk_buff (skb->pp_recycle).
> > - Unifies reference counting of SKB fragment netmems and regular netmem=
s
> >    under netmem_inc_ref() and netmem_dec_ref(), eliminating the separat=
e
> >    skb_netmem_ref(), skb_netmem_unref(), and skb_mark_for_recycle() API=
s.
>
> Part of the performance gain from page_pool was to completely avoid the
> atomic refcnt operation, when we can see that page refcnt=3D=3D1.
> Are you removing this?
>

I am not, and this is a very sharp observation, because retaining that
optimization was one of the things I struggled with my LLM to come up
with a way to retain that optimization without pp_recycle. Patch 4
includes verification from pp-bench that the fast path remains just as
fast:

   - no-softirq-page_pool01 (fast path): 37 cycles (18.7 ns) baseline
vs      36-37 cycles (18.5 ns) patched.
   - no-softirq-page_pool02 (ptr_ring): 77-78 cycles (38.9 ns)
baseline vs      76-77 cycles (38.4 ns) patched.

But the sashiko comments indicates there is at least 1 race related to
this we missed. It looks like a smp_rmb() after checking the page is
exclusively owned may fix it. Let me see if that works.

--=20
Thanks,
Mina

Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.215.179
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793920342;
	b=U7SLvuvVp1San5Ks76zNQG9p/lBBRjiQYfsnilk7sxG9VR+EltJN9FISzs1fK5PszTv7
	 FgzxwBCQxsjIHpFQ3lvggzPjJua70066NoJfFwQiTQZ+YmVi9SJfuxQEH9DKE6x9/nogO
	 tlL5BRlwFzY7WZeWGH3fuheslKUSsoDIa362pJbrbgRLuQOWH1vuYebVbOEMGYl5NiDcR
	 5IXHJPTPiKBamNV3AXWt2MmJhLOiuod7ne8+FTvJqsZyih4gfhkORnOEytrj3VriVzI6c
	 6aKwaQzY+hPipu8B43ZIL17dLcut8e8aStghwHJ849zIYpWRQAZlns+gF1mlz0S+AnQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793920342;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=w+g0xKR97zcXC//9XGcArRTzIRGbaLo0LA3je3jFgFY=;
	b=qTR9QVRggDl+OOmYEmkMjMTGjUzQRZoY7wQjCksqrV5Vo0DgnuFNBl+rXINmin8KVEqb
	 tBawecdV+BXRuDtjao5aePRUSDxNfch3/f0pbw7+UM/mnzmNRyDETVgfiCdiFhKK7iroS
	 mrr0vPuTvLfKWDBPtPfvvkPwsyDDcWX3JM6G5d8O7UDSYrFO2Jv4xjwdGdPzBm9KfpRe2
	 1xCavCFc6bdfnWq3dUS60LjARnKicXIiIi9uEJ7RC/8Ln59FYWvcHgfqWT44WaMbir/rg
	 vNjPlPZGpjovCIyx/uBHUZ7UC5P5pn2ReMckMjzVknZXHQkAyessecObgFsggatBvoA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=paul-moore.com;
	spf=pass smtp.mailfrom=paul-moore.com;
	dkim=pass header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=ePSbskAw;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.215.179
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8E13606A326
	for <linux-hyperv@vger.kernel.org>; Thu,  5 Nov 2026 23:12:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E8E13606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=ePSbskAw
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-cd6a7e1f4e4so14534a12.2
        for <linux-hyperv@vger.kernel.org>; Thu, 05 Nov 2026 15:12:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793920341; cv=none;
        d=google.com; s=arc-20260327;
        b=NultXg6v1r6V2hw8sy4iHEQFlY5xYgk26kvIdVGSAscNObKLY3zVNCeDP+3JDRM0qO
         N+zfXz5+a9tueXnF/DnW4EtaK10nv+sIcWQtGbG2/IskrbqCKhhDUytljaorwiqpkqTJ
         SBknfueAfE+Quky3mWcghCHvfoZ/6extfWjoI9VYZSMPOSZQt8kKCwqp5YZSg+LF99A1
         XytFQJzh+EFlUyyvBj5ecXAWloQp+PnoMr+BF7EM63XRp9d7HcXfr68WJyYvRzSN3Kxw
         UBxk/XYQYF6s+vcr6L2muAntyVU98ABX5CaL9A+Q3h5FKDRqV+NSA0tMkXaFgEnU35Iy
         AU5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=w+g0xKR97zcXC//9XGcArRTzIRGbaLo0LA3je3jFgFY=;
        fh=UL8CbqutwsvatXIX9xDDlzP2QPRkbD75Yw52sn/dB04=;
        b=qEeUvwdcQxJN+vKapV5WCfSxp0E4uOvSETtT+fGpAZYYsQtfQ6Vf+eHwT7tPE0nPzX
         /DM/FZpuEY3WPmHsruuBXPca3F5tqBrm2AMbiFp+8t9mTMe2otWPZ4mLvirFlemrexNQ
         yBRt/tLJJmC/gbaqFUXpyV39x1bsQNngwrUZZtqV2gksrjSuIZD1Bp32rSBFq4M9D2jv
         b0Edgqvapr4uy7MmaWd9yKRvlcV9bcJB2dP/llcbgSRY6n0NfR9PKNZTJF7VVmyd2ZY6
         jy+JX8ob3xl8uekKwtrlDzuCpqSRQ/+MFqJ+KmckB7UMYLMrrnnBkwhxu+0fmVxjDMnb
         BxaQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1793920341; x=1794525141; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=w+g0xKR97zcXC//9XGcArRTzIRGbaLo0LA3je3jFgFY=;
        b=ePSbskAwea0d9B6NpBdXuFYsWvLDCToKGcxFrN9C/fQLJKxAOsbctr8qBrrZUslJXJ
         9CLcMCSIkKD7ZW5JSZB/FlpnXL7wVvbFlxAaV35NsJbH9Ct+Vj1AE0PSCxPZMXuxmspf
         S8DzKorUUKYgddL+oYJfDiSPHAXfQ8DdRb1gIJCpXWqjafW5TeuSLk2tBK8Xu5u2Toof
         wmqoUSerZIxxVmbDxgyvtDxt3hKRgQ27SfmnssLj7BFyrZUgbmKG7qeTDPokQzsw8F3e
         sMOi8Cm8Fp7SxcfGGOrWu3vbz980QOeeJXGWbY7zrPoyxcb1MpuMc94aw2AmHxsi0GQi
         jm0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793920341; x=1794525141;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=w+g0xKR97zcXC//9XGcArRTzIRGbaLo0LA3je3jFgFY=;
        b=PYUsewDBqxzra5LUYmMt0G2+jwWLTQC7UgxGPFsDpHHlU2keBAeQN0dPq+Ysw1b535
         RBcKQXjGMvft8PdGNLdx2A5jV6q55bOeqVNngj9qWncOy9IQY1+RE/aTEJm9J4DtgjRp
         307N6BfDH/8Shl8lJ5HB7fu3quW/qgNhyNl48BvdOPeAkUoKqtiZryFdXUeqaz4K9tyB
         GuaohvDkUiBoG1shTalAenLF0XyFEhu1Enhc/EyLJFJa0YQf3CmpqX5WecnRtb+lS0Nt
         8rfEJvyNRXZXfB46L/HR2PHaLf/ZLd/fN19D825VAAR+BIVGqgPCa0L2D2CD79Advcvn
         0h6Q==
X-Forwarded-Encrypted: i=1; AKwUvBxi6fP64t7r29anl20Tbqolk+aDwaTxUFaOrhQipjLfle1dMKYOXSvfZg+X5RCrSK7Z+ZHdfzPFGBPRInM=@vger.kernel.org
X-Gm-Message-State: APuU4Z9Mx4YY+9kJM0TG38grlnV+3czuyU0ScFURGFXmnsBR6Wwmb5uJ
	yUWBNFUhhv8IDlFLYy4LbKOA6weTo9i9PMNpUoLIXKII8yxRaUhf7yQz3ra3QjCyJlqEERSqNBi
	53emOZSC94RfgMQC9wOv9fNxQujfMgCwr1CtTxDHW
X-Gm-Gg: AYBFou25uqVU3ZJ4kQRMNw0Y/4tE0wBdj0pvDwzA4PjEXsB5LwZexvlUJsbLoOVJY59
	j+CWX7wTmFOCSslaD4RwuKOFfUjsxg/8wQHCSo5suVVHqp2Y8Tg7S01kMx+biMC4mF2BzElwzyZ
	oSHYA5OrhkYN6WTtW8vRCr4N2v7kiZRjiVBfILVq5DmZ/hDb67k5l9J6oTxCVGwuj/rcMH+wOLp
	dH9J09gXi4K2zKWIoZVshHTtbHwXw1jtAx5ye29caHBIyZlAxfk/M82ml21gRnrekEDU6z6uZGn
	V9WW1M4R6M6dcGzYiuLmdJG1uvR88V/9MHdoWlCivb/hMy0KmPeMDdyeFTZrKT64CwOlfKGC2+u
	RVmWF6t18yCrc6iCYf6/+MRxJwAp8MSbnswnrGU2aepQoyV4QLCannnOjXWqiT9vsjApj
X-Received: by 2002:a17:90a:d88f:b0:3ac:b867:81df with SMTP id
 98e67ed59e1d1-3b0db6fbe69mr555739a91.39.1793920341210; Thu, 05 Nov 2026
 15:12:21 -0800 (PST)
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Post: <mailto:linux-hyperv@vger.kernel.org>
List-Help: <mailto:linux-hyperv+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hyperv+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261105-late-2026-mmap_prepare-v1-0-c56aadfbab8a@kernel.org>
In-Reply-To: <20261105-late-2026-mmap_prepare-v1-0-c56aadfbab8a@kernel.org>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 5 Nov 2026 18:12:09 -0500
X-Gm-Features: AclHuK9SAmQ1s59IzUj_GoyUW49QmobrDei9zDR78OY4d10Tcv8mWs8d-l1JUg8
Message-ID: <CAHC9VhQvpFeEJaEyPDaqj8_S752puSaNe0Rn-hxjh=ugCoFsxA@mail.gmail.com>
Subject: Re: [PATCH 00/14] mm: convert further simple mmap hooks to mmap_prepare
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Juergen Gross <jgross@suse.com>, Stefano Stabellini <sstabellini@kernel.org>, 
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, 
	Shrikanth Hegde <sshegde@linux.ibm.com>, Haiyang Zhang <haiyangz@microsoft.com>, 
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Jarkko Sakkinen <jarkko@kernel.org>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Jan Kara <jack@suse.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, =?UTF-8?B?T25kcmVqIE1vc27DocSNZWs=?= <omosnacek@gmail.com>, 
	Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>, 
	Ryan Chen <ryan_chen@aspeedtech.com>, Billy Tsai <billy_tsai@aspeedtech.com>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Abel Vesa <abelvesa@kernel.org>, Jens Wiklander <jenswi@kernel.org>, 
	Sumit Garg <sumit.garg@kernel.org>, Scott Branden <scott.branden@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Richard Cochran <richardcochran@gmail.com>, 
	David Woodhouse <dwmw2@infradead.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, xen-devel@lists.xenproject.org, 
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	kvm@vger.kernel.org, linux-hyperv@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-sgx@vger.kernel.org, 
	selinux@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-arm-msm@vger.kernel.org, 
	op-tee@lists.trustedfirmware.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 5, 2026 at 4:06=E2=80=AFPM Lorenzo Stoakes (ARM) <ljs@kernel.or=
g> wrote:
>
> Continue the conversion of users of the deprecated f_op->mmap callback to
> f_op->mmap_prepare. Keep things gentle this cycle by targeting simple
> cases.
>
> No functional change intended.
>
> Build tested on x86-64 (allmodconfig, each patch individually), i386,
> arm64 and ppc64le.
>
> <<>>
>
> David, Andrew - I wonder whether one of you guys could take this series
> through your tree? Since it's kernel-wide it seems sensible to take it
> through an mm tree.

Granted I've only properly looked at the SELinux patch (7/14), the
rest I've just skimmed through, but these are all independent patches,
right?  Is there any reason why individual subsystem maintainers
shouldn't just pick up their associated patch?  Yes, perhaps chasing
down individual maintainers is a bit more work, but isn't that the way
this should work?

> Lorenzo Stoakes (ARM) (14):
>       xen/privcmd: convert mmap hook to mmap_prepare
>       KVM: PPC: Book3S: convert spapr TCE mmap hook to mmap_prepare
>       mshv_vtl: convert mmap hooks to mmap_prepare
>       vduse: convert IOVA domain mmap hook to mmap_prepare
>       x86/sgx: convert vepc mmap hook to mmap_prepare
>       udf: convert mmap hook to mmap_prepare
>       selinuxfs: convert mmap hooks to mmap_prepare
>       xen: convert xenstore interface mmap hooks to mmap_prepare
>       soc: aspeed: convert LPC and P2A control mmap hooks to mmap_prepare
>       soc: qcom: rmtfs_mem: convert mmap hook to mmap_prepare
>       tee: convert shm mmap hook to mmap_prepare
>       misc: bcm-vk: convert mmap hook to mmap_prepare
>       ptp: vmclock: convert mmap hook to mmap_prepare
>       vhost-vdpa: convert mmap hook to mmap_prepare
>
>  arch/powerpc/kvm/book3s_64_vio.c        |  6 +++---
>  arch/x86/kernel/cpu/sgx/virt.c          | 15 ++++++++-------
>  drivers/hv/mshv_vtl_main.c              | 14 +++++++-------
>  drivers/misc/bcm-vk/bcm_vk_dev.c        | 20 ++++++++++----------
>  drivers/ptp/ptp_vmclock.c               | 19 +++++++++----------
>  drivers/soc/aspeed/aspeed-lpc-ctrl.c    | 20 +++++++++-----------
>  drivers/soc/aspeed/aspeed-p2a-ctrl.c    | 22 ++++++++--------------
>  drivers/soc/qcom/rmtfs_mem.c            | 22 ++++++++++------------
>  drivers/tee/tee_shm.c                   | 14 +++++++-------
>  drivers/vdpa/vdpa_user/iova_domain.c    | 12 ++++++------
>  drivers/vhost/vdpa.c                    | 23 ++++++++++++-----------
>  drivers/xen/privcmd.c                   | 11 +++++------
>  drivers/xen/xenbus/xenbus_dev_backend.c | 14 ++++++--------
>  drivers/xen/xenfs/xenstored.c           | 14 ++++++--------
>  fs/udf/file.c                           |  8 ++++----
>  security/selinux/selinuxfs.c            | 24 +++++++++++-------------
>  16 files changed, 121 insertions(+), 137 deletions(-)

--=20
paul-moore.com

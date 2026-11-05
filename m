Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.216.43
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793920457;
	b=f7owtNzji+wtfEBFO41GalUDDAv4IDvuG1p1amulPAMz4QmY6XkQWWU+IZ9K4EXMan1I
	 pN9EISdZZp4o3T8Azu/tojdlGGq0OlMEVMHLVvls8nwv7YaqPHLeJOEpVuCAG+ZL04n5o
	 fwj/33U1ZMHaFzkJfDHYZKJ+g5CQHDgP2d6oYES7oQR4+7CC2GSwfBSFlCfHp0qaFLG63
	 QFs+TJEewqllQRHo4G4dfji4E5BTLfNF3GtUsW5HtLU6cQP4yRDL0yBSQx+L9w5d7jkRx
	 WPvatvygY4lewy3AdIf/Mt095v/mN9VhzKEA/3RZL6LwSFmAn4wku5L7DulPWzxadsw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793920457;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=mGiD8zQqMuzCkGXAZBtgumh8HlT9rNPiWNa35MXqkeQ=;
	b=eS8NoT2Z+OmAZj/8FeBrdBO8baJ/1xPEl2KowXe9XoItlUDgGauHs//+NPSxYAvp7JUz
	 aTMfgzo8GNwRC383Fi+6PKjOeg8ZxhHgv5sTKonpgYIal1OFL0Qbu0bgV1+8WOfB1u8H/
	 sszGtvPWzb5+gGdtJfBpHGVHzWXDUFPBl1gtOukZVG5Uvx3Nek11fs25sRUP5ADwN9Xyi
	 Ltotq6WYoglDrwXqsdpeF4z0N54RMTo1XnWORITuoc8eR16fmoILO+cOHlXoi+k38zFZq
	 2Z5uMeyiu4HI2FLWTPSqphgBIFXcx19TQ2DM95ya683/B5aBNt++K8WVNCazSSZZneg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=paul-moore.com;
	spf=pass smtp.mailfrom=paul-moore.com;
	dkim=pass header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=IU6i1Fwv;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.216.43
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A81C606A31B
	for <linux-hyperv@vger.kernel.org>; Thu,  5 Nov 2026 23:14:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1A81C606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=IU6i1Fwv
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3acdcfa2bd3so60762a91.3
        for <linux-hyperv@vger.kernel.org>; Thu, 05 Nov 2026 15:14:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793920456; cv=none;
        d=google.com; s=arc-20260327;
        b=Eb8XYQ+zyjEg9uskvhtuOEixFDSRtwUvnQvA1TahMjIp3lNX0QyzrQCKx0dg4W7Mpy
         SppWmv3q/3bUOHCmAoaVhy/o09WeA/3O4oSQFzFgWj+58qmkMKobStadZ/EDs0xyXsPv
         oZJKgYCWU8akGGFOkA0789WGNWnT77YY8VkzfsQZswnoGq7c1vOf2ICArx2jPfckYXnS
         PkrWBBIAzpxInJjdKZMmnplwZNMWPhUzPXhZ3dkCZynnHRTijoHEZvyAI7EmwCnnu53p
         5wEPZBiEkV+m5kYJ2TfIj9SoGoY59NaHpv62pU1iWvHKn1V4DxtH2DgFTnAQGQ+csjQi
         RvJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mGiD8zQqMuzCkGXAZBtgumh8HlT9rNPiWNa35MXqkeQ=;
        fh=SSFPm0QKQiqwtwSnKvpBLw8qk0qadieZEpc2t3DFQRg=;
        b=XWBCo2Dyad/L29Bt2XiXHVxtwfeY59Jw7vfkIohhcfH8RFA+ILiPrj3BOtpOeHZrCo
         RBSCd2i0w44ivDPpf/CM0BQ9B8jmzQv/EJrTfDPOUt7f0fM2hiShds5fir3q7Z40tpiW
         ASR7kVtq/oL7+ww/QaygO5ii9ydWaH9DUvTg5kJLIShth/n221efTiVNhZfsYHqQCYzn
         RlDCr3pvJCO53v4reOcAncTIwkOtkrbMdPyia+3YVINXtwyzyFvl2PvURJC/k+fVdWYC
         r1hohIyN44HLxauy0DHmTMQsKyb9KV6medUY0rdseKBr/x5PLJthBsCON0U10uRfJLU6
         gagQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1793920456; x=1794525256; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mGiD8zQqMuzCkGXAZBtgumh8HlT9rNPiWNa35MXqkeQ=;
        b=IU6i1Fwv/0w/cks1e2nfs6t6sk022zL/8GvQwys2lPo33xKyfU4+rlcYd/DQAZEHG/
         pOKIazGTVuNB5nr366kMh62Z8mKuK+0wykvjpk6nMnF62dQEPqXhVYv3AiAUQh2yheQg
         Wv57SCnVaPWXfP0Spf5ZrgQ+6Qros/0dGKzT5Ct8KPvTnGxmERS9srU07KlGSKT3u7rc
         WSDGWK1HJ7ZHGpFoQ0kLcdKEj3NsCe6oNqECA6Dmye2YgKsYtmlI/U8g/CwAwltsgKHy
         7lk6f9CpVk0uzXD9qAsG8lDByv90XfisBUHNR3hzhw22DDDhGO8biMGoTBxSg1pPVUNx
         pPJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793920456; x=1794525256;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mGiD8zQqMuzCkGXAZBtgumh8HlT9rNPiWNa35MXqkeQ=;
        b=XPkh+xzcrIzlbWYA/i0tZA1eu2284l3WyEH7SIEKFcanWIsotG7YVyIx8mALctgwOR
         YANRKda5lmPxKnjy8nyLTS9y+O4If4CtYxfkZL+KrS41Z4HK1QApzOiFrj4r2lJFAgTd
         Th9Hb/+dN3+iBCWslNN6cAcg7CxOAa+Cg+57nI0TH/veVuNAxc6Hwcv2MBZGXIwXvyLC
         cyyHNplxBgkOcj5/EX7/H4ooUYY/ldDi9xwJMK5aulamTvKLmm2KiAFv6nApcJh8K/rW
         3iUXVPLNGv8V9IU2nXXZ0JJ4JIolRuOekkSFW7TEB/yYvI+9MpbOjKn8XQrH8g+QNgmc
         toIg==
X-Forwarded-Encrypted: i=1; AKwUvBwu9/yDppU356JWDUl4DSxcLZqyVh6zAYTtx8UX9D9wyQ4nMOqvkCdRf/vkGL/wegmDSARINblRusJ6BrE=@vger.kernel.org
X-Gm-Message-State: APuU4Z/yVUbMeDwI8y3POtPqnyjHFUguW96uineOPVkxByuGwwBL/MRq
	AOHBS+K0Gjyg/CA3OHm9+3+cBkPs2NKwo12Ow4StECIjWGyyhmDlAJnX5St+Ij9VrFe1CaPGzhG
	nKHrWC6GTSpRLgvPyinl9Q4AMaSOUwrxlFlZ1VbXW
X-Gm-Gg: AYBFou13m8OGwCYxXgfjBP9EulmNLIo5g7WRiwB02xwV+ati+vGMW1LYpnIzfhGMpR/
	AGmmA65ryScA2qg3U7J7knka+nWhppqWKAkOuwpRD+ZeQr1vFMuNXa4VYm0hQ2AMmMkYlr26cGx
	BLKDZ7Jd2LmfbhjmArRlzDrjgBTxu6uOcHjmTpuWTa5y69wVSVgtnpgc/bfnt1Rn40PZM9uoS3z
	zNVJ1Z/gBVMGIhFu0bywLnvw6OCvfQmSmojL+Cfq/9APjEW3CXbPJogrGhmwR7beSLIFs6eJXjw
	azgfBqivSsfi0QY7cW4X1rDxXpUXsval24j5B8dKdQ6LIH2iSfH0A7+FuyR7k4iisFRw/DA6GO6
	A1LT7god/RQknd87POUAd2k66ZyR7+1zNsUzqSaf/K6WEffgcSvRlssahatm3ct1iw80O
X-Received: by 2002:a17:90b:48cf:b0:3ad:a462:f07f with SMTP id
 98e67ed59e1d1-3b0db6e8ca3mr534231a91.45.1793920456567; Thu, 05 Nov 2026
 15:14:16 -0800 (PST)
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Post: <mailto:linux-hyperv@vger.kernel.org>
List-Help: <mailto:linux-hyperv+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hyperv+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261105-late-2026-mmap_prepare-v1-0-c56aadfbab8a@kernel.org> <20261105-late-2026-mmap_prepare-v1-7-c56aadfbab8a@kernel.org>
In-Reply-To: <20261105-late-2026-mmap_prepare-v1-7-c56aadfbab8a@kernel.org>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 5 Nov 2026 18:14:04 -0500
X-Gm-Features: AclHuK-Yq9Ya_gmjsTlhf760be1vg51BQVbAOtNinoyo6VpZvAmG2k73A1wV2Mc
Message-ID: <CAHC9VhQcmX09Do8BmY-HYJEWKiw7Tf-ZB=EEr9K6t5dBzk0SSQ@mail.gmail.com>
Subject: Re: [PATCH 07/14] selinuxfs: convert mmap hooks to mmap_prepare
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

On Thu, Nov 5, 2026 at 4:07=E2=80=AFPM Lorenzo Stoakes (ARM) <ljs@kernel.or=
g> wrote:
>
> Move from the deprecated mmap hook to the new mmap_prepare hook for the
> policy and status files.
>
> The policy file only sets VMA flags and operations. The status file remap=
s
> a single page, so use the PFN remap mmap action to do so.
>
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> ---
>  security/selinux/selinuxfs.c | 24 +++++++++++-------------
>  1 file changed, 11 insertions(+), 13 deletions(-)

See my comment in the cover letter.  I'd prefer to take this via the
SELinux tree so it can be included in all of our SELinux testing for
v7.5, but if this has to go through a single tree with the rest of the
changes, here is my ACK.

Acked-by: Paul Moore <paul@paul-moore.com>

--=20
paul-moore.com

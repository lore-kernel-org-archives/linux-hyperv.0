Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795100718;
	b=EHAnclgBlszgl43UppV90PfAAsOBlsYhlYRhRant3BNmjS3eK3MPgnplV64/p6BaVGk7
	 zj64UWmGWPXeViGKT9uz6LzShvgmbq1GqhJ/5xqAH4rZfcfdYzxnJ8yKwSaDGUUfYWLdu
	 /C4+65Ge/jv2Ib93h/wM4KkJArPSA+BJYBj5VVr3DQQqIznKP1VMcToDSu1F6vP/EOINh
	 wBp6N+nf4S6JCyeNbeRgODGlkTD0h51FTtE+WJy39QtHypAhT7j2/M02BkMY2/hbn/wXu
	 Y1Engk+FXStBuLleeDaLZNnsv/UFxP6tOeV4jnA8LYBkQXCH/HupDzdvAp48IGoiZOQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795100718;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=cra6Vs20NtPqxX9EfP/IC1RWThkucYohNUCRfJABY3A=;
	b=1XdDoy8isyUfuLmAQ0g/Z/thnEFeEkDdvgZfOmGRfrUtEG/wXEWiTYFyhavpPmRoocpT
	 yZ3Nw7S+omHHGvUKA79uQDDQ4FY4jARvCQ1NtHwPc6rzBXXFrYnOE4/WW+ErychnG7q7I
	 JSCSLRlMu6Qclaj3hAfuF+Ag0OSAnIopuEvcZ275hfY/CiPwlD3x9DS4RW3DtLABSFcus
	 Bj1hFU4MRb83AAiT8BIsQWNUXBMuhHu6UZaGIC+aiIZo/o3H3nX/G/JJFhVMLfp/9kAvB
	 m8y+cTNnNA+ZLcKNe6ra9US9UCwcBJgHhaNmUC3R3NyQPqZRE5mWmdf6AWsAr1K9DEQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=QOfZmYHN;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b="M/u5pjsP";
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2FA8606A33B
	for <linux-hyperv@vger.kernel.org>; Thu, 19 Nov 2026 15:05:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C2FA8606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=QOfZmYHN;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=M/u5pjsP
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795100717;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cra6Vs20NtPqxX9EfP/IC1RWThkucYohNUCRfJABY3A=;
	b=QOfZmYHNys9bR2nbd1exheChTNjkPoAodW3ImevLtfz07NoverccJ+VI8Y4wGZkukD89Nn
	H9O2XRVqaQ1En6ZsjXQLk/7rGmhgbfdY8sfIRkJVOlxkhpoDu58otsUm/vS9r8zMfpxGqD
	U9EV5U2rWxeH+LmiiAIbIVK9O7IXUZ0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-296-jMHjE3A6Nza1LZqUzy-CgQ-1; Thu, 19 Nov 2026 10:05:14 -0500
X-MC-Unique: jMHjE3A6Nza1LZqUzy-CgQ-1
X-Mimecast-MFC-AGG-ID: jMHjE3A6Nza1LZqUzy-CgQ_1795100714
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-49034831bb3so1611297f8f.1
        for <linux-hyperv@vger.kernel.org>; Thu, 19 Nov 2026 07:05:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1795100713; x=1795705513; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=cra6Vs20NtPqxX9EfP/IC1RWThkucYohNUCRfJABY3A=;
        b=M/u5pjsPyc/9N48N/0EssEYRJNakgsn9YHzqC55V6mGYpInsHPPwTiFmhSBQO/BNZV
         47Kpio0IOkENBcK9jv3h+/TjwnmbJ2XGS0YtNGeWAYwhvdPzkgGuyEjhWabd4gma47rW
         i2eUQQSi7w0yJ2Fi/tlkxRAXz6GKQNJi2/ljwIsdjmFgBclryKidDJpR+gwmiBh0HW2o
         dsKTdRjIvuSYyb2z6vL7dtmSrF+B96YFT+sVc7u0qKw5xxvnY1tyBxtsYsefkJXSf8/C
         uOhND8uVg4zZEtSa+qnHT/eisLZ4jO9wuU01H4loGp/MneMJHowW2nIWRIvykEkgWaSz
         eigg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795100713; x=1795705513;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cra6Vs20NtPqxX9EfP/IC1RWThkucYohNUCRfJABY3A=;
        b=b76seS3+Ke9sN1s/yav4WS5pOx+xjsWeKEpRhNzWsi6torQ7cJn+fxd/eMYzPozVV5
         2Hrnfe4N9rRakUTm1PBqe+AXx7TuqoSVdePpt8GEx9smEAcGIwcdyTKANz/DaVJrlKrq
         9/8VbENRMG2JbRky0nBACSNh/w9XU9xbYqEOmxZQreMfUcMlDe/rrZy8aV+7glzpw+iQ
         h6Us6x0bmXSlYxmUwIPqMl/6Za1DSUwOHFKvd3/aD1oZpDmhBnzQn43Px0XnXmIa6RS3
         C7FJoKV48y0leZzY2VDGSR7zqQoI6wd695jEMrTtIOj2FPfor8E7HvHcTKlFek9R1dGo
         fcpw==
X-Forwarded-Encrypted: i=1; AL+hErEka/z7TmkFD2/qwp3ABTPBwUBGFRAkI3t3SYs6KlI0zw8wA46WCAcWGOP8tyWdAV4p/txCmwCnyatYhpA=@vger.kernel.org
X-Gm-Message-State: APuU4Z+ZXoqyY2gFt/5yvcRZn0W2V39ud7rfINVbkFUcaEQ4ZitfoO0f
	aLWo1VFCtNW+O5iU4+m/q6VU6gx6w/dYUKyd8tPbZAzmMaYd+vFBD1vjihX3jLBp5fGCZ2vOHdm
	uHQxd79QQApsImrGvg3DkHX2qi5yz6KJaxmIre+ly2oePXn2aIplCtbPrz5HDbNl1Xg==
X-Gm-Gg: AZFdTZed59TbpywnukrHat7gk/VIxQPAjV03Qu9AhL1AqVKDefuqjQMaVvTPmsJS7BO
	cyBrKXAizbdJsHmXDRz+zFyoumdW0c/PoHHEpRYaXU0D/gb7YQD4l+yGBbv9/s9ahc9IQsPXJCS
	JyjPl/Lh5mijjUk1P86RIyyh4TCAT0j5SyfA6YOuncDrkQOd+nQY1ceoIYCfe+YHw8H69krinO8
	IX1yquhIxU2X36IwMb4w9Aq+TX3KA8UTsWm/JkpCw4lkSB/3YaHfIKVEpe0F/eMEEkcSUOjubd+
	kdfoOrQKCypiT2/8WqvvfTXTuBq4P6jTAjZeqk+TFM0B+qjkobvfiGqv3ZDFJ97S/g3Gk0vCDEN
	5ou5arLsPsxK0snC2R5N8ENatZWG1IrEwy8+DgJjLVg==
X-Received: by 2002:a05:6000:2608:b0:4a9:2728:fdfc with SMTP id ffacd0b85a97d-4a92728ff7amr4686417f8f.28.1795100713313;
        Thu, 19 Nov 2026 07:05:13 -0800 (PST)
X-Received: by 2002:a05:6000:2608:b0:4a9:2728:fdfc with SMTP id ffacd0b85a97d-4a92728ff7amr4686266f8f.28.1795100712535;
        Thu, 19 Nov 2026 07:05:12 -0800 (PST)
Received: from redhat.com ([2a0d:6fc0:1522:6500:ac93:c62:f076:48c6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6c61e53asm61225f8f.59.2026.11.19.07.05.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 07:05:11 -0800 (PST)
Date: Thu, 19 Nov 2026 10:05:05 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Jason Wang <jasowangio@gmail.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, Jan Kara <jack@suse.com>,
	Paul Moore <paul@paul-moore.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Ondrej =?utf-8?B?TW9zbsOhxI1law==?= <omosnacek@gmail.com>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Ryan Chen <ryan_chen@aspeedtech.com>,
	Billy Tsai <billy_tsai@aspeedtech.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Abel Vesa <abelvesa@kernel.org>, Jens Wiklander <jenswi@kernel.org>,
	Sumit Garg <sumit.garg@kernel.org>,
	Scott Branden <scott.branden@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Richard Cochran <richardcochran@gmail.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org,
	linux-hyperv@vger.kernel.org, virtualization@lists.linux.dev,
	linux-sgx@vger.kernel.org, selinux@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
	linux-arm-msm@vger.kernel.org, op-tee@lists.trustedfirmware.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH 14/14] vhost-vdpa: convert mmap hook to mmap_prepare
Message-ID: <20261119100450-mutt-send-email-mst@kernel.org>
References: <20261105-late-2026-mmap_prepare-v1-0-c56aadfbab8a@kernel.org>
 <20261105-late-2026-mmap_prepare-v1-14-c56aadfbab8a@kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Post: <mailto:linux-hyperv@vger.kernel.org>
List-Help: <mailto:linux-hyperv+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hyperv+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261105-late-2026-mmap_prepare-v1-14-c56aadfbab8a@kernel.org>

On Thu, Nov 05, 2026 at 09:05:45PM +0000, Lorenzo Stoakes (ARM) wrote:
> Move from the deprecated mmap hook to the new mmap_prepare hook. The hook
> only validates the request and sets the VMA flags, operations and page
> protection.
> 
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>


feel free to merge with rest of this.

> ---
>  drivers/vhost/vdpa.c | 23 ++++++++++++-----------
>  1 file changed, 12 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> index ff7d90719171..993b2d7c8927 100644
> --- a/drivers/vhost/vdpa.c
> +++ b/drivers/vhost/vdpa.c
> @@ -1573,19 +1573,19 @@ static const struct vm_operations_struct vhost_vdpa_vm_ops = {
>  	.fault = vhost_vdpa_fault,
>  };
>  
> -static int vhost_vdpa_mmap(struct file *file, struct vm_area_struct *vma)
> +static int vhost_vdpa_mmap_prepare(struct vm_area_desc *desc)
>  {
> -	struct vhost_vdpa *v = vma->vm_file->private_data;
> +	struct vhost_vdpa *v = desc->file->private_data;
>  	struct vdpa_device *vdpa = v->vdpa;
>  	const struct vdpa_config_ops *ops = vdpa->config;
>  	struct vdpa_notification_area notify;
> -	unsigned long index = vma->vm_pgoff;
> +	unsigned long index = desc->pgoff;
>  
> -	if (vma->vm_end - vma->vm_start != PAGE_SIZE)
> +	if (vma_desc_size(desc) != PAGE_SIZE)
>  		return -EINVAL;
> -	if ((vma->vm_flags & VM_SHARED) == 0)
> +	if (!vma_desc_test(desc, VMA_SHARED_BIT))
>  		return -EINVAL;
> -	if (vma->vm_flags & VM_READ)
> +	if (vma_desc_test(desc, VMA_READ_BIT))
>  		return -EINVAL;
>  	if (!ops->get_vq_notification)
>  		return -ENOTSUPP;
> @@ -1598,12 +1598,13 @@ static int vhost_vdpa_mmap(struct file *file, struct vm_area_struct *vma)
>  		return -EINVAL;
>  	if (notify.addr & (PAGE_SIZE - 1))
>  		return -EINVAL;
> -	if (vma->vm_end - vma->vm_start != notify.size)
> +	if (vma_desc_size(desc) != notify.size)
>  		return -ENOTSUPP;
>  
> -	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
> -	vm_flags_set(vma, VM_IO | VM_PFNMAP | VM_DONTEXPAND | VM_DONTDUMP);
> -	vma->vm_ops = &vhost_vdpa_vm_ops;
> +	desc->page_prot = pgprot_noncached(desc->page_prot);
> +	vma_desc_set_flags(desc, VMA_IO_BIT, VMA_PFNMAP_BIT, VMA_DONTEXPAND_BIT,
> +			   VMA_DONTDUMP_BIT);
> +	desc->vm_ops = &vhost_vdpa_vm_ops;
>  	return 0;
>  }
>  #endif /* CONFIG_MMU */
> @@ -1615,7 +1616,7 @@ static const struct file_operations vhost_vdpa_fops = {
>  	.write_iter	= vhost_vdpa_chr_write_iter,
>  	.unlocked_ioctl	= vhost_vdpa_unlocked_ioctl,
>  #ifdef CONFIG_MMU
> -	.mmap		= vhost_vdpa_mmap,
> +	.mmap_prepare	= vhost_vdpa_mmap_prepare,
>  #endif /* CONFIG_MMU */
>  	.compat_ioctl	= compat_ptr_ioctl,
>  };
> 
> -- 
> 2.56.0


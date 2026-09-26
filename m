Received: from mail-ua2-f12.google.com (mail-ua2-f12.google.com [74.125.226.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36164353A79
	for <linux-hyperv@vger.kernel.org>; Sat, 26 Sep 2026 03:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.226.204
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790395021; cv=pass; b=D/rGEg4B0Oh7geCvkC8pp5SzqXT10kbEBuU8/PngkGkeQ42dZKPr+ZXmVnBGe+k/WeftF1Y1h7enZh1FbfJYuvgnhPJoLktLH0AJyMx+95dsqKusxGi6oknh5KDvLvlKoEws2G2UvB1svGxENOYGPj30y7t9O7DvxnxWBIh3Ttg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790395021; c=relaxed/simple;
	bh=kZy9FlRDjUea/4cavqBXm9PiQeLiuh2i8j3p75iGMn0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jsICqzS28xORa3r69NRmz38yQj2p2tgHCZS3L3dii8tMo3NzzUf2wNUZtdN9VgYL4KFU0ubLWqpzXz7BmCDa7Jgotr+YypfYniXOSf5O2o/ttoVRrsiIIvJ+neWLhZTHQKsTDtOiVabaB1yY5gPTGN9NYTPVAtDWUnx4BHe2C2M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lkLDbuYW; arc=pass smtp.client-ip=74.125.226.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lkLDbuYW"
Received: by mail-ua2-f12.google.com with SMTP id a1e0cc1a2514c-980b6159d30so418621241.0
        for <linux-hyperv@vger.kernel.org>; Fri, 25 Sep 2026 20:57:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790395019; cv=none;
        d=google.com; s=arc-20260327;
        b=i6mD6vxON3zRWMiQ2bvc84DQmUzfYzDDFmbQA9x2VNJF/72M//Y4Vu78ciTnauhswC
         8MAlRzoQQEPaNgMH/4/r+fSEzvecyK5wjWeL7mG1QVXxq1i7h9y3odgsTqYn4MePdInW
         ndXJJd00Cd2py2oLCCR8o0YrvvQ+NTJ2XN57CFDz89OueamZrha9F37lPQW49lBSUaX7
         vepCLbdAi5c583IEh2Gn5SqNDMpHtlaA7lZgN9SLvnlGgRNk41blVsxOMY3cEp7pL6IJ
         joI5qZkrbWiOYbtatliW3gWmR1H4Vy4gv/YpdUcOazhg2blfN0DEHK0hyYUFbqaXOjRp
         3Qsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=31bXx9DDYtYaMyGphvOilRAP9jmRVAn7WJ7/Gygm+I4=;
        fh=RT9F4rrS2ZnZnogrZKqze2B3dq8kUMjD+gfJf5brcx4=;
        b=Do713/M+LJ8Lzy4CwgDCgNBSdg15+G7gJvFoCqE/ukkrXA1pyL530FAMDwPaxuPpZZ
         uvro81KupAVHGWLMoYc/z/lhE/I1l9PXo8qhQN7xsytFMLxQLUokmmeYdN5N8395ggMq
         Lx8TUnS4nqQuTtqaKb6sqRzXm4e8gcxMKFi8/KgsmRJa9knOLtuLMcwylV98QZy0mm9g
         vhDcGCfgOrOxG38C+QSpzq0W9/gOvJ7tLiMQh43Vk9wWR+KjIuwFZYoe8+x5nnTEC852
         Zwm+LEu3/HD3QDeaqh5ZjKgp7B/QQAImCkA31UzbibHkLLqVpO9zXe4lQfV27O4DXbP4
         t3JA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790395019; x=1790999819; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=31bXx9DDYtYaMyGphvOilRAP9jmRVAn7WJ7/Gygm+I4=;
        b=lkLDbuYWe0jVdvY4eQYlxkFYJhybqytQZeoZdlbmCSISseP+rCVtaJ6MV4XW9uNkau
         a6qcSjLZWgpFnCN9TmrFWJXRPd/EroM+iFFV+wdRHtK1BqAnV3kbVhn7KOFaQKeh+/pp
         Zhsp9YOiyWI7KdgG7tZ5jKCv7hIS+JhPI2ht+yHExky1kuZDiz069u41xGglHDok+Zcl
         v79RSF8yQO3LKU2ZXJeXZIFTgLQ3l1rPK3pam7y/11gHQpySgFBB9GN4HlUYRQkO9pRW
         +udgK1rt08eUiX0AJX1F+jOWcxhxrHYk+Po8HmBJ+zQDufdArLRDwyUF87vZawXOzt2Z
         q6uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790395019; x=1790999819;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=31bXx9DDYtYaMyGphvOilRAP9jmRVAn7WJ7/Gygm+I4=;
        b=Vj9VfNZ6/znE39LeAoCewGIXZQx8FzdpDjSYSVLVdjj18JDf8WlrDpBumrZYhZux4e
         KFleJCD93DO9Ei29hVo9ZTTMcBX/xSyI+OQJs4ZCzINNEP4vBUclcAn4TMrkMNjretuP
         UHTe+YBLxbC/hasHiTK2qoI7pLxBUUm1GJtWiZb6t10p7eGoLbVHFPe8IznnSCOcIT80
         +KXzQjI2rXYNoTl+vnzjFbI/b3BhSwkdBLT7EY98zyatMRXQj688Zoq+w4/jzGaAXjQw
         8IgAojv9urL3NXr2/17LrteQ0c926tV9PNPEgbYbq2Og9c8x3ZIux8gY0O+qRHDOqPat
         J1AQ==
X-Forwarded-Encrypted: i=1; AKwUvBwpGt4j7mUevR0z+59uVRMVwcnLeJLwS5hTn5mAfgt1BmXPKXftTrO5PbSiXkmAbdg6cv0qWc98FtIrgWk=@vger.kernel.org
X-Gm-Message-State: AFuF++mNc4scq2K/r4bC85CtQvHYS8XQ8vSP2mY2Xf6da9E0ilQp1wwK
	tvbDwsmM41TBAamt8g6dtz+9WnhS7qyn3CV8uR1dnCAG09HwxdvnQoUVxJXxSQrzn//KOY3qy+T
	6Vy/7+xUdwiIe1hQTAkbB6PkoNICZW4/4TeAYt5g=
X-Gm-Gg: AYBFou27T7lTWKjwRu9LHWPcQp6lqcLjVtV3Q26Mp8AhuZHZ/Q5q5BhyZrzu1UNKirZ
	u2pl7XEvFuEmJocK1xIimorMqyCRm2AaxY5n4pvzwW9Sljph0C8lg3znTmB11lDm4+Zl2LHGBtK
	V11ZuDCsQTMv7+gBb3tFwr/9Us1ZmA3e1pT6n2YRnoKVhBv0w/F/kWfKD1Gt8CI68g5SrWvNNrr
	0TJzZfJYkAI8xL0IqG5BrI3IM2aJ12xOLW+r9ELEIaRo4Up3KX2ZHggpukuZOVT/0EXKGnDFfVO
	0O7EdGYajHqyuiZkZcCh2th5ehdTlf5UWvnjGgMzGY60LqWnkLwY5F0fG85FBWUxrbgc7NMOtNt
	0LET5IKfSFI41u6Jip6jx
X-Received: by 2002:a05:6102:512b:b0:7b3:5cb7:49 with SMTP id
 ada2fe7eead31-7b35cc64b1emr468961137.31.1790395017546; Fri, 25 Sep 2026
 20:56:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260923055320.2602534-1-morbo@google.com> <SN6PR02MB4157A2693AE5369CA19A84DCD48F2@SN6PR02MB4157.namprd02.prod.outlook.com>
In-Reply-To: <SN6PR02MB4157A2693AE5369CA19A84DCD48F2@SN6PR02MB4157.namprd02.prod.outlook.com>
From: Bill Wendling <morbo@google.com>
Date: Fri, 25 Sep 2026 20:56:41 -0700
X-Gm-Features: AclHuK9ZglMRgpOjf7nJE9QEEZwUIEVC7ZTeuasL8ipLCjkjknKZffHOUZ4KyBI
Message-ID: <CAGG=3QW1HvN9Rz0k41jnDv4YMY1-LA0NhiA1B+CqzRfZThspbQ@mail.gmail.com>
Subject: Re: [PATCH] Drivers: hv: vmbus: annotate struct vmbus_gpadl with __counted_by_ptr
To: Michael Kelley <mhklinux@outlook.com>
Cc: "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, 
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Justin Stitt <justinstitt@google.com>, 
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>, 
	"llvm@lists.linux.dev" <llvm@lists.linux.dev>, 
	"codemender-patching+linux@google.com" <codemender-patching+linux@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 25, 2026 at 6:55=E2=80=AFPM Michael Kelley <mhklinux@outlook.co=
m> wrote:
>
> From: Bill Wendling <morbo@google.com> Sent: Tuesday, September 22, 2026 =
10:53 PM
> >
> > Add the "__counted_by_ptr" attribute to the buffer field of "struct
> > vmbus_gpadl". This allows compilers (GCC and Clang) to perform
> > compile-time and runtime bounds-checking when KASAN is enabled, prevent=
ing
> > potential out-of-bounds accesses to the GPADL buffer.
>
> It turns out this "buffer" field is never dereferenced. The value is save=
d
> here only for the purpose of passing into set_memory_encrypted() as
> called by vmbus_teardown_gpadl(). The memory *is* referenced, but
> through a wraparound mapping created by vmap() from the struct page's
> underlying the buffer. The mapping is created in hv_ringbuffer_init().
>
> Given that, is this patch still appropriate?
>
Hi Michael,

Huh...so it is. The buffer is converted to 'unsigned long' (*sigh*)
and then passed into arch-specific functions, which do what you
mentioned above. Given that please feel free to ignore this patch.
Apologies for the extra emails...

-bw

> > The fields "buffer" and "size" of "struct vmbus_gpadl" are assigned
> > exactly once, during GPADL establishment inside
> > "__vmbus_establish_gpadl()" in "drivers/hv/channel.c".
> >
> > To ensure that the count field ("size") is initialized before the
> > pointer field ("buffer") is assigned, we reorder the assignments in
> > "__vmbus_establish_gpadl()" so that "gpadl->size" is written before
> > "gpadl->buffer".
> >
> > Cc: codemender-patching+linux@google.com
> > Assisted-by: LLM
> > Signed-off-by: Bill Wendling <morbo@google.com>
> > ---
> >  drivers/hv/channel.c   | 2 +-
> >  include/linux/hyperv.h | 2 +-
> >  2 files changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/hv/channel.c b/drivers/hv/channel.c
> > index 7e4cc6f55237..7042de2dd481 100644
> > --- a/drivers/hv/channel.c
> > +++ b/drivers/hv/channel.c
> > @@ -548,8 +548,8 @@ static int __vmbus_establish_gpadl(struct vmbus_cha=
nnel
> > *channel,
> >
> >       /* At this point, we received the gpadl created msg */
> >       gpadl->gpadl_handle =3D gpadlmsg->gpadl;
> > -     gpadl->buffer =3D kbuffer;
> >       gpadl->size =3D size;
> > +     gpadl->buffer =3D kbuffer;
> >
> >
> >  cleanup:
> > diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
> > index 9e109d91aa14..408748a05440 100644
> > --- a/include/linux/hyperv.h
> > +++ b/include/linux/hyperv.h
> > @@ -780,7 +780,7 @@ struct vmbus_device {
> >  struct vmbus_gpadl {
> >       u32 gpadl_handle;
> >       u32 size;
> > -     void *buffer;
> > +     void *buffer __counted_by_ptr(size);
> >       bool decrypted;
> >  };
> >
> > --
> > 2.55.0.1082.g2b9226bbc0-goog
> >
>

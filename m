Received: from mail-ua2-f43.google.com (mail-ua2-f43.google.com [74.125.226.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB06E38A736
	for <linux-hyperv@vger.kernel.org>; Sat, 26 Sep 2026 04:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.226.235
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790395216; cv=pass; b=oYZw8SMfqg9KPySVWYF+k6w20aYTS9VmMF74IVTU0dVneVr5r7JvJB+/8cqxgWFtsK3joVOfvHyhK6CT+uiN7Ihib2nlYlVSW9EUAvwIZ3G460RRi4esYAK9icQY3oIKkyZjH9sglBr4esJlcmrYeslwXEOyI4PYPY4AyZ6b3lM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790395216; c=relaxed/simple;
	bh=8Y2bsAkSTZILhk3+rv+DzLT4+GI9Kjxt3IAQHjbMyP0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=obqMjFMVgQsJz3JR+kUf171hsMOJTSLaG3fs35nPPGmBZGimp5yjjUFDYcK3xPO56jIxYHxgho7CQglu1wxJFHixI2q+mIcUlQNy6YWcRItDHtVksUsMPwjNMeeBPOOmZGgWfJ9HhSPlA9v4ECF06E/zE/whxrrT3fsgMY3QkHE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mUDjKBol; arc=pass smtp.client-ip=74.125.226.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mUDjKBol"
Received: by mail-ua2-f43.google.com with SMTP id a1e0cc1a2514c-98531196e20so890418241.0
        for <linux-hyperv@vger.kernel.org>; Fri, 25 Sep 2026 21:00:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790395213; cv=none;
        d=google.com; s=arc-20260327;
        b=QESm+QJUUzHrcQtRbvgIGo9KanMItNAlbcr0k34rJK8M5Eel7zyrWRS4YqUSSpCSCh
         wD02kHV/R2oXrp60tM202OAti2EJiiE61/eJcHM27R5cRSroF2ZUYPjYHPFcZTKVwXJO
         4gjujfih5/dNdzIfdv8ADUy3VrrVvanb2zR6KSj4f9xGbg+EoguiVtNG5XTSo5aBqQvl
         TSNMp1cJz6k8szS7zEtoxT0MVMvIiyFPf2iw1tNbKTUjnBgBS+Bz2rAJ2tOOQmvDjuaA
         R2EvpMl1h7PEOIl+xkze87ai6x/g8vlJ9/AVxvivSDITaSDRcjRHnQ6FO1O5m3sDQhpT
         UH9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MYpeyRZV+TWw0zn+XSYzCNOx9+tm8LCGwN/L1KGsoYA=;
        fh=4T/PyGdU9AH5VmtgczqPAlTZ06aMCnPigoKD7n6DjuE=;
        b=kFtfEAyMxu4IrJPhWgmXXys8XtAj41jItrKRR986Oy3tekOm01K/8p3WJ64Jh3zQuB
         J5bFXn9rh7TQGKN0FIGY4KP3nNPXwmHaNzJngUDAVYpwcI3Xs/ZM6Dxh8pd/ze2/bT49
         INy2G1f2uhOpFbVIutEzJ7J8jwlZGXqbw3Vy6pWVgs1WKqJ1wAvalmy1PXZRJvV8FZ+M
         9hjdFFB4xGfBN9hvEDuf6l2cTkwDZDxmBgkLs5FVNmncQkyNk00bquNGaofo67tmS9cZ
         ghyzt28O0c88BebIFajSY6K4JOXC6neaVzZn1p1Ud33BIoxhXTWk4gGF+wOh92n59zoK
         Qc/g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790395213; x=1791000013; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=MYpeyRZV+TWw0zn+XSYzCNOx9+tm8LCGwN/L1KGsoYA=;
        b=mUDjKBolyl6G6UFKJaNw0/pN9mtnFg5Zuujb9UtJH+TgqHTVVdBww7nUcIu57dBDMo
         67m39PxoKPaOc0ZKf19r+0ZhvRFd9dKG4RVQW0gvJFVEasut4l3wHaCQlJ8bavsTvOoO
         rQGWcfMqWxtXrbA2j56pj/al47BPbCRIcKPo03Axq1kABTuEK+mS8w1MSdY/8zhQP2va
         ruGIR9aBHv77CA4GU2KRxgs3EiFeEuYRicIAckZ80QErQL1yyUKfVngkdcunwNnHpKGE
         zmSwb6xV5nLJg2mZoTVHiHvoEa7UDN8t0JOVEXf39VSeJKy4P4Jvg6e9rg23kEdk7Xba
         Mn5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790395213; x=1791000013;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MYpeyRZV+TWw0zn+XSYzCNOx9+tm8LCGwN/L1KGsoYA=;
        b=WeszHikYrlD0KcEs4sQLI6ID8ldsybzViK+lDfEt/amzmRm+FSUmMUkpH4JVCzHDSo
         uTIQvIHCVIDIboA+OEF2Xf78jSchyvdxKYM3RqhGmuxWxQ3yQbL1wOwtlGYhtusQ+wCG
         /NgRIaxBERRCp+L/3ZEWYtz3mY2W5bxY+BeHmhiADolVN4dHIk+ooUn9ueKLdFqG5/MJ
         QTvfh+275f9SsuKO6O4xTSPE75lpSLO4Nrum47yP0n9izn6zzfxksfdEDKe33c5Gna83
         LjCx9S0bjA5VPOTHY5VpPdaSjlCFnkmFnCoH+2y2TfaDxpUvs5cpJ5stu0AIdLSokQLj
         p7/g==
X-Forwarded-Encrypted: i=1; AKwUvByUuuUwhsqkSvhdFdeEiHSwZsd6zZBg5j8RFMzs+9/HlTocqiaVWnuP5Mmrq/UjP+vcngN8/IlKU/VGqQc=@vger.kernel.org
X-Gm-Message-State: AFuF++m41T93iDGB6R54uNuw0hstpBzprAZIIPxBHA7VDKAigWvaqwo+
	0BdyllHE8Pn7nAEreDI6CfECnurGGlj+DlvOD/eEr0KFMC/+rbed/R1CPk4YGsu8SEkSMTy9T9Q
	hcLDiHZ0UFCSbZiPzhoOXswFHbeqNj+vA+FpucZc=
X-Gm-Gg: AYBFou2c1dE22bDzS3SS1n+3cMOprYMbzQ8dLZjO9mMHzmEIVSSPdLYx+Z69/65Dupo
	TLZ7VFR9Lsgr6CSxgjymILGAjc40cUMbsGzqCjS/swwKmvbSBRljEewYpBEJ4VBrNsuJ4xRMIQF
	MVjjTEh5XVHf6tcvRW6m/ZFNL5i925LyN7tkG/LI7aFKIC871SO3cKNx/SUYLgDfyRWsavx/aZV
	5moBElP5r6YJEMUu/FUHmykQ/82+U2S66nbDjyvyhYjGIA9FGWVVC2o3Yk4Da4gKqOyd3nXwBK0
	U5okfub8dmuAeLzNLiFjgII9701sT88SqaGQ7lHxCCHc01sEJABK6fBeCFGH2rEFlMyyyPiXNj7
	1qEHvuwveJA8iWV5GuFb/
X-Received: by 2002:a05:6102:290d:b0:7ae:da60:5dfb with SMTP id
 ada2fe7eead31-7af1bf73808mr3668288137.13.1790395212940; Fri, 25 Sep 2026
 21:00:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260923055320.2602534-1-morbo@google.com> <a51283e0-7d55-4d06-bf7d-3cd7b7a21faa@embeddedor.com>
 <202609230021.7F6F2140@keescook> <204fb990-7b45-4ce1-8e6a-260538bfb678@embeddedor.com>
In-Reply-To: <204fb990-7b45-4ce1-8e6a-260538bfb678@embeddedor.com>
From: Bill Wendling <morbo@google.com>
Date: Fri, 25 Sep 2026 20:59:56 -0700
X-Gm-Features: AclHuK_iI1gG_woeJMTGNDN_cmjTZYiMNuN9pp2RmlztTl9u5AsCWNOE4zKQOyY
Message-ID: <CAGG=3QW43-Kez+FkRM=SuZtbJ_ODgVXY1nrtg7BTYG_OgP3kBQ@mail.gmail.com>
Subject: Re: [PATCH] Drivers: hv: vmbus: annotate struct vmbus_gpadl with __counted_by_ptr
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: Kees Cook <kees@kernel.org>, "K. Y. Srinivasan" <kys@microsoft.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Justin Stitt <justinstitt@google.com>, 
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, llvm@lists.linux.dev, 
	codemender-patching+linux@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 23, 2026 at 1:02=E2=80=AFAM Gustavo A. R. Silva
<gustavo@embeddedor.com> wrote:
> On 9/23/26 16:23, Kees Cook wrote:
> > On Wed, Sep 23, 2026 at 03:10:08PM +0900, Gustavo A. R. Silva wrote:
> >>
> >>
> >> On 9/23/26 14:53, Bill Wendling wrote:
> >>> Add the "__counted_by_ptr" attribute to the buffer field of "struct
> >>> vmbus_gpadl". This allows compilers (GCC and Clang) to perform
> >>> compile-time and runtime bounds-checking when KASAN is enabled, preve=
nting
> >>> potential out-of-bounds accesses to the GPADL buffer.
> >>>
> >>> The fields "buffer" and "size" of "struct vmbus_gpadl" are assigned
> >>> exactly once, during GPADL establishment inside
> >>> "__vmbus_establish_gpadl()" in "drivers/hv/channel.c".
> >>>
> >>> To ensure that the count field ("size") is initialized before the
> >>> pointer field ("buffer") is assigned, we reorder the assignments in
> >>> "__vmbus_establish_gpadl()" so that "gpadl->size" is written before
> >>> "gpadl->buffer".
> >>>
> >>> Cc: codemender-patching+linux@google.com
> >>> Assisted-by: LLM
> >>> Signed-off-by: Bill Wendling <morbo@google.com>
> >>> ---
> >>>    drivers/hv/channel.c   | 2 +-
> >>>    include/linux/hyperv.h | 2 +-
> >>>    2 files changed, 2 insertions(+), 2 deletions(-)
> >>>
> >>> diff --git a/drivers/hv/channel.c b/drivers/hv/channel.c
> >>> index 7e4cc6f55237..7042de2dd481 100644
> >>> --- a/drivers/hv/channel.c
> >>> +++ b/drivers/hv/channel.c
> >>> @@ -548,8 +548,8 @@ static int __vmbus_establish_gpadl(struct vmbus_c=
hannel *channel,
> >>>     /* At this point, we received the gpadl created msg */
> >>>     gpadl->gpadl_handle =3D gpadlmsg->gpadl;
> >>> -   gpadl->buffer =3D kbuffer;
> >>>     gpadl->size =3D size;
> >>> +   gpadl->buffer =3D kbuffer;
> >>
> >> I think in some cases these subtle changes are worth a short but
> >> informative comment saying that the _counter_ must be initialized
> >> before the first reference to the pointer.
> >
> > But that's only for dereferencing it... there's no ordering requirement
>
> Ah yes, I got a bit carried away by the change itself.
>
> > here at all (and I think swapping order is needless churn). Neither
> > order is correct: only having them both set before dereferencing
> > "buffer" is required.
> Yes; maybe this is something the LLM should learn.
>
> Thanks
> -Gustavo

I've explicitly told the LLM exactly this, but it either forgets or
ignores it. *sigh*

-bw

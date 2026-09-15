Received: from mail-ed2-f12.google.com (mail-ed2-f12.google.com [74.125.228.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E47F0414A16
	for <linux-hyperv@vger.kernel.org>; Tue, 15 Sep 2026 16:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789488555; cv=none; b=L9eL1f9cDXpAygI0bOSnPt4p5L3THjFeeTN2cNI0KryfQHTF6XxbBwG0JN3hpA11PRjKJ9tXt5uvEUljw3v8OwfOvPOdaDhUlt0gYMMHDSLmDXDKin0hIAdyQ+eutXeEG9nxG6zGBrUcqwGmLsZeezjKj5dn7r6WjBBUO4WGTd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789488555; c=relaxed/simple;
	bh=TaD3IKHcoZf0PQ+wUUh3mHvOgYZf6uXYuUZRFHNcE+Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h2fKaREfynW0b0TR6fghD3NeEHcSQitrCCKXMNTiUiY/TTcxcV/Rkyp5q9wZ1jFGnfeCubZkg67ump2guplQBmW01Lgy6hmQQWra1ujbPA0plTH/yMllGc0xTujFmGdyzLIh5YRiirYLXdsumLXgzJi6gOwT1i/9np70UzSuZ98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=KYIKdYeG; arc=none smtp.client-ip=74.125.228.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="KYIKdYeG"
Received: by mail-ed2-f12.google.com with SMTP id 4fb4d7f45d1cf-6a99391ffb2so6089579a12.0
        for <linux-hyperv@vger.kernel.org>; Tue, 15 Sep 2026 09:09:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1789488551; x=1790093351; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cj8iWYGkmy9fr6Sp+MjBMi0cvssqzarl8Tgut8FUMEc=;
        b=KYIKdYeGjmyBjw+9lGbHovqSCQlhO7Cd8jUUt/+5Ly04+JZlHqxQzkXviwWicmcWGD
         COLIIamcICpj58bs1K/fLy/nBJ8ev2p+h9g3n+ZfZDZp2NWdJ4hJfeGDSzhVgV+COYu5
         7cN2LHMH0jHZFBMWCHOwytx1N2e+NbY6eor/E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789488551; x=1790093351;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=cj8iWYGkmy9fr6Sp+MjBMi0cvssqzarl8Tgut8FUMEc=;
        b=C+1NMG/AMOcAhco43FC0xuaKFKIfVrzqfqSSzNyuziSRB1WVsPsk21oAzkLLTp+5Qw
         JqOFf5blMudiYMnKp/asaQAsZZa/qyUck6iBcEYJ5U8urvkrh5HO0u06pRxlFLyvlRN7
         kQw1ze6zRSSZgejH7VYsllVB8TtPlMNw22AreeDoNqg3DICNtrl29ZKWVLUl+6BNuExJ
         jBNfkKBbxvB/6rj8ez76dKRZke1xhxxC5LD2IrqnVD9E4Jafl3WodNYflqLUPy6ZpPXh
         uCGJ0eDLxhDxlC/8cbvphFiY9rYygm6mS/vhIWDcgU4ohYLiguA+63U3dUbXVDJW0D17
         UBBQ==
X-Forwarded-Encrypted: i=1; AKwUvBzvor6diKHg5ymyxfBM7e7LCf1x72TvniB9m19/H0DuhrT5fUuKacyVmTLUjrPIcCfC3T5n8bnPKFQmMN8=@vger.kernel.org
X-Gm-Message-State: AFuF++nxXoku3FkXOEdIgT2eoH7FVvImeH3KkskVXH02LtmghIlCk5g7
	ZpZb0ojcXhVzfqgdQQ1MTJ9ujAw6m21Z9HAUGKWSCef5sz51mpK83xHmzrFAAXsxVVt+934hOpc
	Ak2NoWbQ=
X-Gm-Gg: AYBFou3PtO0lskX/Y/L9OS5Lmpop0dym2WMXLaB9hMkadwemEkVbRGfFAMwo829gpG9
	2rAG65I0v/nvJpcDnn1hZdGXOwd1chfz0lWHoGR6ZGVvvpYOjROgzChF0GU8Zzo0JCZ3ssBKmI0
	OxD91EFWLgSX4r6RMxnPqtvgfbrt7Ksb42Q4pnVrWBzlPOtuBjri7BfPCEPOL1xkEpNYwOW5VEW
	8YOjeZOp2coCRK57sSQcIkQNDQaH89WgqGc69YFggjqTriMvsApLB6cM/xwRP7i1IqveSzScZLk
	W2Aaq4s6kQV1bv3KSfx3+bm/z120JYkS2U64UE1MV7FZ/tnoVXAvDiBqGVHlDScKWKtCIh/t17I
	7dtsO1v++REnrGPwBZY/ym1+wQaMK3MnBIzGM4IUmN8CkN5cGKLlRCRGXXdZ0aX1ZRAN38ittlS
	9i4ZwNxLCFfdDCPzuV5siJednQzrI2pRstF9Ivgr69csHaYK6xJfW6bRdeVYiXNVc2sSh9/dsDG
	z9isi0QzAyZUmImsSjnA9lb0Dtg2sRSPtk1qj8hues2m3L1tg==
X-Received: by 2002:a17:907:ea91:b0:c26:19de:9ac3 with SMTP id a640c23a62f3a-c29b86f8fb0mr539122466b.27.1789488550628;
        Tue, 15 Sep 2026 09:09:10 -0700 (PDT)
Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com. [74.125.228.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c29de5b915csm937266b.37.2026.09.15.09.09.10
        for <linux-hyperv@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Sep 2026 09:09:10 -0700 (PDT)
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c2953a01240so511866b.0
        for <linux-hyperv@vger.kernel.org>; Tue, 15 Sep 2026 09:09:10 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBw4PlEiszawzd5nhrAWrh1ZeKxismBcGxRu5nE4bh/YT1M64gLYAw24C1EWJd2RNhlMnAoTtjjb3SfDhmE=@vger.kernel.org
X-Received: by 2002:a17:907:cd0d:b0:c29:439b:d5c1 with SMTP id
 a640c23a62f3a-c29b86141b9mr553591866b.16.1789488168046; Tue, 15 Sep 2026
 09:02:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260915-work-fd-reserve-unify-folded-v1-0-4d5217d6b246@kernel.org>
In-Reply-To: <20260915-work-fd-reserve-unify-folded-v1-0-4d5217d6b246@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 15 Sep 2026 09:02:31 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjeamU=_RYT9cR3dZJ2N-Teo-N1+aYh7jwhrB=iWXD0cg@mail.gmail.com>
X-Gm-Features: AcwNN1WK06t9f9BcKFBIanysXcyUXK4eRICuH4x14s60AdlpF6ijCATIYaYAAvQ
Message-ID: <CAHk-=wjeamU=_RYT9cR3dZJ2N-Teo-N1+aYh7jwhrB=iWXD0cg@mail.gmail.com>
Subject: Re: [PATCH RFC POC 00/50] file: handle files on syscall exit
To: Christian Brauner <brauner@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jann Horn <jannh@google.com>, Jan Kara <jack@suse.cz>, 
	Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Oleg Nesterov <oleg@redhat.com>, linux-alpha@vger.kernel.org, 
	linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, 
	linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, 
	linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, 
	linux-um@lists.infradead.org, Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org, 
	netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-gpio@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, bpf@vger.kernel.org, 
	David Airlie <airlied@redhat.com>, virtualization@lists.linux.dev, kvm@vger.kernel.org, 
	kexec@lists.infradead.org, linux-hyperv@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 15 Sept 2026 at 04:31, Christian Brauner <brauner@kernel.org> wrote:
>
> TL;DR, this lets arch code handle fd install and cleanup. fd_prepare()
> allocates a descriptor like get_unused_fd_flags() does and records it in
> a slot on the task. fd_stage() attaches the file to that slot and
> returns the number.

Honestly, I am *not* a fan. At all.

I think this adds complexity rather than removing it.

The diffstat tells a story:

>  106 files changed, 962 insertions(+), 861 deletions(-)

in how this adds a hundred lines more than it deletes.

But to make things worse, it adds them in bad places: low-level
architecture assembly code.

Those extra lines are *not* making complicated code simpler. Quite the
reverse. They are taking fairly straightforward "just deal with errors
with normal cleanup in the place where it makes sense" and makes the
*straightforward* case simpler, while making the big picture more
complicated and subtle, and adding new code to places that are not
simple and just blindly do somethign that makes no sense in that
context.

IOW: it's more code, and it's more abstraction, and it DOES NOT HELP.

And yes, most of the well-maintained modern platforms (read: x86 and
arm64) use the generic infrastructure and they don't show that
low-level asm effect. So for those cases, it's mainly just  that added
conceptual complexity and a new odd rule - and makes a *successful*
system call go through that "extra work" and indirection phase that it
didn't use to go through.

So it just spreads out the work, and moves it to a less obvious place.

All for the very questionable advantage that you can now randomly add
a file descriptor without the few lines of fairly straightforward
rollback.

IOW, I do not see a single real upside to this, and I see immediate
downsides to it, and a more abstract complicated machinery.

I do *not* see why we woudl want to make this be a "every system call
exit" kind of thing. If there are places that think it's complicated
to do, they could have *their* local little stack of fd's pending. Why
force it onto the low-level system call entry for every system call
when there are only a small handful of actual real cases (the vfs
itself, and random ioctl's by odd driver subsystems).

              Linus

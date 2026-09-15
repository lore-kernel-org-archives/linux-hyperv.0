Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84E36438493
	for <linux-hyperv@vger.kernel.org>; Tue, 15 Sep 2026 17:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789494730; cv=pass; b=aKu2PNCrifZvIDBSXE+AnuPD+UWfrXS6ezWWoiHcnljpXuV29MOhpiqbgISjwygQnAgzJ5Eed3VgVSZqgUIeerPPwHVtF99xxAW2uxPKsUpJr4hI1XPJR2eijBgM6RbBSxtkTGul4t5oQJzamA4bWCcrck5RBldwMDkLaxUvZWo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789494730; c=relaxed/simple;
	bh=+4G5uXJmB7HF3o1L37WqbjganRxVa3Gn0saA7lTxNiM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FlrROPOaIf6ZNk0DuYf8hNbE7XUmPsEs3+frc/PPPWqLjszXAF67lPl7TKmiEJ7ERaVpyBu2eMBVfjKjUFjO+zdtmgi1HTZE8k8G7b/AGcjbEgizgyqIL0AZx9dbrbwgeGqMaakQ+qeo6XHu4e91cIczmEX6YLwm+4Zr6z93lGo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WPgx9Wh6; arc=pass smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WPgx9Wh6"
Received: by mail-pj2-f12.google.com with SMTP id d9443c01a7336-2db425c9050so12215ad.0
        for <linux-hyperv@vger.kernel.org>; Tue, 15 Sep 2026 10:52:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789494727; cv=none;
        d=google.com; s=arc-20260327;
        b=LPxAw/TFelXG1uKwx8J4G5rSJezg5RbBF1tUYo4idUDq6M+HN1RVQKRYQi6240ADJj
         74e4um/+37bjF2XCmM7eqCO35zpvHToa8MAwTV0f+oZKgQLhRF0rBEhhV6/xBEYqeqjB
         tTl6ycbrxl7UY679b+P5ypmM9JBDxWtT3qGaUqVwEOLEcYOi7wuiqN20lAg3yExtIvHF
         IKOmGWsK/IgGw4mn8ILJ1AGvt+oadiRil1uKGlrq82rBh8jNCO5dWmgX41fnbuqDIS8W
         k1SzNBmKPtbUlpiyThYlAHCesQ/6PIAEvsMP/gz4g47CgdG8gO9NOQLyAwhThYoRAIoH
         AS6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+4G5uXJmB7HF3o1L37WqbjganRxVa3Gn0saA7lTxNiM=;
        fh=a9+NwBVARrlmCqC1LDr1+F3oE2LKleJPKhOxv8Se1Y8=;
        b=FdykuFsPanBKhTkSHb7gcEh4u9v3byMymbEPaXZlMyF/ZJ3871mtSEXK9rTQi3sNlw
         TxIwM6ZJOiWT1eDETn1T8Scam6HG+Lr/i8YP2231gK90xE+8zooFNKM2oOXRBr8saoC2
         FDcmyGZueGUPGui9TccHfj4kajv/vbVeAhfPLrZHQqAGt1WQp5bYx6OWOpvWmWS8oNdx
         Q0y/2K7JntA1k7WC7PT7z0dPhZv8lNgPMmBPMZ5sihxL6AKxbl05N97gxEZn1FTZgZfh
         7DOPqwMbg/ellFjCycsiO+sOTwWa1Z4YDFRfT/emTnaPfbVSOCixMgGLv2DQm67Z6K03
         STjA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789494727; x=1790099527; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+4G5uXJmB7HF3o1L37WqbjganRxVa3Gn0saA7lTxNiM=;
        b=WPgx9Wh6g8ehXMOaZf8ZSNtevHb9fzr3lXk5INKsJirqC99dpiARLSwTsIwHA4pbMW
         JbWx8MvBxDUFu6opqA60njTwuSet+XjH0Wga4OKXeEmVhOXoy61UWc3rqiL6EU8/l428
         EjMY1UqvowxmFEZiD+cpXVE0I3gM0Ssco82ZH8FSIs0h6jzSdSLoGG2b/9Ga+W+7Aup7
         R3Y2jKX2VRyqaVjVjF8po02JGQLWYioBTM31SQGX//CGOHsZjgwuKy0KaaC3tSzQflwo
         ISJi8sLOMT0xayOGlmIx3TnuUJAs8/tTEps0xY78QDJPw7a+XDrg4k1OSruo0M4Rr9uE
         eRpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789494727; x=1790099527;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+4G5uXJmB7HF3o1L37WqbjganRxVa3Gn0saA7lTxNiM=;
        b=RI7IqwrLO5YrrPPz1n+DbK1T22wUnItQW7RByohaPnF6khw/KYgwwFJlQKQXc1/JOO
         98JfwPfCqV1PNwuLa24Yasdl0F9PklctO0vRGldnd7mDnP2fl4EoR3GL/5yLYBWD51j0
         2SjBTE4eG/hB35c3T+x8sju48heuSLLQe8nR+JZ8Vy82Q8eKJNsQFZxhQH/k1b2edk/5
         xrOBDSH240pwzJ0mcSC1nVR3IYRnH70N/lEKthNHsP+LjCf/HDjlYIsuXOy9zRhfuc2L
         NigkpWhC7DU4mmzj3Y7nBRdnypRH4aQLCj1NBwrvp6NgtyZ7syNULsBgauePOFQT/Xoa
         Encg==
X-Forwarded-Encrypted: i=1; AKwUvByo+60nlM4cyAbfF0w4xwhrJpt5BnpsOXziJkWj9NHSnWUSpbspttmnKmix5V7w8sAMqTjBoB5gIfFYFXE=@vger.kernel.org
X-Gm-Message-State: AFuF++nge9cDcAXyaYj3noXFjjrqs/lleiVIHZko9K974GNYOOtma33d
	1ScSqyXCtojYmGNbZ+FPkcq2lJ36FbJhqJwnjE2KwI2ie7sHnE7OQj1vDXdaNqtdxiBUcKwbVwu
	zoGZ+CowdD5kbaGVojwtntBHybSIhzhDVxueEzFDT
X-Gm-Gg: AYBFou0uZlY1nBLOYHvo9eTNavrjg7lVPxT/8x7TIcvFQZGqshe/LAIRGilUcChc08N
	eUCFW6zepc5mqQU6gtsao1UcL9nNOUw4MPqFmCkNqifuudOZuGnTYhybZOo0Dca/Q/12yUot73O
	9IEbI2sy6wIg8dEBR+vopsTonU4J7TGWWWvXdUcPki/VaI10y1h+pGxzjD9S/gsE67YAHHGexOM
	98vI3t9ykBiW1BlRQSU3YXfNbbttXakQxiUmTW92NeIBashPhNXGSdCZLcZkMLM/+ZG6Nn4C6aB
	C56wVq40GKR1bxCOGhAyh+T15C1SXoU6RGdoT5PLt4+k8+Nm6K2FCKawxipmNR3M/RsV32VQnuM
	dJKbSkZE9qwxCpIo6g+Vmijp26rfNO1sUA/ruKaIuOOz9P/1ugUM=
X-Received: by 2002:a17:902:f612:b0:2dd:5363:31ec with SMTP id
 d9443c01a7336-2dd89c0c38amr177395ad.14.1789494726332; Tue, 15 Sep 2026
 10:52:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260915-work-fd-reserve-unify-folded-v1-0-4d5217d6b246@kernel.org>
In-Reply-To: <20260915-work-fd-reserve-unify-folded-v1-0-4d5217d6b246@kernel.org>
From: Jann Horn <jannh@google.com>
Date: Tue, 15 Sep 2026 19:51:27 +0200
X-Gm-Features: AcwNN1Vhgv53PI2-XyXtJBbVzCNkGiiWjtvOE2b-8zHim7-UybJ3H2xniPj1VUE
Message-ID: <CAG48ez1RsdT=O=-0city3vjgWhDvY424KtTmrCJntWy5ds3HBQ@mail.gmail.com>
Subject: Re: [PATCH RFC POC 00/50] file: handle files on syscall exit
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, Oleg Nesterov <oleg@redhat.com>, linux-alpha@vger.kernel.org, 
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
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 15, 2026 at 1:31=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
> TL;DR, this lets arch code handle fd install and cleanup. fd_prepare()
> allocates a descriptor like get_unused_fd_flags() does and records it in
> a slot on the task. fd_stage() attaches the file to that slot and
> returns the number.

I'm not really a fan but I feel like if you want to do this, you
should be using task_work so you don't have to touch the entry/exit
paths directly? (And if task_work is too inefficient somehow, you
could tinker with the task_work implementation.)

> When the syscall returns success the exit path installs every staged
> file. When it returns an error it drops the descriptors and the files.

Is this mainly about stuff like "we installed a file descriptor and
then the following put_user() failed"? Because if so, I think a nicer
fix would be to have a policy of "if userspace provides unwritable
memory to a syscall, just keep going and pretend the access worked",
and maybe have a sysctl that kills the process when this happens to
emphasize that userspace should not be doing this.

Received: from mail-ej2-f26.google.com (mail-ej2-f26.google.com [74.125.228.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF8654CE66E
	for <linux-hyperv@vger.kernel.org>; Tue, 15 Sep 2026 19:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789499361; cv=none; b=CvGE13vSceDfr5ImYiSsuJI13y+Vrbtsg+uIqbBxgyX3ieg0z7bVt+UqX+euzNJDuYCbUSnqjh7oBcEKqccCS8Lh9L1KrJoehccqgNcu+xDiu6WQ6Ywu5buseo9R8WeIHcG1ZIXt4XX/ZhhUL0ujhj/0Zopi4kbhv5l4AUx6gW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789499361; c=relaxed/simple;
	bh=AGk4y8oFpNibhByHKIxcRS7KnQx6z20Q8VC6dFl1tNo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LmP1eBlN/7j1VmuSmvqABZvChyojEGH8byH87pGEMgpVGwf7GI1BZMzvBm5pp/Y3unCd/pR31b9jlbJTjv9AygR2Rf+P72513trIlzXGcco60N3xz2LiVB74oZo4hgaFWvLrfaoMV7ZL35zxm/tGGmxZ9On+SmlAZonlrPh7ITM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=CSrtt9Un; arc=none smtp.client-ip=74.125.228.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="CSrtt9Un"
Received: by mail-ej2-f26.google.com with SMTP id a640c23a62f3a-c2940ef15d3so28238066b.2
        for <linux-hyperv@vger.kernel.org>; Tue, 15 Sep 2026 12:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1789499357; x=1790104157; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XFFk9jJtDswBQpA8QWIooO6lLG4HdlvPT/LqykRjG+U=;
        b=CSrtt9Unpbm2RA3J8D1Piu8PqBvT7/aa/KZ5CE3c3D++Q65F+8LC8PQhJ+YAQkLRZF
         FOCbEfcedihMauvO8i4QEZYDfsgCMc/AU6Y/5BuRF/k4i643ZbHqsUyNas20hZQzkd2E
         0RZUaMtkje/C5faG2xlXImdyEwn4T014v7tJM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789499357; x=1790104157;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=XFFk9jJtDswBQpA8QWIooO6lLG4HdlvPT/LqykRjG+U=;
        b=AF16Y0y3o1XoR0F5p3/MdIdLL6XEiGC8slxVA1xhvzuDDo4gLXMuXotRRFPYjB14ss
         a23Ap16mvgwFcYp0RtPjTtLHM4Aljwh3N+Gg52G0NASM9JSGkiNAtfJVEn7THnidmlWg
         C8KpjL4zU0z9O0TDt05DSxdsAc2HHnmODWHSaA3C3TMlL5SkKnFTFuYOToGpVpnQEQ8X
         zq8w8nPtoNtf4PE2Xt6IRpxJtUeSwZ+/m36UH5OjrHzNUn6l/p+HFVAvOQn7yWtjEcaM
         /G3Pa0UzJMWVFwmj9NRYKOSDnqarRK/k0Wzo3/16zDlJ1E+7ZU5CxONGtgiVM5BlCDCI
         Nvzw==
X-Forwarded-Encrypted: i=1; AKwUvBxXcJ97TY9+qzrhH0zA3K4gfaqp5NWdjpL+nJyiN5a1tqpIBfXw0SuOWBqDX4LgVHZQFReOTWWZexZYjdA=@vger.kernel.org
X-Gm-Message-State: AFuF++nfJUVuB1kodKKRyaDLTqVz+jyiI2MKmoNqhQnEbUBJ2mRVwXP8
	sbVqJ7CIrgQ+FEpvsNj0xVUFXt+pkMvvNxsqbquCMAXtuponLXY1RRoz7mpTMPVQXiyEo/DGs9D
	q4Z5EA24=
X-Gm-Gg: AYBFou21qk5DXyKWO3JM1kGXo7A+t1NshaxzvoQVhnN6IwOKvkPDvtgIToliDNz8qKg
	T26vSBy9m1tEVRdIuChEUT5x9AoyPgbqIWz0DlN/mhUBuJqtMvMFyPjdwZKIRyfC48ikeX/BON8
	BIQxZtTx2xNHi8b/8j6o9F/ZhPclcVo+fLuorrBVga04ceOtzSAPnyhaq45YkJXN1hpGvQ8tFIJ
	3iLmapLFp9KjF/3TzqmhvUbU9d+yHLsF87AuxJYNH/M22seA0OFtUUOUJio6ydjAaBpVzWv6tqP
	VXmb3a3RZIoeyfI1auKyGVqGvZjqkqUsAj6ChEZie4L1Z2M04QpFJPuwFBIZbY6qdhzG0pum+AW
	22RH1fNHJ9kF6r80jEU7GWIjAd+3XWygzXIM4diHFJv/Tg5/kX6QdcEilEIaPohWu6migXeuKgE
	uo1oo4CQCn8O2YOeIL0O7A+fY7RwcwMqM2MOfc7wd4otJVnMuSY9PpbVtlqypPKtGnHgFPv5vZU
	M/7TaVBE+d4oo2AfMTDqEBUCt6rkOcGOV652OGoXNaWX1HUmNc=
X-Received: by 2002:a17:907:3e07:b0:c25:8c05:902f with SMTP id a640c23a62f3a-c29b86b7559mr1163626866b.13.1789499357108;
        Tue, 15 Sep 2026 12:09:17 -0700 (PDT)
Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com. [74.125.228.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c29de48af2asm16170366b.26.2026.09.15.12.09.15
        for <linux-hyperv@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Sep 2026 12:09:16 -0700 (PDT)
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c254fa663bfso33744066b.1
        for <linux-hyperv@vger.kernel.org>; Tue, 15 Sep 2026 12:09:15 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvByq9lYPQA1dyPcqjgfegU41UXVwEji88tgI8qlWlQlH5s1MoAgI9iqjBfaxYHLK76k27KSqmHDOLyJ4XiI=@vger.kernel.org
X-Received: by 2002:a17:906:7309:b0:c25:47a4:fedc with SMTP id
 a640c23a62f3a-c29b839a057mr1176039766b.2.1789499355710; Tue, 15 Sep 2026
 12:09:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260915-work-fd-reserve-unify-folded-v1-0-4d5217d6b246@kernel.org>
 <CAG48ez1RsdT=O=-0city3vjgWhDvY424KtTmrCJntWy5ds3HBQ@mail.gmail.com>
In-Reply-To: <CAG48ez1RsdT=O=-0city3vjgWhDvY424KtTmrCJntWy5ds3HBQ@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 15 Sep 2026 12:08:57 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi3Kkqgfg6zUTHpQoZNL2VOB4vYqpi6RX0WNO++29UtyQ@mail.gmail.com>
X-Gm-Features: AcwNN1VCm0LMG7z3Jned014oJh6WBcf4uOx0OBk98_hrtHKbrhcQiMMJ_A-fmB0
Message-ID: <CAHk-=wi3Kkqgfg6zUTHpQoZNL2VOB4vYqpi6RX0WNO++29UtyQ@mail.gmail.com>
Subject: Re: [PATCH RFC POC 00/50] file: handle files on syscall exit
To: Jann Horn <jannh@google.com>
Cc: Christian Brauner <brauner@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
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

On Tue, 15 Sept 2026 at 10:52, Jann Horn <jannh@google.com> wrote:
>
> Is this mainly about stuff like "we installed a file descriptor and
> then the following put_user() failed"? Because if so, I think a nicer
> fix would be to have a policy of "if userspace provides unwritable
> memory to a syscall, just keep going and pretend the access worked",
> and maybe have a sysctl that kills the process when this happens to
> emphasize that userspace should not be doing this.

We've done that before, where we just ignore put_user() errors and the
user gets whatever the user gets.

It is maybe not optimal, but it's fine. You can find quite a lot of
unchecked put_user() calls with a pattern like

        git grep '^[[:space:]]*put_user(.*);'

and some of them are in core code - see the two in kernel/fork.c, for example.

One of them says "if userspace has not set up a proper pointer then
tough luck". The other one doesn't even bother with a comment.

The scheduler has two cases too, although one of them is admittedly
for another error case.

So yes, saying "if you pass bogus arguments, you get what you get" is
a valid model. It's perhaps not the *preferred* model, but it's not
wrong.

It *would* be wrong to take code that already has error handling and
remove the error handling, though.

                  Linus

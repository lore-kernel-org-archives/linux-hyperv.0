Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 606354908C4
	for <linux-hyperv@vger.kernel.org>; Wed, 16 Sep 2026 09:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789552229; cv=none; b=VSvxQY+rt/7Z9a8JNqN6nnPp5tcIl19SOyg57Q1ZWmUtVx7G1kz4ozKvPoMa19RZZnZ3jTfZ9FfI7IlAcG+oRtlKzokuTNhnQPz1oQ3GAdiVo5n6Tvk15gsu6HKDsJTcm3GoQiBZ8SEhdD7qnWT/EKqtzfi/IhxSCFN5jkrCY2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789552229; c=relaxed/simple;
	bh=zVftL0e6KTn1Fup/RmgkkUqXURXldH56P13A6WLi8KQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PreamslXU02jxfiEToVsxi34505W8kqojYnIU4MKhUQEM/Wt3CMR30pvMd8T2/o2POhfZzwOq+TEwgoCkJuFU/yA7y6Rpqy7+1V5If7hCVt5hb8JAoI+KVfRNNPj6URKtO+gOHxN8w8S7+OMKLnVl2vF2M7mkawuYG4qVg+AfKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dzby88uf; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dzby88uf"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49e66390995so4145605e9.2
        for <linux-hyperv@vger.kernel.org>; Wed, 16 Sep 2026 02:50:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789552219; x=1790157019; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=79YAdtaHEv3S3nDvYc6X9C5ar06F3FncZEtUncQdJQ4=;
        b=Dzby88ufsV19pEuHSQnO0Z3r75FgiJ44qF/jXgKTm3w+wAYVSGDUH6LyexeTQiqa/g
         mb7EWvB3UuhKI7YAj+i2TOZr9/Z0Jn4HnQ3SO6kUkIrvAwSnRTzKzvfGb0So06LetuEf
         Ts3VEs9CM5zHiWBu1V4JZ71jpXN6ZkETnLDwqKE7PV3aA5kY0+ABvWOim6YHWnbq5cCK
         nHzOneSJDYvvXY/C7BkTDDo/hN/r3+9IBjrwRhsKYcoz9kdWM+uOTg6K8qjcDaH6D7EX
         KA0rYEGGzwyipB5cM3imDGmhTpbUuWgcSiyW3ZIBr1TR7/Q7dN5mD7jr++kuJyreI5UR
         skeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789552219; x=1790157019;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=79YAdtaHEv3S3nDvYc6X9C5ar06F3FncZEtUncQdJQ4=;
        b=oow9gHa3yYLhkQ3mSszdx5q9iXcuznBfzd9gYrJCVZJOeZiIu5CszDfG2dpiVo3zxU
         pM3z15CnNzVB7lkvm2GnvwT+KWw+qUMHv/OBSM0nVuusqCPO1IxrQBucC4RbaGrJ2M41
         lFzGc5akJ2QNvNeeuVp0kdbXdQ7yK72aiuQSbE+r4aG0m3+O8p0a+j1zitTIXN6/zl9y
         QBWhoDP75WvpPUo1jpKbE0LU3J/8pgebUdYK7Kni3DvtVk9sCOsfBl4YuU62Ge+itHae
         a9lXefeAnJA96KvbjBwLZi/RT3iqk3oXE2ibDFsAQUhyt55ggVX7b28o51gs8R6vQ1bJ
         zRtA==
X-Forwarded-Encrypted: i=1; AKwUvBwfuOMzXRxwYFOBhcQWR2CzMhp0NXuylvUymLIf2FM7abq3Wm/QjehHsMXFzhKgsLkbavMwjTf2TP72puI=@vger.kernel.org
X-Gm-Message-State: AFuF++mbIas8On2yefOhfAdvv+R2Cp71YpZvqahpPFp3tm0nJLiFEpAz
	X+npdg+BKXbX2sTqaN0YrGLMCw0hR/5q1hVSpbCpyBZsNqkN8ks23xL1
X-Gm-Gg: AYBFou3PPdTn8m99wk60eVYN7al6j1BaT030HRS/pjJLynba8uACU0r9xfguBz1dqjW
	1qDL8jvSP9tUanAgbWEgR8zX6PTlf7VHgSVzADe89bv97k0WKxEwr6Tupbtr9hDYnIwCXfY8FKO
	4Mz/fByaDW8nj2uUaQO2IvRrk9ZJ/wYvJ4vf7Vx/vESO8fRY+aB4MBXcQN372JKmJEQha7QZQok
	ofddra/hW6chSELWRHq3jVdYyKR59n6RiNB+WjSTksScDmr3P729dpeO4sLd9vW5qFfwsMf6j8c
	oyQe4GlhX7c+/v6hMy1f2cjomhlev3w7JRaKp2hnQUctIZBK5ktTLeKcn0kv1Vq+HrOoB18PREf
	9/mxnCkXR0zN9VZYBExfK/ZdYT3GN68f5d22DgoRYcNE1MpisTqKi45bN3+MvsysYKMn+FJ58SG
	SnaB64F/+KVAHBeXsh/+PTm9xXD+GxKKZrtyza4Dyv4rFlJ5eAiK9ovBbITfzWP1tOrR5KvRObF
	NPSbEF5sb971D7i0ziNTkA3pcVEPmWxnxq0LNoD0EYPqwA=
X-Received: by 2002:a05:600c:4ec6:b0:49c:fea3:8633 with SMTP id 5b1f17b1804b1-49eb732aec0mr19444455e9.24.1789552219000;
        Wed, 16 Sep 2026 02:50:19 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49e83b02245sm84055225e9.10.2026.09.16.02.50.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 02:50:18 -0700 (PDT)
Date: Wed, 16 Sep 2026 10:50:17 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jann Horn <jannh@google.com>, Christian Brauner <brauner@kernel.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, Ingo
 Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, Oleg Nesterov <oleg@redhat.com>,
 linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
 linux-hexagon@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
 linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org,
 linux-parisc@vger.kernel.org, linux-sh@vger.kernel.org,
 sparclinux@vger.kernel.org, linux-um@lists.infradead.org, Jens Axboe
 <axboe@kernel.dk>, io-uring@vger.kernel.org, netdev@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-gpio@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 bpf@vger.kernel.org, David Airlie <airlied@redhat.com>,
 virtualization@lists.linux.dev, kvm@vger.kernel.org,
 kexec@lists.infradead.org, linux-hyperv@vger.kernel.org
Subject: Re: [PATCH RFC POC 00/50] file: handle files on syscall exit
Message-ID: <20260916105017.13ea5e36@pumpkin>
In-Reply-To: <CAHk-=wi3Kkqgfg6zUTHpQoZNL2VOB4vYqpi6RX0WNO++29UtyQ@mail.gmail.com>
References: <20260915-work-fd-reserve-unify-folded-v1-0-4d5217d6b246@kernel.org>
	<CAG48ez1RsdT=O=-0city3vjgWhDvY424KtTmrCJntWy5ds3HBQ@mail.gmail.com>
	<CAHk-=wi3Kkqgfg6zUTHpQoZNL2VOB4vYqpi6RX0WNO++29UtyQ@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 15 Sep 2026 12:08:57 -0700
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Tue, 15 Sept 2026 at 10:52, Jann Horn <jannh@google.com> wrote:
> >
> > Is this mainly about stuff like "we installed a file descriptor and
> > then the following put_user() failed"? Because if so, I think a nicer
> > fix would be to have a policy of "if userspace provides unwritable
> > memory to a syscall, just keep going and pretend the access worked",
> > and maybe have a sysctl that kills the process when this happens to
> > emphasize that userspace should not be doing this.  
> 
> We've done that before, where we just ignore put_user() errors and the
> user gets whatever the user gets.
> 
> It is maybe not optimal, but it's fine. You can find quite a lot of
> unchecked put_user() calls with a pattern like
> 
>         git grep '^[[:space:]]*put_user(.*);'
> 
> and some of them are in core code - see the two in kernel/fork.c, for example.
> 
> One of them says "if userspace has not set up a proper pointer then
> tough luck". The other one doesn't even bother with a comment.

I think the code should try to return EFAULT (IIRC that is too hard
in one of the exec cases).
Otherwise very unexpected things might happen if the memory is just
readonly.
If you ignore the error and the pointer is invalid the application will
get a SIGSEGV and (usually) die.
But winding back kernel data because a user copy failed is likely to
be problematic/difficult and at best have error path code that isn't
really tested.

As well as writing fd numbers to userspace, some sockopt code tries to
wind back if the write to optlen fails (which has been read earlier).

I've forgotten which Unix converted EFAULT to SIGSEGV in the system
call exit code - I'm sure one of the ones I've used did.

David

> 
> The scheduler has two cases too, although one of them is admittedly
> for another error case.
> 
> So yes, saying "if you pass bogus arguments, you get what you get" is
> a valid model. It's perhaps not the *preferred* model, but it's not
> wrong.
> 
> It *would* be wrong to take code that already has error handling and
> remove the error handling, though.
> 
>                   Linus
> 


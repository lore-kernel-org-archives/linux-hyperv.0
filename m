Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96CA044AB82
	for <linux-hyperv@vger.kernel.org>; Tue,  4 Aug 2026 11:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785841713; cv=none; b=oO5ZF0d0MXoybWUgldKv95wCA2whk5DKJ99+bnyU8auj+jKHmmvNnRFx+DR9wT32YW7Q8g3NRTiRjMxjWddk0hZVax5FRu5kOD7kWMT+JeqxWwRbZJcFc3ebfecuLo5khZjAwpBnlAiRBmJsByuPRaUMskdg5OpDtV30I9bRrcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785841713; c=relaxed/simple;
	bh=qpSjpcdU0lZQjHDQk8/Zn8BjE1TAsojA7eExd4R7QrQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tcLSxFvoqm6TAk220vX55aZyMB2QZ+ztl3WMQbon2GJGc8aNBjA3uJVjfWZh8cKfC1TiZzyejqNC7XWd+WjL7kQb7BdiW45bWVng0MbmMZaOyMJadxEgb7FGwbCY9hoRf6UqKegp1PQlshXk9ZTjuTaLKF8CmeUB/PJJpchx+38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=TqegCiS3; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="TqegCiS3"
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-39c8e65e3f5so40080661fa.0
        for <linux-hyperv@vger.kernel.org>; Tue, 04 Aug 2026 04:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1785841705; x=1786446505; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kI4V36Sbi2eoM2PIUIRbZwfMejC4hN4t85DIc4lGtp8=;
        b=TqegCiS39TZCFqUxGKmbx6F6v4PhPEZGnLtS6H0oHlUCeQk1JyY9oyn5300n2hVb5s
         qPTbSn2hICCZkE8omIEiOwqpT5P4NO7JgM57hlwwSIcomq8gBywe/rl3U1PRz3VQfnAN
         smJjBSlhPgzOSKkAlDaP8vWGZ3v9mew7BACg6Bol4WMnTVJaUl6XQ7LWYWYCnlfVZMNF
         e1OfNbnRRK2W59OXjV9FO5V5yZvB2OHw66ny6bg/kq7mPVW3fnHXax3QQ0ka08tan9JH
         atqRU0N7mn3vQWAO1rKZjW9JEfnfdmr/EZ4M+iHOpV6zoUOWuWwClhvigbHgifO1Oobv
         y8SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785841705; x=1786446505;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kI4V36Sbi2eoM2PIUIRbZwfMejC4hN4t85DIc4lGtp8=;
        b=JJGjjeSxnzZ5ErDy/unK1CQooSyBs/PyGCZ5luAhY/VdO9zX6w6UcA8HyRl6t35MK8
         SA2uCDtoKI83HwcX31ESWOcnChDmD6pDGTZCq2v5S6gvKNTKO/kmISly6zOUSsKBJm7n
         haxMRntm2VwZV3nXZnXyANIJ6JbPv2Rg4waqKL4ogvWZh+2rMNa63PLhX/eSGdzVelWJ
         DhicM3IloDL9HVqjKPgbSCsMEvjJH7ZNKsm5Dlr5WdcLf3z6zkjJSjlhFraXe/59EteR
         xyfh5eLMyu6sMKOY6u6AJE/5yy8Ewe4bfZsNhAUcJmiZQi9N5IUfZcqheLCuLPQ1ygCo
         kX3Q==
X-Forwarded-Encrypted: i=1; AHgh+RrNIyRTDMpdkczRKhVU14bpLW0alvlf0wz0ZVMGq/fhgroM45+6vAOteJ+Xt2fKFXMzL4MNHIYYnfu8fzs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwL9OpT4Jste0eFvVnATOkkAP1BwpkbM61Ch2Tw5nx2EXRXl7DN
	lR7jzHFtAWcvPg/naVoO5xjmkgHAWOiyaU7J5xzSYY/zkYoQfSPeF/IRsh1EUU9oFPU=
X-Gm-Gg: AR+sD10tSnCVkZpOexV2MVEJSSU9z8VBO3w8wOztDyNq+I9yF/tK0d5B0ePz9lbtfge
	d18QwnxJbtrP6Zpvy0PhzgitB4oi6b8CURiN+YEXF22RttCT6p3bZP4lgz2WfNc2EHTg+Iz3waB
	RBz8bvJ/84hr3wreFNJE1xdpL/yzLnUuQqwK6HIY2UHXWSaGkY48+HZ2Or8mUpLwSj5ISqK+9dM
	gsEo9FX2gPdyQD0JLUib+4t1a9+40ep/lCLv5FQKMnFJd1v2S9fHi30E3vaXntZEJG5HDwz8C7y
	bViPR+gLc/nnto5FBEXFwXLbk0G4GBD81F1+Rq53N4N2bCtlTDZE788y9y7hkh0dN6SlsZ3O2sn
	EZ0A9En8drC0fkb3kaRFxs9qpV9cEWrPW6NkAqag3awHafV8bhc+ZEJSEiuz1ZpkfpKMeZEYzU1
	CmjpI+shSn4cBErEkvizC7UVYzYEK9unN3B2O46GLGQ6okTNkWGzArmi497Dr/F7SAOUhQvBngO
	0kBFMLU4w==
X-Received: by 2002:a05:6512:2546:b0:5b2:a68d:2763 with SMTP id 2adb3069b0e04-5b2e4f1afecmr2052171e87.12.1785841704997;
        Tue, 04 Aug 2026 04:08:24 -0700 (PDT)
Received: from localhost ([140.209.217.211])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b2e23d23b5sm2518666e87.35.2026.08.04.04.08.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 04:08:24 -0700 (PDT)
Date: Tue, 4 Aug 2026 13:08:18 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Leon Romanovsky <leon@kernel.org>
Cc: Konstantin Taranov <kotaranov@microsoft.com>, 
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>, "jgg@ziepe.ca" <jgg@ziepe.ca>, Long Li <longli@microsoft.com>, 
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
Subject: Re: [PATCH rdma-next] RDMA/mana_ib: Retain create CQ flags field name
Message-ID: <anHFniO-9SrlUx0O@FV6GYCPJ69>
References: <20260731091041.2250897-1-jiri@resnulli.us>
 <DU8PR83MB0975547820CBB956D4EFFE57B4C82@DU8PR83MB0975.EURPRD83.prod.outlook.com>
 <anCBtLSxn8TtFcSz@FV6GYCPJ69>
 <20260803132844.GA326170@unreal>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260803132844.GA326170@unreal>

Mon, Aug 03, 2026 at 03:28:44PM +0200, leon@kernel.org wrote:
>On Mon, Aug 03, 2026 at 01:59:07PM +0200, Jiri Pirko wrote:
>> Fri, Jul 31, 2026 at 02:54:31PM +0200, kotaranov@microsoft.com wrote:
>> >> From: Jiri Pirko <jiri@nvidia.com>
>> >> 
>> >> Commit eb70d83a8645 ("RDMA/mana_ib: Adopt robust udata") renamed the
>> >> "flags" field of struct mana_ib_create_cq to "comp_mask", as
>> >> ib_copy_validate_udata_in_cm() only validates a member with that name.
>> >> 
>> >> The layout did not change, but the field has been a part of the UAPI since
>> >> commit 44b607ad4cdf ("RDMA/mana_ib: implement uapi for creation of rnic
>> >> cq"), so the rename breaks userspace referring to it, for example the mana
>> >> provider of rdma-core assigning cmd_drv->flags.
>> >> 
>> >> Convert the field to a union providing both names, so that
>> >> ib_copy_validate_udata_in_cm() still finds "comp_mask" and userspace keeps
>> >> "flags", without having to add a helper for this single case.
>> >> 
>> >
>> >Thanks for the patch, but my understanding that it is a common practice to rename the fields,
>> >and kernels headers should not accumulate historical names. 
>> 
>> That is not doable in UAPI.
>
>There are multiple levels of UAPI contracts. In RDMA, we guarantee
>binary compatibility because userspace (rdma-core) is effectively the
>second half of the RDMA driver stack. These drivers do not exist
>without rdma-core.
>
>As such, this is exactly how the RDMA UAPI is intended to work.

That is some odd UAPI...


>
>
>> Some userspace app, like rdma-core in this case, might use it and rename breaks the compilation. Some other
>> app you don't know about may use it.
>
>rdma-core does not use these headers directly. Instead, it vendors
>them in the kernel-headers directories specifically for this purpose.
>
>> 
>> 
>> >I also faced a similar problem from renames in other providers, when I needed a new kernel header in rdma-core.
>> >If this breaks your rdma-core in a PR, just remove the field rename in kernel update commit as that header update commit is not getting merged anyway from your PR.
>> >My understanding that maintainers of RDMA-core will merge the kernel header update, and will bring this change from my PR:
>> >https://github.com/linux-rdma/rdma-core/pull/1765/commits/0dcadd9316f1b98e21973e3a6e0f96186d49bd5a
>> 
>> this is not how UAPI can be changed :/ It simply can't be changed.
>
>It can, at least in RDMA and elsewhere in the kernel, where user
>access is provided through properly designed libraries.

Ehm, up to you. Very loose.


>
>Thanks
>
>> 
>> 
>> >
>> >- Konstantin
>> >
>> >> Fixes: eb70d83a8645 ("RDMA/mana_ib: Adopt robust udata")
>> >> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
>> >> ---
>> >>  include/uapi/rdma/mana-abi.h | 5 ++++-
>> >>  1 file changed, 4 insertions(+), 1 deletion(-)
>> >> 
>> >> diff --git a/include/uapi/rdma/mana-abi.h b/include/uapi/rdma/mana-abi.h
>> >> index 410f0ddc8c89..431c7076f20a 100644
>> >> --- a/include/uapi/rdma/mana-abi.h
>> >> +++ b/include/uapi/rdma/mana-abi.h
>> >> @@ -25,7 +25,10 @@ enum mana_ib_create_cq_flags {
>> >> 
>> >>  struct mana_ib_create_cq {
>> >>  	__aligned_u64 buf_addr;
>> >> -	__u16	comp_mask;
>> >> +	union {
>> >> +		__u16	comp_mask;
>> >> +		__u16	flags; /* the original name of the field */
>> >> +	};
>> >>  	__u16	reserved0;
>> >>  	__u32	reserved1;
>> >>  };
>> >> --
>> >> 2.54.0
>> >

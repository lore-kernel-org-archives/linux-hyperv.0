Received: from mail-lr2-f12.google.com (mail-lr2-f12.google.com [74.125.230.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4873194C95
	for <linux-hyperv@vger.kernel.org>; Tue, 15 Sep 2026 23:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789513310; cv=none; b=ULxMM2cAnOsDR8Is+QaJhfKipgZUtDysecJKY2JWH8Zqt42Iziuv2YvoWVPopZtZhgBENfhUMtsysmnedR0/snD420aFqFzA5cHRKCpku1TKOYzW6I4KBSIBHA/Poh5iW5Zs17itX/YT5QoKigPVkOP9ONyAs46G9CiD3GCZFLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789513310; c=relaxed/simple;
	bh=ITz7hBythv5OWTbmQ9c4e1mzRPysX2+YTMbCrseTj6Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GazJoyuBUEBQwQPvtMmQeZyTK9w09YlNmrrDpnjK/jKLTAxdcLAjdr/RNV5QwmumlTpwvejLuwruGpR60cHWLfsUbSgj6VIPuUYwkjpo72CaO53aJ35Y7icjrBwYnzP9G947wsz9OJHcrnjJ3G+IJMbgheet6enznUBbk+9M+oM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=K3yYI3uq; arc=none smtp.client-ip=74.125.230.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="K3yYI3uq"
Received: by mail-lr2-f12.google.com with SMTP id 38308e7fff4ca-3a5a04b88e9so3095221fa.0
        for <linux-hyperv@vger.kernel.org>; Tue, 15 Sep 2026 16:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1789513306; x=1790118106; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7NEEN5klK6sYQ7k8fj+V0z2WeSFVNwjy5fJJIdfiMPQ=;
        b=K3yYI3uqCGHyXCNM9nVz+abqwjRgwYN02Q3wVP0IJdRGYYk35VuFulST7xeYrDYJ3K
         OrsRXkXm3wWvuu7tZ1fvEjv7+oHoL6LT0OQ+3PyAJq/4WVvdLkbFSJEHvna6jQSPsGE7
         N2ayUUuWyFkzHqgPVpofWs5/qlGgdLf/PwrVo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789513306; x=1790118106;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=7NEEN5klK6sYQ7k8fj+V0z2WeSFVNwjy5fJJIdfiMPQ=;
        b=Cgij7Zl4VrPMDuiEYoEDc4Z2m/HzI++6yuiSveMrLSUMbrpwCQnmJ+cCxHmcl6VRU/
         lNN2ossvuGvbbuFZNvPxtKFYc39wt59WaU+3lUhtxiVjQY+Vmjl1ov/oGZJ9dRWrghnZ
         CDcNYYKEnv3DDhBp82459jy87HG822DoCmuZuBpgO9sp34bp0gjTVhf1j83Yt7C/gpTi
         m2gwtELj+tZ2p93DgfyO+iynlyMKk1+ROeRBPIrQYBTZkLVg8xW1Q5H8IdcOUrh3clHe
         hjCue5rnFz55pccnHrVflhERGfYkrsyy893kjoHZOOnRKAdl6tGrzjFGhGVel+64/vww
         9jPA==
X-Forwarded-Encrypted: i=1; AKwUvBwxuIeg58EEQ9GvOktkHHTZff+20Oke6e3hWTn29B1jozTaRSTzuz3rxRixFTrfsUz+jRVhvmALtJOW9aA=@vger.kernel.org
X-Gm-Message-State: AFuF++nW5mgAJQ8dcNiuuTG4NLkh9UP4xlc4r6Uu0tlUvhhodUyp8RGx
	FhogHWHD0udgE0mZ05bqaI8rmcJPBsU1laMwnXymkm3T2L/gTvL7L2fgCjWf3SFXGNYDUouiKCx
	DXaTbq5ZWWw==
X-Gm-Gg: AYBFou3KDJgisSD1P3ZIYwE3mv34AMoed4GoBuTqDrZkfw8ehcD8mLrbkNCsHYUL7g9
	SK7EDtkJ72sbArdPZ8lE49JdYMbHQRu1vZtND4detb/3hwfgyXKDq9Dm5sjdTP8rgyjGnyUW51s
	0/KLtSbJ2Y67fpcf3aJL/plq5f1yFLu8FT5F/M2/OXiROaQ6ihRRF7qvtOXdmElY+mosu1vI224
	OCorKrqGQPiikFETPoYovZIK/ajMSkEh7AEq2iT4A1EFgIdq3jYrh/vFyCh8aW3rOzyzi02NgiC
	l9PrrwKMSY6dqubzsvEYjha8i4YDtGU9M/ReJzl14KgdUBxQ71bFUzND8xYXz65vL10VSESp8e+
	0GIQc4uLGpWlyUL++ZftsHrI+x8WY2Yjpni38NmlB44hoxQhJcwX2ConzzJ3Y2Ys54F/I1VO6q4
	9ETdI9n2ZNZ+bxpCkv7w9yCfjGxeQNBMIeFppUpcm/co8etICagmrxXeDJU7x63pFF49vYWlhPI
	Q1t4/EHsQ17zw8A10vfSFTpLGnudElwY9eG+6iD5KpKYGEGN4s=
X-Received: by 2002:a2e:8593:0:b0:39a:d7f7:981d with SMTP id 38308e7fff4ca-3a5dc9d2f94mr835761fa.12.1789513306364;
        Tue, 15 Sep 2026 16:01:46 -0700 (PDT)
Received: from mail-lf2-f13.google.com (mail-lf2-f13.google.com. [74.125.229.205])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3a5daf9f6f8sm2056591fa.18.2026.09.15.16.01.45
        for <linux-hyperv@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Sep 2026 16:01:46 -0700 (PDT)
Received: by mail-lf2-f13.google.com with SMTP id 2adb3069b0e04-5b5e4f17452so244304e87.3
        for <linux-hyperv@vger.kernel.org>; Tue, 15 Sep 2026 16:01:45 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBw8yYYETnkFssHg5lSqSOr94wxK64nHbHHEl5AE8bkXeCwMo8iNbHuguqtUohe+J9evhVTM15amM649aZI=@vger.kernel.org
X-Received: by 2002:a05:6402:5d1:b0:6a9:a6c0:e5ef with SMTP id
 4fb4d7f45d1cf-6aa2244ef06mr218172a12.37.1789512913950; Tue, 15 Sep 2026
 15:55:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260915-work-fd-reserve-unify-folded-v1-0-4d5217d6b246@kernel.org>
 <CAHk-=wjeamU=_RYT9cR3dZJ2N-Teo-N1+aYh7jwhrB=iWXD0cg@mail.gmail.com> <CACSVV028AdnTYa6OKDeoJYCau58uTkKMgEdqTn7crNSV8QZxOA@mail.gmail.com>
In-Reply-To: <CACSVV028AdnTYa6OKDeoJYCau58uTkKMgEdqTn7crNSV8QZxOA@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 15 Sep 2026 15:54:57 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjhJF91TCO0Zqeuf+caG2tQZ4AzbLr2qFmRmnMM4dbh4g@mail.gmail.com>
X-Gm-Features: AcwNN1Wx2MaYDtFtmeOlL6MnzYY7doY_FEPpziKatTBWbLOeKsjmritQ5JuAL3M
Message-ID: <CAHk-=wjhJF91TCO0Zqeuf+caG2tQZ4AzbLr2qFmRmnMM4dbh4g@mail.gmail.com>
Subject: Re: [PATCH RFC POC 00/50] file: handle files on syscall exit
To: rob.clark@oss.qualcomm.com
Cc: Christian Brauner <brauner@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jann Horn <jannh@google.com>, Jan Kara <jack@suse.cz>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, linux-fsdevel@vger.kernel.org, 
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

On Tue, 15 Sept 2026 at 15:21, Rob Clark <rob.clark@oss.qualcomm.com> wrote:
>
> With fd's it is more than just about error rollback.. exposing an fd
> to userspace mid-way thru an ioctl is an easy security bug to write..

That isn't very common code. It's something that is done by a few
strange cases, and yes, those cases should just do it right.

But "those few cases should do it right" does not mean "make a whole
new subsystem for this thing that makes a simple "open" actually be
slower and stranger".

             Linus

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 405303E1204;
	Wed, 23 Sep 2026 07:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790148186; cv=none; b=jtmxgU7XN/ZfiZT0DvJRpYqDLvbhFIUNRQdbabH84j+7RdWgsV/sG1rKNmehFfUWxMYeDFylsczXR3atRRXz8gjRfB3zv2J57hkFIBg4bvrRXpthsFJz2N2ydHt7fSLtLLR5aci+iT4XRPqMxt/Lc+veWUZdKF1j7CPLnzCH3HQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790148186; c=relaxed/simple;
	bh=oCN1KbF54mPhtRZ1+Re4+FxfSHl0cJYsKsBOTSfQ/PQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a9abBnopsjM89ZBJomvkIsVWcewtpcudo4ZP+//cQZzaQd6atuacQkDYM3d0rYcdMyg6MZp3HMJTP/i6ITbVX12axv3SXsTKoDRv0OX2u1+3/lDa0v7SsHsliG3t882hyCL9yWAmJEfPL9E8cc91cP4YNG4KjRQg6EwY9upwwTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lhl+A7Wz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lhl+A7Wz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 422821F000FF;
	Wed, 23 Sep 2026 07:23:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790148181;
	bh=iWP0JfqpS7KoO6l/InDB/IDX8Qgt3W/nlO+IzCSYcfc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=lhl+A7WzgpOerXuR8PJ0U6DFAGu088foHRA3S0KQbC3UlTBrHWw47qGkRAbRmNNy/
	 OuJ6kGvpVJgNgIUepXmuL4wPrF/6+wCAq2uNzvwCFrAmndd4nKuM1qYWhsUTpdanNp
	 OQdOK9W1OaemiylkeVO1brYr4Kpio3A5OPlhdthspIR3K6AlteFKDkHtOZTf0O3bSJ
	 l7leDdm6ArB8cM8b/hOK+v1w+VJF6D1mIvj0/T/KfPOwCnYi73+FoRsgE1WeFsDpMq
	 xUbyk91sQeSdthV5bZzKs6GiKTH+hr8BR9gocFUaBAc8P+D150TtQAlb3OAwC2U/a4
	 UX3aioxlAQaOQ==
Date: Wed, 23 Sep 2026 00:23:01 -0700
From: Kees Cook <kees@kernel.org>
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: Bill Wendling <morbo@google.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Justin Stitt <justinstitt@google.com>, linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
	llvm@lists.linux.dev, codemender-patching+linux@google.com
Subject: Re: [PATCH] Drivers: hv: vmbus: annotate struct vmbus_gpadl with
 __counted_by_ptr
Message-ID: <202609230021.7F6F2140@keescook>
References: <20260923055320.2602534-1-morbo@google.com>
 <a51283e0-7d55-4d06-bf7d-3cd7b7a21faa@embeddedor.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a51283e0-7d55-4d06-bf7d-3cd7b7a21faa@embeddedor.com>

On Wed, Sep 23, 2026 at 03:10:08PM +0900, Gustavo A. R. Silva wrote:
> 
> 
> On 9/23/26 14:53, Bill Wendling wrote:
> > Add the "__counted_by_ptr" attribute to the buffer field of "struct
> > vmbus_gpadl". This allows compilers (GCC and Clang) to perform
> > compile-time and runtime bounds-checking when KASAN is enabled, preventing
> > potential out-of-bounds accesses to the GPADL buffer.
> > 
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
> >   drivers/hv/channel.c   | 2 +-
> >   include/linux/hyperv.h | 2 +-
> >   2 files changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/hv/channel.c b/drivers/hv/channel.c
> > index 7e4cc6f55237..7042de2dd481 100644
> > --- a/drivers/hv/channel.c
> > +++ b/drivers/hv/channel.c
> > @@ -548,8 +548,8 @@ static int __vmbus_establish_gpadl(struct vmbus_channel *channel,
> >   	/* At this point, we received the gpadl created msg */
> >   	gpadl->gpadl_handle = gpadlmsg->gpadl;
> > -	gpadl->buffer = kbuffer;
> >   	gpadl->size = size;
> > +	gpadl->buffer = kbuffer;
> 
> I think in some cases these subtle changes are worth a short but
> informative comment saying that the _counter_ must be initialized
> before the first reference to the pointer.

But that's only for dereferencing it... there's no ordering requirement
here at all (and I think swapping order is needless churn). Neither
order is correct: only having them both set before dereferencing
"buffer" is required.


-- 
Kees Cook

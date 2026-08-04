Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60FFE3CEBBB;
	Tue,  4 Aug 2026 10:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785840004; cv=none; b=doS6DAf+g+F4cHtFHlBOBNp2CZXnMa3qq6phVRkp3QfUOKMdkGNLzZoWV5v2A2mkA1v0BOXuhIweuhb9ZML3iAKLEwhlVsmsdAVZT9W8xgyAuJciqslRkO1RnHEDoWq2oCLgzIpvuHndXG0/EMn19sC0yPXGUe0ehimTs3Mst64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785840004; c=relaxed/simple;
	bh=66Vr/fy3qYcTZO6v5sVMVw5Sihq2KQZzSp511oVKZTY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rc8fvoV0GqzxsYPI/nxu3byilMi4MpAZ1lmLOGmCwCKF5BptU013ZmZE2sXaNh7aVWcw2uQwyJGUJ4qOWilTa9/z/2hUdKy8amylqLBuz20bz0sbopVWPtnHZ/6Fok0A5jQeYNRNiUwiKjFL4n+B9HRogZ4p+s+qTx43gIMNtuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=LGA1lkkR; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LGA1lkkR"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=MsldYqnXOycsS4y2/7KD3GU//XDAu63pq55swDGd2xw=; b=LGA1lkkRQbVX1KW9YPvaAmrSjX
	iVDDDoXj/8hc/CzXkHA5ffJ8pRRD8pKaS0GgylshFZGV1Gt51cxqLuoVgYiuV2+ASvLqawoyP37O2
	ta0OHhxCiAPtEM7zdUElmcx4T8aqOOi6F0Y2q+lPdg8ionsZP3yHhQDAZ8wcCfqcYRJN5+hEbCGN8
	sfZ+ukTa3ier64oRKtJsK+zhxdviWmRFE/G+2nNfwhkLzN58M0Lmk13/TM+rpL52AWovHxCh20cap
	NFJT1Jbuiblfw8ziL76Tp7Ia//DA11YVN9uCIT6u7MxpE8hBCpXj1BKi8NhSEyEoqHzzQKtxscgCI
	IVoTVISw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wrCYe-00000009nOq-2bzw;
	Tue, 04 Aug 2026 10:39:40 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 5984030045A; Tue, 04 Aug 2026 12:39:38 +0200 (CEST)
Date: Tue, 4 Aug 2026 12:39:38 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Dmitry Ilvokhin <d@ilvokhin.com>
Cc: Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	Boqun Feng <boqun@kernel.org>, Waiman Long <longman@redhat.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>, Thomas Gleixner <tglx@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, Juergen Gross <jgross@suse.com>,
	Ajay Kaher <ajay.kaher@broadcom.com>,
	Alexey Makhalov <alexey.makhalov@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Jason Baron <jbaron@akamai.com>, Alice Ryhl <aliceryhl@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
	linux-hyperv@vger.kernel.org, virtualization@lists.linux.dev,
	kvm@vger.kernel.org, xen-devel@lists.xenproject.org,
	linux-arch@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH 0/5] locking/qspinlock: Add contended_release tracepoint
Message-ID: <20260804103938.GH776954@noisy.programming.kicks-ass.net>
References: <cover.1785778551.git.d@ilvokhin.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1785778551.git.d@ilvokhin.com>

On Tue, Aug 04, 2026 at 07:15:40AM +0000, Dmitry Ilvokhin wrote:

> Patch 1 is Peter's draft from [1] and is missing his Signed-off-by.
> Peter, please add it if you are happy with the patch.
> 
> Dmitry Ilvokhin (4):
>   locking: Factor out queued_spin_release()
>   locking/qspinlock: Add contended_release tracepoint
>   tracing/lock: Use TRACE_EVENT_FN() for contended_release
>   x86/paravirt: Trace contended_release on unlock
> 
> Peter Zijlstra (1):
>   x86/paravirt: Use static_call() for the paravirt spinlock ops

Right, this all looks nice. Let me go queue this for the robots.

Thanks!

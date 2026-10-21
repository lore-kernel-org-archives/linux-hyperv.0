Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792616336;
	b=ZhfVaSDO4BUCr46npDbygO3Je9q684sFpelZ8QcolD7o7vQZ4EnUz8mXV1YALq7vbCqT
	 dmOWZKuHfWKboZ4cTZ52ddamZ+Z+QxJCUq9/kzFXe4Le8gMNRlg4QCFvA0n2KDP4uRv1N
	 3X0WCKN0xbDagDXE+I5nsagT0S9EHw0WMiRgl3xIUBQ1J1GcWhjtk4orn5mEyYBn91mew
	 1iok1ZVIhve4CQrnEzgF+zkwUtOdYLB0/nhMqullQHOeIxqTubcCS2qKTLohNj6xDLwiJ
	 hEVL3ali5enlBIeXVfVKeog5WBaqPB6sNr6+mz2SwTafhEOya9X4ZHS7PF8Lc/hHqeg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792616336;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=W8QpUwmMkLvVxRBYSH3rqkRjfuSW4enaMRdeQNLqIcg=;
	b=I+47OgqIe0ytCoWRNiIp0+rSh9VanmPfmD5KmZBbAQvqQo+FoxABjCjgmC1qEmNc0aaL
	 cEGHixdX/uSRo6f+8j1P0Peqv1/fVkMCtGYoMgpvPE6QBb3yvVDEYsZNRCg0syO1cLBEP
	 eyQt1SwHBzVuAsenmzJNyRnVfQmcSgX+wgIdlpr+gWYNhwfaoiHUCBAWPQunUzHhSaMoT
	 OG/PPsRqv9hOT6+ZVw0YqhZO122/RyWoNZgr6KC7o1aLApTd0VvKV6JE3mXJPB3Sc5vQp
	 z+wjAVoCJmzBUEp9BCU8hwvBbpzmRk9Mc5Vq7i9Evm6dnPSdtFXO6uFP/97xEzbi49Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=b8wdlYnJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 760A8606A319;
	Wed, 21 Oct 2026 20:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=b8wdlYnJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00AFF1F000C2;
	Wed, 21 Oct 2026 20:58:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792616336;
	bh=W8QpUwmMkLvVxRBYSH3rqkRjfuSW4enaMRdeQNLqIcg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=b8wdlYnJygC9QUFvBH0kNwqRrRzW8FCxvY4yW0TAOjd0ISGq+EPh3zZUhSGohygFR
	 iogrxxdFBaPr9Bk0pySII4vMnbmTzuk2+eRdzF4FVSHXnEpHM2Uj6gCMeo9IH/Ujk6
	 dfVthZhXotiix0YjX7KAnUb3TOhEc1BL4q8e3SnIdJSIudcdOeIH6FGkm1AEFqwBYm
	 dv0CsN+sjEB/ScQ9RgK6kw5tBIB+qyga1Ik7XSkdVYk/b3Eq65DzhX5B+VI4TrYUra
	 E+P8CC33dj/APijwMMU9rTkR+XiyM2BsPQY1u+lyWQjGnen4umSKHm4LNtUWXKQboJ
	 JYH1kNNIPCt3g==
Date: Wed, 21 Oct 2026 13:58:54 -0700
From: Wei Liu <wei.liu@kernel.org>
To: Naman Jain <namjain@linux.microsoft.com>
Cc: Daehyeon Ko <4ncienth@gmail.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Saurabh Sengar <ssengar@linux.microsoft.com>,
	Michael Kelley <mhklinux@outlook.com>, linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] mshv_vtl: fix poll waitqueue handling
Message-ID: <20261021205854.GM851443@liuwe-devbox-debian-v2.local>
References: <cover.1792398881.git.4ncienth@gmail.com>
 <61e6d816-7cd4-4124-960c-805f7689b568@linux.microsoft.com>
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Post: <mailto:linux-hyperv@vger.kernel.org>
List-Help: <mailto:linux-hyperv+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hyperv+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <61e6d816-7cd4-4124-960c-805f7689b568@linux.microsoft.com>

On Mon, Oct 19, 2026 at 02:37:39PM +0530, Naman Jain wrote:
> 
> 
> On 10/19/2026 2:13 PM, Daehyeon Ko wrote:
> > MSHV_SET_POLL_FILE retains one embedded wait entry per CPU after vfs_poll()
> > returns. Two independent bugs affect that state.
> > 
> > First, a provider such as signalfd may retire a non-file-owned waitqueue
> > with POLLFREE. The MSHV callback leaves its entry linked and retains the
> > queue pointer, allowing a later replacement to access freed provider
> > memory. Patch 1 detaches on POLLFREE and introduces an RCU-safe removal
> > helper.
> > 
> > Second, a poll callback may register more than one waitqueue. MSHV inserts
> > the same embedded list node into each queue, corrupting the first list.
> > Patch 2 rejects a second distinct queue and uses the common helper to
> > unwind the first registration.
> > 
> > The roots, triggers, effects, and runtime oracles remain independent.
> > Source-equivalent KASAN/LOCKDEP tests reproduced both bugs and validated
> > the fixes. The local system is not a Hyper-V VTL2 environment, so the
> > series has not been exercised through the real MSHV ioctl. OpenVMM does
> > not exercise these paths in its current use of the interface.
> > 
> > An LLM assisted the source audits, fix development, and validation. Each
> > patch notes that assistance in its changelog.
> > 
> > Changes in v2:
> > - combine the two previously standalone fixes into one series;
> > - rebase onto current Torvalds master;
> > - introduce the removal helper in patch 1 and reuse it in patch 2;
> > - replace the obsolete Assisted-by trailer with changelog prose.
> > 
> > Previous standalone submissions:
> > - POLLFREE v1: <20261017141527.623376-1-4ncienth@gmail.com>
> > - multi-waitqueue v2, now withdrawn:
> >    <20261019070438.3732624-1-4ncienth@gmail.com>
> > 
> > Daehyeon Ko (2):
> >    mshv_vtl: detach poll waiter on POLLFREE
> >    mshv_vtl: reject poll files with multiple waitqueues
> > 
> >   drivers/hv/mshv_vtl_main.c | 51 ++++++++++++++++++++++++++++++++++----
> >   1 file changed, 46 insertions(+), 5 deletions(-)
> > 
> > 
> > base-commit: c03c1a14507dfaf8b856c2608f9ac216021fc222
> 
> I would suggest you to generally wait for a couple more days to collect
> other reviewers feedback as well, in case someone is reviewing your changes.
> You can then address them together in the next version.
> 
> For the series,
> Reviewed-by: Naman Jain <namjain@linux.microsoft.com>

Applied.

Wei

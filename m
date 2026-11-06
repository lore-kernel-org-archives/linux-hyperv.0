Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793968694;
	b=eoR0e53VBwszrBJBfXIwyQa1LIL583uzUjYOC0jVT2om8NYf1/muagnoWQoYyUzdZJE9
	 G+6vfIySfcsBUNGr0QaZXZV+KKgc5XMoN3LiTnsJgPZ4cEL1aQ59tNbF6FwhGmxJxm+WW
	 yd1Os3JBEpuUZSvI1swIA+H03JpcCH5p3pkuNi3kzHHgNTj5ZqAFi56dRQPfLVqxZmPb6
	 6v4h2G1uUJbg2kx6iHtwHISSR4mwv5vQMMdW6lfuXRxCYiCsIRlJAyVAIXP1BJGGvQ61i
	 UvzE+AouohH4hDrZk8CaGwygt+LeChNwdWs0qBq4RLWNTVRj7dOLHUOJ9OWw9WxhcnA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793968694;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=IUiGCier333Hz09PdeW6j76Dwlflwlp2lMcssnAzTuQ=;
	b=uz55+lKFTGAeiT4MPYoaYDPrq7xjHEHg7bEu+aPomDuVYBTAqghrgROhk4nnhVvx6KZe
	 NuEY1tbYA3VcYCT90C25GkGUz/b8840bjXVKCLFceSVzLWB7iUEM/9vsulkhmQd2MlKAy
	 Or5eIMVo14wGEM2Gw5ippxc5p4z/d8+8c4I3f5x/eZksa4Sl+HUz01R41++ZBgSFYpO7t
	 5X5wFOz+LWlg3+040uJSBQu+GfLAXHUSIOSjgRH2wOTXY+iELH7cIA+CNHaPp5L4N8thr
	 E19PGglcD/uD9RqGHaLEh52gkFpKudhrvRYs8LJdtZducY596I5C7dLBNCBWgUnQA9Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VIo4FhS3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD525606A326;
	Fri,  6 Nov 2026 12:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VIo4FhS3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDFD61F0089F;
	Fri,  6 Nov 2026 12:38:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793968693;
	bh=IUiGCier333Hz09PdeW6j76Dwlflwlp2lMcssnAzTuQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=VIo4FhS3PG8yGjv8w7BUwZ9r+AF5M4M8k8kQsXCAQvczJVcmNHj36plfKWlPmr2Zx
	 k0aHR3fYtfDiWBAscKWUNaHbEQ0a4WaEHhFh2QQgFDqPH2v3dqL22f1RP8cT3zBQBN
	 vea9aykHPzqadQgV5YwCc09/45yAAChGDHyYoGlQLjMEW2eyFUwl7K92ZCLe4w7y87
	 svudE7/onGOUbjQ3GHFl8qKeMCtQ2peixq5KOdxk4yWqz9EFcXMsKF9p4ZA5o8eT0s
	 /nFxufqx+VWDkjWf55i6xcuuqx2hwrz8DPfsKznWspjB8/Qyqc3nv1cnVZe5dDCS1n
	 1oxKjv0STGpXQ==
Date: Fri, 6 Nov 2026 13:38:10 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Naman Jain <namjain@linux.microsoft.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Long Li <longli@microsoft.com>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Peter Zijlstra <peterz@infradead.org>, Phil Auld <pauld@redhat.com>,
	Thomas Gleixner <tglx@kernel.org>, Waiman Long <longman@redhat.com>,
	Wei Liu <wei.liu@kernel.org>, linux-hyperv@vger.kernel.org,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH 39/47] clocksource: hyper-v: Move
 CPUHP_AP_HYPERV_TIMER_STARTING post stop_machine()
Message-ID: <au3KMiLqclDsVESx@pavilion.home>
References: <20261105163045.38862-1-frederic@kernel.org>
 <20261105163045.38862-40-frederic@kernel.org>
 <da4937bd-542e-4a46-a5a5-35596572f5df@linux.microsoft.com>
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Post: <mailto:linux-hyperv@vger.kernel.org>
List-Help: <mailto:linux-hyperv+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hyperv+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <da4937bd-542e-4a46-a5a5-35596572f5df@linux.microsoft.com>

Le Fri, Nov 06, 2026 at 03:37:26PM +0530, Naman Jain a écrit :
> 
> 
> On 11/5/2026 10:00 PM, Frederic Weisbecker wrote:
> > Between CPUHP_TEARDOWN_CPU and CPUHP_AP_OFFLINE, stop_machine executes
> > all the teardown callbacks while stopping all CPUs in the system. This
> > doesn't mix-up well with running RT or isolated tasks.
> > 
> > In order to transition smoothly from global stop_machine to finer
> > grained synchronization between teardown callbacks and the other CPUs,
> > a new stop machine post function has been introduced to be executed
> > after the main one with IRQs still disabled while other CPUs can exit
> > stop_machine().
> > 
> > The teardown callback here simply performs timer and IRQ disablement,
> > both of which can run concurrently with other CPUs.
> > 
> > Move it to post stop_machine() accordingly.
> > 
> > Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> > ---
> >   kernel/cpu.c | 4 ++--
> >   1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/kernel/cpu.c b/kernel/cpu.c
> > index 93b8498e26c4..b49b67ef5ecb 100644
> 
> I am unable to correlate the commit message with the change and could not
> find the rest of the series on lore to get more context.

Sorry about that. I couldn't CC everyone to the motherpatch so I tried
to bring as much context as I could to each individual follow-up's changelog.
Probably that wasn't enough.

So here is the cover letter that explains the whole intent:

https://lore.kernel.org/lkml/20261105163045.38862-1-frederic@kernel.org/

And the patch that does the initial infrastructure change to stop machine:

https://lore.kernel.org/lkml/20261105163045.38862-2-frederic@kernel.org/

Thanks.

-- 
Frederic Weisbecker
SUSE Labs

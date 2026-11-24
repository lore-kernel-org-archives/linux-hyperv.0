Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795560422;
	b=D2D9Nldzd3jtx2tif/o+9teZooW3HXKIhtFxIjDWA7/h637Mq+1mPz25NRUlRBKWQFVF
	 RmbsWJUUS2efd76JW7e+XpmleeL20pSdtGLQUdmm6BKQ/1ZqWAPcZ/itiYB1vB7sdtD2M
	 EkhPIQcvTXcrQKdV4IuIyQ/JE8TenP/K1M0hFDD6m2HFo5DhcdbYl6zTrGhk6tP4r5tfo
	 o3ZaZYaOOYJ+UiHtEgPT1KyFAU92AzDNQw12vKywjXNSz7kTzV4bGmeJlhW4o/Shmjy+y
	 9wGz9fbiVTMqDuJt5OtV2+klGAVJCYZrwpY5r2bLUrWxWBvER9BsI9QQuWb1+wIwjaQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795560422;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=QZbOIIEk7H0KKk4tYWFzvGM9t3bVkxuWdsBirZWAwWI=;
	b=kNWVxuQ+JeZf5qwYI1VzlBzay7dXl4OACGLvkworRJqpYa6oYDtHTkXkzzjez+Cd1/a0
	 byM7GL+eSHAzKAG6F0AeffB+jHU5D68TQzWoCZx8DTNlTgDNqAtYJaHplZAHIjxDK310V
	 q4cPpA6rYQEerxD5q4g43XhH2JEThXqgcNPjMzuprafCIAUYHkK1RHdrZXBsqWNHZP1xM
	 YWe8XBEnxTMApQ09LLlzOSxeRqFIRdOh2JEeJFuiYdmJHYlg+KYWiVuXo3bT6Q6o7NIy3
	 e/59u+qcjVF5UYqWKTHpWphv3zUaePnPVSIdIx4U8qOXse5T5OByhVVfVFB6DIt+uyA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AKHAcfxO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6419606A329;
	Tue, 24 Nov 2026 22:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AKHAcfxO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B3BE1F000EC;
	Tue, 24 Nov 2026 22:47:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795560421;
	bh=QZbOIIEk7H0KKk4tYWFzvGM9t3bVkxuWdsBirZWAwWI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=AKHAcfxO6i+/7bEGlMUHPQPM6+9hWjAF08IT6x3wKyjkSD7H3tPwAoyo0Tjt4/hc6
	 i7R7HzI/MIAuInFMR7hl/ABnLq+PWGCRH9jJYusRJ6ZdgKUbHz1Bgwob9PEdyPynqt
	 6cxVZSBgUP0gYOSbjJGN7UndprTHnxcirG1Ng7yzCSuNgcpf/wpJ9WZrCG/5FlwbTU
	 Bqu6J8kaqLxIh329hVGcB29PxrsNmhlGMy8UaGsNXFLOD3LPa2qMHc0HYY9r0Hihrj
	 T7USd9rhZr1+yGOuR/zNdZGbSN83FZasnqsuwsv2Dv6Iiv1G11KERPAv0r/md+BhYp
	 NmINzTpB7s19A==
Date: Tue, 24 Nov 2026 23:46:59 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Michael Kelley <mhklinux@outlook.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Peter Zijlstra <peterz@infradead.org>, Phil Auld <pauld@redhat.com>,
	Thomas Gleixner <tglx@kernel.org>, Waiman Long <longman@redhat.com>,
	Wei Liu <wei.liu@kernel.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH 39/47] clocksource: hyper-v: Move
 CPUHP_AP_HYPERV_TIMER_STARTING post stop_machine()
Message-ID: <awYT40A-Xgw0U-lK@pavilion.home>
References: <20261105163045.38862-1-frederic@kernel.org>
 <20261105163045.38862-40-frederic@kernel.org>
 <MN2PR02MB6863BD8055B08CA905B85980D4462@MN2PR02MB6863.namprd02.prod.outlook.com>
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
In-Reply-To: <MN2PR02MB6863BD8055B08CA905B85980D4462@MN2PR02MB6863.namprd02.prod.outlook.com>

Le Sun, Nov 22, 2026 at 09:26:45PM +0000, Michael Kelley a écrit :
> From: Frederic Weisbecker <frederic@kernel.org> Sent: Thursday, November 5, 2026 8:31 AM
> > 
> > Between CPUHP_TEARDOWN_CPU and CPUHP_AP_OFFLINE, stop_machine executes
> > all the teardown callbacks while stopping all CPUs in the system. This
> > doesn't mix-up well with running RT or isolated tasks.
> 
> s/mix-up/mix/
> 
> "mix-up" usually denotes some kind of confusion or miscommunication,
> and I don't think that's what you mean here.
> 
> The first sentence here talks about "stopping" all CPUs in the system.
> It took me some investigation to realize that you meant "stopping"
> in the sense that stop_machine() temporarily pauses all the CPUs,
> and not permanently "stopping" the CPUs during a shutdown, as
> x86 native_machine_shutdown() does when it calls stop_other_cpus(). 
> Unfortunately, the word "stop" is overloaded and is used for both
> cases. Maybe something like this would help clarify:
> 
> "... while temporarily stopping/pausing all CPUs in the system."
> 
> Michael

Thank you, I'm making those changes to the whole set.

-- 
Frederic Weisbecker
SUSE Labs

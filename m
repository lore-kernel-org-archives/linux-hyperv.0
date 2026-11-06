Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=13.77.154.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793959661;
	b=u9hgAPfB/aOORNWZNEQVjJkLlyYvgTxINc74X6ZwY57XKmHiHY4BheylbanSAMgkWLuC
	 psd4Jl5+LgcFPXNKeEcynPC5ycJSBW5YnrTw4iwV+e+iAtwekV/9y3i2eyf1AVfc6HZhi
	 rLUklKLX1E1hCNNsPdqX/U/r6DtSxQXNmKl0taxO8sIYdUUQ6xRQvdLXN+IcgyHv0iDJ2
	 PxAHQPBa/nzpfa3IRwL/jSTfWO+0n5q16SMuy4uWQw0C3VkkBx2F1Bcb/zan34k+49z8i
	 XFPDQXx9EyhuF9gkW0H+EEBpA/qpG5Cb7opVZCqf9X+a3RixQxM3+Jumli6/kl3QtqA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793959661;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:X-Spam-Status:
	 X-Spam-Checker-Version;
	bh=4KliYQLOkHRMH3GsBEDAYRnBw+vTw59dBjsCMzw0iYU=;
	b=CMSCDVcs92rWk/9bx4gdFnyGSUBsd7AqPsQ3YwcAclcOrvs3yHzju2g2S3nin7DLbH7k
	 vGmYflH4LEJFS7P5eKEQIfg1Yr1/D5iL4yzYLaVlFhQcH+bakVzpPjokd02m4kp2xWydo
	 9UWA3EsbD0OSp7vzoOvXmpjOn5PdKrNxbb0MGDd/nOkZIMMKdSexBg+mdBskvf2jnrOmT
	 nM5dT/AJMalz5K5MXVfTE2jRty90OZ7RSsR016e4M3g096mVgOJfW/nSo3onu8peQfhkt
	 c1K9jLETHuXAZpD5SbhyMmL4d1bUMO/Gxz/2XNpsf8PPVwY4du0FlLTxl4s3liV6hOg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.microsoft.com;
	spf=pass smtp.mailfrom=linux.microsoft.com;
	dkim=pass header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=k9eYQuQk;
	arc=none smtp.remote-ip=13.77.154.182
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C3B9606A326;
	Fri,  6 Nov 2026 10:07:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4C3B9606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=k9eYQuQk
Received: from [192.168.1.14] (unknown [52.172.102.187])
	by linux.microsoft.com (Postfix) with ESMTPSA id E477D20B7167;
	Fri,  6 Nov 2026 02:07:30 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E477D20B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1793959655;
	bh=4KliYQLOkHRMH3GsBEDAYRnBw+vTw59dBjsCMzw0iYU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=k9eYQuQkEYzlfycUHHEhM9p5wZCfuJAxVyAbYl5N4IHX5m3HkGBGcFASfj5X3rUbc
	 0PMffL/CUvRIbGv0jXHfOi68U+vMKDI9CL+OdvYZmFGSb3eVbwf2ymH8/m166JZj+H
	 Td2plXZZGDIkLnaUAdbungHOX6N32uzefqj99IZQ=
Message-ID: <da4937bd-542e-4a46-a5a5-35596572f5df@linux.microsoft.com>
Date: Fri, 6 Nov 2026 15:37:26 +0530
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Post: <mailto:linux-hyperv@vger.kernel.org>
List-Help: <mailto:linux-hyperv+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hyperv+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 39/47] clocksource: hyper-v: Move
 CPUHP_AP_HYPERV_TIMER_STARTING post stop_machine()
To: Frederic Weisbecker <frederic@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>
Cc: "K. Y. Srinivasan" <kys@microsoft.com>,
 Daniel Lezcano <daniel.lezcano@kernel.org>, Dexuan Cui
 <decui@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>,
 Long Li <longli@microsoft.com>, Marco Crivellari
 <marco.crivellari@suse.com>, Peter Zijlstra <peterz@infradead.org>,
 Phil Auld <pauld@redhat.com>, Thomas Gleixner <tglx@kernel.org>,
 Waiman Long <longman@redhat.com>, Wei Liu <wei.liu@kernel.org>,
 linux-hyperv@vger.kernel.org, "Paul E. McKenney" <paulmck@kernel.org>
References: <20261105163045.38862-1-frederic@kernel.org>
 <20261105163045.38862-40-frederic@kernel.org>
Content-Language: en-US
From: Naman Jain <namjain@linux.microsoft.com>
In-Reply-To: <20261105163045.38862-40-frederic@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/5/2026 10:00 PM, Frederic Weisbecker wrote:
> Between CPUHP_TEARDOWN_CPU and CPUHP_AP_OFFLINE, stop_machine executes
> all the teardown callbacks while stopping all CPUs in the system. This
> doesn't mix-up well with running RT or isolated tasks.
> 
> In order to transition smoothly from global stop_machine to finer
> grained synchronization between teardown callbacks and the other CPUs,
> a new stop machine post function has been introduced to be executed
> after the main one with IRQs still disabled while other CPUs can exit
> stop_machine().
> 
> The teardown callback here simply performs timer and IRQ disablement,
> both of which can run concurrently with other CPUs.
> 
> Move it to post stop_machine() accordingly.
> 
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> ---
>   kernel/cpu.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/cpu.c b/kernel/cpu.c
> index 93b8498e26c4..b49b67ef5ecb 100644

I am unable to correlate the commit message with the change and could 
not find the rest of the series on lore to get more context.


Regards,
Naman

> --- a/kernel/cpu.c
> +++ b/kernel/cpu.c
> @@ -1275,7 +1275,7 @@ void clear_tasks_mm_cpumask(int cpu)
>   static int take_cpu_down(void *_param)
>   {
>   	struct cpuhp_cpu_state *st = this_cpu_ptr(&cpuhp_state);
> -	enum cpuhp_state target = max((int)st->target, CPUHP_AP_TI_GP_TIMER_STARTING);
> +	enum cpuhp_state target = max((int)st->target, CPUHP_AP_HYPERV_TIMER_STARTING);
>   	int err, cpu = smp_processor_id();
>   
>   	/* Ensure this CPU doesn't handle any more interrupts. */
> @@ -1303,7 +1303,7 @@ static int take_cpu_down_post(void *_param)
>   	enum cpuhp_state target = max((int)st->target, CPUHP_AP_OFFLINE);
>   	int cpu = smp_processor_id();
>   
> -	WARN_ON(st->state != CPUHP_AP_TI_GP_TIMER_STARTING);
> +	WARN_ON(st->state != CPUHP_AP_HYPERV_TIMER_STARTING);
>   	/*
>   	 * Invoke the former CPU_DYING callbacks. DYING must not fail!
>   	 */


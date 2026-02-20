Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10247318EE4;
	Fri, 20 Feb 2026 04:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771560646; cv=none; b=f40DQUDMWPTl3gpaOj8cV3FnnBlHLoKqHaGSVqOSXOcvVetrjkuV7owHI492B7HfU14E8lhS1eceJOSxUv1QGIJeUSLlKGmWQkZOHO7nL47IHA6kcbBs9aXdXpqIVc30bH22I9DFGrzp46eKIADaL4EKSXIVTtuBpau6wAHyqSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771560646; c=relaxed/simple;
	bh=Db/wdfVcXsniMHB7ine8YIWTDXSl11tG9gQ8k5IjjLI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=oC0AiIANVApZnnv5/ZnhhpPkO+UBzBVWCC1Lkj1+JWH1OxPUdj4pIsrefn1HA0+fy5GM7j4A1DioPQj3W5/lmJsr9+Uzt5jxLYalJT1Iplcww9hWsrib9W+prZqMHRx7qXi4HlDqteACtTiCwMSPyCq8J2qigOsjJSSnRI1cfR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kr71DRur; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kr71DRur"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 986B9C2BCB0;
	Fri, 20 Feb 2026 04:10:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771560645;
	bh=Db/wdfVcXsniMHB7ine8YIWTDXSl11tG9gQ8k5IjjLI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=kr71DRurREHYrZUr3Iu8kBF3sP8Kd84HBgPzOFQul6k/zdt4cn+xGkSwn0Z2bqTfV
	 tf5GWnU3xbuMF1mRY2zfCfhwSJ3szrnd4MwQID7TlG/ObeeVfWOZaUAUN9KDzPtFXq
	 uy1Y74jNH9hfglIFadwb8ipRoBqsN6Uzgj+8SQxzFAonkiWY1FDYL7wgISg0RrCqCf
	 Ea0jKMmyz8PSk9M1AEvK0cx4T9JGn1EjDLxRkWlV1jl+wC4Rkuzikre+XGx59kvCUa
	 0nl4J1xMm2mAntv2sFs93qKoael3Itii9ExFq0zMW3WuUeG439WsT4vH4KO58AiK6B
	 bv8XfesBgFH7g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FD8A3809A88;
	Fri, 20 Feb 2026 04:10:55 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 00/21] paravirt: cleanup and reorg
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <177156065379.189817.4828097381020781784.git-patchwork-notify@kernel.org>
Date: Fri, 20 Feb 2026 04:10:53 +0000
References: <20250917145220.31064-1-jgross@suse.com>
In-Reply-To: <20250917145220.31064-1-jgross@suse.com>
To: =?utf-8?b?SsO8cmdlbiBHcm/DnyA8amdyb3NzQHN1c2UuY29tPg==?=@aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 x86@kernel.org, linux-hyperv@vger.kernel.org, virtualization@lists.linux.dev,
 loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
 kvm@vger.kernel.org, luto@kernel.org, tglx@linutronix.de, mingo@redhat.com,
 bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com, kys@microsoft.com,
 haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
 peterz@infradead.org, will@kernel.org, boqun.feng@gmail.com,
 longman@redhat.com, jikos@kernel.org, jpoimboe@kernel.org,
 pawan.kumar.gupta@linux.intel.com, boris.ostrovsky@oracle.com,
 xen-devel@lists.xenproject.org, ajay.kaher@broadcom.com,
 alexey.makhalov@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
 linux@armlinux.org.uk, catalin.marinas@arm.com, chenhuacai@kernel.org,
 kernel@xen0n.name, maddy@linux.ibm.com, mpe@ellerman.id.au,
 npiggin@gmail.com, christophe.leroy@csgroup.eu, paul.walmsley@sifive.com,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr,
 juri.lelli@redhat.com, vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
 rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
 vschneid@redhat.com, linux-arm-kernel@lists.infradead.org,
 pbonzini@redhat.com, vkuznets@redhat.com, sstabellini@kernel.org,
 oleksandr_tyshchenko@epam.com, daniel.lezcano@linaro.org, oleg@redhat.com

Hello:

This series was applied to riscv/linux.git (fixes)
by Borislav Petkov (AMD) <bp@alien8.de>:

On Wed, 17 Sep 2025 16:51:59 +0200 you wrote:
> Some cleanups and reorg of paravirt code and headers:
> 
> - The first 2 patches should be not controversial at all, as they
>   remove just some no longer needed #include and struct forward
>   declarations.
> 
> - The 3rd patch is removing CONFIG_PARAVIRT_DEBUG, which IMO has
>   no real value, as it just changes a crash to a BUG() (the stack
>   trace will basically be the same). As the maintainer of the main
>   paravirt user (Xen) I have never seen this crash/BUG() to happen.
> 
> [...]

Here is the summary with links:
  - [v2,05/21] paravirt: Remove asm/paravirt_api_clock.h
    https://git.kernel.org/riscv/c/68b10fd40d49
  - [v2,06/21] sched: Move clock related paravirt code to kernel/sched
    (no matching commit)
  - [v2,10/21] riscv/paravirt: Use common code for paravirt_steal_clock()
    https://git.kernel.org/riscv/c/ee9ffcf99f07

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



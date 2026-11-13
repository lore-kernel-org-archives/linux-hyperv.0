Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794577934;
	b=W7zXGk2wZAwq7D3nO42CbI91OezImwhE+I/CF1b0WG0USdC66oCpzAgJOL0qneYEVaXJ
	 JUCZABOLUXIs6iOrEe/CzvAwfnuFBk2xMK6PuGTueJJekdTURJkCKdhdMZiSccpHvpXmy
	 uJN7qsKDtxPHG0MGJpK3VpwiIQRGJlthgkFHWg73TEXUdVllpVp2UwDiSRO6LDFkt3G5h
	 iuBC2s+BHhhQAqBghbzdCiQQVUa5c10Or3C/fOnKsk94rpjxaHXdimICEWMn+x0U9GPDn
	 0+Tx0QeOihCiIWGffb7kcimNP8KO6REDmqJMAhWKfB29S5TFYp3YlT4kQb4uiSBhhRQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794577934;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=MlPSuCq58e3P4npzO9nCJTYzKVXM26Cp2n+6yfohh6Y=;
	b=wZGJNVX080c+SvKHCFhUdQoQDjpljOP0kW5Udee2yG14VAu0KHOYxT+25mViWDXBPWZA
	 WVforDFC5OR3hVTClv170qLZg1Eqc89XwFiC1G0DrLjsZUijQUs9SpNXZDU83LrmAn010
	 iEx9PfwAhh2hVcFCPQuJsOplFwHKPbMi5YvS8QcbSTiWJ3wb6hHafXO0GXoe2FHO/yY/f
	 k0snC0uYks5qMf7NAAijrsj00UFOjORsJqwerIF95xRIDyxqds5jFrYkFp2YjFU0uAtog
	 CVMcefAGfSL2t4wyQTEWx8YU6puJSxdeevJESFql2ct2TsHQA0/G0MSgwtGOS0XHZmg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=TKl1Fpo0;
	arc=none smtp.remote-ip=209.85.214.200
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 814BB606A89A
	for <linux-hyperv@vger.kernel.org>; Fri, 13 Nov 2026 13:52:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 814BB606A89A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=TKl1Fpo0
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2ed077a15c3so8454105ad.0
        for <linux-hyperv@vger.kernel.org>; Fri, 13 Nov 2026 05:52:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794577934; x=1795182734; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MlPSuCq58e3P4npzO9nCJTYzKVXM26Cp2n+6yfohh6Y=;
        b=TKl1Fpo09aGy2X/6g4rqWMCDe6yRsGaCn4ziqqMCt/0BCllTEK/txyF3L+0dqyNWoz
         5Od1dnzxNCQwBS8yxStc6Dq1GcvuI6UEk4Hz/hDG8HdhemvzD2ZpS2Ahjaz5Ct1n9uYy
         eo4xcF+LWNWzWMMKinYUDIT2hG4FZ6FYvdm9oc8mK62op1pxfBXjX7tfJk8krceQYyXI
         iMCjPO15xuUmL4/iZvf8rvSS3pp2FMKWpSOEPzGx6/w5ODk7vyIO0siRPUcts7X+6Wv0
         2pLEokDE8n1HY+Mj0PuxRg1JqaDpKeeG67RL5mUYgtVa7vLJRD34hMsFZmZ0KhkgSAnK
         qi5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794577934; x=1795182734;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MlPSuCq58e3P4npzO9nCJTYzKVXM26Cp2n+6yfohh6Y=;
        b=Hu5Uq1mrX3GFs2dc1D+5OD+Xfi2E0Ixi3UBr6v7YSRio8iSSN8hRq1HsinS7pAsClt
         waSbH1kyP6ok9HsFjBdJoX8qsn3PAoRphp8Hq+DF/W8U/peX1M6DG6X4AkeT/axknC1+
         mvxPDGz7nU86nTxAYYcWe6dDU67MIJ9ceTzKLU5ZyX1I+bWdfvMk8718Ym0/MIeTwcjC
         YGF9z6d8zGBSw7lHDNjuMhcARUqZ39uOYoKfWFHHyAmC6BPEwCABk/xXVFcCAWNqx7c0
         LHXNGQUeHq0/cq8/zl099MEijYV7z3wOzqCbeOwtbSjpIM4C92g1ottF+1D1rcLPmZJB
         CuqQ==
X-Forwarded-Encrypted: i=1; AL+hErHPeL91F3ds3/YKcaThHdzRgR/AswtygCPfIDKunUBRoGdHpvE9hGOmMr/s4OYpbFh2k26T3cHTcdEw9wI=@vger.kernel.org
X-Gm-Message-State: APuU4Z9rulDHQcHytF51/mnu1RIFT2kPZmMFKUxeApEuw29PdBPIadp6
	Ipc06Vm/P3+8TzZyj9tJhNU8DcQJ5aKuxvd/J6alxaX0KF7JJ2D64m7prslmSfprhkhAnenOz55
	3WlRr5g==
X-Received: from plly20.prod.google.com ([2002:a17:902:7c94:b0:2e9:4ce7:154a])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:da86:b0:2ed:1fb0:7784
 with SMTP id d9443c01a7336-2ee0da7bd5fmr24791955ad.10.1794577933550; Fri, 13
 Nov 2026 05:52:13 -0800 (PST)
Date: Fri, 13 Nov 2026 05:47:27 -0800
In-Reply-To: <20261005192431.87317-1-hmushi@amazon.co.uk>
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Post: <mailto:linux-hyperv@vger.kernel.org>
List-Help: <mailto:linux-hyperv+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hyperv+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261005192431.87317-1-hmushi@amazon.co.uk>
X-Mailer: git-send-email 2.56.1.703.gf848ed807c-goog
Message-ID: <179441831766.81610.17390734527567827315.b4-ty@b4>
Subject: Re: [PATCH 0/3] KVM: x86: Support hibernation of a nested Hyper-V
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, kvm@vger.kernel.org, 
	Mushahid Hussain <hmushi@amazon.co.uk>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	"K . Y . Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>, linux-hyperv@vger.kernel.org, 
	linux-kernel@vger.kernel.org, nh-open-source@amazon.com, mushi.shar@gmail.com
Content-Type: text/plain; charset="utf-8"

On Mon, 05 Oct 2026 19:24:28 +0000, Mushahid Hussain wrote:
> A Windows guest with the Hyper-V role enabled runs its own hypervisor
> (hvix64) nested under KVM. When KVM advertises the Hyper-V time and
> frequency MSRs, hvix64 lets KVM own the partition reference time. It
> then offers hibernation to Windows only if KVM also advertises CPUID
> 0x40000004 EAX bit 20 (RestoreTimeOnResume), and on resume restores
> the saved TSC and reference time through HvCallRestorePartitionTime
> (0x103). Both are reserved in the TLFS and defined in Microsoft's
> hvdef crate.
> 
> [...]

Applied patch 1 to kvm-x86 vmx, thanks!

[1/3] KVM: nVMX: Clear stale vmcs02 sync flag in free_nested()
      https://github.com/kvm-x86/linux/commit/ef289f270c59

--
https://github.com/kvm-x86/linux/tree/next

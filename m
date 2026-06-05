Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 616A42DD5F6;
	Fri,  5 Jun 2026 12:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780663033; cv=none; b=tn4AGKWuf9FJaxFr2aLdfNj8I9kQSsXz+eXTDsD7TCEUFBYNRJsT+UVoc/HJw8c7x3iQF5nKEIp5os7MqfidtbqGmUevTtz7cLLdB125eAcLSO3bKbofauYuk/nY1u0Kc1KEXaWFuvMadgIrRe3KIu/Xy1s5dZ9/S4Jy02NFDu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780663033; c=relaxed/simple;
	bh=TFOjSSeqouMOXYAq3kZ6xmLXWL9r5HaIy07YjxMF+yk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qpQwj67Zs5sNd0DtXi5qQ6BKpSq1pmIMh5xifINHK63j+5sgYF3qXWBeZSYfCNxGA8BZw41+/NyTY3ztfPFORMt19uamDwUF2d0wB1njD6a5wy6pX6xymAGoEJBcSG2iTqdK+5iplY87ajAAcW/qSorSZOYXs09zBqXbYMz6xSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YEmTZWq3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YEmTZWq3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17B0B1F00893;
	Fri,  5 Jun 2026 12:37:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780663032;
	bh=5W6FiCPw6sX6Mb9wMs7Y8uennTDZr6e1xX3L0BW5MJY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=YEmTZWq3dmUMH12jc/DFu/P4OzcULMgWKzk+y8GZ2rhlb8n7qhyCDBCHw3xHKlFm9
	 KVFiUJuI8WqYf4gVlg0KIfDVESYWvU9coOvSXxaaEpQGfqw86+RrMazwrYVG7phoWz
	 8ULdotuRnveudrTehApXe/p3rsX97IhOHfDklWPuNSP8QP7jgjeqf9ReklwS9qgISR
	 s6UYCikKByY1nzH3/pR4dS8lA5/wXlDQiziSmJdE2KUBdAvlGGUFeSOJ/pgA9SUGOA
	 QKppWOWpDZWGMhV4kceQk+T/u8V6Uy/xLJZAj2+XZUEShBrRSDpJ+Eq5uMTH3UgVmT
	 lWqJi0DUTsDgQ==
From: Thomas Gleixner <tglx@kernel.org>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
 <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 Kiryl Shutsemau <kas@kernel.org>, Sean Christopherson <seanjc@google.com>,
 "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang
 <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui
 <decui@microsoft.com>, Long Li <longli@microsoft.com>, Ajay Kaher
 <ajay.kaher@broadcom.com>, Alexey Makhalov <alexey.makhalov@broadcom.com>,
 Jan Kiszka <jan.kiszka@siemens.com>, Andy Lutomirski <luto@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Juergen Gross <jgross@suse.com>,
 Daniel Lezcano <daniel.lezcano@kernel.org>, John Stultz
 <jstultz@google.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Rick Edgecombe
 <rick.p.edgecombe@intel.com>, Vitaly Kuznetsov <vkuznets@redhat.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Boris Ostrovsky
 <boris.ostrovsky@oracle.com>, Stephen Boyd <sboyd@kernel.org>,
 kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-coco@lists.linux.dev, linux-hyperv@vger.kernel.org,
 virtualization@lists.linux.dev, xen-devel@lists.xenproject.org, David
 Woodhouse <dwmw@amazon.co.uk>, Tom Lendacky <thomas.lendacky@amd.com>,
 Nikunj A Dadhania <nikunj@amd.com>, David Woodhouse <dwmw2@infradead.org>,
 Michael Kelley <mhklinux@outlook.com>
Subject: Re: [PATCH v4 02/47] x86/tsc: Add a standalone helpers for getting
 TSC info from CPUID.0x15
In-Reply-To: <20260529144435.704127-3-seanjc@google.com>
References: <20260529144435.704127-1-seanjc@google.com>
 <20260529144435.704127-3-seanjc@google.com>
Date: Fri, 05 Jun 2026 14:37:09 +0200
Message-ID: <87cxy55fka.ffs@fw13>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, May 29 2026 at 07:43, Sean Christopherson wrote:
>  		cpuid(CPUID_LEAF_FREQ, &eax_base_mhz, &ebx, &ecx, &edx);
> -		crystal_khz = eax_base_mhz * 1000 *
> -			eax_denominator / ebx_numerator;
> +		info.crystal_khz = eax_base_mhz * 1000 *
> +			info.denominator / info.numerator;

Please get rid of this ugly line break. You have 100 characters.


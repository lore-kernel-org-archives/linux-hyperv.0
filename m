Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792566985;
	b=WSQdj/eFu1LYo8MUv23lyHIkqqC/YerTwVp7lCOefunmV9Zxb43UmY8nJWZuSU6Ysw+N
	 1COiW2lNI1p1MT8cKtdkeUjqRouzSeUyS9OQT+CWbltkVK/04fcKuijWAX5vVcXbp/KSw
	 A22OwehMCi0yQemSb9cdHhRSwTM4662tXEkrgRF+zD/vSCqL8GCeamyT0o7sItiKkhmgT
	 e6JLU7/FdRxH7o+Lu7XtbEo6uWplqVUQIcwfg4wEcsbVGNY6Yfrypx8Vnxm3o1qnXNFZe
	 tpHgkLI/kHvxFRYrBl1eZ/wqET7KM0QaWyTfSJryjwtNl8fktEOmj7XwmePAwsLgu2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792566985;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=IcAo2Ym8uMAFU/7ijn4ad29pcAenhcyHv2jg95iqaaI=;
	b=iUduxHNicF1NQ/xv1ywwc+SutawdCU3IlCeR6LuTtLumNCJPInwUDNpXAAiMz+r/WgLT
	 JnN5mm7nDhGCfUz2v/+JMK+P46ytYc9r5Eihv3aWNB9bg3zB64i4iplialXjHIjmkWVAd
	 hyLXfskoa3eW3qERHMgAWIpewz5GdS0aZnAQrzKHwtrPkTxRAMc7KO/7Tmk9BEB2gcnVk
	 MurIgh1XOH0P7qHk3KlhoYNPZadyg5qKlAfCAQZsWnGn+gzRM7UzQW0+Brfj+rRA05wkG
	 ftcoHkqipKc0tSW6CcIsunaHZT0DHD28XG1dl2nxDVLEzRF7iUf09ygZbazs7aea4jA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AftNe2BQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65DAA606A319;
	Wed, 21 Oct 2026 07:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AftNe2BQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC6C31F000C9;
	Wed, 21 Oct 2026 07:16:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792566984;
	bh=IcAo2Ym8uMAFU/7ijn4ad29pcAenhcyHv2jg95iqaaI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=AftNe2BQHKHIY5Y1u5PW9ziV8R9pTS7jlzux8OYrQ+mi2+wxWfTKoPiswu0miCzYN
	 88y7rLKkNwtmxpBcbGOARubnZEUF7hYr+RHWBNyAVjTuTzbM82ppenFDdXzeNtd2nt
	 GFRzQscMuY6h7pXZPctLCSbHbeVeA5GEZbcXRjfQTDfIc5GGioRvhHtyhTmpSKXZJK
	 JE5N9wGVV31UinYn1Wn3rBa/cpBW+7nyKbBQL4QinMGTJyJ3AP3mLqICwCA2LDBYwN
	 iUteUg8bshLleQAgbGlYFWj6Ns/2Sf6ANw4ZaIvXTj9r6xslR2gbU6PH8B5DfTsXuf
	 lzi+dSW+XE2wA==
Date: Wed, 21 Oct 2026 00:16:23 -0700
From: Wei Liu <wei.liu@kernel.org>
To: Sasha Levin <sashal@kernel.org>
Cc: "K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Mary Hardy <maryhardy@microsoft.com>,
	Saurabh Sengar <ssengar@linux.microsoft.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: Re: [PATCH] tools: hv: remove unused rte_smp_mb()
Message-ID: <20261021071623.GE851443@liuwe-devbox-debian-v2.local>
References: <20261011223358.2327625-12-sashal@kernel.org>
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
In-Reply-To: <20261011223358.2327625-12-sashal@kernel.org>

On Sun, Oct 11, 2026 at 06:33:40PM -0400, Sasha Levin wrote:
> rte_smp_mb() has never been used, and its "static inline __always_inline"
> declares inline twice, so clang warns:
> 
>   vmbus_bufring.c:61:15: warning: duplicate 'inline' declaration specifier [-Wduplicate-decl-specifier]
>   vmbus_bufring.c:62:1: warning: unused function 'rte_smp_mb' [-Wunused-function]
> 
> Remove it.
> 
> Fixes: 45bab4d746510 ("tools: hv: Add vmbus_bufring")
> Assisted-by: LLM
> Signed-off-by: Sasha Levin <sashal@kernel.org>

Applied.

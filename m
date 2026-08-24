Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 542881A5B9E;
	Mon, 24 Aug 2026 00:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787531635; cv=none; b=MdnVX1kH0MrRVq4Wtxh2GnBZRY34yqLVWLg+tveEYRx6VdY+mEjAiBECflWN//ITQ2WLECDuaCvbsYZUb0/rx8yPYxjH80W5lzOJ7f+IQPZmzRvZieqWsZPrx5T4EGATkXjmmmfwWHfqE15ZVueDfL7ArWoaepSPtVDH7elaleY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787531635; c=relaxed/simple;
	bh=vimA5frroaQop+gXI41yK9tc5h2nhZEBmvU9pM8fauU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AZsUBjPe4Fj/YUTIgYVo55uLkPtsX9Zbcdwxn/EbmYmYLRncQTxaWHuazYIZFzsudW2w1fUlGcFVX+KByfTzyrGqPBvGMrYX8eWKNlunP4gjxb/b/+Sv3Gi7OS4bZhTbuKKkEmCcYEBn4ir9eRYwKCBWthCGW9tsc8WtiT4rWnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mc3fYX3J; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mc3fYX3J"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B00281F000E9;
	Mon, 24 Aug 2026 00:33:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787531633;
	bh=XQkd3Eue/ZIdgnMLrwU4Ac3/VNF9X2y1wQVURMKty/U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Mc3fYX3JfNIqi8ut9jYk0TLNjfmWb79fdBzdSmRhfniW8jEUITPHfZWizkO5NLQgi
	 8N3hyTY6n6LLqgq0woG+x6wNp01e48yzcUzimfoYDxoFwpweBODAbClwxAZtpi3bWD
	 Bd2ltfqaMFCib8tATIlVzi/Ldu/z1uUfGr3v5zbrnQBtWQBn9dBYOrKHiw0PvONd6Q
	 XSJ4cgE4LDBlGvEjuMPwAlhUA9QkAH9q0H27qwr6oqgmjZACce+8rAq8Q1EAoL3IkT
	 WEguWZ3FxzCEuL5pnbNvc154oEiG7nAQQ6+hj9CHWmHZymAH1MPyAK3WZMysFncGd4
	 +d2GMMnDw0qvw==
Date: Sun, 23 Aug 2026 17:33:52 -0700
From: Wei Liu <wei.liu@kernel.org>
To: Kameron Carr <kameroncarr@linux.microsoft.com>
Cc: decui@microsoft.com, haiyangz@microsoft.com, kys@microsoft.com,
	longli@microsoft.com, wei.liu@kernel.org, mhklinux@outlook.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH v4 0/3] Drivers: hv: decrypt netvsc buffers on contiguous
 direct-map addresses
Message-ID: <20260824003352.GH3566091@liuwe-devbox-debian-v2.local>
References: <20260811160447.2529876-1-kameroncarr@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260811160447.2529876-1-kameroncarr@linux.microsoft.com>

On Tue, Aug 11, 2026 at 09:04:44AM -0700, Kameron Carr wrote:
[...]
> Kameron Carr (3):
>   Drivers: hv: vmbus: add vmbus_establish_gpadl_caller_decrypted()
>   Drivers: hv: vmbus: Add vmbus_alloc_buffer()/vmbus_free_buffer() for
>     CoCo VMs
>   hv_netvsc: Allocate send/receive buffers using vmbus_alloc_buffer()

Applied. Thanks.

Wei

Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792567824;
	b=2yME9hMIqLFL5DPxQYdphVQaYgiLW+JfvZCTtMQ+kG2fGzfw+79OYzaDUcS+TI+8O+SG
	 j0vAdj9buRnfDye7qPnboNofMwPAHZACvOI3qW/439YZuYZ04cgxU14J/1ls+qlY/wBeh
	 Y3XCevV8FaJ+xaqZXEvuAcDOWa6RQQTaudlf+Sw00Ar75CN5OtZAV0Vi1kqQ+X09k6PfJ
	 Smnz3u8mO+Q00rwahLmQzh5nv/ckPby6M7FzyzThBIj/GWuWKJ1P6rBEN6CT6gTXATifP
	 Idc/mc3YT69eCmWaxFQqaY4xyqpQ+049x6nHOUtaSUZ2HmVD8mD6Cjc1SqCItRszUSg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792567824;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=zrEtDjy2R5IthbLoIfecjROqMlYBPHXFdVWJppSjRJs=;
	b=1EEi2MN4ZniC+7LIa+y0m6yGowU7LAObfOXq28oDiauVRjEKqBUB4JtdWWyST4O4dJu1
	 y36YUkaido0+Ks1VZNKEHsNTuaUmVrjq83mmDH63iodHkk1B4qu0TE396QqbxyeAu4cJW
	 onkK/1xi45Pfy/dNl1+keO6K5fbB+9yhfOcEMQvRuvDMWJiupdvbGLrMxK6qL3WTa5IuQ
	 a8XlHeoW9uGm+hZT07yk+AmkH+LYZ8w9XRO5COq4pwbsG6vUQYS+Rq1TZCvVId9EO5V+R
	 TrvPjTOifZMlkNeDiH2+U7YYogTKoKVlSQblTWzxEeOULK45F3MtCODDUfyiWfAOzzg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OOd9qvxG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 982EC606A320;
	Wed, 21 Oct 2026 07:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OOd9qvxG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7F451F000C9;
	Wed, 21 Oct 2026 07:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792567824;
	bh=zrEtDjy2R5IthbLoIfecjROqMlYBPHXFdVWJppSjRJs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=OOd9qvxGvI7JABZhNxoWMHV/Qk0ypc1s5mqoDsZCX1o06ECGO7xZY+PuNW90JG9fb
	 ahuvGvCCYoN++0Q5ecwyYHjdJ1Xnopir6+wW9Km8B6XCt9r3X+iXwUhgxN2TCFiCS3
	 41IsdOzh0MLsT+MEchPmkjh6FRy3uAQOEwJRjOU/DgDm/7mXDcR7C8M4YhiZq92Sbt
	 fPcoKFgjJJoaH7zjc1q/hVYx7hcoIY08uSikodnlHcS7mCnPyBU6McXvQBZkwHqzqN
	 BsepB2DQUWWKM0RB7Lg5NfYu1MuotW2vrpKF27zsj0r53vHfAznNO72WwL3xTHnFmX
	 uiNc8HlwU9ycA==
Date: Wed, 21 Oct 2026 00:30:22 -0700
From: Wei Liu <wei.liu@kernel.org>
To: Magnus Kulke <magnuskulke@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
	Magnus Kulke <magnuskulke@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
	Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>,
	linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Souradeep Chakrabarti <schakrabarti@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <liuwe@microsoft.com>,
	Anirudh Rayabharam <Anirudh.Rayabharam@microsoft.com>
Subject: Re: [PATCH v4] drivers/hv: remove deposited pages from direct map
Message-ID: <20261021073022.GI851443@liuwe-devbox-debian-v2.local>
References: <20260930121047.19993-1-magnuskulke@linux.microsoft.com>
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
In-Reply-To: <20260930121047.19993-1-magnuskulke@linux.microsoft.com>

On Wed, Sep 30, 2026 at 02:10:47PM +0200, Magnus Kulke wrote:
> hv_call_deposit_pages() donates pages (deposit) to hypervisor for L2
> guest on L1VH systems via HVCALL_DEPOSIT_MEMORY. The hypervisor takes
> ownership of those pages and per contract revokes root partition
> access to them, raising a #GP on access from the L1VH root partition.
> 
> However, the pages remain mapped in the kernel direct map, so kernel
> code may still access them even though the hypervisor has revoked
> access.
> 
> Helpers such as "load_unaligned_zeropad()" deliberately read past the
> end of a buffer and across page boundaries. A read into an unmapped
> page is tolerated and triggers a #PF, for which the kernel executes
> a fixup in the exception table.
> 
> If such a call steps into a page that has been deposited, the access
> raises a #GP by the hypervisor from which the above handler cannot
> recover and the kernel panics:
> 
>   Oops: general protection fault, maybe for address 0xff1100941a3dfffc
>   RIP: 0010:csum_partial+0xe5/0x110
> 
> This condition will appear on L1VH system that have created L2
> partitions (and hence deposited pages) and exercise networking code
> paths such as csum_partial() can trigger this condition when a buffer
> ends close to a page boundary (e.g fffc in the above example).
> 
> The fix is to remove the deposited pages from the direct map before
> they are passed to the hypervisor, and restore them when the hypervisor
> returns them again.
> 
> We want to avoid flushing the TLB in the loop, so we use the _noflush()
> variant of set_direct_map_valid() when marking a deposited page invalid
> and flush the affected page ranges in one go ourselves. In the opposite
> direction this is not required:
> 
>   > If a paging-structure entry is modified to change the P flag from
>   > 0 to 1, no invalidation is necessary. This is because no TLB entry
>   > or paging-structure cache entry is created with information from a
>   > paging-structure entry in which the P flag is 0.
> 
> (Intel SDM Vol. 3, 4.10.4.3)
> 
> Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>

I changed the prefix to mshv and queued this patch up.

Wei

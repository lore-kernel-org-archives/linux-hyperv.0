Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792569275;
	b=VU8oGQ61ATfmOL2ZigH3KUj7MQTQpclgu6X+0jGHUZ0cvy8K6c+9dHdNU+wQ5kf2CuTg
	 S3puTvCkSANTThDAlQNLas2lCjC4vtUjSPdNWhByuxYhevqt/SGrna8gkknSBPo+JRePR
	 h6umJS/4ZgAzH8+QmfGUJwhO+tPOHxLF4MNYeUacciqgZkEdQIxAb+GRC/AyGHuJ+tCDP
	 bk8WdOi/b/f80nAC8HZLsDfFsw/rxL+bHzrSrbYpGIlaWTphHMHk2U4l2FgoOtuzK7RH7
	 h6qmleAQj2bv0kVRNdJuD1hhC3Q4/I2jmP4eaps/bNxM/vJlpZ/NXQ+PgG5gjV3nmhQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792569275;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=P5jPyrsipjOZRyAQQJ7dr7r5vLtteQsHq4fMoXGpg2g=;
	b=yxmeYI3mf1/okmrme3ONAbweaWKlqr3hMEQLlxkYCj3x8CQI3Xu+Su+gQx2vLqg8u7cD
	 auAf+/nBWuCH/+FBenV59HIR28KKkNg7+TkwaVr8Sb6wn0X0qIfOFBcGjKTY03ZGhEBSC
	 jZgNkv2MV7BGSZ8twSd4lWP+e1oVVj9LUgV7fE1dwhhb/bn7cL8NU4NYBaYB5doDxPmYr
	 oNGUEa2jWYIGms4KRc/3aCXX+UTcEYP6PETujQdu5DUOIfqhN3WWdxjvQZAVJmq7sIkLt
	 J2e7alPeO/M06ny3bzXw6Kft+f7l5SU+V1QCWuZGdv9zh3eAKsGwri7ZbT+jxIna3PA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UZ86Xyzf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38057606A319;
	Wed, 21 Oct 2026 07:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UZ86Xyzf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D75A1F000C9;
	Wed, 21 Oct 2026 07:54:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792569274;
	bh=P5jPyrsipjOZRyAQQJ7dr7r5vLtteQsHq4fMoXGpg2g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=UZ86XyzfhwNabrc+QWFmxGXjzb7EhgJUd1pofbSnKz48KeQijP6qHrA8/F+dPSHe0
	 OkCsfPUFRcJhka442PrynUwtbz/LZnrC6nOAim5D42vLkXJ8WVWjnF2cmPOewyAEUz
	 4RXtwdlT9DU053wSmzojk4NTsrD6gzkgd3fX1QcIPy5asJuI4msw6AoJSes1AkU6vm
	 nlR137b35oqUnoaqK+I1XKh1gAEj5oHuJwviS0PzQttPTJu5N4j9bGYB0M2rey510H
	 5JiNNGep/ZSbXp0RnbwfzfTVybeOcM7XXfy1+UzeyJiv4u23W+ewaAkwTWdy3ow4tS
	 d/SGEVdZCoNbA==
Date: Wed, 21 Oct 2026 00:54:33 -0700
From: Wei Liu <wei.liu@kernel.org>
To: mhklinux@outlook.com
Cc: haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
	corbet@lwn.net, skhan@linuxfoundation.org, rdunlap@infradead.org,
	linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH 1/1] Documentation: hyperv: Update information on guest
 CPU offlining
Message-ID: <20261021075433.GK851443@liuwe-devbox-debian-v2.local>
References: <20261017160848.14730-1-mhklinux@outlook.com>
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
In-Reply-To: <20261017160848.14730-1-mhklinux@outlook.com>

On Sat, Oct 17, 2026 at 09:08:48AM -0700, Michael Kelley wrote:
> In Hyper-V Overview documentation, remove the out-of-date reference
> to explicitly reassigning VMBus channel interrupts before taking a
> guest CPU offline. Instead, reference the VMBus documentation, which
> is already up-to-date on this topic.
> 
> Signed-off-by: Michael Kelley <mhklinux@outlook.com>

Applied. Thanks.

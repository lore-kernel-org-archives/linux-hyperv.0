Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CB2933B6C2;
	Wed, 18 Feb 2026 23:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771457706; cv=none; b=YyRIgVO59ogY7EEER0Tvui1TICegW7xXSCJz6UfdccnpyzvkiQMlJKU+zCuS4iO3A4yz8wVht1waFXGFBLVDYg3dotacifajrvnpBWwwD03XFAaVvqmER96l2+lwh05AeKPdyd7ac2BAXmSqPbuGqY8kaJQ2lYLvkaaB6Rdtm8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771457706; c=relaxed/simple;
	bh=7nOcJw8iXpNyTXv/EY0f+wOoUn/x+uXLeBRt8DqYABw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MsRFstIkWNdPyPu2ZySY4Yh1QdgmQ3N/b9QjFpGS1sh0nrZWJLMfIHpBBcXbeRi+MV1JecFA1rPQGHf57CR9zuV0DkSoDNUc+Li7n1N52zoUbE61PoEBaz/+gMWnWxjUGO5ntAovpDyv4HteuN1Oadnefx4rDuq4ZjoStfigqnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LoPCYqn+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LoPCYqn+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91770C116D0;
	Wed, 18 Feb 2026 23:35:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771457705;
	bh=7nOcJw8iXpNyTXv/EY0f+wOoUn/x+uXLeBRt8DqYABw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LoPCYqn+arQwAH8kW9HZqhFO04q/4rACvjOFSyYbUeyXJ7MNE4jYdbynQ8htTxlXX
	 02J/eT67K6HXYdh7r8WmIKL2eUtUWWC50xR0VXGZEot3sEbc6eg+whqKf6r5b9sn7r
	 iuKVsbrZLLlyn1ynZ4zgr7hB4SuFX7YQe5PziZoJQ9pk9jGIdtXkELBLfa3Y/7IY+4
	 8QfD8m/ttYLcaTeCZ0m2vJBUeQDqKyytxGKf/epr8dt5SBOTYbrDX6C7Cu9B1RiJ6I
	 igWa0PV3avTj9o/fU7/SyRbydhs4c0q/razNxZv7WGp1xX3sa9s+GwUApOY8ntxYMo
	 At4HC5kGhz0JQ==
Date: Wed, 18 Feb 2026 23:35:04 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Magnus Kulke <magnuskulke@linux.microsoft.com>
Cc: wei.liu@kernel.org, haiyangz@microsoft.com, kys@microsoft.com,
	decui@microsoft.com, linux-hyperv@vger.kernel.org,
	skinsburskii@linux.microsoft.com, magnuskulke@microsoft.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mshv: expose hv_call_scrub_partition
Message-ID: <20260218233504.GM2236050@liuwe-devbox-debian-v2.local>
References: <20260218141911.555592-1-magnuskulke@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260218141911.555592-1-magnuskulke@linux.microsoft.com>

On Wed, Feb 18, 2026 at 03:19:11PM +0100, Magnus Kulke wrote:
> This hv call needs to be exposed for VMMs to be able to soft-reboot
> guests. It will reset APIC and state of para-virtualized devices like
> SynIC.
> 
> Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>

Applied to hyperv-next. Thanks.

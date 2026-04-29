Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DA333B4E9C;
	Wed, 29 Apr 2026 22:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777500955; cv=none; b=YUJkdC+x9bV45tl8kK1UdopTnOW4AX/mHXQ6sBgSmEQPlJ+z7AzOSf2QXfSK2uJXugPG5l1SRVYQUk3332B7aJTBnBGFy9ap/MJIbEljesVVYapWptGr0oHTzHdpR8bJXd8T+ilb6u0Le9ttlRl0LzZzjwy8bcwGnPiTd/UnhQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777500955; c=relaxed/simple;
	bh=23SpWJVP6Hhf3lV5eWMyeLwhcPxcDI6P6InYG3r/Dmg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IzZyLno9xO3z3vP45p/2ddTceuJIijeUcNNKGvoDBb1eMGrg+hDSsi3x5qpMWYOkRYJG4Zs1+2g0h7ug/cNoPmtdd+l2+Uo3BEEdsoB3SVZM1L0N2w8Nz2uFAS8XP4R81JtlXmS+KL/sAFnqClfBQvFGc/ENu0HxqLgY2H5cj48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mmbw5iUt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mmbw5iUt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1DA8C19425;
	Wed, 29 Apr 2026 22:15:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777500954;
	bh=23SpWJVP6Hhf3lV5eWMyeLwhcPxcDI6P6InYG3r/Dmg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Mmbw5iUtw69JM0muc7FUpK8hOWm9gsgVZgR3slmQTv/R+5dr9amF3NxjTshNvIFv8
	 1SARvbjfk5LmW797539TqsPl0ciI1ZmtbxHQuPY2FUnPqD1oBYEjcDRzFywdtG/q9e
	 K1LvZ7eVBZ+BGlJlbJZgB2SKOwuNHroHRgigeewKhUE7+w6SF85M+a0YJ5/M8Slhdq
	 pmJ8IQy/8DUyARw+tDkonEOOeNbhEwVK6S3mM+qAq34ndVArPQIowubwxsZo5udLKX
	 4qHEna0q428Sh+op+O4bJfQPd1Ju/AQCTTFNnhPyRa2ioWAUT3InYmbjdnRcSaYBtt
	 yGlfvoV9wO/gg==
Date: Wed, 29 Apr 2026 22:15:53 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: "K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>, linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hv: utils: replace deprecated strcpy with strscpy in
 kvp_register
Message-ID: <20260429221553.GB2584450@liuwe-devbox-debian-v2.local>
References: <20260428171104.591947-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260428171104.591947-2-thorsten.blum@linux.dev>

On Tue, Apr 28, 2026 at 07:11:05PM +0200, Thorsten Blum wrote:
> strcpy() has been deprecated [1] because it performs no bounds checking
> on the destination buffer, which can lead to buffer overflows. While the
> current code works correctly, replace strcpy() with the safer strscpy()
> to follow secure coding best practices. Use ->body.kvp_register.version
> directly as the destination buffer and remove the local variable.
> 
> [1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strcpy
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>

Applied. Thanks.

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2ADD470E9C;
	Wed, 22 Jul 2026 22:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784758862; cv=none; b=jmYJatJodHyAgPz1N55nuMVpjOed3nvi4OBXqjt8f7UxqmjjlefVuYcc1NJUNiLh7a8/oOlIP+vk8B5YidLfLPrSix7oQuqJxPKZcwODJlvPfNEKAUgX62akxChNB4CY1hL8W4f01uxGlHxYd9rnBRhsEcPb3MM14P6jPYZt5G0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784758862; c=relaxed/simple;
	bh=rDyuS5IF255Ua/X7kIB4lrFPMPzGFyoIL+Pj6fTWqSY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XfjLqE3M+8rCn8KCjXxA2XdI9FKWozmLVrP4/LDe2+x6D7dX8unuru+8mEdjTN+oY+PRDV1Fp12zddwAL0AMMQE04TuKicimVi4zY4ZgQL9tCyuG9Hco13oRJuFAbcBfZnP733v/3iFUyQFa1ASUG0U+wP8eeMH5X8kfPVg41VY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PkU8nfNK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PkU8nfNK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6ABE61F000E9;
	Wed, 22 Jul 2026 22:21:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784758860;
	bh=SoVnGTSH+5oxqEqjvKU/P7WkBMP64YA7GsAORNce/bE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=PkU8nfNK4eEel4KXpdDN2Gp7TZsHMpkha+fuOzImSWTlpA6pdR+ly679gPMCGT2W8
	 aN+WFpC6WYTjfW8UV6nB4+SLDm3zU7yQEAL/34k1qxEV3csSCtA2j4iNPGJVgdWABH
	 oFljqsB+H9js1hyKvBOaM8sH72kyweEWePACWlByhNc65aCx22eUC/Rl+Nx/2rMx6v
	 4nwrHI9jyGcVSlZ1YAtoCgZVpUMziVpBBcmokNZeP9qccbVZlkP+pq0Ib66s4ZvJu0
	 fsavSTnYO2F4Sm4UNNiwkDXlQ+B1mejrIwrIIKZGQlymd0l0NIgLSKN6DivgUMsR2+
	 iG26CFM9V00kg==
Date: Wed, 22 Jul 2026 15:20:59 -0700
From: Wei Liu <wei.liu@kernel.org>
To: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
Cc: Yi Xie <xieyi@kylinos.cn>, kys@microsoft.com, haiyangz@microsoft.com,
	wei.liu@kernel.org, linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mshv: fix fd leak in mshv_ioctl_create_vtl()
Message-ID: <20260722222059.GE2020652@liuwe-devbox-debian-v2.local>
References: <20260708012852.36824-1-xieyi@kylinos.cn>
 <ak5LDBRXOVYTrZ9r@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ak5LDBRXOVYTrZ9r@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>

On Wed, Jul 08, 2026 at 09:05:16AM -0400, Hamza Mahfooz wrote:
> On Wed, Jul 08, 2026 at 09:28:52AM +0800, Yi Xie wrote:
> > put_unused_fd() if anon_inode_getfile() fails.
> > 
> > Signed-off-by: Yi Xie <xieyi@kylinos.cn>
> 
> Reviewed-by: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>

Applied to hyperv-fixes. Thanks.

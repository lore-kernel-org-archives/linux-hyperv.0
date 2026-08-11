Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7192E35AC10;
	Tue, 11 Aug 2026 17:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786470992; cv=none; b=cBa/Mxh65y2a5Q/TLuOEy1of96oM6j27aw3JazULJTJVdARhIsSEHYPFUwrxNIhR7SP0ZxtT+tYMbG2msIBGbjjUQSMk/mbEkZjmu4eyc1uspDL4JCfBcBKql2R7eAWhxd7+OIOClrsfDb/9jDnKjvprUYez0pNwUs9Fn4iHBYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786470992; c=relaxed/simple;
	bh=2M89J+qoHgn37w03Og2VuLOXprezwa9lxTyXDmydFpc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aMCAaFKlW1Ub3rlzFbv3mFMZq68SX30kDbi+inYuND+tJO938cSOpoMmEhkqFfMVxKVnQp1JfHAHMxv2Nnu+qw1Ms5LOuSpc6VzLiMU/Siq8TOgbgtFUh8JrjQD+awN2gkOvM531GfbJEYScYEmOMcFGP4ggXs53+bhjbcnUjTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lsk4eh2m; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lsk4eh2m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F20721F000E9;
	Tue, 11 Aug 2026 17:56:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786470991;
	bh=ThQSY+CNsi9iAycl5RgsH6o1u/JymNZOEV5XFTa2M7k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Lsk4eh2mIedYUtF8qepg0RtPkf4EAsVBlBRhzcEaF/9Y4RlM29YjU6SnxaER/+xyO
	 LcldzKeLM1d1luCgTkVp1xFqKqlvOlCNTVv2Af3iiHJR7Rfum+nRkdOB0XHQfI+m5k
	 pX3Sb+2wdGHk42nZvXAD0IrjxRV+xUdHXimMDKaqoESlA9Jnkj3EQoGPB8tuij/Uoj
	 /pl9GhNHhMom3TCHi0EPWYQYYMVyiMe7Pzjd8WOu55LQvkeSnrWBqe7BBurfFXqgHD
	 mtSB2j78F7L2RgRcfzzmWFoZK5zN9fNMzRko9rmwE5iVeCv2RozTpiu30EMCVM7Wup
	 VFsvYPbASA4Vg==
Date: Tue, 11 Aug 2026 10:56:29 -0700
From: Wei Liu <wei.liu@kernel.org>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Wei Liu <wei.liu@kernel.org>,
	Linux on Hyper-V List <linux-hyperv@vger.kernel.org>,
	linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC 1/2] PCI: Add controller reset method
Message-ID: <20260811175629.GB2714057@liuwe-devbox-debian-v2.local>
References: <20260724230844.3259741-1-wei.liu@kernel.org>
 <20260724230844.3259741-2-wei.liu@kernel.org>
 <20260810185545.GC2496954@liuwe-devbox-debian-v2.local>
 <rlgkynaq654kznkcxfgwi7mv3w2qymq5dieof5zskdq23gaica@o4zcrt2pgxdk>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <rlgkynaq654kznkcxfgwi7mv3w2qymq5dieof5zskdq23gaica@o4zcrt2pgxdk>

On Tue, Aug 11, 2026 at 06:28:19PM +0200, Manivannan Sadhasivam wrote:
> 
> I recently added a hook for resetting the Root Ports in a platform specific way
> [1]. This new hook is called in the SBR reset path. Will it work for you?
> 
> - Mani
> 
> [1] https://lore.kernel.org/all/20260729-pci-port-reset-v9-2-53570b92064d@oss.qualcomm.com/
> 

Thank you. I will check that out.

Wei

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70BC430C60D;
	Sun, 12 Apr 2026 12:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775998360; cv=none; b=ILDyzbCIKcp77ZguQG1kS66WkCXHTWh1tWgZ3UfRDmHTN7Kmle+UJMH3Q+D9dxIbBUdnI7/FS5UmvqyhqhKlASqfDopnwaLiYcH5rV6uYszVb4qBHVE4kICx0mR7jseKC9BopeKS0X3t1GQtPuctbDQUFgHCxBeCxxOd85K88Ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775998360; c=relaxed/simple;
	bh=9o3Hq+Ry7zzts5Yree8zlYDr+AWyfx6JLoCAFtbLDaE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TTs2RnEgw/Y1u9AO1Rxff0MHHaA72+OIJvWqTBw9aVKfF/MScLvhoUZriYWu69kJnmWoaAbiYqaqmg6FVoZnRVrax7zmG9K88fMqeV5b342JRH0mFObTDa/6TM7XbXHquwO2AOaF6YJNrJePIFyg3Q1UWc8HQNoWj1P7e8YL82Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PKUPdAHP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PKUPdAHP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48D1BC19424;
	Sun, 12 Apr 2026 12:52:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775998360;
	bh=9o3Hq+Ry7zzts5Yree8zlYDr+AWyfx6JLoCAFtbLDaE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PKUPdAHP+meFD/SmJIe8PLjCuo/N5Fj8UgmD4+tANFLOZ7/9ZaduQXw+ucFqkxrYv
	 LPfkrCyEXYrdbQxvM0Xi0WuvsKuLt48lHPkA2VBIVTsqcjv8tQHLT40uVLDXLFJq/8
	 QNasOgfhBpdjwLjoymOen4fMiTD1GsN6mucwqrRJvX4K4LHfiVeLsPjjeHpuhRb4HS
	 /WbblF2DWL8FBbcZEHoP0F+7OIXg2kIRWI4rN3NqltIRGkHDgNUdiE+PgHcvkyWZJ2
	 NC7E5H/y8iWCwcQ93xIDzKpw5kFdWW5NbvzDD548wbyv3lP77PI+LS4pIDcCllcQE6
	 +JZ1EmxcMXuvw==
Date: Sun, 12 Apr 2026 13:52:33 +0100
From: Simon Horman <horms@kernel.org>
To: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, longli@microsoft.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, ssengar@linux.microsoft.com,
	dipayanroy@linux.microsoft.com, gargaditya@linux.microsoft.com,
	shradhagupta@linux.microsoft.com, kees@kernel.org,
	kotaranov@microsoft.com, yury.norov@gmail.com,
	linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 2/2] net: mana: Move current_speed debugfs file to
 mana_init_port()
Message-ID: <20260412125233.GJ469338@kernel.org>
References: <20260408081224.302308-1-ernis@linux.microsoft.com>
 <20260408081224.302308-3-ernis@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260408081224.302308-3-ernis@linux.microsoft.com>

On Wed, Apr 08, 2026 at 01:12:20AM -0700, Erni Sri Satya Vennela wrote:
> Move the current_speed debugfs file creation from mana_probe_port() to
> mana_init_port(). The file was previously created only during initial
> probe, but mana_cleanup_port_context() removes the entire vPort debugfs
> directory during detach/attach cycles. Since mana_init_port() recreates
> the directory on re-attach, moving current_speed here ensures it survives
> these cycles.
> 
> Fixes: 75cabb46935b ("net: mana: Add support for net_shaper_ops")
> Signed-off-by: Erni Sri Satya Vennela <ernis@linux.microsoft.com>

Reviewed-by: Simon Horman <horms@kernel.org>


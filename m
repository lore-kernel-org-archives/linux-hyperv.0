Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96B9335E930;
	Fri, 24 Jul 2026 21:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784929267; cv=none; b=SoT31jHABRgrfWkId9iMR309v/cwujRpjn1jsHL7BH0JdGzRYAuShFrqhZelh3EYPYyfPrKUu4aGINWst3w4Kwdhsm1wulE1iqnFnxqbtyEL0Vs4nCRxe9irVr2HSnRnaaXBFhJ2+wlyCJI6uXiKDbs4lx3Xb1mi12y45xSrrlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784929267; c=relaxed/simple;
	bh=rNwQ2eDik4dMMmUzlAEsOYZucnukL0XQX/sD9Cqn3gs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CUeD6WWrr1blXbYzFnw2W93PkOjqZZuA3v4YTE7hDwO8pU7hptey/CZczt0yhDkgkvjQyoCk84dfMWdXFyLNdutDPewy/86eOS2ouTke/0M9g2rCJ9seJ0RypXnnuEJ4bUumutZQdTSkRtGfmiHhU9YPGiBvT2wdo903CkxnLts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=CaypEGPh; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="CaypEGPh"
Received: from [192.168.0.88] (192-184-212-33.fiber.dynamic.sonic.net [192.184.212.33])
	by linux.microsoft.com (Postfix) with ESMTPSA id 009D820B7167;
	Fri, 24 Jul 2026 14:40:51 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 009D820B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1784929252;
	bh=1mJALukeVdyw27qenIgY8bjuuOXC8hWkYC73Ao+0+9w=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=CaypEGPhKGHh5BESLkO649D0BT6qISISau8enXlVQcIMfDVKz+4eiyS8vEEAo8pBR
	 Kv2Cx79g/jBjMILWLC72KllRVjE5Vf4A54LJpnz3kNamq8+5cJzYWpVxhXQG0sEgo3
	 A72OtO0drVG6N4Ss5ULM+FFy+idY/BMX7XjtTgJU=
Message-ID: <de52b1dd-2371-b2cc-52f4-0eb56020c9db@linux.microsoft.com>
Date: Fri, 24 Jul 2026 14:41:05 -0700
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH V4 8/9] mshv: Populate mmio mappings for PCI passthru
Content-Language: en-US
To: sashiko-reviews@lists.linux.dev
Cc: linux-pci@vger.kernel.org, linux-hyperv@vger.kernel.org
References: <20260718021949.926306-1-mrathor@linux.microsoft.com>
 <20260718021949.926306-9-mrathor@linux.microsoft.com>
 <20260718023321.925F11F000E9@smtp.kernel.org>
From: Mukesh R <mrathor@linux.microsoft.com>
In-Reply-To: <20260718023321.925F11F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/17/26 19:33, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 8 potential issue(s) to consider:
> 
> New issues:
> - [Critical] hv_map_mmio_pages extrapolates the physical base address for an entire MMIO region from a single page fault, allowing unauthorized arbitrary physical memory access.

> - [High] Flawed alignment logic allows mapping unaligned addresses as 2M large pages and fails to iterate the physical frame variable.
> - [High] Unconditional use of FAULT_FLAG_WRITE in mshv_chk_get_mmio_start_pfn breaks read-only MMIO mappings.

Above 2 addressed in next version.

Thanks,
-Mukesh

  ... snip ...


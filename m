Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 398133C9429;
	Thu,  2 Apr 2026 17:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775152633; cv=none; b=aLkL3kMi03CV5HFQ7DDZIHoSV0xnGGEUieHzSqjDartQT9dwLuCYkbWeof4k9zaNrm9/EyT3j1ISiqhWVQMP4ZqiSQKyeFu1xL3lZbRd1A7DI1p8kndMO6vobhSoeyNhqoK0FdtAZBqgdlKpvz2bVmiXkBL6edY9JmAhkWAkTYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775152633; c=relaxed/simple;
	bh=CLYm4aP2ClMxsj3IfT1vok6re+4DGSxJmLWmbXJQBfg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CQHDZ4VwoPbx0OaYoA52MuqlZMenkc2zpOKh30sbN3v0HjVZAVxrMZhd5IBEnFIf4WaCUexBL9WjRlUL8d3gXAGnsK/kzckITuqt+90U4t7J/QaKG7yFvhIUnWTWjDlcEpZlI2YzpdyENsQCZSnrA9oZlbKEDBBz3YsQy84VfoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=KcY8aOXH; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="KcY8aOXH"
Received: from skinsburskii.localdomain (unknown [20.236.11.29])
	by linux.microsoft.com (Postfix) with ESMTPSA id B74D320B712B;
	Thu,  2 Apr 2026 10:57:11 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B74D320B712B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1775152632;
	bh=1o5UsYphC63IxqO4PYP93hmGRUndCMD0kxbG9B8uhAs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KcY8aOXHrhFoBn8mZbVfdq0k6sYoYAhqg/WGspuidNHrDxJtAUrp2iD3Ndy4FRt2l
	 bJKKX+dIq9VC9Y7UHrrZ3uEZxTWEdJLAjNq62eoQkd+wGJd1xZfhj3PuQht11xLz96
	 vxva0+kRY9Jl3MPkalt+RL1DXMk+PqX68SEO5nWw=
Date: Thu, 2 Apr 2026 10:57:09 -0700
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: Anirudh Rayabharam <anirudh@anirudhrb.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, longli@microsoft.com,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/7] mshv: Rename mshv_mem_region to mshv_region
Message-ID: <ac6t9d2CIvL469_t@skinsburskii.localdomain>
References: <177508151446.215674.7844504277869257435.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
 <177508156067.215674.12361225930217655159.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
 <20260402-fervent-thick-boobook-45dba9@anirudhrb>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260402-fervent-thick-boobook-45dba9@anirudhrb>

On Thu, Apr 02, 2026 at 04:33:24PM +0000, Anirudh Rayabharam wrote:
> On Wed, Apr 01, 2026 at 10:12:40PM +0000, Stanislav Kinsburskii wrote:
> > The mshv_mem_region structure represents guest address space regions,
> > which can be either RAM-backed memory or memory-mapped IO regions
> > without physical backing. The "mem_" prefix incorrectly suggests the
> > structure only handles memory regions, creating confusion about its
> > actual purpose.
> > 
> > Remove the "mem_" prefix to align with existing function naming
> > (mshv_region_map, mshv_region_pin, etc.) and accurately reflect that
> > this structure manages arbitrary guest address space mappings
> > regardless of their backing type.
> 
> I don't think the "mem_" prefix automatically suggested the backing
> type.
> 

What else can it suggest?

> Isn't mshv_region too vague now? Region of what?
> 

The region of address space, which can or can not be backed by memory.

Thanks,
Stanislav

> Thanks,
> Anirudh.

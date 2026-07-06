Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB7CB3C1F45
	for <linux-hyperv@vger.kernel.org>; Mon,  6 Jul 2026 18:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783361805; cv=none; b=M8fFtHY8JPGQ5GWZ+SvG2MZOVyXYECyVLVsoIqB1yV+C+oW/hbRDakSC8/Ala99wpnODMZGGIEn+i7mne3QmVwwOQkclZxe0nQWeSNUsWnJ2BThPuBJCOXVAnEF7wcCFsLXAVdbgel521iukBc587XZHmoGfrVMJ6CTzbuFvHO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783361805; c=relaxed/simple;
	bh=XBxMi0JruZRfOpKBpk8TTN47HygeQas2rW6X95AsLZ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JzIFiMgTJMLTcQbi1OPWzcwHd6Xv2ZSbnFAJDcDPkn+JEUWZzXibfX2T1T9QAQ5gzsGT/baYlDB3SMCu9mTNuEmXrVu4VqYOLa+AnMYSGQEnJGBibU6cgfgPxkhDfgXzUpXG1v9/g5jlQCOXnyN1D4o9beavUl5zFEbv5yDKBqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=FehRhRiV; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="FehRhRiV"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-8e5be46f663so21382556d6.0
        for <linux-hyperv@vger.kernel.org>; Mon, 06 Jul 2026 11:16:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1783361803; x=1783966603; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=XBxMi0JruZRfOpKBpk8TTN47HygeQas2rW6X95AsLZ4=;
        b=FehRhRiViCRvs6KWCYlxLKVPllj/RBP1vFb7kDLqghWhOb/EXWfAnu0dE/lldlDRce
         Zl+VyEuaWEYXPqq97wk2nLqiifcGBWzhrmkmitr5tErtWIEi0REw7ZVuk1Vun4PgjQOV
         yXySEw97AeYeQkdU3B6TEOUgO7zYAbEIOLD+yOuMCkoc4blTkC5hwgZu7y+85EJo5QDn
         d2Uk0veJHIQYlJx+VL38M2KkXmAsdd8G7vvAAmII5uEimL8ou8Wnz5gI3W6QRbO4V1EW
         tHs/SEM7aWrpytcfgNBa3ab8RBbECpq0XwhES/0eFbJuPYCNcITIp27aMdE3zPQqzwiZ
         6SiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783361803; x=1783966603;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XBxMi0JruZRfOpKBpk8TTN47HygeQas2rW6X95AsLZ4=;
        b=GCJfDegWYTUhRBzj4lzLYelTb9A8ofE/cIMDMZPvVD+97yLKMlsDojHpMJGM2pXrJr
         i7mxglftTCbRSIO0kTUZC7m1HLbgcVuwkm6UA/HFVlZyHMTSA9aB5TW2yvtntrzJ+APu
         fQQ+fbgsJ2XV0s75pJNo0eD5DFLFjNsaUjOjlKF7IRA0ftxnKpabybkpiZZeBI7WViyF
         XUlqRn91Dop2HVHylsyLrZ3/+1j+1K2zwZl6cryd8YAlX946XQpCpAOHO9zkeBkngqVH
         Xh7JU69OVMN206CVDdo5lD0pcuw7wwuc7+Cb+Lnl4xYsuGQcJsl/1rqp2mnh6y6Rikoy
         RZOw==
X-Forwarded-Encrypted: i=1; AHgh+RoT66rppm0efvJco3bFHDPu1fJTeol6/HZv1m66veRDu81Abg9AeFzYtAiArNehyjqdC75Z8mB5qyooHwU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzE5OYNnyNQjmPBaUHrv8mQjXgksccfMvZcjlP7s9kiA6D2Rqdj
	xgG75XCfYj98VoJ4trOUwVqzfds/vLcGMA2G/zTYd0AsR+zQgCOpNbptDO59HS0dpt8=
X-Gm-Gg: AfdE7cmpb1o6qoYlJPLW/I0igyFe3zqNVZtRP8i63li022einN0vDnLLGH2V+FvL4Is
	UUIglElpGMREPklq65QhKHTos2X/OuNhn3qCUcVhttJCTGB9QItMvEcQ5cmq/YTunlw9S6ZxM3e
	1GKfsCYBGtwLtnMbcy5txSKFNOkpdvH6SduIbpZkOETxM2eyoFSk8TCmMwUBb2FA0kELAFzrC7/
	curuX39RcbiLGQsua5wjT+SBXWAAWZmwnqfGpEZYLOlzEgZs3tdPkFB/8Kk/xShVCHcsNPjI8oH
	u4jUo6P0LLeEqY06g69DPN1bDZZhyBn4dCkkwU6Czd1foPSVhi7T57WPTgIXEnaUDDeq0YJfX73
	3v6bMYpsjGFFDnmptez38Z8gF08+934QWaTbUVr/2GS9T5xethU3Na4ReAwHR1jqMGMq157g=
X-Received: by 2002:a05:6214:226b:b0:8ee:b05c:596d with SMTP id 6a1803df08f44-8fcb336e9fbmr21380346d6.22.1783361802525;
        Mon, 06 Jul 2026 11:16:42 -0700 (PDT)
Received: from ziepe.ca ([159.2.72.92])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8f4724b9ff8sm139929466d6.40.2026.07.06.11.16.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 11:16:42 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wgns0-00000000dbb-1jFq;
	Mon, 06 Jul 2026 15:16:40 -0300
Date: Mon, 6 Jul 2026 15:16:40 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Stanislav Kinsburskii <skinsburskii@gmail.com>
Cc: Liam.Howlett@oracle.com, akpm@linux-foundation.org, david@kernel.org,
	corbet@lwn.net, leon@kernel.org, ljs@kernel.org, mhocko@suse.com,
	rppt@kernel.org, shuah@kernel.org, skhan@linuxfoundation.org,
	surenb@google.com, vbabka@kernel.org, kys@microsoft.com,
	haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
	longli@microsoft.com, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org, linux-hyperv@vger.kernel.org
Subject: Re: [PATCH v6 4/4] mshv: Use hmm_range_fault_unlocked() for region
 faults
Message-ID: <20260706181640.GC118978@ziepe.ca>
References: <178336023903.504354.7500950448226027718.stgit@skinsburskii>
 <178336052192.504354.1841795575701703197.stgit@skinsburskii>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <178336052192.504354.1841795575701703197.stgit@skinsburskii>

On Mon, Jul 06, 2026 at 10:55:21AM -0700, Stanislav Kinsburskii wrote:
> Convert mshv_region_hmm_fault_and_lock() to use
> hmm_range_fault_unlocked() instead of taking mmap_read_lock() around
> hmm_range_fault() directly.

Please convert all the trivial users too, thanks

Jason

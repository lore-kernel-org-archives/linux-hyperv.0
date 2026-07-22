Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9015A3368AE;
	Wed, 22 Jul 2026 23:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784764000; cv=none; b=XhoQLvHtj6VPaeS5baLn4lyHNwfNhyryOTeeZxeuHEANXT4Z4/kT88osL2KBftGxHO3DBTcnNd8ASxi7dJtQhVfP5cFM0wgS1I8+AtRaXvob9xsPVevkhrgrrHvkJjYyoMaEqIs9dzWw9OL1z43gsQQ9AQLdeHHv92anwnEqwnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784764000; c=relaxed/simple;
	bh=1zeglWTYzYq2y06DQW2aTUuwhrQEpWhuWFZZxjK+8J8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q0AcSEp+8UYms4I0OCJ6KyOLFuXFQVcGGsSJmFC/Tafn5Yi5MDT6jbyS3Nx/vZEoGC66l+8zxqq+9I9itbc6h63DyKWqRQ0HnqmT6mxl8rc+f0LVIdy0FAdKadadOOuY1o1Ozg4saNzwNsyakAxTgDP0lyhHIsXb7GnER1A7Euk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BCRvggQb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BCRvggQb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1A771F000E9;
	Wed, 22 Jul 2026 23:46:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784763999;
	bh=RB9UPBEhxIeTB3bnfZdIzjuiylaXVHZnh0zfTHJa1+w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=BCRvggQbxIMt9t298AbvqC2Qg3lQ1u7sqXB3qsFXqBm+Wpoh8IcjFRFr3bAuLQKUv
	 VThbKuKPPZPjCOYp6bSzvMIrktu6ZGyblfSZf+evfaG2DQ8RVBcql4hxHBWg30u4/i
	 wCOYK8/ROczedqMxN7SkXKWTYuEOb3H1IIhMrzRyTnjWGWaIwLAtqYB4AnEDT83vah
	 KU/jjHZs1yb3WPf8SbMlA2Gv7wZ0f0sWg7ZzqoYy9CtkrXgIrV6jKc74GLyUHAgWf5
	 ImvWSOtHqFsW6zUbeVDaylTs/QjTwBXkcgeaxofOy3JliIrpMRiJYaeWYeURwa4DOo
	 ufCpTYHWr1f9A==
Date: Wed, 22 Jul 2026 16:46:37 -0700
From: Wei Liu <wei.liu@kernel.org>
To: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, longli@microsoft.com,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 10/18] mshv: portid_table: Make mshv_portid_lookup()
 RCU-aware by contract
Message-ID: <20260722234637.GH2020652@liuwe-devbox-debian-v2.local>
References: <177816592843.21765.4364464279247150355.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
 <177816863447.21765.7284842709694944084.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <177816863447.21765.7284842709694944084.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>

On Thu, May 07, 2026 at 03:43:54PM +0000, Stanislav Kinsburskii wrote:
> mshv_portid_lookup() previously took rcu_read_lock() internally, ran
> idr_find(), released the read lock, and copied the struct contents
> into a caller-supplied buffer.  This had two problems.
> 
> 1. The struct copy ran outside the read section, racing with
>    mshv_portid_free() which does idr_remove + synchronize_rcu + kfree.
>    A copy that started just before synchronize_rcu() observed the read
>    section as already drained and was free to read freed memory while
>    the writer was kfree()'ing the entry.
> 
> 2. The only consumer, mshv_doorbell_isr(), then dispatched a callback
>    using fields of the snapshot — entirely outside any RCU read
>    section.  The callback's data argument and any field it touches
>    were therefore safe only because mshv_isr() runs from
>    sysvec_hyperv_callback, a non-threaded system vector that
>    synchronize_rcu() implicitly waits for via the hardirq quiescent-
>    state coupling.  That protection is real today but undocumented and
>    fragile: a future move of mshv_isr() to a threaded context, or a
>    future caller that registers a doorbell with a shorter-lived data
>    pointer, would silently expose a use-after-free.
> 
> Make the contract explicit instead of implicit.  mshv_portid_lookup()
> now returns a pointer to the table entry and requires the caller to
> hold rcu_read_lock for the entire lifetime of that pointer.  The
> contract is annotated with __must_hold(RCU) so sparse flags any
> direct caller that forgets it.  The sole caller, mshv_doorbell_isr(),
> takes rcu_read_lock around the whole drain loop, so the lookup, the
> field reads, and the doorbell_cb dispatch all run inside one
> read-side critical section.  synchronize_rcu() in mshv_portid_free()
> now genuinely waits for any in-flight callback before kfree() runs,
> without relying on hardirq context for correctness.
> 
> This also drops the by-value struct copy: entries are publish-once
> (populated before idr_alloc) and free-once (after synchronize_rcu),
> so a pointer dereferenced inside the read section gives a stable
> view of the contents without copying.
> 
> Fixes: 621191d709b14 ("Drivers: hv: Introduce mshv_root module to expose /dev/mshv to VMMs")
> Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
> ---
>  drivers/hv/mshv_portid_table.c |   22 +++++++---------------
>  drivers/hv/mshv_root.h         |    2 +-
>  drivers/hv/mshv_synic.c        |   15 +++++++++------
>  3 files changed, 17 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/hv/mshv_portid_table.c b/drivers/hv/mshv_portid_table.c
> index c349af1f0aaac..4cdf8e9575390 100644
> --- a/drivers/hv/mshv_portid_table.c
> +++ b/drivers/hv/mshv_portid_table.c
> @@ -64,20 +64,12 @@ mshv_portid_free(int port_id)
>  	kfree(info);
>  }
>  
> -int
> -mshv_portid_lookup(int port_id, struct port_table_info *info)
> +/*
> + * Caller must hold rcu_read_lock for the entire lifetime of the
> + * returned pointer.  Returns NULL if @port_id is not in the table.
> + */
> +struct port_table_info *mshv_portid_lookup(int port_id)
> +	__must_hold(RCU)
>  {
> -	struct port_table_info *_info;
> -	int ret = -ENOENT;
> -
> -	rcu_read_lock();
> -	_info = idr_find(&port_table_idr, port_id);
> -	rcu_read_unlock();
> -
> -	if (_info) {
> -		*info = *_info;
> -		ret = 0;
> -	}
> -
> -	return ret;
> +	return idr_find(&port_table_idr, port_id);
>  }

This is now a one line function. We can drop this function completely.

Wei

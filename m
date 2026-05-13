Received: from sender4-of-o52.zoho.com (sender4-of-o52.zoho.com [136.143.188.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DF3638C2A7;
	Wed, 13 May 2026 11:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778671234; cv=pass; b=gLhuhMvWiB5YlULS8P/VljSLHjDuvU2L/MKi1uxeuHcrIp1de0kqbqZ/FueiqVtJzJt/Fs7BmLdE+stYyBx+2ZyCgnxLXYXZsXgaR7rELK1bstjUGJJo0GcIEQhka1Hjz6LnVbU5tWqbc4YdAO98KfKgUDL5zJ08XPenMBIDBF4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778671234; c=relaxed/simple;
	bh=ddfeMCcpfut7xpvefRpVqM6X4x1MFjvW5jMaVIHYN5E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OFpTFMuUQ08bg9H8kcUPmSEbwZOvIlGAcyDv1Tl2wMIUN6BlOkiX7EqWpdw5B5tVlAAEDHrR8rC0WCuWvqfGXQE1maiqO9nfyFd5uAU9BKI5y45BzyegYlcZAGl17gdfZUTFHE4jmyrfZAR3UQdqQHTY/RUkhPTeGWV3p+pC7Bs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=anirudhrb.com; spf=pass smtp.mailfrom=anirudhrb.com; dkim=pass (1024-bit key) header.d=anirudhrb.com header.i=anirudh@anirudhrb.com header.b=gjXOmenP; arc=pass smtp.client-ip=136.143.188.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=anirudhrb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=anirudhrb.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=anirudhrb.com header.i=anirudh@anirudhrb.com header.b="gjXOmenP"
ARC-Seal: i=1; a=rsa-sha256; t=1778671223; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=jPGLT9kNFRP5TdYILWkw96EFHmkJWZndyof9rTnFaOKj2Wc2sU8kD3Hq4FJSqVB5mJKZuNFW/q+6BxxIEOHvYnL/2QMLYX69ENmsW3aAALDAQgqNkgU8XsXFEaEg1Pmbyvzn8GNivl8ViYm1q791RNEaoy0UciThZI+ns9G/5cc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1778671223; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=DHBpenYnykzUVOhtQ/LVnAgPDeq6D9iMSc1BpowZwkI=; 
	b=CyUb8Avqz00ZoZBTO6nvDFTximbzjXL3qRqwirpsEDxyerakJMaaUeUKj+mEcXXU7zavFhc0et7hqY8luSp7RZijBP4OKVBeFmqTlU3cUe7ZODVH2xYDii3ayFphtHPtzUHwF4bPTXdais6ATmYa6ITcOsIQht0WZtrUwY8vPqs=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=anirudhrb.com;
	spf=pass  smtp.mailfrom=anirudh@anirudhrb.com;
	dmarc=pass header.from=<anirudh@anirudhrb.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1778671223;
	s=zoho; d=anirudhrb.com; i=anirudh@anirudhrb.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:Message-Id:Reply-To;
	bh=DHBpenYnykzUVOhtQ/LVnAgPDeq6D9iMSc1BpowZwkI=;
	b=gjXOmenPpn8/u3+I6/cebmu5z843awg3jqlx8k4tWHBEuss9QUfH6QPr/i9HLVnX
	D28JvV/CHQWxDF13Fh5DJltsxHWqenWBuE+XBZyO55avrmb9QUke94O1oAEeNSrcHdd
	aS4k6JTF3nX/BXJs8VJQaegU+LrYnTzihlmAJGVU=
Received: by mx.zohomail.com with SMTPS id 1778671221666175.70422729059203;
	Wed, 13 May 2026 04:20:21 -0700 (PDT)
Date: Wed, 13 May 2026 11:20:15 +0000
From: Anirudh Rayabharam <anirudh@anirudhrb.com>
To: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, longli@microsoft.com,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 10/18] mshv: portid_table: Make mshv_portid_lookup()
 RCU-aware by contract
Message-ID: <20260513-infallible-angelfish-of-wonder-41f393@anirudhrb>
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
X-ZohoMailClient: External

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

Reviewed-by: Anirudh Rayabharam (Microsoft) <anirudh@anirudhrb.com>


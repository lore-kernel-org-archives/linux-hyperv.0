Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAE3A45FFA0
	for <linux-hyperv@vger.kernel.org>; Fri,  7 Aug 2026 16:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786120569; cv=none; b=rNDyDy48lYVddYn3Qai3bBWZvDv+gHaGF8UMLgJCx0LCfe3JvQNIMoXpmx+Lc/8J2lJyMh2LKRaHXDCgoak7yRxwRWePP381Oa/UFpBVBl6fvizSoTXZ85EkttUtZ3IyZJdFWr+h4qlYbXmGY9lsqsm/o7eqfhmwdn3TN5/IgGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786120569; c=relaxed/simple;
	bh=PkVOmXJRRSqZ4YelyV/5P7qJdudhHDOqahjgzpbxe/o=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=t+ksDz0c8ra+9WCYGNByLjzvco+BR+jwsx8CaXOySCBwXUnlGZwfOF5ztdlPlWmWEFA/jjcAIOBGFawedwD0tb/tQACB2Gg8w2IspLR0QpM4aUjJvCqKitqRdvcrPlWWRJNvuEhS+V8MKRQVpH13bjRhLRJ5c6hKCCWyzNl6940=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NoYQ1KWu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NoYQ1KWu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C8271F000E9;
	Fri,  7 Aug 2026 16:36:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786120567;
	bh=OAUR85AH374jmbwSUvrfiAhz+ips+ZXyiaLILByjmfc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NoYQ1KWuqMXrwm6CxQ6O5XU58JfPrviryCf5e5FjioYXOhmqpyEDRKDkQO+xvSZL6
	 qZfwM30mTWOIOms0kBtf9tyv4miSrfaTHQcCd5T93S+ibh54B8njftJkpGK3+fF/2N
	 gnJe6D7pRFxlKzofOe7SEn6Jc6mRj/o8KvVOkBQg4l56Kcs1SYgDaxe8tEQ+VpWE+R
	 NbVEqWgpQ5jt+O+r68bYp7H1xD8xReGYU67Y6kggkRNMF929nNTNdN8BxBmF2P7xRx
	 7+NaXWVtFnire1inmrz7Oj5Jg7lIwiyYMF8S7EcOsr0nOW8Ow3OxD3awOAmT0Gi9Mk
	 jRzLvfKvE61ow==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 13/13] mshv: set up own SynIC registers on a nested
 root partition
Reply-To: sashiko-reviews@lists.linux.dev
To: "Wei Hu" <weh@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <20260807135134.303943-14-weh@linux.microsoft.com>
References: <20260807135134.303943-1-weh@linux.microsoft.com>
 <20260807135134.303943-14-weh@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 07 Aug 2026 16:36:06 +0000
Message-Id: <20260807163607.4C8271F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Use-after-free in `mshv_portid_lookup()` due to dereferencing =
an RCU-protected pointer outside the RCU read-side critical section.
- [High] Use-after-free of `mshv_vp` in `mshv_intercept_isr` and `mshv_sche=
duler_isr` due to premature `kfree(vp)` in `destroy_partition`.
--

--- Patch [13]: [PATCH v1 13/13] mshv: set up own SynIC registers on a nest=
ed root partition ---
commit e9472d7549df2c05d78706a10839e3ca1d79d52c
Author: Wei Hu <weh@microsoft.com>

mshv: set up own SynIC registers on a nested root partition
   =20
Upstream mshv_synic_cpu_init()/_exit() skip programming the SynIC
SIMP/SIEFP/SCONTROL registers when VMBus is active (hv_vmbus_exists()),
assuming VMBus's hv_hyp_synic_enable_regs() already provisioned them.

That assumption is wrong for a *nested* root partition. There, VMBus
programs the *nested* SynIC MSRs (HV_X64_MSR_NESTED_SIMP, ...) via
hv_set_msr()'s nested remap, while mshv_synic reads/writes the
*non-nested* SynIC MSRs (hv_get/set_non_nested_msr). As a result mshv
maps the wrong message page, never receives the SYNIC intercept message
that carries the async hypercall completion, and mshv_async_hvcall_handler
blocks forever -- hanging SEV-SNP guest creation from user space.

Gate the "VMBus owns the SynIC registers" optimization on !hv_nested so
that a nested root partition programs its own non-nested SynIC registers,
restoring correct intercept/async-hypercall delivery. No change for a
non-nested (bare-metal) root.

> diff --git a/drivers/hv/mshv_synic.c b/drivers/hv/mshv_synic.c
> index 7c168e5a740dd..7d714ee5d2267 100644
> --- a/drivers/hv/mshv_synic.c
> +++ b/drivers/hv/mshv_synic.c
[ ... ]
> @@ -593,7 +599,13 @@ static int mshv_synic_cpu_exit(unsigned int cpu)
>  	struct hv_synic_event_ring_page **event_ring_page =3D
>  		&spages->synic_event_ring_page;
>  	/* VMBus owns SIMP/SIEFP/SCONTROL when it is active */
> -	bool vmbus_active =3D hv_vmbus_exists();
> +	/*
> +	 * On a nested root partition VMBus programs the *nested* SynIC MSRs
> +	 * (SIMP/SIEFP/SCONTROL) via hv_set_msr()'s nested remap, whereas the
> +	 * code below reads/writes the non-nested SynIC MSRs. So when nested,
> +	 * do not defer SynIC setup to VMBus -- set up our own registers.
> +	 */
> +	bool vmbus_active =3D hv_vmbus_exists() && !hv_nested;
> =20
>  	/* Disable the interrupt */
>  	sint.as_uint64 =3D hv_get_non_nested_msr(HV_MSR_SINT0 + HV_SYNIC_INTERC=
EPTION_SINT_INDEX);

[Severity: High]
This isn't a bug introduced by this patch, but I noticed a pre-existing
use-after-free pattern regarding mshv_vp in mshv_intercept_isr() and
mshv_scheduler_isr().

When userspace initiates partition destruction, destroy_partition() frees
virtual processors before removing the partition from the RCU-protected hash
list:

drivers/hv/mshv_root_main.c:destroy_partition() {
...
			kfree(vp);

			partition->pt_vp_array[i] =3D NULL;
		}
...
}

Concurrently, hypervisor messages can trigger mshv_intercept_isr() which
reads the VP pointer while holding the rcu_read_lock:

drivers/hv/mshv_synic.c:mshv_intercept_isr() {
...
	vp =3D partition->pt_vp_array[vp_index];
	if (unlikely(!vp)) {
		pr_debug("failed to find VP %u\n", vp_index);
		goto unlock_out;
	}

	kick_vp(vp);
...
}

Is it possible for kick_vp() to write to freed memory if the read happens
just before kfree(vp) in destroy_partition()?


[Severity: Critical]
This is a pre-existing issue, but does mshv_portid_lookup() have a
use-after-free if it drops the RCU lock before dereferencing the protected
pointer?

drivers/hv/mshv_portid_table.c:mshv_portid_lookup() {
...
	rcu_read_lock();
	_info =3D idr_find(&port_table_idr, port_id);
	rcu_read_unlock();

	if (_info) {
		*info =3D *_info;
...
}

Concurrently, mshv_portid_free() can remove the port ID, call
synchronize_rcu(), and free the memory:

drivers/hv/mshv_portid_table.c:mshv_portid_free() {
...
	idr_unlock(&port_table_idr);

	synchronize_rcu();
	kfree(info);
...
}

Since rcu_read_unlock() is called prematurely, synchronize_rcu() wouldn't
wait for the dereference.

This is concerning because mshv_doorbell_isr() uses this returned struct to
invoke a callback:

drivers/hv/mshv_synic.c:mshv_doorbell_isr() {
...
		/* Invoke the callback */
		ptinfo.hv_port_doorbell.doorbell_cb(port,
						 ptinfo.hv_port_doorbell.data);
...
}

Could an attacker trigger port freeing to race with the doorbell interrupt
and control the function pointer?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260807135134.3039=
43-1-weh@linux.microsoft.com?part=3D13

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6DC73BB48;
	Sat, 18 Jul 2026 02:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784341944; cv=none; b=Tft5vnu5fXPTp7oJH/a5I9jXE0qZqMRYi1onVJ6IpBfgAi/EfEoA4wCKmCxEoTzGtTyYY4E+Tb+bThz3F2L3dSTyu/hkFSjNB9YuraSFQjkO5z6o+onGyQ4lIATB9Km2x7RxE/RXd87EDQBYe2EmDZQC59ci+voNGfCwyhKSV/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784341944; c=relaxed/simple;
	bh=vTdwZxme+2ODBIE4+dZTkvh2pt9Zx7o29GLqZAybDEA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nuIM9C9lR+KpN9eSqqs/SJ5FsgMi5rtcrXzLt5iw9qNU9z/IdKnZ6YiyeILWcCVHK/z2H7N1AB6IEb+41P8Muh23XBAHjwKWaOwDrfqIfNfceVfmw2aDoKuf7SBpXJmcQLRyKIl+IIFskfh0UnVR54agZfdNyUA9vUC7FwvQIgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IJBC1IaC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IJBC1IaC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 302381F00A3A;
	Sat, 18 Jul 2026 02:32:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784341943;
	bh=gICeMjlMW8LEz3tt7vUIFw0g3Gi54kc1wL/VI51XOl8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IJBC1IaC+wWJd01OV818sR8daT999tvMlnQCFxKtINmgGGu17sRAZakZbtILKWmxD
	 zEUAyLFX3JYPzq8XStrRaux75DIr9fEY4kaivNYdYDkqrLhtIvYFascKBARbDu7BTo
	 ksICAJ4da+4HmpRTt0uZxVSMt7uFeyWMZ+r9+JmXbnIMsPEwCk6AiNAQ4IBs/eQk8o
	 MZm7esO2oPe7+YpCSXpPeZI/uxb2xIhVrQvMik/mcn0SCQTnp4WKTNDyDOLCCtwBiA
	 fJ5o0TRo0A1DJjB1L6ospfnGjqgmTWbNz1egbPQpiKPkbR9qOrWITAl4dLwZTxN2lD
	 uHxg8o+CtolbQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V4 1/9] mshv: Provide a way to get partition ID if
 running in a VMM process
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mukesh R" <mrathor@linux.microsoft.com>
Cc: linux-pci@vger.kernel.org, linux-hyperv@vger.kernel.org
In-Reply-To: <20260718021949.926306-2-mrathor@linux.microsoft.com>
References: <20260718021949.926306-1-mrathor@linux.microsoft.com>
 <20260718021949.926306-2-mrathor@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 18 Jul 2026 02:32:22 +0000
Message-Id: <20260718023223.302381F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] Using global `current->tgid` to track and authorize partition owne=
rship introduces a PID reuse vulnerability and breaks support for VMMs mana=
ging multiple partitions.
- [High] `mshv_current_partid()` returns a raw partition ID without acquiri=
ng a reference, leading to a TOCTOU race where the partition can be freed a=
nd its ID reused.

Pre-existing issues:
- [High] VPs are freed before their parent partition is unlinked from the R=
CU hash table, causing a Use-After-Free for concurrent RCU readers.
--

--- Patch [1]: [PATCH V4 1/9] mshv: Provide a way to get partition ID if ru=
nning in a VMM process ---
commit ce04f426ae72519f5c20b1bad8ffd34a07810200
Author: Mukesh R <mrathor@linux.microsoft.com>

mshv: Provide a way to get partition ID if running in a VMM process

Many PCI passthru related hypercalls require partition ID of the target
guest. Guests are actually managed by MSHV driver and the partition ID
is only maintained there. Add a field in the partition struct in MSHV
driver to save the tgid of the VMM process creating the partition, and
add a function there to retrieve partition ID if the current process is
a VMM process.

> diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
> index 146726cc4e9ba..f1ff45a77b42c 100644
> --- a/drivers/hv/mshv_root_main.c
> +++ b/drivers/hv/mshv_root_main.c
> @@ -1908,6 +1908,27 @@ mshv_partition_release(struct inode *inode, struct=
 file *filp)
>  	return 0;
>  }

[Severity: High]
This is a pre-existing issue, but there appears to be a use-after-free
condition when a partition is being destroyed.

In destroy_partition(), child mshv_vp objects are freed while the parent
partition remains linked in the RCU-protected mshv_root.pt_htable:

destroy_partition() {
    ...
    kfree(vp);
    partition->pt_vp_array[i] =3D NULL;
    ...
    remove_partition(partition);
}

If a concurrent asynchronous interrupt (like handle_bitset_message) looks up
the partition via mshv_partition_find() and accesses the VP before
remove_partition() unlinks the partition and waits for a grace period,
could the ISR call kick_vp(vp) on freed memory?

> +/* Given a process tgid, return partition id if it is a VMM process */
> +u64 mshv_current_partid(void)
> +{
> +	struct mshv_partition *pt;
> +	int i;
> +	u64 ret_ptid =3D HV_PARTITION_ID_INVALID;
> +
> +	rcu_read_lock();
> +
> +	hash_for_each_rcu(mshv_root.pt_htable, i, pt, pt_hnode) {
> +		if (pt->pt_vmm_tgid =3D=3D current->tgid) {
> +			ret_ptid =3D pt->pt_id;
> +			break;
> +		}
> +	}

[Severity: High]
Is it safe to track partition ownership using a global transient identifier
like current->tgid instead of an explicit file descriptor or reference-coun=
ted
token?

If a single VMM process creates multiple partitions, wouldn't
mshv_current_partid() arbitrarily return the first one found in the hash
table, breaking PCI passthru operations for all subsequent partitions?

Furthermore, could PID recycling lead to a situation where a new VMM process
accidentally matches an old partition whose fd was passed to a long-running
process that outlived the original creator?

> +
> +	rcu_read_unlock();
> +	return ret_ptid;

[Severity: High]
Does returning the raw pt_id here without acquiring a reference to the
partition object introduce a race condition?

Once the RCU read lock is dropped, a concurrent thread could close the
partition fd, causing destroy_partition() to delete it in the hypervisor.

If the hypervisor reuses this ID for a newly created partition belonging to=
 a
different VMM, could the original caller's subsequent PCI passthru hypercall
mistakenly target the unrelated partition?

> +}
> +EXPORT_SYMBOL_GPL(mshv_current_partid);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260718021949.9263=
06-1-mrathor@linux.microsoft.com?part=3D1

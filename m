Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47F8A4B66E2;
	Mon,  5 Oct 2026 19:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791229135; cv=none; b=S5bA3iFRBZLSdJmetmAP0JlxOQJtWiB0xpGPHC5RoBolTMgkVK5z5J3CRCfkcuo8DwzVz/2hUY1J+hoU3v1Itvg+BdlM5IWW9NARF9DUUe+cz7kwVVUve2c3OT1wROiLvC600hILbwSFsbRqP+gD9kNe9WWcWmU5DDwwW9yb99k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791229135; c=relaxed/simple;
	bh=skySoc3cmaE4L4KdgTFns/U0q7fcKjW4WK8GaQt8sMk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=oA+tHnx2/kfWy5VvlZE0LYC2EdbOiOPk4MB8ojkbGWUueQP/9MEq3CVqNt1sWR1XHU1sGo7CDWUVdaukwLhWyKsmo0nGuoJcmXqUMAwpiAToZqRgng3sW1XSA+9JA2Fa5smhRnABhS+jF/YO8LqfDAOIt6RJDJtfPpAYlaxpq/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eHGkoWRH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eHGkoWRH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A50251F000FF;
	Mon,  5 Oct 2026 19:38:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791229133;
	bh=CQV4LqLL4C2laXbdTlS0xjO5svs3sFvzrNnY3x3xYik=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eHGkoWRHZPI7JoApngMpDsn235ukDhvZyKnvqHkeGZBf8/l3GCKN1Y3UkM2cd9tIt
	 aoL1fapL5gllTG56SRw54p44x9+dQ0x7vxNu7zuOCCsliB4YJoKpeW40zhy3Idd1MH
	 TrLfxCbIOsFPUyYriqg1A/7GacnPgyT2wQW7xvQeLRwkdlZEdkAwXC9wxJYjTF78p5
	 kBZzik6pC/EA8xb9Ljashn8iZsGFkUCOPDRznka7eBSrCIVjVQ/2MZ4UTI717/XDLZ
	 ccp9yVH8G3R2+68Gqv60OCzYPQdf3xPLkPJDGrUmTSu283gQe8ghP+ENz3pknLkgyB
	 sn24BWoRXVNUA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/3] KVM: x86: hyper-v: Implement
 HvCallRestorePartitionTime
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mushahid Hussain" <hmushi@amazon.co.uk>
Cc: kvm@vger.kernel.org, linux-hyperv@vger.kernel.org
In-Reply-To: <20261005192431.87317-4-hmushi@amazon.co.uk>
References: <20261005192431.87317-1-hmushi@amazon.co.uk>
 <20261005192431.87317-4-hmushi@amazon.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 05 Oct 2026 19:38:53 +0000
Message-Id: <20261005193853.A50251F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] x86/kvm: Race condition in kvm_vcpu_apply_tsc_generation() causes =
state corruption
- [High] x86/kvm: Pre-mature matched TSC count increment permits double-cou=
nting
- [Medium] x86/kvm: VM-wide cur_tsc_offset overwritten in per-vCPU loop
--

commit 3619ce01761243ff0d6db55e73b6eefb9f3cc10b
Author: Mushahid Hussain <hmushi@amazon.co.uk>
Subject: KVM: x86: hyper-v: Implement HvCallRestorePartitionTime

A nested Hyper-V guest can resume from hibernation and use
HvCallRestorePartitionTime to sync its TSC and reference counter. This comm=
it
implements handling for the hypercall in KVM, stepping both clocks in a
single update. It updates kvm_set_clock_and_tsc() and issues requests to
write the TSC offset for each vCPU.

> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 19666a80240a5..c0865468b02e7 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c

[ ... ]

> @@ -4354,13 +4354,85 @@ static int kvm_vm_ioctl_get_clock(struct kvm *kvm=
, void __user *argp)
>  	return 0;
>  }
> =20
> -static void __kvm_set_clock(struct kvm *kvm, struct kvm_clock_data *data)
> +/* Must precede pvclock_update_vm_gtod_copy(), which reads the matched c=
ount. */
> +static void kvm_open_tsc_generation(struct kvm *kvm, u64 guest_tsc)
> +{
> +	struct kvm_arch *ka =3D &kvm->arch;
> +	struct kvm_vcpu *vcpu;
> +	unsigned long i;
> +
> +	lockdep_assert_held(&ka->tsc_write_lock);
> +
> +	ka->cur_tsc_generation++;
> +	ka->cur_tsc_write =3D guest_tsc;
> +	ka->last_tsc_write =3D guest_tsc;
> +	ka->nr_vcpus_matched_tsc =3D atomic_read(&kvm->online_vcpus) - 1;

[Severity: High]
Is it safe to pre-increment the matched count globally before the per-vCPU
updates complete?

If a vCPU executes kvm_synchronize_tsc() before processing the asynchronous
KVM_REQ_WRITE_TSC_OFFSET, it might see a stale generation, match it, and
increment ka->nr_vcpus_matched_tsc.

Since the count is pre-incremented here, double-counting could cause
the total to reach or exceed online_vcpus, permanently breaking the KVM
masterclock validation (which checks if matched_tsc + 1 =3D=3D online_vcpus=
).

> +
> +	kvm_for_each_vcpu(i, vcpu, kvm) {
> +		if (vcpu->arch.guest_tsc_protected)
> +			continue;
> +		ka->last_tsc_khz =3D vcpu->arch.virtual_tsc_khz;
> +		ka->last_tsc_scaling_ratio =3D vcpu->arch.l1_tsc_scaling_ratio;
> +		break;
> +	}
> +}
> +
> +/* Every vCPU reads @guest_tsc at host TSC @host_tsc. */
> +static void kvm_set_tsc_generation(struct kvm *kvm, u64 host_tsc,
> +				   u64 guest_tsc, u64 ns)
> +{
> +	struct kvm_arch *ka =3D &kvm->arch;
> +	struct kvm_vcpu *vcpu;
> +	unsigned long i;
> +
> +	lockdep_assert_held(&ka->tsc_write_lock);
> +
> +	ka->cur_tsc_nsec =3D ns;
> +	ka->last_tsc_nsec =3D ns;
> +	ka->restore_host_tsc =3D host_tsc;
> +	ka->restore_guest_tsc =3D guest_tsc;
> +	ka->restore_tsc_nsec =3D ns;
> +
> +	kvm_for_each_vcpu(i, vcpu, kvm) {
> +		if (vcpu->arch.guest_tsc_protected)
> +			continue;
> +
> +		ka->cur_tsc_offset =3D kvm_compute_l1_tsc_offset(vcpu, host_tsc,
> +							       guest_tsc);
> +		ka->last_tsc_offset =3D ka->cur_tsc_offset;

[Severity: Medium]
Could this loop repeatedly overwrite the VM-wide offset, leaving it configu=
red
for the last vCPU?

If vCPUs have different TSC scaling ratios (which can be set via
KVM_SET_TSC_KHZ), the reference frequency is bound to the first valid vCPU =
in
kvm_open_tsc_generation() above, while the offset here ends up bound to the
last vCPU, breaking consistency.

> +		kvm_make_request(KVM_REQ_WRITE_TSC_OFFSET, vcpu);
> +	}
> +}
> +
> +/* Runs on the vCPU; only the owner writes its TSC offset. */
> +static void kvm_vcpu_apply_tsc_generation(struct kvm_vcpu *vcpu)
> +{
> +	struct kvm_arch *ka =3D &vcpu->kvm->arch;
> +	unsigned long flags;
> +	u64 offset;
> +
> +	raw_spin_lock_irqsave(&ka->tsc_write_lock, flags);
> +	offset =3D kvm_compute_l1_tsc_offset(vcpu, ka->restore_host_tsc,
> +					   ka->restore_guest_tsc);
> +	vcpu->arch.last_guest_tsc =3D ka->restore_guest_tsc;
> +	vcpu->arch.this_tsc_generation =3D ka->cur_tsc_generation;

[Severity: High]
Could a race condition corrupt state tracking here?

If a concurrent write to MSR_IA32_TSC bumps ka->cur_tsc_generation while
KVM_REQ_WRITE_TSC_OFFSET is queued, the vCPU processing the request will co=
py
the newer generation counter here while applying the stale ka->restore_*
offset data.

This would leave the vCPU claiming synchronization with the new generation
while actually holding old data, breaking KVM masterclock and TSC
synchronization.

> +	vcpu->arch.this_tsc_nsec =3D ka->restore_tsc_nsec;
> +	vcpu->arch.this_tsc_write =3D ka->restore_guest_tsc;
> +	raw_spin_unlock_irqrestore(&ka->tsc_write_lock, flags);
> +
> +	kvm_vcpu_write_tsc_offset(vcpu, offset);
> +}

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261005192431.8731=
7-1-hmushi@amazon.co.uk?part=3D3

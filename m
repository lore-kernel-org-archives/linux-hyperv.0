Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 641314825C6
	for <linux-hyperv@vger.kernel.org>; Mon, 12 Oct 2026 21:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791840209; cv=pass; b=qkV+m/uiBGpVnfUrPXpHXUwC52VSNDHGZmOKco1UIlZ0Ob/z8TRgsuafwEokJ9ourb5k5SyFRrnuqlcBF7Ma0gm4fcAZlWMGSockjcfn4YmFu1tPO8PvPncpxndTNsupMjc8+A2cUeDB4BQ6OS7IpPeAC41jOZpDjJSI4K+Lh3I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791840209; c=relaxed/simple;
	bh=M/ThXiHN1P68R+1YhMAmr597pKOSWjt23LCQQNjErlw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MKl7xj7ZyeoGgsr+abx20j+IaBJbpGWPPFL+iWkYCscdxZF+a5ry8OFF96RZRi55anLhY5A+dwULW5CFCqIRuwuKSSKdfPlbxWGIxmfcfJUsEgmEvL8khGE3XuRt/W3vHX+BQPCkO45Wn1r7vzLeOOm9UA12jZm0IMSBKI3otHE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YxyjDzyY; arc=pass smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YxyjDzyY"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-6afac79b3a3so17622a12.1
        for <linux-hyperv@vger.kernel.org>; Mon, 12 Oct 2026 14:23:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791840207; cv=none;
        d=google.com; s=arc-20260327;
        b=XWwGMG9ww14nPyQJkymhA4/s7mZPWbZCeqRXcS+wTMT9/Vst76vs85KVBnayThygWr
         uIPejc0Xb8r2zW9Z2BRS29ldNgSrdL4geWD73139wsivbzQmssm5VebF/2gkMI4U1XYS
         hKjJ7EtDgyjp5i26WSOpk8mIklAj+vH4EZW7NxICnT33NFfcPi6o6OM/PcfxcR7m80b4
         nwHV+dCYepfIhv5KX607X/jUAG48p0qzWYiVM7zd7LEefNuWlFHQvDBsTf70Jg3cyJOq
         TktFv2H+hdRYrnlNcCqqJypSzX7inM4rgJlzmJ9qBGeWXf3YlkQgvdO632OF6bUKHnqZ
         3UbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Ee4DfkcYbf3IOngkIJrGviVyrMh0yvV16mhd+eYxirU=;
        fh=xYrQmemdqp58EK4di5yCrLkZA33juPE6WEdJTg0Odw8=;
        b=GDfdS96L7JpIdacSKylxB2o6pe7l6S0Jda9j/f7eUPiGSGg2+mmPmZBNE/JTI8vrMT
         AwJWl5mkhcw1QdBJF/kyyDjseu035YsRKy1VTBRTd3KFYfQqZ08TY5OdqoDS9176EYcz
         OTXSbu2/UHIVbV/gg985xfckau+AgKEFuFcKVXU39IwWRlkubzHax2qBPebLEX+KApDl
         BNXS4tUE94AIftrKtGiWhZSI0yo5+VXSeBTCWJg1Cgon3mS6Qk95yw0NzoVZxnWvhdyl
         +UFuY3Yg4fXZ6HVNfAF20VcsS9hODx6v2V+j+cJzXLw7ZYLp8VzX1sTgnV6L4MMn0Rrr
         YXlA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791840207; x=1792445007; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Ee4DfkcYbf3IOngkIJrGviVyrMh0yvV16mhd+eYxirU=;
        b=YxyjDzyYf6cnh0FGlyV4iPCczRMiNCHVZdq6ohQBqN6eDGCRuRPUDnWlsXdkEHzwt0
         tS5s1EAYYZYZjZ8Zq8XnqwSc7MDU1+7WMrUR6eGLaR8fkT96LOrmcchgTDd4TDn90xc+
         QXZH+ewhwhNumewH0GMLanH1ZmpBL95gIELragGoWu1RVWJm7py86QkQo6MLlT9qDz/u
         VqmcK0H9c8KRoZJLR+8JzXoWVE1ET895yQ1dnQ5K+d1RRDNg1ReLwRdBNfXsV+8r1uAN
         dF9XOSVVpwM5qBr/T110MiMC5saFB1LwOC4ls0+pHu4d1tXvxpMgjlnwoVLSwL5Ls5CI
         5TXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791840207; x=1792445007;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ee4DfkcYbf3IOngkIJrGviVyrMh0yvV16mhd+eYxirU=;
        b=DRAFpp4zfhnmRuC/yCL0Ojhh36BcLoWSKvJOJASdkrPMhXktZcly9cd3+PeIpnDWnu
         +p9PF7GkD9F5g1CUAhyF57fGRz8RRJtnEB1KNLsf+6YIzpohoG2nVZqNIcTeTRpUJV1i
         n5f9A8oQx8SqAzjExAWNKxyUlOAaojSQf1UZZtFP//JZNVrVjZZHyh1G9pPq8U5NWjTB
         ti44GbZH1IyteIw3aSeLSSe/oaohv+s9/LWujN2m7nQI/UBAg8Ccu+S8swdfCPdKwCUb
         aohq88gKRJiIx+gAO3ooY3uINqM5OL1U4JATlePi1UMIsGeVxhIJ5owi3iZL8Nw32bG0
         cTRA==
X-Forwarded-Encrypted: i=1; AKwUvBw5C9SBsdbarDNa9d5+0rhWm1KdOPvwj2H+adkyU6UUev5QyAwthTwwQj+KGzr6fsiBVCfvF6XnFGjof9I=@vger.kernel.org
X-Gm-Message-State: AFq9FYJC6APIejt6LDrsYxW/ZCxfq6yEK8U9DGog5eBV5qPJVU1gT0CJ
	iuFJr7WZ6bS17P2QapDY+OMUB9N5INlZu3rZnmL74swX3pA1hKxfUoCH2NzCA7yZ3ZhrCzOVlPW
	wZt2rcUHL5LAgazAcZ1rILFze8sbc9zqIvYNucwRg
X-Gm-Gg: AYBFou2QS5gTYGei27MVuVTj27pWK70A8BQ7lEjRoC3xcdCNCAAMEps8girEce2gXxz
	y+L1KukGDXDbpDC1mYyN9jYkTjGX0TobLZG0igEqAMk2hEPRo2MTEWP0LyFOJTKARFdkNqJzZWo
	bYO3OeVgR6AvdIKlogIhV07t88ZGBXL0gUqEoCGNgsfWYc6rkFY+k6CZ5W8yqq2kqblj12qUHZ6
	FV/PiUXJpFgWQ1ow5uU4bbzTcfMAbNywdSThpR2Q/bqmVQ8e5czUiMyiDEUP3UjUf6/125YP2/p
	CN78RM+9MyJg7Hk9ZVkIS8TGL6JPm4RV2bNnfyFfSb8Qzse9pkXvfCA=
X-Received: by 2002:a05:6402:a203:20b0:6a9:f353:ef65 with SMTP id
 4fb4d7f45d1cf-6b1988db8e0mr99917a12.5.1791840206242; Mon, 12 Oct 2026
 14:23:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261005192431.87317-1-hmushi@amazon.co.uk> <20261005192431.87317-4-hmushi@amazon.co.uk>
In-Reply-To: <20261005192431.87317-4-hmushi@amazon.co.uk>
From: Jim Mattson <jmattson@google.com>
Date: Mon, 12 Oct 2026 14:23:12 -0700
X-Gm-Features: AclHuK_0KBTsLrSFa-h9vss0cVbmlNZ4lJ9qkYRPDWcihjTkz5_I3EkMbPan9w4
Message-ID: <CALMp9eQz2ouQvFhBYv_R33_sUQ+ehxv__-f5iZ=_3aA2Guwy5w@mail.gmail.com>
Subject: Re: [PATCH 3/3] KVM: x86: hyper-v: Implement HvCallRestorePartitionTime
To: Mushahid Hussain <hmushi@amazon.co.uk>
Cc: kvm@vger.kernel.org, Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	"K . Y . Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>, linux-hyperv@vger.kernel.org, 
	linux-kernel@vger.kernel.org, nh-open-source@amazon.com, mushi.shar@gmail.com, 
	Todd Frederick <tfred@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 5, 2026 at 12:26=E2=80=AFPM Mushahid Hussain <hmushi@amazon.co.=
uk> wrote:
>
> A nested Hyper-V that sees the frequency MSRs lets its parent own
> the partition reference time. After a resume from hibernation it
> issues HvCallRestorePartitionTime (0x103) with the TSC and the
> reference counter it saved, and expects both clocks to continue
> from there. KVM rejected the hypercall. The guest time base stayed
> inconsistent and the root partition did not run.
>
> Restore both clocks in one pvclock update, so no vCPU runs with the
> new TSC and the old reference time. Each vCPU computes and writes its
> own TSC offset from the recorded step, so no other vCPU writes its
> TSC state. kvm_synchronize_tsc() writes the offset of the calling
> vCPU only. Mark the TSC page as changed by the guest, so it is
> recomputed even when TSC emulation control is set.
>
> The TLFS marks the hypercall, its input and CPUID 0x40000004 EAX
> bit 20 (RestoreTimeOnResume) as reserved. Microsoft's hvdef crate
> defines them (hypercall::RestorePartitionTime), and Microsoft's
> OHCL kernel carries the same C definitions in hvgdk_mini.h.
>
> Advertise bit 20 and gate the hypercall on it under
> KVM_CAP_HYPERV_ENFORCE_CPUID. Hyper-V offers hibernation to its root
> partition only when the parent sets this bit.
>
> Assisted-by: Claude:claude-fable-5.1
> Signed-off-by: Mushahid Hussain <hmushi@amazon.co.uk>
> ---

Aside from what Sashiko and David have already said...

> +static u64 kvm_hv_restore_partition_time(struct kvm_vcpu *vcpu,
> +                                        struct kvm_hv_hcall *hc)
> +{
> +       struct kvm_hv *hv =3D to_kvm_hv(vcpu->kvm);
> +       struct hv_input_restore_partition_time in;
> +
> +       BUILD_BUG_ON(sizeof(in) !=3D 32);
> +
> +       if (kvm_vcpu_read_guest(vcpu, hc->ingpa, &in, sizeof(in)))
> +               return HV_STATUS_INVALID_HYPERCALL_INPUT;

Nit: some validation checks are missing here. Per the TLFS, hypercall
input parameters must be 8-byte aligned and must not cross a page
boundary (cf. kvm_hvcall_signal_event()).

> +       if (in.reserved)
> +               return HV_STATUS_INVALID_HYPERCALL_INPUT;
> +       if (in.partition_id !=3D HV_PARTITION_ID_SELF)
> +               return HV_STATUS_INVALID_PARTITION_ID;
> +
> +       /* The guest asked for the step; recompute the TSC page as for it=
s own write. */
> +       mutex_lock(&hv->hv_lock);
> +       if (hv->hv_tsc_page & HV_X64_MSR_TSC_REFERENCE_ENABLE)
> +               hv->hv_tsc_page_status =3D HV_TSC_PAGE_GUEST_CHANGED;
> +       mutex_unlock(&hv->hv_lock);

I think there's a window here in which another vCPU can consume
HV_TSC_PAGE_GUEST_CHANGED before kvm_set_clock_and_tsc() steps the
clocks. If TSC emulation control is enabled,
kvm_hv_request_tsc_page_update() won't invalidate the resulting stale
TSC page.

> +       kvm_set_clock_and_tsc(vcpu->kvm, in.reference_time_in_100ns * 100=
, in.tsc);

When stepping the reference time forward, don't we have to recalculate
the hrtimer deadlines associated with armed synthetic timers?
Otherwise, those hrtimers will fire late.

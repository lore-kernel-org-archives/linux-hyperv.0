Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 188453D25A2
	for <linux-hyperv@vger.kernel.org>; Mon, 12 Oct 2026 19:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791833379; cv=pass; b=HfZxQ0gN3fguM1yoP5qNBlQ8T+f4XT8oj+DC6KnvY9B1ONnluWabW2OsvjJYPj/ZYaDAsJ44gS/hQIOfOkgiI6TgUR8xVu37pYaOMnjrzkshq/P8E2Q+bw7BnFrHv3XfcirLON6oNPfGjcf6Rzh2WhIaMVWdRsrUc/Xqj2alG2o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791833379; c=relaxed/simple;
	bh=aoPqNjug6jdHt00ush3qNX20F7lS1qZxd63aAzecos4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mhVwqJRnPZoWR2CdTiQ90MePR+kzx0px5Yb3clFJIKmzfEh2+dbGlMGn3bKxj2JVW7QeBUj+NZAYh1OeztZeIC9oX3DJzfP4GAj6nat7RbsqZs4qn71+EO9AjwPoEgxzYwRLXF8ZgBcahTFJ0DP0UI9OmmlI3X49+MEwOEvg9Zg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Afe/3Zr4; arc=pass smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Afe/3Zr4"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6ae14cdc63aso15148a12.1
        for <linux-hyperv@vger.kernel.org>; Mon, 12 Oct 2026 12:29:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791833376; cv=none;
        d=google.com; s=arc-20260327;
        b=CRRpNhcrzh/vI08toNsWQVUBb8/nQg6ZxFYoK8HsWd75A9g6YGbCWORllDOuIXSu2Z
         IFfyGtYmkAKdweg8Nvd0WRLhaE0i/1DWyTCaXo14u2zqNWShf2M62xDiE4bHetoFbzeh
         wARI+5DinoTS9Zw5Pf6pcrOtY1Q2UsdbHbaoI/FmqhfPSzAW1dOiHfhlQ088mX9RK6XP
         g310ma3CK/HJAk7O+MkpzIfCkbWnkV4rqpfhK2YwcMF5m+q4gK6jGJZ7Bgv84vvDQtIz
         /mFGUs9ElVNuJXopScfiF7ui1JefhgemDqNhuOa5zw7UvmtN9YVn1VOL2tLYprdKsMEl
         dq0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=aoPqNjug6jdHt00ush3qNX20F7lS1qZxd63aAzecos4=;
        fh=b2qyBkUt+5fsjsIFleLFMe2Dq5b6ThKBqvUeTo0kn6U=;
        b=YFQkOMbGhbb84YYrFZ0FHRInyqThDA6CyYjK/mebjqMIyYatf78I3JT3CD6s8ZCk7h
         JHmQxba+UTkpVnZYtOjD+ivHkOJKfYyv/4nBWTTDdIVD6Qp16YwEAfPmZ6y1CnhvEbZc
         gCqMB4yaBttpEi0YNjm9FiLkZz5KLhocrkZ5/0Pn8zMusYK/XJte5h0/ZBro07wSJ2YS
         brStfANJFrKmDpluliS7s9ff5IZY762vkepSVRnguNbUje/L0ZDoNr1H7DuprFt2KBtQ
         YRMokN2FHhSs8LpGT+JGjBKKmKVL0alEDzUh1orDwmbNkfhrum9kTx2Vf1qvrAX+Sr+g
         bZ9A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791833376; x=1792438176; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=aoPqNjug6jdHt00ush3qNX20F7lS1qZxd63aAzecos4=;
        b=Afe/3Zr4ZBhFeXjfVNJcs5SlL8kH9Hf4n+lQ9CVzyQqXgqdq27opBUFIMFZdn2VRCP
         k7yVRUfPkGSbUSMqtxqRmmH8/OXpVZ4uXfJZAbeDOYPxQcJOEYAbB73gJxCGFQc8HJcs
         FK3N9Kez/I5hywoERU+iTFa9YoLWPiLEKMdnQn5Jzx6f6sTgvP9YHszAr8PWKlbGftEl
         s6RHPCMOr+ekjfOVGp3kfBSvmttbwYdICha4KSmjOVKRI2h34OQUMguffv7ogVewEae2
         3YXkRZ13tctZ9CZ3Itwje+mrr3IUm8TnsJEmcTshBjWKi/P4GNtJ10EcSfCDQ/3JtCPy
         HRUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791833376; x=1792438176;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aoPqNjug6jdHt00ush3qNX20F7lS1qZxd63aAzecos4=;
        b=OmWkyh6nVMIzfOiB4lib8Yk09o9PteR9sWEssJ+rgwkxGBb7QKZZZwPwY/FJ8VRVje
         8O6JI9To2FUEk3Jyx4VgJVrWucTeLp/IfSFVdt/f3JauJLgAhuFly9ZhgrJCGw8r0zxY
         dHIBP60FUsKUNcdXx950o9Dm0BE+NqvZ74y/C1ufslehlN8PHMCTjtzCrJ8qBuswfl08
         nQpFnXaJBZ0hDTq9sy1+Z2GaMDzdrjPBQkieyifBebMkw04YptYgeemSZwrynd8ucUUi
         xRjvxVvMnC3QGzof8/dfKHtphNYLp0JvYyBsgFriBIR6ZSePEioEilG3WHrB4auxugNn
         NwUw==
X-Forwarded-Encrypted: i=1; AKwUvBx5b8za4K0lR5Osboe8nHwujsY1GcWWugX8ydM+gm40LhRlo4X/mrqVMrydJ8CAoMa58aQUproyYsxBQCk=@vger.kernel.org
X-Gm-Message-State: AFq9FYKkGHYY0Qm+mePaiL9V0YPs4M155myTCBUZ35Dw1Xycslw28Z3T
	zwwtXF6sz4tekTF4GZqw818BhaIJHEt2zvK9QItKCqGZ4f2lPv9C0R1RFJ8Y26WftrvSo3ObHIe
	GsbZ1Ga2eFGGS3RebqSwTewD8iQRDGecnSrpWgS4k
X-Gm-Gg: AYBFou2uQZz+tIjum4bFPiNAAt6e874O8ww+OV0c5DIfRSxUk3hJ1dGVdODjPU2exhO
	Z8g/kpJTVa6abm9fjxGreSHxIWCWTGVQ2NRmJq8/MF2cxu/OqozoooU94WWvENkTEaytBPhVNKI
	7pKX/gGFW8uTEKb7a9r2FhCtAmHpqxqlzYI2MJ7ggXh2TLIPV6GlXp4ynIISYFf+TyKzhkDduti
	APsCNcQ5Xy41cYmc6HS3+7lTKnyPT7DLfu0OQi3M6d7cG/nHVIcrlQ/LNZKrRCXoT2BNNL+QIEG
	7czb3DTB+7selBkq+iJTXbnYZvrs7MR/9SV5d9Chs/hODrCRmJ/RTSk=
X-Received: by 2002:aa7:d58b:0:b0:6ae:188e:e119 with SMTP id
 4fb4d7f45d1cf-6b199a610c8mr109200a12.9.1791833375825; Mon, 12 Oct 2026
 12:29:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261005192431.87317-1-hmushi@amazon.co.uk> <20261005192431.87317-2-hmushi@amazon.co.uk>
In-Reply-To: <20261005192431.87317-2-hmushi@amazon.co.uk>
From: Jim Mattson <jmattson@google.com>
Date: Mon, 12 Oct 2026 12:29:24 -0700
X-Gm-Features: AclHuK_hh2UTJ_clCzObOqLEy25Uk0BI6IitQI982CcGkWt3YHwLApApzuL7Il4
Message-ID: <CALMp9eQB_FmUocuEf8hTYVVWoOTZCWzJ1LhHm__BaVoNX8wKMw@mail.gmail.com>
Subject: Re: [PATCH 1/3] KVM: nVMX: Clear stale vmcs02 sync flag in free_nested()
To: Mushahid Hussain <hmushi@amazon.co.uk>
Cc: kvm@vger.kernel.org, Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	"K . Y . Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>, linux-hyperv@vger.kernel.org, 
	linux-kernel@vger.kernel.org, nh-open-source@amazon.com, mushi.shar@gmail.com, 
	stable@vger.kernel.org, Todd Frederick <tfred@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 5, 2026 at 12:25=E2=80=AFPM Mushahid Hussain <hmushi@amazon.co.=
uk> wrote:
>
> free_nested() frees vmcs02 but leaves need_sync_vmcs02_to_vmcs12_rare
> set. The flag means that the rare guest fields of vmcs12 are valid
> only in vmcs02. After vmcs02 is freed the flag is wrong.
>
> L1 then executes VMXON and loads a vmcs12 with VMPTRLD. The flag is
> still set, so the first sync copies the rare fields from the new,
> never launched vmcs02 into vmcs12. This sets TR, LDTR, GDTR, IDTR,
> the segment registers and the FS/GS bases to zero in guest memory.
> set_current_vmptr() re-arms the other lazy flags at VMPTRLD. This
> flag has no such point, so VMXOFF is the place to clear it.
>
> A nested Hyper-V follows this sequence when it resumes from
> hibernation. It executes VMXOFF before hibernation. On resume, it
> reloads the VMCS images that winresume restored from the hiberfile.
> VM-entry fails with exit reason 0x80000021 (invalid guest state) and
> the guest hypervisor resets the machine. vmx_leave_nested() also goes
> through free_nested(), so KVM_SET_NESTED_STATE takes the same path.
>
> Clear the flag together with the other nested state.
>
> Fixes: 7952d769c29c ("KVM: nVMX: Sync rarely accessed guest fields only w=
hen needed")
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:claude-fable-5.1
> Signed-off-by: Mushahid Hussain <hmushi@amazon.co.uk>
Reviewed-by: Jim Mattson <jmattson@google.com>

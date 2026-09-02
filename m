Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69D0837B020
	for <linux-hyperv@vger.kernel.org>; Wed,  2 Sep 2026 06:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788330620; cv=pass; b=umLjMMjIaBBu5vAbgi47eppcDPptIp/RzekufgoUkdkIm0/uawhwXBi3EITnMBMXOyTrnpHRH1ctvI4PXtWgqJVunyt0nxIilv/1BD79WcdvjP352QrDXRD2rwzxFI73ObHCtSSEMEZ7f+vKBGTR2f2bagsUGCq2t26404FB/gE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788330620; c=relaxed/simple;
	bh=hqXX916iabVWIaVT+yLpLwAMtJOlKrOokwbeDU8nU94=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bcfiaKvZFamrpTd1wXJzIz52hqtWj4ZKhSATlQS/ujK7jeD8Rt6Qj0JajPb4Y+Egof07ExC0Z4m3UxmQJaQXAWcoZOXEnKUkZCDtVOZRAqiOWzjO1/in2Lt1TTOID6tR6pvYGcm3oFR2fwdQFh1qHo5YisDwR4uusRwzyJrHMTw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NRQAafHM; arc=pass smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NRQAafHM"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2d5cad1a6baso6073785ad.3
        for <linux-hyperv@vger.kernel.org>; Tue, 01 Sep 2026 23:30:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788330619; cv=none;
        d=google.com; s=arc-20260327;
        b=qMrZ0nRktcBoMTiFSNqzqAJu3OoQ+Nowd/87WtU4nboRm+GAj4tMC61TFiHzqjTU9s
         9B5gU0bkgTnVlu7U9OBFwjQXt43zy/xpzdJtwRgQTPGHn+DDUnVbdQh3mYf9yjiGashK
         HdJYLfwzGo5Qw0zgN6fPVCfe7X8HAvGCjV2gvAuMgHLe3UxKKbvW+oT+6DELttCjMzNG
         w+vDumRvE8R++ilw/erQuZWTtcapGCDqFwI46cYHN//xZ0GyKmPhHziREJCssaTuJVFK
         7tlYNxP7ua93urr1639YkyQ0Mt8GXwzl0nxE/BaAUAb4UuGWDQjn7AvkdmvaNiTaqTWC
         g8bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=uSdUTO5pFYDk/RdXIauhZ/Y8HcVVZ3tNgjyl9k6n1+k=;
        fh=x2XnT1PMewG0qIJF9zmGkH/9leg9xCw8R48LJr3phcc=;
        b=OuzJ8XJLl2G59FT+XGfbA7aK8d5YL9Gd1Y9FOuvCGhuCYE9eZIbOFD3khg2Q4eteW4
         abZ6u74WWFS2cQcWhl849LgfBhq/4YizIGOq15+NvkpjTZ2idePGYKQsG0V7zIokv4L5
         qZt7DyM+x2xOE+Zkyb19I/AurWOhV1wj5Bed+PUXlhX2t5jwrQZQfBKq2cMmcEWEH8+u
         3kb2Rnm0PduekShhJLtd82bwTIG266WxQ1KnCj0aizDx/lMrl6vAs9fYe1NLPlg++0F2
         pZLLKnAehIsFbiAfSrkK3t81JKQ5p3YZzE6v1AY4kKkqyrwg8m63ugYy88ED4/BtY8ZC
         5fTA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788330619; x=1788935419; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=uSdUTO5pFYDk/RdXIauhZ/Y8HcVVZ3tNgjyl9k6n1+k=;
        b=NRQAafHMwMHeuZW+gBwZKd7HuAgbAQouLRG23W77zrFaxCESS6+3k3FQxKP3Sr5RqX
         tDjNdYE14Dp+7mKHfBjo0lIOyXA6kYcaRI2p7vEd8kR/x2lilXWqHKRwUGVjf+Vmag35
         v7NYypvUGqWwmiyNu4LrhtvKPQm8hKDn4OtqKg5WnCj40TpBwlzknontBqhor4FHp/74
         41ByciO/4DYVwD24pCeNCz4EFQArYYsPF3r5kqoeSoh8eoWctKwrGDIT+3amtX4OmX1t
         AsNF703Ww6QRUpBDZ/XSPlauMIi/KZ/D4GhM67/QqBiV0HabVsVGxOtietr7iadF8cwy
         1rjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788330619; x=1788935419;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uSdUTO5pFYDk/RdXIauhZ/Y8HcVVZ3tNgjyl9k6n1+k=;
        b=a5VKnWYFbbqOS71y7JiSfPvLtglhFapuvp0KHscNUjhsS+vrx+xe6nAFcBCLpD5Wz0
         0qE6FFouD/XlNnP2u+LZngSE8QyLnKjYHMtbVf65mFT6y/Z1GCqKx/y+CTvyxFnmrlnH
         xY/Bs0vOqbAif7D9efXeAP6JV3gEx1YRj3TSorPGoZKCpPtaULHfWO0CBjZXgpq7HIB6
         vqxIXijUXkXNqm0XlVoZ07c6ZXHp6GcVhakwCt9cMvmCSdCgspg8s4fV4uJNi2Pz9hWP
         H4F7M+1M4fIRjTPk7H+/vO/c9B6yGnopluURHs3nfb9mKfHppGirmoxxf7kjMt9Agf3S
         Lv9w==
X-Forwarded-Encrypted: i=1; AKwUvBxHO5BoI9/fA4E3BkH9RoeQdWwTjr9/Re6pSCLHawq01EIUl86rUGanLl3lAYqw+DSXVpa3rgk5kmuxvic=@vger.kernel.org
X-Gm-Message-State: AFuF++nYwXPsvC9TkasnN5eZfFi/xLA0kBnVPggFotyACVAs8VQgIB0r
	oi2xA+c/T6SqQUFILDW6xU9yi88fcEfpVktN/Eug35ZgUyj1heKi+SYsj+50vtpnPlwR3yoAIEm
	lN3d0ljH5aQbAu3zZJev5QW/ytSQxabY=
X-Gm-Gg: AYBFou1SgD29SW65bVAEu8UuvIC8bv98S5AG3+xyf7GJ5KTG34QGCWJIbyGz5bw9xKy
	vZ++vREawFzUH4akdDsMptN87v+4rE6bGbYU5FD1J8yKk2yqR7yqgxJOIiVe6eI96GQpij0ErMX
	9WmV+RzEg6hsLnUVCWU6C1+L7Arb773/u3qYADYS0DoDN+H75peuVzW+OWd65OwnV8Y0Abax+M1
	R+gKcDvftmyNYHFvjstXpkyAtFPeDkQXnNHVxSkwPnP4OP/PayUsNZU2q/GgC/4U18xPTwFrFD/
	GpEXvdmUGuIRWWQE5DdVFM+oV2v8SBAe9kk3ILp5aC/wWSvM3qyfEsTA
X-Received: by 2002:a17:90b:5606:b0:398:9be6:f996 with SMTP id
 98e67ed59e1d1-39aee1115e0mr4127538a91.21.1788330618532; Tue, 01 Sep 2026
 23:30:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260902030127.581040-1-mhklinux@outlook.com>
In-Reply-To: <20260902030127.581040-1-mhklinux@outlook.com>
From: Tianyu Lan <ltykernel@gmail.com>
Date: Wed, 2 Sep 2026 14:30:02 +0800
X-Gm-Features: AcwNN1WbeMKUAbOCq_nM3KSlOWjFb_TW0sxASOv2OLNMYayJ0082OMFXrWDXWXA
Message-ID: <CAMvTesAKMHYC36QViaUi_cw8-gSkBQyJtCd+Kt73HoDaLOkwUQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] x86/hyperv: Avoid using per-cpu output page in hv_apicid_to_vp_index()
To: mhklinux@outlook.com
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org, 
	decui@microsoft.com, longli@microsoft.com, tglx@kernel.org, mingo@redhat.com, 
	bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, 
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 2, 2026 at 11:02=E2=80=AFAM Michael Kelley <mhkelley58@gmail.co=
m> wrote:
>
> hv_apicid_to_vp_index() currently uses the per-cpu hypercall input
> and output pages. This function is called when running in VTL2 and
> when running in an SEV-SNP CoCo VM with no paravisor. In the former
> case, the output page is allocated, but in the latter case it is
> not, so the hypervisor stores the output VP index in memory that has
> not been allocated by the guest.
>
> Fix this by using the input page for both input and output. The
> hypercall has very small input and output, so sharing the same
> page for both is straightforward. An alternative fix is to
> allocate the per-cpu output page when running in an SEV-SNP CoCo
> guest, but this uses significantly more memory, particularly
> with larger vCPUs counts.
>
> Fixes: 86c48271e0d6 ("x86/hyperv: Fix APIC ID and VP index confusion in h=
v_snp_boot_ap()")
> Signed-off-by: Michael Kelley <mhklinux@outlook.com>
> ---
> I'm not aware that this bug is causing any real problems because
> SEV-SNP CoCo VMs on Hyper-V are rarely, if ever, used without a
> paravisor. But it was on my list of little clean-ups to do, and
> a recent Sashiko analysis [1] flagged the issue. So the best thing
> to do is just fix it.
Reviewed-by: Tianyu Lan <tiala@microsoft.com>

>
> [1] https://lore.kernel.org/linux-hyperv/20260901171238.834601F00A3A@smtp=
.kernel.org/
>
> Changes in v2:
> * Make the new code a bit cleaner by dropping the unnecessary cast
>   to u32 *
>
>  arch/x86/hyperv/hv_init.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
> index d5edc8530964..2a71c70d7e27 100644
> --- a/arch/x86/hyperv/hv_init.c
> +++ b/arch/x86/hyperv/hv_init.c
> @@ -731,7 +731,8 @@ int hv_apicid_to_vp_index(u32 apic_id)
>         input->partition_id =3D HV_PARTITION_ID_SELF;
>         input->apic_ids[0] =3D apic_id;
>
> -       output =3D *this_cpu_ptr(hyperv_pcpu_output_arg);
> +       /* Treat input as having 2 APIC IDs so output is 64-bit aligned *=
/
> +       output =3D (void *)input + struct_size(input, apic_ids, 2);
>
>         control =3D HV_HYPERCALL_REP_COMP_1 | HVCALL_GET_VP_INDEX_FROM_AP=
IC_ID;
>         status =3D hv_do_hypercall(control, input, output);
> --
> 2.25.1
>
>


--=20
Thanks
Tianyu Lan

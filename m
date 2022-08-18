Return-Path: <linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E50EC00140
	for <linux-hyperv@archiver.kernel.org>; Thu, 18 Aug 2022 17:57:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345110AbiHRR5P (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Thu, 18 Aug 2022 13:57:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238647AbiHRR5O (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 18 Aug 2022 13:57:14 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD299BD136
        for <linux-hyperv@vger.kernel.org>; Thu, 18 Aug 2022 10:57:13 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id m2so2137377pls.4
        for <linux-hyperv@vger.kernel.org>; Thu, 18 Aug 2022 10:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=e05CvhD1ZUMfUEn0ZBtVumUZSqrCVNyPhu4vjgJboZk=;
        b=GwhnujooADK3rszphRziElGJZtVU6I4Xqb2RegMVbHwxkDtnNjHHcO7HvUgubyZ6YE
         3DI0cPXr7G9dxjPwO0boNSu9Hl/sHI6xRb+ZH65pXNSdoAAy+XEI0u31PqqqeflFF7Iy
         Ygy0xx0k4tO1fkUMYX4P9KwhdRwlMwa6mdxXh5V82ap/rr6VZYDcSz5m8Ix0k/2YbUHj
         83W7GnqbHg2EPAQVYo+tCZ1LIs19d6V6vqf1mbLQ7LHUAXIbjO+YlTQ34gjLzu8rWx+I
         ZXfsxvZYUy9tJ2BWM9BH+fJvkk6JYvJtBvaT5qqDmLZCG7QrTBXt4FD+pZJJzpOWMn4x
         uUkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=e05CvhD1ZUMfUEn0ZBtVumUZSqrCVNyPhu4vjgJboZk=;
        b=Ca1aERg9UUqDVe3jOtkyPS+WwWFyab1o3rhPX/76AaHg1d13DjSzMQDHlSLi52B++j
         FH7kDcT/4pmktAkRCOWqq1626HjF4HXewpvlbeUynUSrRMVpWKEAlhA6v5+yFBMn8ksP
         iEHWwh/cSkufbvvYB1GDy0iKEOzSDcshw4iw4Ld7H1pAsZ6H7/2YbXPAiUI9G9HnHM0g
         F9ujSNi5jrr11rwAb/6C6+n65wwcEyPMENANz1KtAP91zuZvZozNZX+DkC3yGnCRzzGE
         1a3wrs3qAdN+O+93ml5s5//EgtWFPoKdmFNEqNmvER78FXOT8IDOuIswJmWqjDuwU5/b
         0U8w==
X-Gm-Message-State: ACgBeo2N5Gk4nhXOOwLtLpLpigADjw3+tXYCgaKQmpiFqIBlLWnN1fLf
        lP6huMu+4IuDK/dZaj92pSAUCg==
X-Google-Smtp-Source: AA6agR75A+8wg2SArLXRaSx/ZSkJUYWTpOGjlEP7zhjOVSUgNBN48pNQJguDQLLN9jD5AyqVgoA7RQ==
X-Received: by 2002:a17:902:8b87:b0:16f:1bb7:984a with SMTP id ay7-20020a1709028b8700b0016f1bb7984amr3494576plb.113.1660845433071;
        Thu, 18 Aug 2022 10:57:13 -0700 (PDT)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id a7-20020a170902ecc700b0016dbdf7b97bsm1675133plh.266.2022.08.18.10.57.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Aug 2022 10:57:12 -0700 (PDT)
Date:   Thu, 18 Aug 2022 17:57:09 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Anirudh Rayabharam <anrayabh@linux.microsoft.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 03/26] x86/hyperv: Update 'struct hv_enlightened_vmcs'
 definition
Message-ID: <Yv59dZwP6rNUtsrn@google.com>
References: <20220802160756.339464-1-vkuznets@redhat.com>
 <20220802160756.339464-4-vkuznets@redhat.com>
 <Yv5ZFgztDHzzIQJ+@google.com>
 <875yiptvsc.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <875yiptvsc.fsf@redhat.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Thu, Aug 18, 2022, Vitaly Kuznetsov wrote:
> Sean Christopherson <seanjc@google.com> writes:
> 
> > On Tue, Aug 02, 2022, Vitaly Kuznetsov wrote:
> >> + * Note: HV_X64_NESTED_EVMCS1_2022_UPDATE is not currently documented in any
> >> + * published TLFS version. When the bit is set, nested hypervisor can use
> >> + * 'updated' eVMCSv1 specification (perf_global_ctrl, s_cet, ssp, lbr_ctl,
> >> + * encls_exiting_bitmap, tsc_multiplier fields which were missing in 2016
> >> + * specification).
> >> + */
> >> +#define HV_X64_NESTED_EVMCS1_2022_UPDATE		BIT(0)
> >
> > This bit is now defined[*], but the docs says it's only for perf_global_ctrl.  Are
> > we expecting an update to the TLFS?
> >
> > 	Indicates support for the GuestPerfGlobalCtrl and HostPerfGlobalCtrl fields
> > 	in the enlightened VMCS.
> >
> > [*] https://docs.microsoft.com/en-us/virtualization/hyper-v-on-windows/tlfs/feature-discovery#hypervisor-nested-virtualization-features---0x4000000a
> >
> 
> Oh well, better this than nothing. I'll ping the people who told me
> about this bit that their description is incomplete.

Not that it changes anything, but I'd rather have no documentation.  I'd much rather
KVM say "this is the undocumented behavior" than "the document behavior is wrong".

Return-Path: <linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68413C433EF
	for <linux-hyperv@archiver.kernel.org>; Fri,  1 Jul 2022 16:03:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231345AbiGAQDN (ORCPT <rfc822;linux-hyperv@archiver.kernel.org>);
        Fri, 1 Jul 2022 12:03:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231297AbiGAQDL (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 1 Jul 2022 12:03:11 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 006F5CD6
        for <linux-hyperv@vger.kernel.org>; Fri,  1 Jul 2022 09:03:10 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id u199so4166190oie.0
        for <linux-hyperv@vger.kernel.org>; Fri, 01 Jul 2022 09:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rqJwHgmuBoxIt5vyJ91QW4DLByGUx5uWYxmbDTSBAHs=;
        b=VywtSoL1CTz2IcDC1UnChIFSEQg26g5qy3uVpJLlxOiDpHgfueGl+AJ2Ho7YdeL1VJ
         diXLfccXWkdUu56eOBb8/T2Z553tlASEgvNics8H0nnjUgbetB1LEKE6VCtkx/4dX0ic
         SY3RbTlUCn7kqm9AIL8X0FBlHikbBrjeO7os283DggS+b+pnndUbWtodmPIaNmqkelC3
         BW4pt+hE86H7pIMhlscJmimNRkl+Aun0/qxu4gMfR+NN4IPN8B0zKGQ0xpqoCTPT3+An
         tJR+gKNwy1M2gF8Sa8e/P+CaL1pxLKIbMUTO/Rosb7iqcHHEB2dFti+dSDF3E8Ni9X2Z
         sQAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rqJwHgmuBoxIt5vyJ91QW4DLByGUx5uWYxmbDTSBAHs=;
        b=dLm6uiVdWisPxWHHiKCNzVKG9ptRn+CE7rJp6PJ30sm2T7g+GZRWBJvow9zy5oLQZ9
         Ni8igct9eDSTy3vvewiIfhe+yrC2R2nJYK5l1leZ/rBztgdDJlCqefhV2kspt3zJyai4
         rsMPxQ54Ji89sAYZpELnyay2bVIuuT4meX/94ZtC0tWxAh5MZB+dzn/pgjhgflR8Mwrs
         YlVfIM18WGg06Hmq4jkE1E+kbtjyfSYcbCqjERHl2P9HTgGNFxoziHBZqwXnN8lOYW8j
         LrZcoZBmaAPXEHZeA8d5QhBrJZjoE4O46PcXorxrYTrSOYlJch4OtrA78nDFJ3sE2hXx
         QvIg==
X-Gm-Message-State: AJIora+jCpRxFOIUs+1NUy2yt8zCz2hNtY9l8VuP6ZqlaFWtKgQMcw/b
        tWkasjScFFWbm2dLDhBQjYnaEqmgccf3wQbstE/RoA==
X-Google-Smtp-Source: AGRyM1uRa9Sidpo3z6KZT3YxqtiTxT8O/4sGDDwSBBqVSkVSRDKb4+wrt9ouf45phdlZFYvPXTUA07bEPbYOM0DUm48=
X-Received: by 2002:a05:6808:2124:b0:335:7483:f62d with SMTP id
 r36-20020a056808212400b003357483f62dmr10390571oiw.112.1656691390201; Fri, 01
 Jul 2022 09:03:10 -0700 (PDT)
MIME-Version: 1.0
References: <20220629150625.238286-1-vkuznets@redhat.com> <20220629150625.238286-20-vkuznets@redhat.com>
In-Reply-To: <20220629150625.238286-20-vkuznets@redhat.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Fri, 1 Jul 2022 09:02:59 -0700
Message-ID: <CALMp9eQjxwNLEV6f-xh+7DpfZ=og_Zf0B9isDqSa2KPMaj8wgg@mail.gmail.com>
Subject: Re: [PATCH v2 19/28] KVM: VMX: Add missing VMEXIT controls to vmcs_config
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Anirudh Rayabharam <anrayabh@linux.microsoft.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, Jun 29, 2022 at 8:07 AM Vitaly Kuznetsov <vkuznets@redhat.com> wrote:
>
> As a preparation to reusing the result of setup_vmcs_config() in
> nested VMX MSR setup, add the VMEXIT controls which KVM doesn't
> use but supports for nVMX to KVM_OPT_VMX_VM_EXIT_CONTROLS and
> filter them out in vmx_vmexit_ctrl().
>
> No functional change intended.
>
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
Reviewed-by: Jim Mattson <jmattson@google.com>

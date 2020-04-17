Return-Path: <SRS0=L+tG=6B=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B52CC352BE
	for <linux-hyperv@archiver.kernel.org>; Fri, 17 Apr 2020 10:56:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 30A7821D94
	for <linux-hyperv@archiver.kernel.org>; Fri, 17 Apr 2020 10:56:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587120978;
	bh=eE0mKh+guDz7kaVBZ5TP3KTi/3uxhOxlVLRn/H49upM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=JjgsePQ5r2mCx4yRS4z5v9CiHzNbd4Cte+RnaAqeLtlWSXD0/iTXSVuwvPposvU8W
	 jJdAawZiQxWT1wSjd2LDbeZ79NPcG9ZJkHWDmk+OYsQ3EzDMzsITmlBtRE7EfpdTlz
	 ubTf71uXd8PapYeGzgWNaaKCMxNXxAP1LNkcXhnw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729512AbgDQK4K (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Fri, 17 Apr 2020 06:56:10 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44743 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729869AbgDQK4D (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 17 Apr 2020 06:56:03 -0400
Received: by mail-wr1-f67.google.com with SMTP id d17so2504021wrg.11;
        Fri, 17 Apr 2020 03:56:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DYBfnvCIOfbYBUVMhiD0yzR/vj6W91VzUhD7daIMuuQ=;
        b=Fz87rzfr+tPDN7+DwmWt+/vz7NG+69QbDYIkkaaAs7elfggHSuyOX7LyvI7Y8h7Xkn
         +k+f2AqR3Itpu/l75Gq30oAjIAmPc/UR27FjuswUs+M8NOMYw2OFn9eFB2M8+/+Xpoba
         meRIWYD8ZLdogNHlydNeJtURXAzpys63ZaVKMLcXH2BhBCOvKDKkftRe+pQ/DV4QgRdy
         g1gidDVYKXtOYurIBLcMY3D1IjUKg6SKEWE4gkJwaF2AI7FuAsmZpJzzaHdI3ReUMP3M
         lG+FNgky1tqTb7L3RtFT63yhGq1ZYmRh/MP+eqWU+4NBonllaQKh0QFZ0NtqHlpJbpE8
         7OEQ==
X-Gm-Message-State: AGi0PuahG5Xd4GLKKoOsWS41BCy3cMv9KB6TI4Nlsgvb+3mQGjEOknQB
        FQADxcFkrDnEnyXCq7BJUeU=
X-Google-Smtp-Source: APiQypK+ym/LoPqHMBZkBeU5WlMnH11OJtjXwSV8yRp3na8YAM9BOJIpCCmi2W1RtJxLUfAfdbHtbA==
X-Received: by 2002:adf:eec8:: with SMTP id a8mr3121013wrp.28.1587120960891;
        Fri, 17 Apr 2020 03:56:00 -0700 (PDT)
Received: from debian (44.142.6.51.dyn.plus.net. [51.6.142.44])
        by smtp.gmail.com with ESMTPSA id h26sm7223748wmb.19.2020.04.17.03.55.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2020 03:56:00 -0700 (PDT)
Date:   Fri, 17 Apr 2020 11:55:58 +0100
From:   Wei Liu <wei.liu@kernel.org>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     Dexuan Cui <decui@microsoft.com>, bp@alien8.de,
        haiyangz@microsoft.com, hpa@zytor.com, kys@microsoft.com,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, sthemmin@microsoft.com, tglx@linutronix.de,
        x86@kernel.org, mikelley@microsoft.com, wei.liu@kernel.org,
        kvm@vger.kernel.org
Subject: Re: [PATCH] x86/hyperv: Suspend/resume the VP assist page for
 hibernation
Message-ID: <20200417105558.2jkqq2lih6vvoip2@debian>
References: <1587104999-28927-1-git-send-email-decui@microsoft.com>
 <87blnqv389.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87blnqv389.fsf@vitty.brq.redhat.com>
User-Agent: NeoMutt/20180716
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Fri, Apr 17, 2020 at 12:03:18PM +0200, Vitaly Kuznetsov wrote:
> Dexuan Cui <decui@microsoft.com> writes:
> 
> > Unlike the other CPUs, CPU0 is never offlined during hibernation. So in the
> > resume path, the "new" kernel's VP assist page is not suspended (i.e.
> > disabled), and later when we jump to the "old" kernel, the page is not
> > properly re-enabled for CPU0 with the allocated page from the old kernel.
> >
> > So far, the VP assist page is only used by hv_apic_eoi_write().
> 
> No, not only for that ('git grep hv_get_vp_assist_page')
> 
> KVM on Hyper-V also needs VP assist page to use Enlightened VMCS. In
> particular, Enlightened VMPTR is written there.
> 
> This makes me wonder: how does hibernation work with KVM in case we use
> Enlightened VMCS and we have VMs running? We need to make sure VP Assist
> page content is preserved.

The page itself is preserved, isn't it?

hv_cpu_die never frees the vp_assit page. It merely disables it.
hv_cpu_init only allocates a new page if necessary.

Wei.

> 
> -- 
> Vitaly
> 

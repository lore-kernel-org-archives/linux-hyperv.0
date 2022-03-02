Return-Path: <linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75E10C433F5
	for <linux-hyperv@archiver.kernel.org>; Wed,  2 Mar 2022 12:43:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230055AbiCBMn5 (ORCPT <rfc822;linux-hyperv@archiver.kernel.org>);
        Wed, 2 Mar 2022 07:43:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229967AbiCBMn4 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 2 Mar 2022 07:43:56 -0500
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D683B74DC5;
        Wed,  2 Mar 2022 04:43:12 -0800 (PST)
Received: by mail-wr1-f51.google.com with SMTP id m6so2571396wrr.10;
        Wed, 02 Mar 2022 04:43:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ihKhXy8qF1g/GS0RQKaO6pmBjBYQT9XtmSR0oNtogaU=;
        b=mSN3js/IoF9cuyr7aF+reJcxk2m3CKjqTkrtwWuCFVs0+XPaTSDcPz0uA9upp51dix
         C6FRO+ioSwFdyNdHOobwCbT1jBEhkgF1KFPzDBc30siScSlEJNTDBdsKBdVcZbKDz+NB
         c1qsOfUsTc/YCmIMvri5Qa1/oWuucujsLHOpORptGE4zCRrHeSsgr4ykN3+LFTj9gZ1b
         3uDpA0SfnRTeldZFbPPHLHSVY/Dm26bvXSWMIqgl1818StvY36OnsfC932FtoHeSuhnX
         e1FJbx3fcDkdOpKgKlScy5xJJef4UTZZecI3c3ROMEENqEmUZOTfGgBaLOCPA6KIaHvK
         t9iA==
X-Gm-Message-State: AOAM532oRNj7sz6g/727P+Jx/aeTem/q0GgpFDrfpat0nWW2Ro7rTwuQ
        FqbdXoY2QWQQ33v+aHrqLQ4=
X-Google-Smtp-Source: ABdhPJwdt179B6l8rxOh7YAPwimzgJGRO2A61bJuSIBgz7+P3KKV455d4AZ0dDb7Ny6x2zbizmMFsQ==
X-Received: by 2002:a5d:5746:0:b0:1ea:9643:92ac with SMTP id q6-20020a5d5746000000b001ea964392acmr22528679wrw.597.1646224991395;
        Wed, 02 Mar 2022 04:43:11 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id i15-20020a05600011cf00b001edc2966dd4sm16337747wrx.47.2022.03.02.04.43.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 04:43:10 -0800 (PST)
Date:   Wed, 2 Mar 2022 12:43:09 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Iouri Tarassov <iourit@linux.microsoft.com>
Cc:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org, spronovo@microsoft.com,
        spronovo@linux.microsoft.com, gregkh@linuxfoundation.org
Subject: Re: [PATCH v3 06/30] drivers: hv: dxgkrnl: Enumerate and open
 dxgadapter objects
Message-ID: <20220302124309.w2zkzfaq3oinok3g@liuwe-devbox-debian-v2>
References: <719fe06b7cbe9ac12fa4a729e810e3383ab421c1.1646163378.git.iourit@linux.microsoft.com>
 <a282cd44ed35b33a1df866cd745f3464dcaac44f.1646163378.git.iourit@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a282cd44ed35b33a1df866cd745f3464dcaac44f.1646163378.git.iourit@linux.microsoft.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, Mar 01, 2022 at 11:45:53AM -0800, Iouri Tarassov wrote:
[...]
> +void dxgadapter_remove_process(struct dxgprocess_adapter *process_info)
> +{
> +	pr_debug("%s %p %p", __func__,
> +		    process_info->adapter, process_info);

This is not very useful in a production system.

Keep in mind that this can flood dmesg when the debug level is cranked
up. The user is just perhaps trying to get information for other parts
of the kernel.

I would like to ask you to reduce the amount of pr_debug's in code, only
leave the most critical ones in place. There is ftrace and ebfp in the
kernel to help with observation at runtime.

> +	list_del(&process_info->adapter_process_list_entry);
> +	process_info->adapter_process_list_entry.next = NULL;
> +	process_info->adapter_process_list_entry.prev = NULL;

There is no need to explicitly set next and prev pointers to NULL. They
have been set to poison values by list_del. Please remove this kind of
code from all other places.

> +}
> +
>  int dxgadapter_acquire_lock_exclusive(struct dxgadapter *adapter)
>  {
>  	down_write(&adapter->core_lock);
> @@ -170,3 +198,52 @@ void dxgadapter_release_lock_shared(struct dxgadapter *adapter)
>  {
>  	up_read(&adapter->core_lock);
>  }
> +
[...]
> +struct dxgprocess_adapter *dxgprocess_get_adapter_info(struct dxgprocess
> +						       *process,
> +						       struct dxgadapter
> +						       *adapter)

Please document the locking requirement or renamed this function. I see
the list is manipulated with no lock held.

> +{
> +	struct dxgprocess_adapter *entry;
> +
> +	list_for_each_entry(entry, &process->process_adapter_list_head,
> +			    process_adapter_list_entry) {
> +		if (adapter == entry->adapter) {
> +			pr_debug("Found process info %p", entry);
> +			return entry;
> +		}
> +	}
> +	return NULL;
> +}

Thanks,
Wei.

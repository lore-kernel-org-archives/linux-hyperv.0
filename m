Return-Path: <SRS0=in6A=CC=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9F17C433DF
	for <linux-hyperv@archiver.kernel.org>; Mon, 24 Aug 2020 17:34:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A29B2067C
	for <linux-hyperv@archiver.kernel.org>; Mon, 24 Aug 2020 17:34:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598290497;
	bh=mu/8EYgOWWMMFVzYggJY3VT5p7NWhR3sCJgvxOn1cR4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=lBE9KND4cUVVKDbgtpWxm38Yau5Rwy6yl4qMK13Ltegx4phEwdcu5YKjD5+iqStJa
	 oDBZYRdQv9CGjXg6DREgS7rlO15C8Gv8VXmBeOs6fxzxUL5RU1UArBCXV1LBFk2ov4
	 EAsQsoWUe8pTKykrBch52Reyd4DYde7J11t1miDE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727992AbgHXRe4 (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Mon, 24 Aug 2020 13:34:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:33484 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728083AbgHXRep (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 24 Aug 2020 13:34:45 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 11E062067C;
        Mon, 24 Aug 2020 17:34:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598290484;
        bh=mu/8EYgOWWMMFVzYggJY3VT5p7NWhR3sCJgvxOn1cR4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=M9po9+1pECMI6iXfro2djH7yNO63Zf3WPyGTSHuQJvh58INJvJSMaD9kVAqGR/6mS
         HATHe2IIR9z8hxM+5OkGCK26YmpZBSioCO+bD/UKz+K47SH/DI5F6aLkTem5p91EdX
         HzkSnV1f1I2pZP+5+O9p1yrK6x7a0kUgqqSizc8E=
Date:   Mon, 24 Aug 2020 19:35:02 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Michael Kelley <mikelley@microsoft.com>
Cc:     will@kernel.org, ardb@kernel.org, arnd@arndb.de,
        catalin.marinas@arm.com, mark.rutland@arm.com, maz@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-efi@vger.kernel.org,
        linux-arch@vger.kernel.org, wei.liu@kernel.org,
        vkuznets@redhat.com, kys@microsoft.com, sunilmut@microsoft.com,
        boqun.feng@gmail.com
Subject: Re: [PATCH v7 09/10] arm64: efi: Export screen_info
Message-ID: <20200824173502.GA1161855@kroah.com>
References: <1598287583-71762-1-git-send-email-mikelley@microsoft.com>
 <1598287583-71762-10-git-send-email-mikelley@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1598287583-71762-10-git-send-email-mikelley@microsoft.com>
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Mon, Aug 24, 2020 at 09:46:22AM -0700, Michael Kelley wrote:
> The Hyper-V frame buffer driver may be built as a module, and
> it needs access to screen_info. So export screen_info.
> 
> Signed-off-by: Michael Kelley <mikelley@microsoft.com>
> ---
>  arch/arm64/kernel/efi.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/kernel/efi.c b/arch/arm64/kernel/efi.c
> index d0cf596..8ff557a 100644
> --- a/arch/arm64/kernel/efi.c
> +++ b/arch/arm64/kernel/efi.c
> @@ -55,6 +55,7 @@ static __init pteval_t create_mapping_protection(efi_memory_desc_t *md)
>  
>  /* we will fill this structure from the stub, so don't put it in .bss */
>  struct screen_info screen_info __section(.data);
> +EXPORT_SYMBOL(screen_info);

EXPORT_SYMBOL_GPL()?

I have to ask :)

thanks,

greg k-h

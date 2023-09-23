Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3054D261;
	Sat, 23 Sep 2023 08:59:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 274C3C433C8;
	Sat, 23 Sep 2023 08:59:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695459549;
	bh=09E8iJecgFYMexjTYJZ5CJ3jBfm+QiwYB3b9gl5Rd3g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tUhnc/sqC/wOn9t/Ho8mYpdoZNToa8x6ToMKPC7Y7Fs4OFRmNXmR1f74PlI9UKLU3
	 YCOq9U+1jMLm0Pt2mOk34zT2wUvnj1/whZWWZCLEW9imKz5gF5U7WaFMA1b6n+uLjo
	 rLo4BTYA8cxQv2YNn9qRhrHCMkY0Lp54kqv60r2Y9oabBpaiziQpyGPFE8WdCzcwg7
	 3IOVPohUye91FVAHJ6PVWS6QGzFjX2ZS9Ueb2vRwbotb2oCrutuF8AYxux4Mmk1Swk
	 zyFHDJkgCWO+04LGqCVZXmFNEnCV3ijKetwc7asvEUUo7e/nkdnFI0NRTgPRvocAV7
	 3pYGPyFdF668Q==
Date: Sat, 23 Sep 2023 11:00:11 -0600
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Kees Cook <keescook@chromium.org>
Cc: "K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] PCI: hv: Annotate struct hv_dr_state with __counted_by
Message-ID: <ZQ8Zmy+NpCkqXomh@work>
References: <20230922175257.work.900-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230922175257.work.900-kees@kernel.org>

On Fri, Sep 22, 2023 at 10:52:57AM -0700, Kees Cook wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
> (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> As found with Coccinelle[1], add __counted_by for struct hv_dr_state.
> 
> [1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci
> 
> Cc: "K. Y. Srinivasan" <kys@microsoft.com>
> Cc: Haiyang Zhang <haiyangz@microsoft.com>
> Cc: Wei Liu <wei.liu@kernel.org>
> Cc: Dexuan Cui <decui@microsoft.com>
> Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>
> Cc: "Krzysztof Wilczyński" <kw@linux.com>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: linux-hyperv@vger.kernel.org
> Cc: linux-pci@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks
--
Gustavo

> ---
>  drivers/pci/controller/pci-hyperv.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
> index bed3cefdaf19..30c7dfeccb16 100644
> --- a/drivers/pci/controller/pci-hyperv.c
> +++ b/drivers/pci/controller/pci-hyperv.c
> @@ -545,7 +545,7 @@ struct hv_pcidev_description {
>  struct hv_dr_state {
>  	struct list_head list_entry;
>  	u32 device_count;
> -	struct hv_pcidev_description func[];
> +	struct hv_pcidev_description func[] __counted_by(device_count);
>  };
>  
>  struct hv_pci_dev {
> -- 
> 2.34.1
> 
> 

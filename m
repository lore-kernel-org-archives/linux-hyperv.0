Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1274F3CCFD2;
	Mon,  7 Sep 2026 13:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788787181; cv=none; b=hYLBh7UUUI8Ugru9UpKvVAsD+VtIe2gItFFozE79QWFjgqB+N8jlzywLMIJV12aq9oW1HMkKdREQ0pczzJISMnpXrEsHm+BH5memeGXreX/aR2Y6/zmn14LWoq55xPCZj9ltyd30FtNWSDzaObT/JNDqlvvMmmGaWNvwh1Csnqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788787181; c=relaxed/simple;
	bh=LSo7jmJ24Scp6m3Zpm08iW2ip9POwOxwp/IhmpjiN2A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KW2kFFz16T9L5ncEIyUKUrpNspyJ6cd8gbA9X26fbBqSFqrIF3FH/Oy73i4CuvfO0A3q3x+C657dQ/E2qoDJp2s1gV3uGsKGgbtgtc8AIV3AbivcMAICIS1U2aTVQium4C0/c71a10VNhZCXFVzUZnG0/HK78KK2WRgpP0LtjaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SHnsGY+D; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SHnsGY+D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD79A1F00A3A;
	Mon,  7 Sep 2026 13:19:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788787176;
	bh=BUmwcbTHkYXmph0slZ3nwW7rclemNODX0V/5P30wQP8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=SHnsGY+D7x5OPgXM4osNJUAlNld4XyLWPAXr7TIKuGlJczyGoDbvWLhEfiwMemNE6
	 6d6TjSYITNXpzL20w+GdL1CRIKBo0LfL5jk9OBfwh+EQc48ZfxTcSs+JEbeGt2UAmq
	 5kqsDjDNIrKSaJShHyGQ6DfG781+F2An5kM37CKS6fGkNblptGW9gaWulZbHgHhJTm
	 HBhZe92EUVw/i5cDIgmn/5ECVcGo21pSO2iaPvDBeHSVHAXeRYBaH8KWZh89jpNkQp
	 tWCQYnCtZi1dFpA8Z7CjMy9yYcXSCblelTIAvJuobpbJ25AOsMZo7xmTtaL4xCikFP
	 hgPD56rR7wj+Q==
Date: Mon, 7 Sep 2026 15:19:30 +0200
From: Benjamin Tissoires <bentiss@kernel.org>
To: Baoli Zhang <baoli.zhang@linux.intel.com>
Cc: "K. Y. Srinivasan" <kys@microsoft.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, 
	Long Li <longli@microsoft.com>, Jiri Kosina <jikos@kernel.org>, 
	Michael Bommarito <michael.bommarito@gmail.com>, linux-hyperv@vger.kernel.org, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: hyperv: fix fortify write overflow in KUnit device
 info tests
Message-ID: <ap65ZxP8IIaJKMgQ@beelink>
References: <20260907004619.2479833-1-baoli.zhang@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260907004619.2479833-1-baoli.zhang@linux.intel.com>

On Sep 07 2026, Baoli Zhang wrote:
> allyesconfig fails to build:
> 
>   In function 'fortify_memset_chk',
>       inlined from 'mousevsc_device_info_valid_descriptor':
>   ./include/linux/fortify-string.h:430:25: error: call to
>   '__write_overflow_field' declared with attribute warning: detected
>   write beyond size of field (1st parameter); maybe use struct_group()?
> 
> Both tests place a report descriptor in bytes allocated past
> struct synthhid_device_info, then memset() it, and derive its address
> from the hid_descriptor member:
> 
>   report = ((u8 *)&info->hid_descriptor) + info->hid_descriptor.bLength;
> 
> Because that expression is a member reference, the fortify checks bound
> the write by sizeof(info->hid_descriptor). bLength is exactly that size
> here, so the remaining room in the member is zero and every write is
> flagged, even though the memory really came from the caller's
> kunit_kzalloc(sizeof(*info) + N).
> 
> Compute the address from the start of info instead, mirroring the
> desc_offset arithmetic that mousevsc_on_receive_device_info() itself
> uses. Deriving from info gives the whole allocation as the object, so
> the writes are no longer attributed to a single member. The result is
> the same address: (u8 *)&info->hid_descriptor is by definition
> (u8 *)info + offsetof(struct synthhid_device_info, hid_descriptor), so
> test behaviour is unchanged.
> 
> sizeof(*info) deliberately is not used for this: hid_descriptor is
> __packed while synthhid_device_info is not, so the struct may carry
> trailing padding and the report would land at the wrong offset.
> 
> Fixes: 83df7b5fa6735 ("HID: hyperv: add KUnit coverage for device info bounds")
> Signed-off-by: Baoli Zhang <baoli.zhang@linux.intel.com>

Please always check is a patch is not already pending in linux-next or
in mainline linux.

d0ad81b2b5fe ("HID: hyperv: make pointer arithmetics understandable for
FORTIFY_SOURCE") already fixes this very same issue.

Cheers,
Benjamin

> ---
>  drivers/hid/hid-hyperv.c | 23 +++++++++++++++++++++--
>  1 file changed, 21 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/hid/hid-hyperv.c b/drivers/hid/hid-hyperv.c
> index 6579bd19da13a..f1042b36d10b7 100644
> --- a/drivers/hid/hid-hyperv.c
> +++ b/drivers/hid/hid-hyperv.c
> @@ -657,6 +657,25 @@ static struct mousevsc_dev *mousevsc_kunit_alloc_dev(struct kunit *test)
>  	return input_dev;
>  }
>  
> +/*
> + * Address of the report descriptor that mousevsc_on_receive_device_info()
> + * expects immediately after the HID descriptor.
> + *
> + * Computed from the start of @info, mirroring the desc_offset arithmetic in
> + * mousevsc_on_receive_device_info(), rather than from &info->hid_descriptor.
> + * The report lives in the extra bytes the caller allocated past the struct, so
> + * deriving it from the member would leave the fortify checks bounding writes
> + * by sizeof(info->hid_descriptor) and reject them. Note sizeof(*info) cannot
> + * be used instead: hid_descriptor is packed while synthhid_device_info is not,
> + * so the struct may carry trailing padding.
> + */
> +static u8 *mousevsc_kunit_report_desc(struct synthhid_device_info *info)
> +{
> +	return (u8 *)info +
> +	       offsetof(struct synthhid_device_info, hid_descriptor) +
> +	       info->hid_descriptor.bLength;
> +}
> +
>  static void mousevsc_device_info_zero_blength(struct kunit *test)
>  {
>  	struct synthhid_device_info *info;
> @@ -687,7 +706,7 @@ static void mousevsc_device_info_valid_descriptor(struct kunit *test)
>  
>  	info->hid_descriptor.bLength = sizeof(struct hid_descriptor);
>  	info->hid_descriptor.rpt_desc.wDescriptorLength = cpu_to_le16(4);
> -	report = ((u8 *)&info->hid_descriptor) + info->hid_descriptor.bLength;
> +	report = mousevsc_kunit_report_desc(info);
>  	memset(report, 0x42, 4);
>  
>  	mousevsc_on_receive_device_info(input_dev, info, sizeof(*info) + 4);
> @@ -713,7 +732,7 @@ static void mousevsc_device_info_report_desc_oob(struct kunit *test)
>  
>  	info->hid_descriptor.bLength = sizeof(struct hid_descriptor);
>  	info->hid_descriptor.rpt_desc.wDescriptorLength = cpu_to_le16(64);
> -	report = ((u8 *)&info->hid_descriptor) + info->hid_descriptor.bLength;
> +	report = mousevsc_kunit_report_desc(info);
>  	memset(report, 0x42, 8);
>  
>  	mousevsc_on_receive_device_info(input_dev, info, sizeof(*info) + 8);
> -- 
> 2.43.0
> 
> 

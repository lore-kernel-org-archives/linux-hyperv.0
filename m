Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 922ED43712B;
	Mon, 10 Aug 2026 18:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786388015; cv=none; b=D2pWCUqPzyfPM3Pq/laSnr6kBxvBZCnHoeQcSpV/NazsI6wEP/60VgLaAsf8x4/ZcebtM9eOj64TafIiqO8JF0+aGriTxlBNDFdWYKICj/OUkSNvrgwLdAn2JiqqROAK3ZPaHmSaEWF/CTgkL9Ig1teqxMu3mcI0lVom9//y0Y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786388015; c=relaxed/simple;
	bh=Qn4/HwoLgnaortynWMh4QZMkhZkROsB0PFmGk2WyicY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T3eWif3rjqyhh+8f98BsKA6DT6im6vS3z3M+xrwq60Vrr14exM8bH7b+8Ebjz7aZt79KBTT0drWkUlUP/CmZjBYJTNN7H7O3/3mHqxpq304F1EjV/aAWpOWmqjjVaEIJB6Jym4IRBqpENTB/sjsez5qCSFCRxsd8ygeNownLurU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d5JqJ3Bx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d5JqJ3Bx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 378E11F000E9;
	Mon, 10 Aug 2026 18:53:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786388014;
	bh=UQgVoPOm74qG2CFWYZqDDNHxvbeuuj9Rmk2oTGIfPZ4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=d5JqJ3BxDjJdsEK1bfExTsDEhExlT+b/nowqWXJ3uBDkmwg0x3wqDOEhkpX6GyHIt
	 QEdhjAi20vRVk5P+Ro9aAy6ZXGcJJVQqa+zB7E6900gFoXlImbeR0YGX9791gdY3bz
	 OzYIwMzadp3eGvatRByGijSxjFwg/KR2rSO8VfblDXNHCr8ci0dr+Fhau/EeHM/WuK
	 /VqGLorhMlUceN9rKuR+DBBGdsMWBJREI2qxsz5Qj6+qP68yqhkNjTX7pvlsUoqNZI
	 wOmgkTwP80MqBKt61DmZhv3vQhuAeanQA5Bm+MDoj++yYLV6BSfsclswmyOh3ycVjA
	 K8bmWc5cVuvlg==
Date: Mon, 10 Aug 2026 11:53:33 -0700
From: Wei Liu <wei.liu@kernel.org>
To: Wei Hu <weh@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>
Subject: Re: [PATCH v2 06/13] mshv: detect and report SEV-SNP support at init
Message-ID: <20260810185333.GB2496954@liuwe-devbox-debian-v2.local>
References: <20260810124527.1409634-1-weh@linux.microsoft.com>
 <20260810124527.1409634-7-weh@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260810124527.1409634-7-weh@linux.microsoft.com>

On Mon, Aug 10, 2026 at 12:45:00PM +0000, Wei Hu wrote:
> From: Wei Liu <wei.liu@kernel.org>
> 
> Query Hyper-V dynamic processor features during mshv initialization to

s/Hyper-V/MSHV/

> determine SEV-SNP availability, and report the result: on success log the
> maximum number of encrypted partitions, otherwise log the decoded SNP
> status string so misconfigurations are diagnosable. Cloud Hypervisor
> expects the root driver to perform this capability check before SEV-SNP
> child partition setup.

No need to reference Cloud Hypervisor here. This applies to all VMMs.

> 
> Signed-off-by: Wei Liu <wei.liu@kernel.org>
> ---
>  drivers/hv/mshv_root_main.c | 96 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 96 insertions(+)
> 
[...]
> +static void __init mshv_check_sev_snp_support(struct device *dev)
> +{
> +	struct hv_input_get_system_property *input;
> +	struct hv_output_get_system_property *output;
> +	unsigned long flags;
> +	enum hv_snp_status snp_status;
> +	u64 status;
> +
> +	local_irq_save(flags);
> +	input = *this_cpu_ptr(hyperv_pcpu_input_arg);
> +	output = *this_cpu_ptr(hyperv_pcpu_output_arg);
> +
> +	memset(input, 0, sizeof(*input));
> +	input->property_id = HV_DYNAMIC_PROCESSOR_FEATURE_PROPERTY;
> +	input->hv_processor_feature = HV_X64_DYNAMIC_PROCESSOR_FEATURE_SNP_STATUS;
> +
> +	status = hv_do_hypercall(HVCALL_GET_SYSTEM_PROPERTY, input, output);
> +	local_irq_restore(flags);
> +	if (!hv_result_success(status)) {
> +		dev_warn(dev, "Failed to get SNP support: %s\n",
> +			 hv_result_to_string(status));
> +		return;
> +	}
> +

Our internal testing has shown that running this on an L1VH partition
gets an error.

The error should be non-fatal. Please squash my internal patch to this
in the next revision.

Wei

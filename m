Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AB43347BA7
	for <linux-hyperv@vger.kernel.org>; Tue, 25 Aug 2026 04:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787631468; cv=none; b=PkQI2LTFMEqJ8ELKVVI6aagygv+i5shAuJk4O9xgGBHuqV9BPNm9Y7oTH4YRF5ogqxY80UeREmBPYYJeY6qZwliO/cCUqBNyrqUepfHHsxqQ9xzI8+uMBs0GF53Ay9ia0fxmwZ8TdgEhIzL5UpZmx2oegZdxCQo+x42/W7+lH1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787631468; c=relaxed/simple;
	bh=02WmQ8a9LIJCZqtDJ/vnsS0B2pDmIPmJdtqlKPV4ra8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Mo3AlNrYo2AogrojpklWCfsakkLSkZTcr79pQ2aQ4BUVYukNGhlImrJDyzq3trw9DBzYiyL64ZfrrUPmL3+4p5F6zoHE2KI+CZxFYQfpqe5UJ2xpHq6qodM6jF/rvrDLPYf2/EodcX/1f8pXZMOsCHeVnivutaaayXfStMryJzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GaR6qTiS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GaR6qTiS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 764D61F000E9;
	Tue, 25 Aug 2026 04:17:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787631466;
	bh=aLlUrE1wvz7ijs96aK7V8k8RUc9ELMb8o1aw6V0Ke8s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GaR6qTiSOLKdqL4iXkh6G9u9Kt+adJV52s797MaCsoHWJt9ymitWIXereSsAi97iE
	 iNgOec3dSJLCG0h3SVorwYUoiNfq9y2dYYIg0Unpf5qU5+efIz2DaeVhkPiChsM34t
	 LBm2EFdoC4sm5bBRdozelT0xipD+iZ6gfMKpZqEtpuEPgk6GjQqcnnmv3ESpsSyARL
	 gf4O7CT4L5hGOPs6XZwtieaQD0/G63E8mYzDkQgGSmA0nGwfqNRmgiU0tD2Yylhf6T
	 2YQMIjl+wL+DvH8Q0zp2GPteqfzfAzvMLFcdst1f2Q5oX3F1H9lK0y+kPGS1pMPeHp
	 KniCyxhC9s4Kw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/7] mshv: add SEV-SNP PSP request hypercall
Reply-To: sashiko-reviews@lists.linux.dev
To: "Wei Hu" <weh@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <20260825040505.826600-3-weh@linux.microsoft.com>
References: <20260825040505.826600-1-weh@linux.microsoft.com>
 <20260825040505.826600-3-weh@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 25 Aug 2026 04:17:45 +0000
Message-Id: <20260825041746.764D61F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] The function misuses the shared per-CPU `hyperv_pcpu_input_arg` fo=
r an asynchronous hypercall, potentially corrupting the hypercall input.
- [Medium] Un-ratelimited `pr_err` on the guest-triggerable hypercall failu=
re path allows a malicious guest to flood the host kernel log.
--

--- Patch [2]: [PATCH v3 2/7] mshv: add SEV-SNP PSP request hypercall ---
commit 8b1f140f3a0780e521d7a96627211fe9e4967940
Author: Wei Liu <wei.liu@kernel.org>

mshv: add SEV-SNP PSP request hypercall

This commit adds a helper for HVCALL_ISSUE_SNP_PSP_GUEST_REQUEST so MSHV
can issue asynchronous PSP guest requests on behalf of encrypted partitions.

> diff --git a/drivers/hv/mshv_root_hv_call.c b/drivers/hv/mshv_root_hv_cal=
l.c
> index cb55d4d4be2e5..48abe338c06f8 100644
> --- a/drivers/hv/mshv_root_hv_call.c
> +++ b/drivers/hv/mshv_root_hv_call.c
> @@ -1009,6 +1009,45 @@ int hv_unmap_stats_page(enum hv_stats_object_type =
type,
>  	return ret;
>  }
> =20
> +#ifdef HV_SUPPORTS_SEV_SNP_GUESTS
> +int hv_call_issue_psp_guest_request(u64 partition_id, u64 req_pfn,
> +				    u64 rsp_pfn,
> +				    void (*completion_handler)(void *data,
> +							       u64 *status),
> +				    void *completion_data)
> +{
> +	struct hv_input_issue_psp_guest_request *input;
> +	unsigned long flags;
> +	u64 status;
> +
> +	if (!completion_handler) {
> +		pr_err("%s: missing completion handler\n", __func__);
> +		return -EINVAL;
> +	}
> +
> +	local_irq_save(flags);
> +	input =3D *this_cpu_ptr(hyperv_pcpu_input_arg);
> +	memset(input, 0, sizeof(*input));
> +	input->partition_id =3D partition_id;
> +	input->request_page =3D req_pfn;
> +	input->response_page =3D rsp_pfn;
> +	status =3D hv_do_hypercall(HVCALL_ISSUE_SNP_PSP_GUEST_REQUEST, input,
> +				 NULL);
> +	local_irq_restore(flags);
> +
> +	if (hv_result(status) =3D=3D HV_STATUS_CALL_PENDING)
> +		completion_handler(completion_data, &status);

[Severity: High]
Does this code risk corrupting the hypercall input data?

The function uses the shared per-CPU hyperv_pcpu_input_arg for the hypercal=
l.
However, it restores interrupts and invokes completion_handler() which bloc=
ks
while the hypercall is pending.

During this time, another thread scheduled on the same CPU can issue a
hypercall and overwrite the shared per-CPU page while the hypervisor is sti=
ll
reading the original parameters asynchronously.

> +
> +	if (!hv_result_success(status)) {
> +		pr_err("%s: status=3D%s partition_id=3D%llu\n", __func__,
> +		       hv_result_to_string(status), partition_id);

[Severity: Medium]
Could this unconditional error print be used to flood the host kernel log?

If a malicious guest VM repeatedly issues invalid SEV-SNP PSP requests, the
hypercall will fail and trigger this error print on the failure path.

Since this can be triggered at will by the guest, it might be safer to
rate-limit this message.

> +		return hv_result_to_errno(status);
> +	}
> +
> +	return 0;
> +}
> +#endif

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260825040505.8266=
00-1-weh@linux.microsoft.com?part=3D2

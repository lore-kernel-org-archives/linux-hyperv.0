Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 463AF3B83E3
	for <linux-hyperv@vger.kernel.org>; Wed, 22 Jul 2026 21:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784757238; cv=none; b=e2Fe9Me3f93OnQxFbulRqi9y/G1HxYV1be48ySK4RbD4vUcnTJ7HVj3Ct2g0bg52oWqHOPn3oYsAkrUz4m4GPfIZuLld64s1kEYhwtGUqgpJloe4MU8O8c6y0O7gRmJW0WQeQjiH+62j1FGBMVSaiiE9A8pk/CqHyKDjPz9kBME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784757238; c=relaxed/simple;
	bh=Yv8kQP1mkhAeq2dKkbnu4Ti2NIcWzZh+kAzfKmBSwcg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=iGhbSRaJiLtXa5WRbr7dWgicW8YGc9fcl/sDpfgSVW3SfxBZ8bhlz8qYrL8hDoK1AqEGMcOSOnOAGKaRe0BNUpsgQTCWPWbEzcZsL2Bvs7WY6egjCFuaEbCyrZQUUAGAfSBz3mTNGNtB4QO9YYOPLyQFkLLVmzpQtRkg7VhUkh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J/VOi871; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J/VOi871"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3A5A1F000E9;
	Wed, 22 Jul 2026 21:53:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784757237;
	bh=g/3DtZV/SJZfZJRD63GW8j79WaSAdUaUYeNTTmY1LGY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=J/VOi871GkbMhEY2kCd9eDR3qRVaX0cs7Qv7JfgH0JNVzOOhfXvhoYlpdJDDo4N4B
	 UGganOGXig8rfgCZR4y1CGVQr+ququA1qm1XqjQXLLU1w3UMdPArw2fG4jTLvrNj4G
	 3XjTOo39wxFUsCsZ6AjST3c2G9Xi4kZU9UIUv0ql3vUCyJe+70uwMQ3WUNLee0ed0l
	 rzzgijpuiqki9qM9IWVtEYetyGllcwjKTJt2Tu9eJ9Vydw/qhsar0bRJlYDM1M/fzj
	 ZrxBn8mbbVbyEn90Y2GrKPCllE6mkaDFsopLLu193jq1BE1/zL63NlD06U4QYhD+/H
	 WhINNt1EvB28g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 3/8] selftests/mm: add HMM test for mmap
 lock-dropping faults
Reply-To: sashiko-reviews@lists.linux.dev
To: "Stanislav Kinsburskii" <skinsburskii@gmail.com>
Cc: linux-hyperv@vger.kernel.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20260722-hmm-v10-v1-3-606464dd601a@gmail.com>
References: <20260722-hmm-v10-v1-0-606464dd601a@gmail.com>
 <20260722-hmm-v10-v1-3-606464dd601a@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 22 Jul 2026 21:53:56 +0000
Message-Id: <20260722215356.C3A5A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] `dmirror_range_fault_unlocked` fails to enforce an absolute time=
out for its `mmu_interval_read_retry` loop, leading to potential livelocks.
--

--- Patch [3]: [PATCH v10 3/8] selftests/mm: add HMM test for mmap lock-dro=
pping faults ---
commit e4ef68d1c56c2f5bfba882ccad54a4d7284e5403
Author: Stanislav Kinsburskii <skinsburskii@gmail.com>

selftests/mm: add HMM test for mmap lock-dropping faults

This commit adds test_hmm coverage for the HMM lock-dropping fault path.
It introduces a new ioctl that exercises the unbounded retry mode while
allowing the mmap lock to be dropped during fault handling, alongside a
corresponding userfaultfd read selftest.

> diff --git a/lib/test_hmm.c b/lib/test_hmm.c
> index 45c0cb9922184..6205fb313bd05 100644
> --- a/lib/test_hmm.c
> +++ b/lib/test_hmm.c

[ ... ]

> @@ -389,6 +389,67 @@ static int dmirror_range_fault(struct dmirror *dmirr=
or,
>  	return ret;
>  }
> =20
> +static int dmirror_range_fault_unlocked(struct dmirror *dmirror,
> +					struct hmm_range *range,
> +					unsigned long timeout)
> +{
> +	int ret;
> +
> +	while (true) {
> +		ret =3D hmm_range_fault_unlocked_timeout(range, timeout);
> +		if (ret)
> +			goto out;
> +
> +		mutex_lock(&dmirror->mutex);
> +		if (mmu_interval_read_retry(range->notifier,
> +					    range->notifier_seq)) {
> +			mutex_unlock(&dmirror->mutex);
> +			continue;

[Severity: Medium]
Does this loop lack an absolute timeout enforcement?

When mmu_interval_read_retry() triggers a retry, the same relative timeout
value is passed back into hmm_range_fault_unlocked_timeout(). Because that
function calculates its internal deadline as jiffies + timeout, the
deadline gets pushed forward on every retry.

Could this lead to a livelock if this function is ever called with a non-ze=
ro
timeout, since the timeout resets infinitely during concurrent page table
invalidations?

> +		}
> +		break;
> +	}
> +
> +	ret =3D dmirror_do_fault(dmirror, range);
> +
> +	mutex_unlock(&dmirror->mutex);
> +out:
> +	return ret;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260722-hmm-v10-v1=
-0-606464dd601a@gmail.com?part=3D3

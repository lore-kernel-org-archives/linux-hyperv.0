Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CB553644C4
	for <linux-hyperv@vger.kernel.org>; Thu,  8 Oct 2026 19:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791486576; cv=none; b=UXfoDZRCfjenzec5ZOU67zoIS/eOY2oNtX2vLdgXvrAw4UDl69NZywauVOZQM89uR5Q1nqbWSOYddpWJo63JlKyEw4n3s0qdYCY8LouPQo8FmPNf1O3sW2MKcrxbIp8ZZTMOdy/x2VFKuRhRdxnwwonRXH+v35quFtAyQsNGMk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791486576; c=relaxed/simple;
	bh=5E5mXuPlH5bwYUMsZ3gtwsa99obJvLOv06QeoRzbS9g=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=FiNAJnqajIAR2vFyKi9aD4z14oz0KroLWMmQ5NypU69n0QsKCqnwZ8Afz7DUMaKp5VRmwX4aU87IQeN7bBP0TSk37b/Bj4f3QxT6MUAZBxxmD1LPad6AtkA4DjRYIhu7z1t4vWS3+rgwhV6gyVL85FxnwUXHvXHzDIEhyEtCJLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YF08+keD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YF08+keD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27D611F00893;
	Thu,  8 Oct 2026 19:09:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791486575;
	bh=JjIUQgphjOMlDjN7rZ4smrrq13/3qhLq4+bh+9YRBKc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YF08+keD1x4+m1IYClCsirTlWx4D+1PlMtSr+G+7HAecQ777l2qNRw7QqcgTe7Gpz
	 +PS3v0Ww4gSZ1CPR1LvCHN8JbPYR+jyjGKuuS1qBVMYhvVUplAQypuHWjOAsTXlV0y
	 tIHEJPmZ6/g7M6dsOXbWK9P14qDukuP0htEnLys1S3aQfR02Bs+mQLNX5ILtyExPl9
	 7hbsMTJm8F424oOU5MABdMt05eVCAtl4YpyJJEogSq3m+fWTPaw1I217BCijngD58q
	 v5mM4IeDut37xOczMamuiqSjBcqmZZPgP6qGhGJhM9mhYM+YB0WK8+TLTbq85dYTN1
	 qPFMIjlK9wk6w==
Message-ID: <sashiko-outbox-164495@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 11/14] hv: vmbus: vmalloc requestor metadata
Reply-To: sashiko-reviews@lists.linux.dev
To: "Emerson Busson" <emersonbusson@gmail.com>
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <20261007190752.336426-12-emersonbusson@gmail.com>
References: <20261007190752.336426-1-emersonbusson@gmail.com>
 <20261007190752.336426-12-emersonbusson@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 08 Oct 2026 19:09:34 +0000
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] hv: memory leak in vmbus KUnit tests on KUNIT_ASSERT_EQ failure
--

commit 691cb947fd6eb3bbd5abcb1f0c1c8a97f9b7e21e
Author: Emerson Busson <emersonbusson@gmail.com>

hv: vmbus: vmalloc requestor metadata

This commit changes the channel open requestor array and bitmap allocations
from kvcalloc and bitmap_zalloc to vzalloc to avoid high-order allocations
under memory fragmentation, and adds KUnit tests for these structures.

> diff --git a/drivers/hv/vmbus_buffer_test.c b/drivers/hv/vmbus_buffer_tes=
t.c
> index 5c8e70d861adb..d0102dabef737 100644
> --- a/drivers/hv/vmbus_buffer_test.c
> +++ b/drivers/hv/vmbus_buffer_test.c
[ ... ]
> +static void vmbus_requestor_invalid_ids_test(struct kunit *test)
> +{
> +	struct vmbus_channel channel =3D { .rqstor_size =3D 4 };
> +	struct vmbus_requestor *rqstor =3D &channel.requestor;
> +	u64 id, addr;
> +
> +	KUNIT_ASSERT_EQ(test, vmbus_alloc_requestor(rqstor, 4), 0);
> +
> +	/* ID 0 is the unsolicited-message sentinel and is never in the set. */
> +	KUNIT_EXPECT_EQ(test, vmbus_request_addr_match(&channel, 0, 0),
> +			VMBUS_RQST_ERROR);
> +
> +	/* Out-of-range IDs are refused, not wrapped. */
> +	KUNIT_EXPECT_EQ(test, vmbus_request_addr_match(&channel, 5, 0),
> +			VMBUS_RQST_ERROR);
> +	KUNIT_EXPECT_EQ(test, vmbus_request_addr_match(&channel, U64_MAX, 0),
> +			VMBUS_RQST_ERROR);
> +
> +	id =3D vmbus_next_request_id(&channel, 0xABCD);
> +	KUNIT_ASSERT_EQ(test, id, 1U);

[Severity: Low]
Does this abort the test and skip the cleanup on failure?

In vmbus_requestor_invalid_ids_test(), vmbus_alloc_requestor() is called=20
earlier to allocate the vmalloc-backed metadata arrays. If this=20
KUNIT_ASSERT_EQ() fails, KUnit immediately aborts the execution of the test=
=20
function.

This would skip the manual cleanup call to vmbus_free_requestor() at the=20
end of the function, resulting in a memory leak of the requestor arrays.

Could this be changed to use KUNIT_EXPECT_EQ(), which reports the failure=20
but continues execution, or could a deferred cleanup action be registered=20
with KUnit?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261007190752.3364=
26-1-emersonbusson@gmail.com?part=3D11

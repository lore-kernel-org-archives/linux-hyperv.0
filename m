Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E582352032
	for <linux-hyperv@vger.kernel.org>; Mon, 31 Aug 2026 11:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788177183; cv=none; b=cBYzt7rkEt1VmmJvUwtgM5IhsDHERs7HbBOWJLxq8e+8C5BWUifcGOr5APAmZNK9QS8SDWjrGrUkYjfVZYiYFQvZLwOIjGiva+Rvi+/7V9poAMxtIFtkJ1Dk6zfSr71YaN4IB3HB7MRXZNQW7k8zTXVIAHrUEGSNHlFMC6sBtJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788177183; c=relaxed/simple;
	bh=KftiCrrg5hyldVQJqZqcY8W/6v28GPr9KW6QY8Zv0JU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=o3adgr4NJ0An9/L7ZAYKGZNVbvlXZiEHXo1ArJtVxQT9te2bnAv8G4YDCfbxbmnzgPzPUr2RPkVjvJm6RfzL7WKNgnDSULB8g0uo+6gTf1UNacSbPtL+CVAAg54++Ec1pc3JPn4xuOMExaL/wTzYiYzwRMA5SkrlxLahwxjXu74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XCl0CYyC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XCl0CYyC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B31E21F000E9;
	Mon, 31 Aug 2026 11:53:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788177181;
	bh=KftiCrrg5hyldVQJqZqcY8W/6v28GPr9KW6QY8Zv0JU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XCl0CYyCUJczCf3F9iutE9mEvsVGaZHvahiHXjnzuZKFoZoIOLPnjB8dwd7ITK9S5
	 GN4hWBYipIjlqEA+MhlETStkrWHz+BrQQFQ1PhOL9SnT04bE/b9hqixQRUvihBIuYa
	 3/Z21RH+k3aQUN6Be5qKp1a9UsJ1X5A1ihbXpusGm6N5r/pAQcCjfrlXIrf073xrYT
	 /M4IyiichL1Pb4FN0MGrZdONCoB3Jz1NfuPuZ85uK2hSrGwvdYFv04QS++ygmY79gY
	 hiS8mEQ77/FALIK5KPbtSeqV1Gqojwv69G7hNf6f2VMXSdzSibSHfkhP89mhLWuVxI
	 4NfxM9V2cFwqg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 5/9] mshv: add SEV-SNP isolated page hypercalls
Reply-To: sashiko-reviews@lists.linux.dev
To: "Wei Hu" <weh@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <20260831112704.2851147-6-weh@linux.microsoft.com>
References: <20260825040505.826600-1-weh@linux.microsoft.com>
 <20260831112704.2851147-1-weh@linux.microsoft.com>
 <20260831112704.2851147-6-weh@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 11:53:01 +0000
Message-Id: <20260831115301.B31E21F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The commit message explicitly claims to add wrappers for 'modify=
ing sparse SPA host access' and 'setting partition properties', but these f=
unctions are completely absent from the patch.
--

commit 39272e85622d93556ea19a15d2e28e9556ab8c29
Author: Wei Liu <wei.liu@kernel.org>

mshv: add SEV-SNP isolated page hypercalls

This patch adds wrappers for importing isolated pages and handling their
completions for SEV-SNP guests. It supports synchronous and pending complet=
ions
and preserves the asynchronous completion result while rejecting malformed =
counts.

> mshv: add SEV-SNP isolated page hypercalls
>=20
> Add wrappers for importing isolated pages, completing the import,
> modifying sparse SPA host access, and setting partition properties.

[Severity: Medium]
Does this commit message accurately reflect the changes in this patch?

The commit message explicitly claims to add wrappers for modifying sparse S=
PA
host access and setting partition properties, but these functions are compl=
etely
absent from the patch payload.

Looking at the changes introduced in drivers/hv/mshv_root_hv_call.c, only t=
he
hv_call_import_isolated_pages() and hv_call_complete_isolated_import() wrap=
pers
are actually implemented.

Are the missing wrappers (such as hv_call_set_partition_property and
modifications to hv_call_modify_spa_host_access) perhaps introduced in a
subsequent patch, such as 'mshv: wire SEV-SNP partition ioctls'?

If so, could the commit message for this patch be updated to only describe =
the
two import wrappers actually added here? This would ensure the patch and its
history remain accurate and self-contained.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831112704.2851=
147-1-weh@linux.microsoft.com?part=3D5

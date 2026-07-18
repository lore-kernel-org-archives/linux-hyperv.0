Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1094525B0B0;
	Sat, 18 Jul 2026 02:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784341953; cv=none; b=HuQTZgRB3IivHpI70847QMYaUNWqUCY8OdnfkEx4Q/7qammemeeB4hHSZj3IsOAXAddMtfZbpScp4/RDqDHvZtW3G/CS5ERH5Berr0c0J71QlVj9UMpFIMcMdhSJMAUHNBQkLG5GUQ30uH+XbiOAl1v/u/oAJqrXur5NDieK1QA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784341953; c=relaxed/simple;
	bh=TKaX3865wzxf7v+o2psapMb3RNvQkTWwQfqCJad181o=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ntneJbq5i1LABro/guNE5mOZ6/yEHUfV2XV/P/IT2YOSyJiQPxuHZ9mSE/S4wq2l5v2U4ETimVpzLXNXYLuGuRq7h98Qmp6k8zLD8vAtICzAqfD9BYWzXvjsfLr9OJBOTOUW9XjY8digiMVqtYJfBOPnuGQ6IvEyts1QvQjcsX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WsLcaQFx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WsLcaQFx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB09E1F00A3A;
	Sat, 18 Jul 2026 02:32:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784341949;
	bh=TKaX3865wzxf7v+o2psapMb3RNvQkTWwQfqCJad181o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WsLcaQFx2O7ZSdgYaMySnoYAtoup515NQEuaHF3tt/MUeXzOAQLgO9GCjsyLjAYt0
	 wC+5qSUqeAL9IQPY7TX5VwRUNP/+COhhmcLbMBKGYZqdN6OqALe2DmFwWJ7iGSzZNK
	 7pVO1/bVPzHS94uiX90GS07VvdI4CclWLTSC0lAv8e75tuoqY3mUkHCMLRqc/G9605
	 x1NrFOdbESA+OlesyNqyak3dFX342PefYgdde4LY4mRpYFiiNNkVdkKi233bvxzl1U
	 IaX6HZGVAXEyJ2Q93pIUOa+e+nDSFco8wWRfyXUsALU6SjH5LcoLMZo+ehJj3Dje5o
	 O5L0nDN5SmFAg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V4 6/9] PCI: hv: Export hv_build_devid_type_pci() and
 change return type
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mukesh R" <mrathor@linux.microsoft.com>
Cc: linux-pci@vger.kernel.org, linux-hyperv@vger.kernel.org
In-Reply-To: <20260718021949.926306-7-mrathor@linux.microsoft.com>
References: <20260718021949.926306-1-mrathor@linux.microsoft.com>
 <20260718021949.926306-7-mrathor@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 18 Jul 2026 02:32:28 +0000
Message-Id: <20260718023228.EB09E1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

> On Hyper-V, most hypercalls related to PCI passthru to map/unmap regions,
> interrupts, etc need a device ID as a parameter. This device ID refers
> to that specific device during the lifetime of passthru. So,
> make hv_build_devid_type_pci() public and change return type to u64 to
> enforce it's size.
>=20
> Signed-off-by: Mukesh R <mrathor@linux.microsoft.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260718021949.9263=
06-1-mrathor@linux.microsoft.com?part=3D6


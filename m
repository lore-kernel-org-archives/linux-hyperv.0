Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20E363921C8
	for <linux-hyperv@vger.kernel.org>; Tue,  4 Aug 2026 19:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785871288; cv=none; b=fkLuIu1yNkBRmHyyPYw8vb/ZNizCHQb3SbWj3tQDkjciClovhtipk69CNvcbKnZAUutV9X1A6vTE2FUqusXRyjth9r7F8lpBFJpt/xxdOZW/dClBKAl1vqGkiszHCUNBUWp9E3u6l9s37pxx0+y4y1CLwXZLVu6expl+vDY4Rv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785871288; c=relaxed/simple;
	bh=CpHs2dscLVTAvHsliwt4qh3ANfN+sYlFgmLmLJ9jtls=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YuzRtsrrhY1lPhLNlillLcdwm5iBlrxE+in9uOWmn9208JLSt3v1eToRBh+oaZ1tCvwMaZlwQHtPUbWhbk98egzDW3dyjjhR3O0x7lfwO3HZWBTFamIJ32QzIfIpxChRz8VaVQLIDSmS8w9VXM6iBmVKjXNXTPTNnQ8B3RIrq/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J+TC9Yzs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J+TC9Yzs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B6851F000E9;
	Tue,  4 Aug 2026 19:21:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785871286;
	bh=zUVSoBztXiPCebt2p43vr8NBpUw/rvLBqPXcCATukgA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=J+TC9YzsAUAnf0mGc4Ok+nFN+o5v06omfNz+8uBozKLm/vL07KwISCo0KwT0Nvg4b
	 kR7yXA8GoCBl6jIpjEJ6BZQkAIfiNLw9slANe3MfcldQ4izCt05vWvnj8JuPBMXjwA
	 EbT2JNnQ3aULlNotRLqTyx1GKEgKVqVWIeV7BEYQ7m3qo475Bp1Dr7rJ03iyRSOXVl
	 cRtV0cgHFSvcy9hysEs9PJCFFoDU/vLqE+6NiQWfWxzigdZ8UvSNs0WlMj7hWD/FGZ
	 ANh6lltwgi6FevA1YJQw5ShJUvAAWh27Khddwsrdf5KIsCAGPRSdf8hlzVZ82murO6
	 XAEzHm08x7n0g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/1] Drivers: hv: vmbus: Fail VMBus module init for
 non-nested root partition
Reply-To: sashiko-reviews@lists.linux.dev
To: "Michael Kelley" <mhkelley58@gmail.com>
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <20260804190517.101981-1-mhklinux@outlook.com>
References: <20260804190517.101981-1-mhklinux@outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 04 Aug 2026 19:21:26 +0000
Message-Id: <20260804192126.9B6851F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Returning -ENODEV in the root partition prevents the hv_vmbus modu=
le from loading, which breaks the loading of the mshv_root module when both=
 are configured as loadable modules.
--

--- Patch [1]: [PATCH 1/1] Drivers: hv: vmbus: Fail VMBus module init for n=
on-nested root partition ---
commit 49405a084beb024e2ba8a360ff4836611b21617d
Author: Michael Kelley <mhkelley58@gmail.com>

Drivers: hv: vmbus: Fail VMBus module init for non-nested root partition

This commit changes the VMBus module initialization to return -ENODEV inste=
ad
of 0 when running directly in the root partition and not nested. This is
intended to prevent the module from successfully loading and later causing
memory faults or a panic during unload when resources were never initialize=
d.

Closes: https://lore.kernel.org/linux-hyperv/20260721154943.A09BD1F00A3D@sm=
tp.kernel.org/

> diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> index 6824bd7cb3c4f..7d5021ceea84f 100644
> --- a/drivers/hv/vmbus_drv.c
> +++ b/drivers/hv/vmbus_drv.c
> @@ -2982,7 +2982,7 @@ static int __init hv_acpi_init(void)
>  		return -ENODEV;
> =20
>  	if (hv_root_partition() && !hv_nested)
> -		return 0;
> +		return -ENODEV;

[Severity: High]
Does returning -ENODEV here break dependent modules when both are built as
loadable modules?

If the VMBus initialization returns an error on a non-nested root partition,
the hv_vmbus module will fail to load and its symbols (like hv_vmbus_exists=
())
will not be exported.

This would prevent the mshv_root module from loading on the root partition
since it depends on those exported symbols, completely breaking mshv_root
functionality in its only intended environment.

> =20
>  	/*
>  	 * Get ACPI resources first.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260804190517.1019=
81-1-mhklinux@outlook.com?part=3D1

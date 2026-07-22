Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF4FD126C03
	for <linux-hyperv@vger.kernel.org>; Wed, 22 Jul 2026 19:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784750252; cv=none; b=i88wYg46t4XV0zxz6Il4P0mFAFuhM3P01ilaSTWHbZOGyLs5Vf6K+TtvJJqEkppdoqmxug3doO6WkyQgRzqOlzRsnKLIiEB/AUeJemcFERILunLg5zrUk8O8q8OXrKM6qFTxGwPV3+P7TuatPsv+gKhgeZHMsVqwZehF5NJhXtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784750252; c=relaxed/simple;
	bh=nyPDqxstTsZb8rD2SOnr+OsdtmfdUHyueZqTz4VKdQ4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nn5kNrYG3Nf4lKJvXlGWHgHF0b+pu2s2nOROiQstKt2fhdBMN4lMjxJGRA5LS4egsBs0D3Xvo8aV4v9PE5EUgz2L4Yu4Djy8hiyyBI1Silx4exftMdU/a6DV1iFZP38nveLCWbqbDdQcjZ5RMiZC/I1Ti5l1Un6v60qOMOH9JWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WB2nkU1+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WB2nkU1+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC0621F000E9;
	Wed, 22 Jul 2026 19:57:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784750250;
	bh=WESbitWJDxVpujFJ7qEb7Q4nzAANBalBa2F14TFr0j0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WB2nkU1+Ok+FGfFPkql6Hmz0js4KX/e3PsWN58QRupY5tFto6cVvSVytB+ImPoo7r
	 erq1nKpUCIWAFIxzhTksL50WTpxOv9aKnjoukssOL2DKp0JNbQA7q9Yk+hWJmHrXyG
	 R15N2nRJZsAnnTuAwSl8raMYfywYmhpbzO51ieMjYbJqU8Nn1Y3d0MtApRhuT/UoYc
	 gycBV5vYj129Le7L6wp0EqRAjl67skSMRWqVr1Im4MtyCI2viLB8EnGS3ejGK2EBPp
	 HAfOymzMYGBt4jYj2afgGFvx4eJGZOE1RDVZIo7LRv+aJUDVlwvxIQ8wmAFMmkQTx2
	 Nkf3NP3lRF4bA==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 1/2] Drivers: hv: vmbus: add
 vmbus_establish_gpadl_caller_decrypted()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kameron Carr" <kameroncarr@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <20260721195633.1438361-2-kameroncarr@linux.microsoft.com>
References: <20260721195633.1438361-1-kameroncarr@linux.microsoft.com>
 <20260721195633.1438361-2-kameroncarr@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 22 Jul 2026 19:57:30 +0000
Message-Id: <20260722195730.AC0621F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but vmbus_teardown_g=
padl() silently overwrites the error code from vmbus_post_msg(), causing it=
 to falsely report success when GPADL teardown fails, leading to use-after-=
free memory corruption.
--

--- Patch [1]: [RFC PATCH 1/2] Drivers: hv: vmbus: add vmbus_establish_gpad=
l_caller_decrypted() ---
commit 93ae4b1e666b7bf013113501ce3aaa80b55f1c28
Author: Kameron Carr <kameroncarr@linux.microsoft.com>

    Drivers: hv: vmbus: add vmbus_establish_gpadl_caller_decrypted()
   =20
    Refactor vmbus_establish_gpadl() to separate the encryption lifecycle
    from the rest of the GPADL establishment logic. Add a new=20
    vmbus_establish_gpadl_caller_decrypted() for callers that want
    to decrypt their own buffers.

> diff --git a/drivers/hv/channel.c b/drivers/hv/channel.c
> index 6821f225248b1..0166367a4df37 100644
> --- a/drivers/hv/channel.c
> +++ b/drivers/hv/channel.c
[ ... ]
> +int vmbus_establish_gpadl_caller_decrypted(struct vmbus_channel *channel,
> +					   void *kbuffer, u32 size,
> +					   struct vmbus_gpadl *gpadl)
> +{
> +	int ret =3D __vmbus_establish_gpadl(channel, HV_GPADL_BUFFER, kbuffer,
> +					  size, 0U, gpadl);
> +
> +	/* Caller owns @kbuffer's encryption; teardown must not touch it. */
> +	gpadl->decrypted =3D false;

[Severity: High]
This isn't a bug introduced by this patch, but does setting gpadl->decrypted
to false here interact with a pre-existing issue in vmbus_teardown_gpadl()
that masks teardown failures?

In vmbus_teardown_gpadl(), if vmbus_post_msg() fails (e.g., due to host
resource starvation), the error code in the ret variable is overwritten
unconditionally before the function returns:

drivers/hv/channel.c:vmbus_teardown_gpadl() {
    ...
	ret =3D vmbus_post_msg(msg,
			     sizeof(struct vmbus_channel_gpadl_teardown), true);
	trace_vmbus_teardown_gpadl(msg, ret);

	if (ret)
		goto post_msg_err;
    ...
post_msg_err:
    ...
	if (gpadl->decrypted)
		ret =3D set_memory_encrypted((unsigned long)gpadl->buffer,
					PFN_UP(gpadl->size));
	else
		ret =3D 0;
    ...
	return ret;
}

Since gpadl->decrypted is set to false for these caller-managed GPADLs,
if vmbus_post_msg() fails during teardown, the else branch will set ret =3D=
 0.

Could this cause vmbus_teardown_gpadl() to falsely report success when
the teardown actually failed? If the caller then frees the buffer while
the hypervisor still holds a mapping to it, could it lead to memory
corruption across the VM boundary?

> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(vmbus_establish_gpadl_caller_decrypted);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260721195633.1438=
361-1-kameroncarr@linux.microsoft.com?part=3D1

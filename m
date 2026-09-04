Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EB513E3DAB
	for <linux-hyperv@vger.kernel.org>; Fri,  4 Sep 2026 16:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788538047; cv=none; b=oIBlW4HIObanMaXOybSo+jTkik465qLfFOW8RkkaSVEXZiNbt8O7WtnySE4ryjurlirjYdDJwybS8au9oOSZXPKdO4vx04kpBEvVfJOZptrnUqZJAZbxGTGltJDCwuJqN7adw8UboKkTT41I9x18iNwvms3NY3yNc5Qc9lhag+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788538047; c=relaxed/simple;
	bh=/5sGsGppFFz4+mcSUOtyp/1zSJoA3vCjn9gSmlasaRA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=DRaazjfi0cVAq4StXgdo1Fr9dq7qAjHh1ogmLk1ixKpkIXubsmGBEv37UZlr+pSSaALUW58oUPOSC/9QY+PTIv6S7mpX+QwZf9udj2+Pr8tZmNlZVXb40ZLwqdLUNSjyD08f4Et7yCweAXIAbPAf/vOCs+WTBXrX/RAjpsTqDBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zp2BdrBK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zp2BdrBK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82AB51F00A3D;
	Fri,  4 Sep 2026 16:07:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788538044;
	bh=Gv0tRh9Rm+FWJ3TU2C3/A8kVJlnbpNhZooz9JFah8wI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Zp2BdrBKmSuA3HtNNIlJ1ekvb32/Nu5oeWGPm/cCKAfoSwYHenwpHu0Q9mtKqZSZ1
	 EYBgTVAFPnA+0rBfswDsgJjMf6do+NzAMVyuraIu6q/fBmIhaBSsqCrzuc/jllDXa+
	 3iIU/OCxe635tnFjdFIxD4sLRIrcEYALc4PvPLzn3DoT/xbUdGBujhXXawEbhtU/TJ
	 oCBEYXyJx5/U/uL3NqakpssBrx8JAQaXWOjZJ31NdqYMWFLWJYVT//L4ZXQq/8nWQv
	 M45BUpaYfuAR/8rDcLMT+Bhj6T2zEMxsGIuX1xezZkJud1VhncXlEzMrvCmpyWwkhL
	 SCgRFCBZUE9+w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net 2/2] hv_netvsc: Leak send/recv buffers if GPADL
 teardown fails
Reply-To: sashiko-reviews@lists.linux.dev
To: "Michael Kelley" <mhkelley58@gmail.com>
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <20260903160651.1637-3-mhklinux@outlook.com>
References: <20260903160651.1637-1-mhklinux@outlook.com>
 <20260903160651.1637-3-mhklinux@outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 Sep 2026 16:07:24 +0000
Message-Id: <20260904160724.82AB51F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] `vmbus_teardown_gpadl` silently overwrites its error code on failu=
re, hiding GPADL teardown failures and defeating the memory leak safeguard.
--

commit 67f15c255388157724c433ac1cc78395f8454d37
Author: Michael Kelley <mhkelley58@gmail.com>

hv_netvsc: Leak send/recv buffers if GPADL teardown fails

This commit updates the receive and send buffer teardown paths to call
vmbus_leak_buffer() when GPADL teardown fails. This ensures the buffers
are intentionally leaked rather than freed while the Hyper-V host might
still retain access to them.

Link: https://lore.kernel.org/linux-hyperv/20260731201210.3653C1F00AC4@smtp=
.kernel.org/

> diff --git a/drivers/net/hyperv/netvsc.c b/drivers/net/hyperv/netvsc.c
> index 5cd084e5696cd..449dc928cc445 100644
> --- a/drivers/net/hyperv/netvsc.c
> +++ b/drivers/net/hyperv/netvsc.c
> @@ -316,6 +316,9 @@ static void netvsc_teardown_recv_gpadl(struct hv_devi=
ce *device,
>  		 * rather than continue and a bugchk
>  		 */
>  		if (ret !=3D 0) {

[Severity: High]
This is a pre-existing issue, but this intended safeguard appears to be
ineffective because vmbus_teardown_gpadl() silently overwrites its error
code on failure.

If vmbus_post_msg() fails inside vmbus_teardown_gpadl(), the original error
code in ret is unconditionally overwritten with 0 when gpadl->decrypted is
false (the standard VM case):

drivers/hv/channel.c:vmbus_teardown_gpadl() {
    ...
post_msg_err:
        if (gpadl->decrypted)
                ret =3D set_memory_encrypted((unsigned long)gpadl->buffer,
                                           PFN_UP(gpadl->size));
        else
                ret =3D 0;
        ...
        return ret;
}

Because vmbus_teardown_gpadl() returns success despite failing, the
if (ret !=3D 0) condition here will not evaluate to true, and the memory le=
ak
safeguard will be skipped. Will this allow the buffers to be freed while the
Hyper-V host retains access, potentially causing memory corruption or a
use-after-free?

> +			vmbus_leak_buffer(&net_device->recv_buf,
> +					  &net_device->recv_buf_chunks,
> +					  &net_device->recv_buf_chunk_cnt);
>  			netdev_err(ndev,
>  				   "unable to teardown receive buffer's gpadl\n");
>  			return;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260903160651.1637=
-1-mhklinux@outlook.com?part=3D2

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC27836A34F
	for <linux-hyperv@vger.kernel.org>; Thu,  8 Oct 2026 19:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791486575; cv=none; b=W2OElEiDwHpxrJzlyMy78KqYlnWePR+vr8XwYQCI4fEsK/36tozJUXnitaXmoKH6+TWtjx0RFl8YA1lr4+ZXLr8JCYPS9ApIE43QdB6cwmwTXJ6vy4sskSajTKF05bSbnGYdBWY9GgLzAG0/Rp79gEJBWMk+260u9rdHw3CvNtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791486575; c=relaxed/simple;
	bh=2N6eSbzDxLAKel/MxKmlz7KTgCe3f8Y1d4WU2nj1U9Y=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=FNB9FmWhyeL5n1AKpo6gpJslwyVGibt2GxAkhJJTmG5DaucdjZ82+7aAyCj2lLFdQFm6uo4V91DvPiI/cq+pnTJvelaFIUOivebfXA01ItoyQEakQkTcN2FpIQFvsiOvaHQhxRhMqTHmkUU0YHjDbKW9pzWqSaXDr8tyN9FRpEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NjmkHNIi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NjmkHNIi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B05C1F000FF;
	Thu,  8 Oct 2026 19:09:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791486574;
	bh=yXhuxRd8xwrFdY2h2Zmrx3L918Phc18u2MUlHJs4eMY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NjmkHNIizxzeb2JYiF1tYKpclZta5k95sv82iiwIHNNTl7iDLzLYsSGLkH2VNWidR
	 Cdhncsrq1DvvVYQ57PeFJInTkT+amTP88q6M6y9BWxsZqbeK8Z77RG/g1NakQ+6SNb
	 C0jSHzc/uTyxDjkCcWn2gUJYd5Tpk53EVMO1QOBVImgir7qY8KgVWeVkNJt2rE8Zrd
	 sejWrOaq/+RnmdjYRTEMutVCxuQMoET/gtydZh8eyEipC2rKlYndM37qgQhlNdEqoU
	 ISWMIHf066vrMigWuZtLaDCh7jniZuS8Vf4Bqf0m2NyGMcC7cQIqnLMb0S4iWjcVrS
	 5hpfWDmX9CarQ==
Message-ID: <sashiko-outbox-164493@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 09/14] hv: use owned VMBus buffers in NetVSC and UIO
Reply-To: sashiko-reviews@lists.linux.dev
To: "Emerson Busson" <emersonbusson@gmail.com>
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <20261007190752.336426-10-emersonbusson@gmail.com>
References: <20261007190752.336426-1-emersonbusson@gmail.com>
 <20261007190752.336426-10-emersonbusson@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 08 Oct 2026 19:09:33 +0000
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] hv_netvsc: host bugcheck DoS due to GPADL teardown after failed re=
voke
--

commit 418182ccc1e62bfbe8d59179d5fb1baf3aaa6d53
Author: Emerson Busson <emersonbusson@gmail.com>

    hv: use owned VMBus buffers in NetVSC and UIO

Move the remaining buffer consumers to the allocation, GPADL and release
entry points that carry one descriptor throughout their lifetime. Preserve
established exported signatures throughout the series.

> diff --git a/drivers/net/hyperv/netvsc.c b/drivers/net/hyperv/netvsc.c
> index ffba1443396ab..fd8aa7a3dcb32 100644
> --- a/drivers/net/hyperv/netvsc.c
> +++ b/drivers/net/hyperv/netvsc.c
> @@ -243,7 +243,6 @@ static void netvsc_revoke_recv_buf(struct hv_device *=
device,
>  		if (ret !=3D 0) {
>  			netdev_err(ndev, "unable to send "
>  				"revoke receive buffer to netvsp\n");
> -			net_device->recv_buffer.leak =3D true;
>  			return;
>  		}
>  		net_device->recv_section_cnt =3D 0;
> @@ -295,7 +294,6 @@ static void netvsc_revoke_send_buf(struct hv_device *=
device,
>  		if (ret !=3D 0) {
>  			netdev_err(ndev, "unable to send "
>  				   "revoke send buffer to netvsp\n");
> -			net_device->send_buffer.leak =3D true;
>  			return;
>  		}
>  		net_device->send_section_cnt =3D 0;
> @@ -308,18 +306,14 @@ static void netvsc_teardown_recv_gpadl(struct hv_de=
vice *device,
>  {
>  	int ret;
> =20
> -	if (net_device->recv_buffer.leak)
> -		return;
> -
>  	if (net_device->recv_buffer.gpadl.gpadl_handle) {
> -		ret =3D vmbus_teardown_gpadl(device->channel,
> -					   &net_device->recv_buffer.gpadl);
> +		ret =3D vmbus_teardown_gpadl_owned(device->channel,
> +						 &net_device->recv_buffer);

[Severity: High]
With the removal of the leak check here and the manual assignment in
netvsc_revoke_recv_buf(), is there a risk of a host bugcheck if the
protocol-level revoke message fails?

If vmbus_sendpacket() returns an error (like -EAGAIN from a full ring) in
netvsc_revoke_recv_buf(), the NetVSP layer won't receive the revoke message
and might still actively map the GPADL. Unconditionally sending a VMBus GPA=
DL
teardown request in this scenario violates the protocol invariant. Could
this lead to a Denial of Service via a host bugcheck or guest termination?

> =20
>  		/* If we failed here, we might as well return and have a leak
>  		 * rather than continue and a bugchk
>  		 */
>  		if (ret !=3D 0) {
> -			net_device->recv_buffer.leak =3D true;
>  			netdev_err(ndev,
>  				   "unable to teardown receive buffer's gpadl\n");
>  			return;
> @@ -333,18 +327,14 @@ static void netvsc_teardown_send_gpadl(struct hv_de=
vice *device,
>  {
>  	int ret;
> =20
> -	if (net_device->send_buffer.leak)
> -		return;
> -
>  	if (net_device->send_buffer.gpadl.gpadl_handle) {
> -		ret =3D vmbus_teardown_gpadl(device->channel,
> -					   &net_device->send_buffer.gpadl);
> +		ret =3D vmbus_teardown_gpadl_owned(device->channel,
> +						 &net_device->send_buffer);

[Severity: High]
Similarly for the send buffer, does removing the leak check and flag tracki=
ng
in netvsc_revoke_send_buf() expose the host to the same bugcheck risk if
the revoke message fails to send?

> =20
>  		/* If we failed here, we might as well return and have a leak
>  		 * rather than continue and a bugchk
>  		 */
>  		if (ret !=3D 0) {
> -			net_device->send_buffer.leak =3D true;
>  			netdev_err(ndev,
>  				   "unable to teardown send buffer's gpadl\n");
>  			return;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261007190752.3364=
26-1-emersonbusson@gmail.com?part=3D9

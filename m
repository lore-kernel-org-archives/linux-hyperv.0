Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6015E2D1F44
	for <linux-hyperv@vger.kernel.org>; Sat, 23 May 2026 14:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779547043; cv=none; b=epAOZcCofTLOx+9HHKFsMHN7SxicWFFSutMpu1Klm84NtVtGlJ1cSTRQjie1uE0DiOeSNsCqk51tW/VuPfeEI9af6CjDPGP14swM/QHn0RRgI40I71EkNA5R1InPam75UP5/R+vne37txUJTIqgSSzU3dP2yjH+oOSfpG50cuOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779547043; c=relaxed/simple;
	bh=qiqaQQQPGXUYIskbzcPMgWfsZ329FRB0LdyTdghVTT4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=p6BaonikBZdcC9S7VeTAVE4gM76jAeyo8A9hCQKvdr1+eq1TyuwF6LvGZj57HVsHaIIomSKjfteWBAs7uQ4uWmkVMKBIQSbNw9D6EiKbYPUxD0jj0StThj2xltjDI8iDi2MyDkmvpDOt2u2o7OiVxVri97pNNPHPzKzzFhmnTxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ujz9qfZu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ujz9qfZu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3D681F000E9;
	Sat, 23 May 2026 14:37:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779547042;
	bh=n8jqhn9EdTq6WjqfIiaoctrUoTHOVjfrtwJSuS5l20A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ujz9qfZudx8cnYq1CqCQLr001K9+2TOZflgv+EV/Kt9x2gVSlpk/N+My+suokhKmY
	 8Mnjtric92QqRaGx4w4nAf6H64tVyKYHlvcAePl5V5sgkFOef90FLAGKIGMy5xG2Mw
	 4YVPpW0AvS7oEsE655M94ly7o/+YMnyCBQXmssJ7GMZ6rvOTSQQ5nUluwlD7ghN8Bh
	 QuG2fXm5iksJaGg4Z1bJshclLIQ4fdcmn/Mf8+/TgvxNG9Y3SfuW+/pYxE1JgIfuSM
	 L/LfWNlbrnEKfIMACdgaM0g59tgmuMrN4owIZGZjCK89QOdOHPsKABqt86ZIOYHcc2
	 +QU+lcNZKw7Ew==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 1/2] drm/hyperv: validate resolution_count and fix
 WIN8 fallback
Reply-To: sashiko-reviews@lists.linux.dev
To: "Berkant Koc" <me@berkoc.com>
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <6945b22419c7d404b4954a113de2ac9c900dba93.1779542874.git.me@berkoc.com>
References: <6945b22419c7d404b4954a113de2ac9c900dba93.1779542874.git.me@berkoc.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 23 May 2026 14:37:21 +0000
Message-Id: <20260523143721.E3D681F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] State Machine Desynchronization and Type Confusion due to missing =
reinit_completion()
--

commit 75355159caa20ef4cf6b36266c2aa7dcbac0177d
Author: Berkant Koc <me@berkoc.com>

drm/hyperv: validate resolution_count and fix WIN8 fallback

This commit bounds the resolution_count in SYNTHVID_RESOLUTION_RESPONSE
to avoid out-of-bounds array access. It also adds a unified fallback
for WIN8 default resolutions when the probe fails or max dimensions
are left unpopulated.

> diff --git a/drivers/gpu/drm/hyperv/hyperv_drm_proto.c b/drivers/gpu/drm/=
hyperv/hyperv_drm_proto.c
> index 051ecc5268321..c3d0ff229e3d0 100644
> --- a/drivers/gpu/drm/hyperv/hyperv_drm_proto.c
> +++ b/drivers/gpu/drm/hyperv/hyperv_drm_proto.c
> @@ -391,8 +391,11 @@ static int hyperv_get_supported_resolution(struct hv=
_device *hdev)
>  		return -ETIMEDOUT;
>  	}

[Severity: High]
This is a pre-existing issue, but does reusing hv->wait without calling
reinit_completion() risk state machine desynchronization?

If a prior request like hyperv_negotiate_version() times out, a delayed
response could trigger complete(&hv->wait) and leave the completion
signaled. When wait_for_completion_timeout() is called in this function,
would it return immediately without waiting for the actual response?

If a WIN10 version negotiation times out and falls back to WIN8, could a
delayed WIN10 response satisfy the subsequent WIN8 wait, leading the driver
to mistakenly assume the hypervisor agreed to the WIN8 protocol?

Since there is no validation of msg->vid_hdr.type after waking up, could
this lead to type confusion where a delayed response from an earlier
request is incorrectly interpreted as the current response?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1779542874.gi=
t.me@berkoc.com?part=3D1

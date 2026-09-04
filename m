Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 976213D16FB;
	Fri,  4 Sep 2026 08:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788508957; cv=none; b=b5lo4DL+O4PSTvNzeBVmABvDwvi6BQJIS3p0sXfiofzi5+FMmjXh+vlN+i++IGwOv82ehy6/77PQz6Es5WYW2XIazo6jq0aleOg/3q1R9Ad5AUFxnJlEMqKyx4TOW0HkOkuw38teeK7aBkG9fhxCYGdHQcV9P0ytHu0jNx982FU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788508957; c=relaxed/simple;
	bh=UYcwg5gB2ncSdh3k3HTgL2Ich5ruHtlLkGuO7elwfeM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=g2Y/kyHv+1Oe+8v0aCqIkTf3++LkcaXPNehpge66K9hbbzdtYKXf1K3ZYbmegbOnkHWxlD1QuyLHJwvqNEXxJ75ZlB0TzC2vD66NwpUrchIuqwrZfN6LD8Cp0ddMD8Hyu1EyNzWiVTHxZjCK55VpXdadyN5nsh1gMpyOVeEDP2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WbfdpEWR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WbfdpEWR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10FD11F00A3D;
	Fri,  4 Sep 2026 08:02:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788508956;
	bh=UYcwg5gB2ncSdh3k3HTgL2Ich5ruHtlLkGuO7elwfeM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WbfdpEWRq+2a00KiIfxmtPG5NcMO2SpXYmzHEzsAC/qGSrnt3vCrkceilFc2dLfJs
	 A6jTTw8mFadAvNDtjv0cs20stzA8l6PEZo0QRgn7f4guJ71lxy+3eZJlm6LckRd/n5
	 +0gL2Fgqu66iyTdfqYFOKgwnuvH7t1zdlzKbRFBBu3Nhrdo06+g6+KQRy31LfaZ2an
	 ObKUuk/ircvTcEQ7Ni7d6cHtKnROgm2WXzsZ0cMc3zLsUO7hHgoK4p7Avbzr0hbGZd
	 KnL2VV29Pdu2Ef+Y76REavRaOIkwcm+bCICVdBfjvDhiz+N+Jro1XlO+v4IK/74Oib
	 aW/DDTArL38aA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 3/5] iommu/x86: Add architectural MSI reserved region
 helper
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yu Zhang" <zhangyu1@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260904075512.174154-4-zhangyu1@linux.microsoft.com>
References: <20260904075512.174154-1-zhangyu1@linux.microsoft.com>
 <20260904075512.174154-4-zhangyu1@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 Sep 2026 08:02:35 +0000
Message-Id: <20260904080236.10FD11F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

> Intel and AMD IOMMU drivers both reserve the x86 architectural MSI
> address window from normal IOVA mappings, but each open-codes the range
> and its allocation attributes.
>=20
> Add iommu_alloc_resv_x86_msi_region() to encapsulate those details, and
> convert the Intel and AMD drivers to use it.
>=20
> Signed-off-by: Yu Zhang <zhangyu1@linux.microsoft.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260904075512.1741=
54-1-zhangyu1@linux.microsoft.com?part=3D3


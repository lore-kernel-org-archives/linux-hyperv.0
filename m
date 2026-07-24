Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC3BA30EF95;
	Fri, 24 Jul 2026 23:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784935558; cv=none; b=brYud0iMnOJRiJhV+P7diJ/LzwOMR1QqPCeg0um51sXZkCBdtJ59DwaVr8L7zQLlbAzM6wM7Om+TtptV5nluU7mZnQI27LJZ9s7kKw/N0jqR7RyE0Jm6rnCyLA/414egeQc7eSbhq3ZdE0RiPxyF8PIYM8u33TuiH4dncdcKfiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784935558; c=relaxed/simple;
	bh=7bbfi0wJ+/alP3LxbvOyB2E20tpgL+33vug8unP2HrQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Q46+FikDzOuRIRVbS5+GfkQgfabnp1lTZmLGLoPJfR5sL7O9gbErzzuCDlaSqw0bv6OGY5EVyOIQZ3+HL5yvH6KDWjzdbWmmXq5mpNcwoY0TLOniawgdbvmSMmBJD1phIT65mOgnIAeY32lmAwvyaxrTdy2oqX95BuYNa3wGLcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FNJM3Y4N; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FNJM3Y4N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11BF01F000E9;
	Fri, 24 Jul 2026 23:25:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784935557;
	bh=7bbfi0wJ+/alP3LxbvOyB2E20tpgL+33vug8unP2HrQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FNJM3Y4NkgPsSRyEuSi5qhT8pcbmER9n5k7hIWkA6caXj44bqzjyGhIK72/9fhDwH
	 CVUduAYVInJzhX+tb9LvtyiWXy7ZlsTUx/uRoOlTrLCKtdjw3RjozRyDg+uJMyk0V7
	 lBhKT/OaLFJfMwgU+kk0hna6opab+toF3yWV94+Upyhtbs5gvJPg3zRWjDreB7oerH
	 3vj3xM44L77TZpVoj7O5o2QhX2w8TH4uS86K3qDm/LJFqWYRPSS+Q+WgDyRLh8Sssc
	 BNL8PVVkbPPtoWWHXnAr7ObX01sxmqtVLFduhac9j4pYRn2RiZe3Ls7iLjoI4ynmCZ
	 POcqjrtXsU80g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 2/2] PCI: hv: Add vPCI device reset support
Reply-To: sashiko-reviews@lists.linux.dev
To: wei.liu@kernel.org
Cc: linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260724230844.3259741-3-wei.liu@kernel.org>
References: <20260724230844.3259741-1-wei.liu@kernel.org>
 <20260724230844.3259741-3-wei.liu@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 24 Jul 2026 23:25:56 +0000
Message-Id: <20260724232557.11BF01F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

> From: Wei Liu <wei.liu@kernel.org>
>=20
> Hyper-V vPCI protocol version 1.5 adds a RESET_DEVICE request for project=
ed
> PCI functions. Negotiate the new protocol version and issue the request
> through the vPCI VMBus channel from the PCI controller reset callback.
>=20
> Use the existing VMBus response path. Return -ENOTTY when the host reports
> STATUS_NOT_SUPPORTED so PCI core may try another reset method.
>=20
> Signed-off-by: Wei Liu <wei.liu@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260724230844.3259=
741-1-wei.liu@kernel.org?part=3D2


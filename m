Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52F8A47F794;
	Wed,  2 Sep 2026 12:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788350969; cv=none; b=ed2d8DLYIUCTkE+4hZlTUKn8YkVkJwNbE1iGHTyCbjm8EDqzaiB6oRvQcrmOyY1d8uW5C+EuwCQPdtTKMafyg8u4n7NVXjvGLm/T2/vlNa9KujHQs/TGUP1VdVbUwlNgU6ZdgmedmKKA0xHHveiPVMfirFbL5qXcEzX+49gVAyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788350969; c=relaxed/simple;
	bh=h8E6356LN7xOxoD3tqsYtk+8SJEe6nTT9DC33DwukXI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=CTUGMsGLxOiLN+si0pWRSCj96N8kUUri7frC1xk+K301GuGL38BnoYz9PPzj0dHd/ZO1o8BGHEFjCYwWAQJ4cXPkapIR0LZqd+k0ox0XaYZnIPVi750UDDd1Gv5tStZryhH5EJoaCXZr79d0Km8dl9YNKtT4HgyKkmItaRwrt4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bt0IHAjN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bt0IHAjN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50A1F1F00A3A;
	Wed,  2 Sep 2026 12:09:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788350957;
	bh=h8E6356LN7xOxoD3tqsYtk+8SJEe6nTT9DC33DwukXI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bt0IHAjNENWKisip1BHemRkNfVbmPLDkvpO3LJzIA3vo87vjOsxv0gFlpiOw3I7g1
	 +T+kx+i8hBk1+G5gH152BnsApXORdmQxmTlb4i9tzExiU8/q9VCzVuIa3PAChS/P+h
	 xpTmOhaXhd2OpyL2JK4fKS/7YCw0HWlMZZONEQNopoEDuu9YoyfJmUA2Uc+xB+h9Le
	 KpotOHCmj++VuOO/WfChEBvZOCE4TSQwq8x71wT0Kgw/JGr4HNs++8yPzxz8KF4/38
	 sEFCUfpnHCVdv1GHT1GFggfdJvBepCi5+lnKVU5N4MJQdH1ZqOrwN+FIms+wr4orYS
	 5vJBlnO7U71Yw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] PCI: hv: warn when wait_for_response() waits
 indefinitely
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sahil Chandna" <sahilchandna@linux.microsoft.com>
Cc: linux-pci@vger.kernel.org, linux-hyperv@vger.kernel.org
In-Reply-To: <20260902115854.2629164-1-sahilchandna@linux.microsoft.com>
References: <20260902115854.2629164-1-sahilchandna@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Sep 2026 12:09:16 +0000
Message-Id: <20260902120917.50A1F1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

> A guest can wait indefinitely in wait_for_response() for the host to
> send either a rescind message or a packet completion. If the
> host does not send either, the guest can remain blocked with no
> diagnostic indicating a reason.
> This was observed during a guest kernel upgrade in which the
> host-side application handling the PCI channel faulted, causing the
> guest to never receive the completion request.
> Add a warning in wait_for_response() when the wait exceeds
> a timeout so that such a hang is visible in the guest's kernel log
> and can be correlated with host-side state.
>=20
> Suggested-by: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
> Suggested-by: Naman Jain <namjain@linux.microsoft.com>
> Suggested-by: Michael Kelley <mhklinux@outlook.com>
> Signed-off-by: Sahil Chandna <sahilchandna@linux.microsoft.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260902115854.2629=
164-1-sahilchandna@linux.microsoft.com?part=3D1


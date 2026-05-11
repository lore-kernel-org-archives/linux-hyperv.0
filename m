Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56B8135A387;
	Mon, 11 May 2026 18:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778522578; cv=none; b=F126vXeh0PtR2ys8mP+eabr2cihqB7qB1YyVozACQ0PA0CSX/RKew+4/MQC0izElaR5V5BGxChJ9bZCp0zu/n4eGgxqdyQ0GxIpYlo5SrvA3A3kzjQ1L97bgdWmsokR0+IG3V5s1BX6g8yGKZNZG9hcVlVhcqZooBP0umdql+0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778522578; c=relaxed/simple;
	bh=CGt2BXFmLddnsPKtaW/96l4swYf5G9PBJ/De+0lW1tU=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:Subject:Cc:To:
	 References:In-Reply-To; b=nHGc8qpcptjIds1M5jThCvSVZr7WGq2Xq7EjQtF2EsAV9UYo+mgvppnnEC57NOUCtBIEvHVhFH9kF2ZMP8QHn6TQ93G6TZr6Bnkil/EKtmU8wxnscBDJsc8hjX80C12q69wvBgMCkK3RgGRMn3403B5lxRQSCSD9pUN3n2qR3F4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FDAmnRf/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FDAmnRf/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A7DEC2BCB0;
	Mon, 11 May 2026 18:02:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778522578;
	bh=CGt2BXFmLddnsPKtaW/96l4swYf5G9PBJ/De+0lW1tU=;
	h=Date:From:Subject:Cc:To:References:In-Reply-To:From;
	b=FDAmnRf/zb1SJiyqbsbSqtEkOw0In4byifA/3b/dTxH1MZgOMHi1ULublk5ky1tGc
	 8dtPTdRfodbpm/1iMb8iCie37Q2jzdk28mwuQ748OMrm+98Cxy/5yJyC+IPOhvPRlo
	 78yZN77yMSz8V//VxXY5PXR1xzz9xrKmApqU2De0K6T1+w+Tmf/0/7k+i7eye4Pfwv
	 Y0Svju4r1dFKEqkcjbqHBNWdCPiozO2E7p2zWgdZhD+dak8yMBhLrpUP3/Hh1Lu3XX
	 rEAlBAdpKqCdNq48XSrK42Ps60jtq35y4Y4d+ZOIFBLwBqoHz7KENVn7Wc5wY5TxjF
	 XEcLs5hh/jQww==
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 11 May 2026 20:02:52 +0200
Message-Id: <DIG1MUKJVLEO.YGTSSYIO5T1K@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v2 0/5] treewide: Convert buses to use generic
 driver_override
Cc: <driver-core@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
 <linux-hyperv@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
 <linux-remoteproc@vger.kernel.org>, "Danilo Krummrich" <dakr@kernel.org>
To: <gregkh@linuxfoundation.org>, <rafael@kernel.org>,
 <linux@armlinux.org.uk>, <nipun.gupta@amd.com>, <nikhil.agarwal@amd.com>,
 <kys@microsoft.com>, <haiyangz@microsoft.com>, <wei.liu@kernel.org>,
 <decui@microsoft.com>, <longli@microsoft.com>, <andersson@kernel.org>,
 <mathieu.poirier@linaro.org>
References: <20260505133935.3772495-1-dakr@kernel.org>
In-Reply-To: <20260505133935.3772495-1-dakr@kernel.org>

On Tue May 5, 2026 at 3:37 PM CEST, Danilo Krummrich wrote:
> This series is based on v7.1-rc1 with no additional dependencies, hence t=
hose
> patches can be picked up by subsystems individually.

Gentle ping on this one; I can alternatively also take those patches throug=
h the
driver-core tree if you prefer.

Thanks,
Danilo

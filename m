Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 014C7492190;
	Tue, 19 May 2026 11:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779188979; cv=none; b=JEw4qBNOsihOEVhPsYfFpnW5Pt89gDxRK3xehbSUyBf9oNRwdUaG3ZbWjzFnNKjUCrNmGlEVdZAgkyPnVkw39ty/c0XXXOhEhNszfRkN8Aq/OPu8x6ZApoNbQci4VMrtsE8x8iFR3h1yoHrMYr+mW+OCbNQk5gYqz38DgCHdWHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779188979; c=relaxed/simple;
	bh=Z6QrArGYUtSILgnE4xtownugUMTyOsOnkTPAE3UFtwA=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:From:Subject:Cc:
	 References:In-Reply-To; b=mYIAlPRxfmAogGV7hFyKFahOw1E/ti4gW8JW8IPqDNoy05s+02g2iWNNYacoYCJ8pS6vvxPWRGnBELPXhJ9rJNEkNbbyv9nby4EVEwwwprQe+W0K1IAfpZo+1XgNzFr+xg3EMPHiSTOEgxE+zkvhFKIHG415QctqBUswzuhCTu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZfCT1tvj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZfCT1tvj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87442C2BCB3;
	Tue, 19 May 2026 11:09:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779188978;
	bh=Z6QrArGYUtSILgnE4xtownugUMTyOsOnkTPAE3UFtwA=;
	h=Date:To:From:Subject:Cc:References:In-Reply-To:From;
	b=ZfCT1tvj6GDRgCxaMNdA+t2S2lUl95uAfPgB/AxCf/4FdWMaQbycNyioRwE7Sapbz
	 8cfamjCYkazg0HTdxra4l/6S6TmWfyWneLLSBBYpgb+Xh08vuKR+Bz4EaUKxfyPg+h
	 n3YubeHBU8avdWjefVbCyvQnjp5rsN3e86kTi9vrzMqrDGtfLx6TarUlZUVNEsvmlM
	 wV3B43HBiZ7YArGfFc9T3J0QrAU3Bf/8tdpFh4oaIT+yZy4gEwAOtTvHbvn3H21Fhl
	 BZ/NlDcwXhq/V5BHNKkt1yAyRxfx2nCCVbkGzZZNq8qTOMvS34ncXP87dFJENK9aM/
	 yRb4gW9cmiDZg==
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 19 May 2026 13:09:33 +0200
Message-Id: <DIMLUQZZA8RT.1W2KO3RDAQM01@kernel.org>
To: <gregkh@linuxfoundation.org>, <rafael@kernel.org>,
 <linux@armlinux.org.uk>, <nipun.gupta@amd.com>, <nikhil.agarwal@amd.com>,
 <kys@microsoft.com>, <haiyangz@microsoft.com>, <wei.liu@kernel.org>,
 <decui@microsoft.com>, <longli@microsoft.com>, <andersson@kernel.org>,
 <mathieu.poirier@linaro.org>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v2 0/5] treewide: Convert buses to use generic
 driver_override
Cc: <driver-core@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
 <linux-hyperv@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
 <linux-remoteproc@vger.kernel.org>
References: <20260505133935.3772495-1-dakr@kernel.org>
 <DIG1MUKJVLEO.YGTSSYIO5T1K@kernel.org>
In-Reply-To: <DIG1MUKJVLEO.YGTSSYIO5T1K@kernel.org>

On Mon May 11, 2026 at 8:02 PM CEST, Danilo Krummrich wrote:
> On Tue May 5, 2026 at 3:37 PM CEST, Danilo Krummrich wrote:
>> This series is based on v7.1-rc1 with no additional dependencies, hence =
those
>> patches can be picked up by subsystems individually.
>
> Gentle ping on this one; I can alternatively also take those patches thro=
ugh the
> driver-core tree if you prefer.

Since the remaining patches of this series have been out since v7.0-rc5 wit=
hout
any objections, I'm planning to pick it up through the driver-core tree for
v7.2-rc1.

Please let me know if there are any concerns or whether you prefer to take
individual patches through your own tree.

Thanks,
Danilo

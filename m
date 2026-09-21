Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AC533BED35;
	Mon, 21 Sep 2026 15:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790005813; cv=none; b=bOi/ybU7B2rhvpLUimYMB40NuSP6RNksVXiWKq54RoTrsRZCAIZaMm4j/c7HPVY1N8vLXjMt6HvCuFOw2HtYo/dqdA5gUj6o6txJtq1C8cdBq24YnRMnh/sManYA/pq9TSCwaiPsZikPxUwQwvGJI6TNtywjk8vQUq0vDVuiCXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790005813; c=relaxed/simple;
	bh=HHOV2sHuKbO7q1y40mnJ3BBAhf3V7+LoKvNJ49goYcw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NVu6qhTI/dT9v1wcDSYIQG1vzn4tDfmGPmpwNltUFiOj8aYECDe+3YQGmt/Mb6Hm7R9QGUzbg90bh/VD9jTxWTT3dUbAjQYydlg6UfAW9286MacH341rQfLaBocWbfiFZUluNz/e6K9u1/pYarPmfLhft4FVn2plRPSo+SjQyr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Oh6mIuQh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Oh6mIuQh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A2DE1F000FF;
	Mon, 21 Sep 2026 15:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790005809;
	bh=zNJc6l1eT2arkxwpoV3EiLXIzBNXwmByVmOhj8b7aKs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Oh6mIuQhm2v+ty5d/2r34B8sYcPUN24dGLKtnmIw7d9PnyuTtkUJ3yk11orWgNjJs
	 H9VGZxSAxkHL5pwAj48a7zPo17bSZSNRLJTe3qYpMx0G4rYK7yI5EtRd2HH1iUC0Gj
	 egaWhIDMDkPWE8YTVUaFwwVPDl91LyGeXYrxF2I9cB9imgatjFfjFRglRVmUD4tEAI
	 504DfX5RF/T8GUooJ4o4dkeh1DlXaBlZlnQYX4nYtVZ3txwNyhcmYSKld8xl0bFVzw
	 GtR++9gvWM0T1ZllGKUFwQ1Og11M/eONSGjVWzZAOVRSyl6Mlz1rP/2lcqcfYgw6by
	 p0EtdZu0S8kSw==
Date: Mon, 21 Sep 2026 08:50:08 -0700
From: Wei Liu <wei.liu@kernel.org>
To: Sahil Chandna <sahilchandna@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, namjain@linux.microsoft.com,
	mhklinux@outlook.com, hamzamahfooz@linux.microsoft.com,
	wei.liu@kernel.org, decui@microsoft.com, longli@microsoft.com,
	lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org,
	robh@kernel.org, bhelgaas@google.com, linux-hyperv@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] PCI: hv: Warn when wait_for_response() waits
 indefinitely
Message-ID: <20260921155008.GA1566687@liuwe-devbox-debian-v2.local>
References: <20260914103918.3125157-1-sahilchandna@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260914103918.3125157-1-sahilchandna@linux.microsoft.com>

On Mon, Sep 14, 2026 at 03:39:09AM -0700, Sahil Chandna wrote:
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
> 
> Suggested-by: Michael Kelley <mhklinux@outlook.com>
> Reviewed-by: Naman Jain <namjain@linux.microsoft.com>
> Signed-off-by: Sahil Chandna <sahilchandna@linux.microsoft.com>

Applied. Thanks.

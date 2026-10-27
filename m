Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793119817;
	b=sgqPmD3HIDOzh9o61M2IOm+3CEXrQsEufWivIVJl2elwle+U7p0or8hn1xiDk7DX896/
	 mi35Pp0IK0nbzbtf22unH2MClsiJD6tPfy4G0hqH4msAEL8FTPTcdp2NNdRUKxIAYbMHs
	 dW0CzYlDdamthAzltRoRwK+dBGyOB67N0KkNTZhbwCVoAXpr/AnsjN7+6SB7wZjqioJ0/
	 2AOEl09ijbnEc+KvJHTM1sZj5Rn0lWEGlXwgW2aNLl8KbBaPY7G3m+S3E1gtvME5fodoX
	 BFRDsLMfJ8uP6xK8fRX31XoDic2bvk0CClLsHWxPAc+mR0NVaBGaL22LAgUSBrEnxMQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793119817;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	b=D9VGx9Erk/2fJkmiFXY5QWz0gwabISD3fwcf0IeH7cJ/rtarUHE6exDjwJlc4ynmIRgp
	 ydCXPwh1fUas4lkRj8e8E2b0/fTkxS3GymwDtfhZ6D8MTDOFYVHAQzt9jZzpuJhHc/sfT
	 bVs8NaaIFKq5h0R88kmR6LRNC1ZbY+y56wt5pFgmtHTB5k91ykNxYVvzGVhoyhdFosdQ6
	 Fo81+jcgZWgNaHxcg/HStP5eB1ZUcFcWTTuuOH8WMUih5kx9yhKnqKyI65tgMdExl6uOv
	 BHM9SIHfwYA/mu2wHJhy2PB4G15fGWcofvNLk+6SGSjAf+HCnxPQMCaLPTtn7TfEU1w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fhsU8Rnf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 129E6606A323;
	Tue, 27 Oct 2026 16:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fhsU8Rnf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03F0E1F01829;
	Tue, 27 Oct 2026 16:50:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793119816;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fhsU8RnfcFr/xVSLNhaC14VM+/SFQqu0UkmWpms/XnWc79gbfQPPOz686VDs+iJwR
	 mtF4JCYonsrwSjB/1nGVc8A8WUqq5TWOAmFwCs3SZkaHYz/woaUIkCurPldYvEEtGt
	 LWbjWbMucFxC4K12Jko8RpHurE9hAyK6ueM+w7IxVC58gskxlXUcJxkKbsD5xDtyQT
	 JotyWNhckRlOBvrb10H1AvDv0w5MYfX1R2VfivtaRIQxORAKmJUEnDcNPu3c48szgB
	 /TNgxdNIAbKPaaXpNyaaWqzOTuHV70BxemuWi1S5HRnPTnQwI2uOKjzh54/Z4T6kR5
	 yI+156Knzvm3g==
From: netdev-bot+sinfo@kernel.org
To: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
Cc: haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, lkmlabelt@gmail.com,
 parri.andrea@gmail.com, linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Wei Liu <liuwe@microsoft.com>
Subject: Re: [PATCH net] hv_netvsc: Stop PPI parsing on invalid metadata
Date: Tue, 27 Oct 2026 16:50:15 +0000
Message-ID: <179311981545.3327.1468271838360668962@kernel.org>
In-Reply-To: <20261027164722.3393397-1-ernis@linux.microsoft.com>
References: <20261027164722.3393397-1-ernis@linux.microsoft.com>
Auto-Submitted: auto-generated
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Post: <mailto:linux-hyperv@vger.kernel.org>
List-Help: <mailto:linux-hyperv+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hyperv+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Hi!

This is an automated message. This series looks like a fix, but its
commit messages seem to be missing some information:

 - How the issue was discovered, e.g. hit in production, hit during
   development, syzbot report, manual code inspection, LLM or static
   analysis tool scan.

 - Whether the issue was actually triggered, or is only theoretical
   (e.g. found by code inspection). If it was triggered please include
   the symptoms, like the stack trace or error messages.

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account. If the series needs another revision for
other reasons, please include the information in the commit messages
then.

The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.

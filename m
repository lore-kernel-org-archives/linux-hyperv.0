Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37A7D502574
	for <linux-hyperv@vger.kernel.org>; Fri,  9 Oct 2026 18:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791571451; cv=none; b=uXs1kkOtSC71vEaMMoosqQ+JarY6kiI6OaXN6mSS+QZ7d6M6mvIe9BHpuCXpeyri+S96VmqsNYmo5epj3oL+P0v/0cvXF4yDcQHGxYLfQ26CaTxmZVU/AKcd1bEmn9lSR7KCVjSi94Huyatml6p63T5amUC2C8bvVA80s4qwgwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791571451; c=relaxed/simple;
	bh=bk132uZ7NkgiEi4KhSYbnW8UsYnqDP2T+CQ+H1I26gw=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=EJP30WCzYvX7OTcJg2OLU3yIadGA026ZVjms8pqo0CgB2AmHCI4pD4RRuA2nhsXDKc/g9qLNE6tRxLg7AM94bhyojsBpQNTGwKx8uiDwdFZ7djrLpb39oFWuBbmtC5TDCnXr2pcC88Jf3gnZnkfQffLWyY8fEW1uNlB8jD6T2Dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DrR45eLN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DrR45eLN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DB331F000FF;
	Fri,  9 Oct 2026 18:44:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791571449;
	bh=XCgA27cKgWBBiWflsIvauuavRGKeyTYsOBjbYR/ai00=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DrR45eLNnQbGZp7AhHNFZMrGQlzU41MGxqJvmPcpKs8G5dC5DPvHcyK0p6mNwOrP9
	 gPbLn+7QveHJswTZUm0ZTwqN4u25GJDqPFxCTA9dX1fgvRNYQ5T5jsK3Re0pa1XJVs
	 OSJJJOYQTcokRJ2ehZk6Q8DGFWfrJY8Rfg8JmWTI6MK9suijpGbchthvSyNsxh5XCd
	 nl17r43wXHSHTxy4JdSlj6kkVLqDJ8yXTj7oi9IJ4r+SAXU/CnBA3lGTWqzuMg8t/Y
	 UMvl08LQDhA94dz85fB4HBrly9nqfEsgG3fxn8pmzrrZkvrb2lod2tFxJanSdRWJbi
	 LUUQ/DIAEvrWg==
Message-ID: <sashiko-outbox-165967@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/1] Documentation: hyperv: Update documentation for
 sending VMBus packets
Reply-To: sashiko-reviews@lists.linux.dev
To: "Michael Kelley" <mhkelley58@gmail.com>
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <20261009184056.7382-1-mhklinux@outlook.com>
References: <20261009184056.7382-1-mhklinux@outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 09 Oct 2026 18:44:09 +0000
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] docs: hyperv: typo in vmbus.rst 'arrving' instead of 'arriving'
--

commit 3fd30f16ff2564a1edce678567a65e19e411e062
Author: Michael Kelley <mhkelley58@gmail.com>

Documentation: hyperv: Update documentation for sending VMBus packets

The commit updates the VMBus documentation to reflect changes in the sending
functions, specifically the removal of vmbus_sendpacket_pagebuffer(), the
addition of vmbus_sendpacket_getid(), and the updated capability of
vmbus_sendpacket_mpb_desc().

> diff --git a/Documentation/virt/hyperv/vmbus.rst b/Documentation/virt/hyp=
erv/vmbus.rst
> index 654bb48499724..9c5b712c6e397 100644
> --- a/Documentation/virt/hyperv/vmbus.rst
> +++ b/Documentation/virt/hyperv/vmbus.rst
> @@ -141,14 +141,15 @@ Three functions exist to send VMBus channel message=
s:

[ ... ]

> +2. vmbus_sendpacket_getid(): Similar to vmbus_sendpacket() but returns
> +   a transaction ID that is matched against a reply from the Hyper-V
> +   host. Useful when the struct completion (or other rendezvous data)
> +   must reside on the caller's stack. By invalidating the transaction
> +   ID before exiting the function due to a timeout or other error, a
> +   late arrving interrupt is assured to not trash the stack.

[Severity: Low]
This isn't a bug, but there is a typo here: "arrving" instead of "arriving".

> +3. vmbus_sendpacket_mpb_desc(): Message with one or more data ranges
> +   to target. Each range consists of a single offset and length plus
> +   a list of GPAs that describe a logical area of guest memory.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261009184056.7382=
-1-mhklinux@outlook.com?part=3D1

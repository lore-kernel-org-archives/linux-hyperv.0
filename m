Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 993AD3C1404
	for <linux-hyperv@vger.kernel.org>; Thu,  8 Oct 2026 19:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791486578; cv=none; b=eMfIrSGBJLyX42My8+ZgCttMB+abQqNs7uAn6SV6ZSU+34+UBM6paBlKWQ4llsbJnsxHcX352v94AAOFO3mXiMYeM/SyL/PAb7BWLM6zKfBeYNJyG6eltUIpjHUovcCUTYi3qzc2htSpNNypYYah0sETBgHcUeWIB2LDfFQJonU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791486578; c=relaxed/simple;
	bh=cfjawSXwQ4ST8AQpfkKILIJXc47XyZAOVEmoSy5jNk4=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=fvtpBZgfHqYNDRbb9Ea73usyO4DMfQ0zgNAHZOHHGPH3MqlS2f4nMOfYcQUK1CFNLGptYZGRAWuZeyLreSN+IL3wA2XBjOGq1sy6cEXcNU+JYO1/aY5swD9P2IIoYzGV2ZEPut0SCdPMSw9zvZ9XSjYAHOZfuCRCjEk081cnkBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DYkEDdjL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DYkEDdjL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 207CE1F00893;
	Thu,  8 Oct 2026 19:09:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791486577;
	bh=cfjawSXwQ4ST8AQpfkKILIJXc47XyZAOVEmoSy5jNk4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DYkEDdjLaZGTp1SttWyXZakCLzYKk6Jtm2HMOu1xkcFAdOBxWLik6vOYV54jkZMVI
	 f2CWTUxJOfUAG7jUhe2ymCnS2ENSUW0kqquweihQxTTSnsDQcNvEHbJld7cPsBNMcI
	 mbbTt+KmRC0fwTzeAmGO+o8s5ydPM/84YrklJz1Oxln1UmMpQilo+glAByMhgqCZ7s
	 PF2OO4Z4eli+JGZ/n7NX8mzFheM8ew0l3/D7AIJUXbAPYPbMgi+gQ3Ka5loE3yrbix
	 pQfvXIXLGrumm2OXIplI8fNdNyR/kNjq4ItGsmcYsbFift+sujc/uE0pelbHSlrkyy
	 YrPwhZ+37op7g==
Message-ID: <sashiko-outbox-164500@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 13/14] hv: netvsc: handle a NULL request address on
 empty completions
Reply-To: sashiko-reviews@lists.linux.dev
To: "Emerson Busson" <emersonbusson@gmail.com>
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <20261007190752.336426-14-emersonbusson@gmail.com>
References: <20261007190752.336426-1-emersonbusson@gmail.com>
 <20261007190752.336426-14-emersonbusson@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 08 Oct 2026 19:09:36 +0000
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Critical] netvsc: Type confusion and memory corruption via untrusted hos=
t msglen mismatch
- [Low] netvsc: data race on global wake_queue ethtool statistic
--

commit cc27953d7c3e5380170944c920266d1ad5b66616
Author: Emerson Busson <emersonbusson@gmail.com>
Subject: hv: netvsc: handle a NULL request address on empty completions

This commit introduces a new check in the empty-payload branch of the netvsc
send completion path to tolerate NULL request addresses, which occur during
control RNDIS sends. It extracts the queue wake and accounting logic into a
new helper function and provides associated KUnit tests.

[Severity: Critical]
In drivers/net/hyperv/netvsc.c, within the netvsc_send_completion and
netvsc_send_tx_complete functions, is there a potential type confusion
regression? The empty-payload branch relies on the untrusted host msglen =
=3D=3D 0
to cast the context pointer to an nvsp_message. If the pointer is actually =
an
sk_buff, does this result in a memory leak? Conversely, if the host sends a
msglen > 0 for a channel_init_pkt transaction, the pointer is cast to an
sk_buff in netvsc_send_tx_complete. Since the pointer is an interior struct
member rather than an sk_buff, could this cause out-of-bounds reads and
slab memory corruption when napi_consume_skb is called on it? This sequence
is reachable by an untrusted host, which violates the security boundary in
confidential virtual machine environments where the host is untrusted.

[Severity: Low]
In drivers/net/hyperv/netvsc.c, at line 788 within the newly extracted
netvsc_send_acct function, does this code introduce a data race on the
wake_queue ethtool statistic? The increment operation on
ndev_ctx->eth_stats.wake_queue is performed non-atomically. When multiple
VMBus channels process completions in concurrent NAPI softirq contexts on
different CPUs, and both channels need to wake their respective stopped
transmit queues, could they simultaneously evaluate the queue state and
update the shared global counter without synchronization, resulting in lost
increments?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261007190752.3364=
26-1-emersonbusson@gmail.com?part=3D13

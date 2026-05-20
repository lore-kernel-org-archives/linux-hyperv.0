Received: from mail-01.1984.is (mail-01.1984.is [185.112.145.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77B4A3A0E8B;
	Wed, 20 May 2026 13:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.112.145.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779283438; cv=none; b=ZJrP7/EosTK9MEzfi4Tsu/ThhDMZfnqsGPKpr0reOheFkLI8pnwRsXeRqOmJWZZLQxUinsVV+Hk03BIUzfSEmzxAeqO520Yu9zhd9xdYzhl2YRJyEx/wdbGdS3WxNQjZUho/r8Rdr4vB15QW7EPmYIXXlV+mLYi37/HfCya6HE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779283438; c=relaxed/simple;
	bh=JvBQ7rPkNMv7B3vcdnRtgIQCanNIdp7WeKtGYiMP2Fo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G4ZHKwBIh1cH+DpegdSCephoKDC8aK3sWCP6vxJXoCzuyEeCb7D/pZIuODbA6oF7Y4oz3KugayRmxzBpeuM1VjsoYYzdXxyfsRG1ueD7MncpMAty5FoacKLCMk4SWvsI9y5wHdKfDfDofWowexDp+eUP5jJ5Zz4FAz4Ri9kcwMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=berkoc.com; spf=pass smtp.mailfrom=berkoc.com; dkim=pass (2048-bit key) header.d=berkoc.com header.i=@berkoc.com header.b=bm2qlhQQ; dkim=pass (2048-bit key) header.d=berkoc.com header.i=@berkoc.com header.b=hQroMKRY; arc=none smtp.client-ip=185.112.145.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=berkoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=berkoc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=berkoc.com header.i=@berkoc.com header.b="bm2qlhQQ";
	dkim=pass (2048-bit key) header.d=berkoc.com header.i=@berkoc.com header.b="hQroMKRY"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=berkoc.com;
	s=1984; h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=TpHuoAiInQYxT4YJJ3nssWVAmB6TOOeSDac13iJxzn0=; b=bm2qlhQQTMezAyjtR8gRC95HTt
	IRnRWM4RblahYeWhH28JMXRi5XNstVjAyfmAw1tC1vA2U/yOtCHA31AtXzXVrYva4y9Zu6/JCW4fX
	XV6tZsLO7z0/esu9bWRoYAhJnNQo+NzGGqEA3STGv9Hlmgo6J/6URUAI0lA6pqUxLdT5fU8cVauy6
	xPxK0xEDMp2ozYGG7nMrxGuC6Y32blEha3jy8r9UhAinYw1GxaFCCg6bEMXc1fNVREXqc9ji+z8b8
	9DCihz3QL1MOfejh83wxVL5mg7NWVq0/w6jMSJCUF0tqpUVOAYSRWcibumaVnDgBmcK7D4MuGo2Cq
	NxOHsOBg==;
Received: from localhost
	by mail-01.1984.is with utf8esmtp (Exim 4.96)
	(envelope-from <me@berkoc.com>)
	id 1wPgto-008r7y-0r;
	Wed, 20 May 2026 13:23:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=berkoc.com;
 i=@berkoc.com; q=dns/txt; s=me; t=1779283418; h=message-id : date :
 subject : cc : to : from : sender : reply-to;
 bh=TpHuoAiInQYxT4YJJ3nssWVAmB6TOOeSDac13iJxzn0=;
 b=hQroMKRYqDHDZIIhVsEmRbGcCbeW8eX/4NKZvhEfOt7XTPQ76sQcek/kK6SZGYj+p3sUz
 j2ljWPFCDbD2NzTYNMmWBZZtYs3Pa652otjW2D0E07Z1cwWnG7B+Jz1S2lbFAGUMEzCeztX
 +jtI49ZhLTcq0QLlErVthy0ojs73rtHBV1RZGWEUosd+zh/ft0pXeD0F1rZmOqVL3R902tT
 qpxoXvRt+Dlp+8DSgfLBRHvd7yA3XmcEF/Q2JiI+HlMeNu5NGUQZ/orka2PrGRn8nko0gLv
 /++lnTEpxw5yj80V8Axh/l56wR2LOtLGMB803YxaEg/0razwgaAH8trU1rnQ==
From: Berkant Koc <me@berkoc.com>
To: Saurabh Sengar <ssengar@linux.microsoft.com>, Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>
Cc: linux-hyperv@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, K. Y. Srinivasan <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Michael Kelley <mhklinux@outlook.com>, Thomas Zimmermann <tzimmermann@suse.de>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, Deepak Rawat <drawat.floss@gmail.com>, sashiko-reviews@lists.linux.dev
Subject: Re: [PATCH v3 2/2] drm/hyperv: validate VMBus packet size in receive callback
Date: Wed, 20 May 2026 15:23:38 +0200
Message-ID: <177928341826.371979.14701698047864220449@berkoc.com>
In-Reply-To: <20260519213450.50E611F000E9@smtp.kernel.org>
References: <e6e63276cca2901641ab39029e4fd3d621b1ee92.1779221799.git.me@berkoc.com> <20260519213450.50E611F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Score: -0.2 (/)
X-Authenticated-User: me@berkoc.com
X-Sender-Address: me@berkoc.com

sashiko-bot@kernel.org wrote:
> - [Critical] Using `bytes_recvd` for `memcpy()` without checking
>   `vmbus_recvpacket()` return value leads to a massive heap buffer
>   overflow.

This one is bounded on this channel. hyperv_connect_vsp() calls
vmbus_open() without setting max_pkt_size, so the inbound ring uses
VMBUS_DEFAULT_MAX_PKT_SIZE (4096) and hv_pkt_iter_first() clamps the
packet length to pkt_buffer_size. bytes_recvd therefore cannot exceed
4096, well under the 16 KiB recv_buf and init_buf, and
vmbus_recvpacket() does not return -ENOBUFS here, so the memcpy length
stays bounded.

I will still gate the dispatch on a successful vmbus_recvpacket()
return in the next revision, as defense in depth, so the bound is
local instead of relying on the ring clamp.

> - [High] Strict sizeof() validation incorrectly rejects
>   dynamically-sized SYNTHVID_RESOLUTION_RESPONSE packets.

Agreed. The response carries resolution_count entries, not the full
SYNTHVID_MAX_RESOLUTION_COUNT array, so checking against
sizeof(struct synthvid_supported_resolution_resp) is too strict. The
next revision validates the fixed prefix, reads and bounds
resolution_count, then requires only the count-sized array.

> - [High] Concurrent lockless write to `hv->init_buf` from VMBus
>   callback allows a malicious host to overwrite data while the guest
>   is validating it.
> - [High] Missing `reinit_completion()` before reusing the shared
>   `hv->wait` completion object.

Both pre-existing. On v2 Michael Kelley suggested splitting the
completion reinit into a separate patch on the resume path. The
init_buf reuse sits in the same area, so I plan to send the reinit and
the related response-type handling as a separate follow-up rather than
fold them into this size-validation change.

Thanks for the review.

Berkant

Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793823006;
	b=vs0P3A/+YfZA2KeI+DSmj9GSoyJOfBy6rPQ7tJybkgMarA3HpfSdo/0Kc2wsy+Th9Kx+
	 fv5mJLNdeL1G6zAWs60UzCCxIhu8Wf0gdR6vZ3YmHAiC7LNCH0E6Lcz0teZ9r0G8uskWw
	 OWg8u5BF0V9UbxiPPe4Ke9V+N0Ui6ytCh/ifv7wgx7StGvvXMqGQWKdmtjOAkPlfwtcXY
	 RDLKdOq30233MjBIEoQiF3153/XGiay7x4qXhZ+L2InwbS3zIFgIyOE+GeGkShye+b8RV
	 //tiz2zshrurf3hbgEyw/rK0oRu5kifzvlB+396t5b+DiKkNE01s/7fdruShF6b2QZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793823006;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=pbB/h7OcDLTENZAMlqrgPHDqleGuLS+XSh/+4bmYjVo=;
	b=W3zh5Qo2NNu1Flh61LTx5N7oyOD3VDIv1qLMllZpLKYcQL16FdGLghUqICRvIYRZsVEr
	 9ZNZV5ZEnRI49d+rjzlwd0dED3JxzKhdQ7/ljQHvcTLOjMCBB7ICp9+5GiwoynCPlFkVh
	 T2zIWD3C37+nczofkMhzlGeUsibUTvzCPq2jYeUfciGi/IRDzlCpOSZEl2766SdYj+KCC
	 UoO5Q4c8KN+tQ4xr1bEBB7pboAADO/BATvFFqn0GlLPogDiwqeZBoaDIpxCLPTozrF4+n
	 W6s3zmPKn8sWzuZV3JLmHO4D7342xc09SipsvL2+OySXo3YvpUmKddH7svZgmUvrrLg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pAmB6tB5;
	arc=none smtp.remote-ip=209.85.128.52
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 549F8607E709
	for <linux-hyperv@vger.kernel.org>; Wed,  4 Nov 2026 20:10:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 549F8607E709
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pAmB6tB5
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4a35d5d4a20so12224995e9.2
        for <linux-hyperv@vger.kernel.org>; Wed, 04 Nov 2026 12:10:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793823005; x=1794427805; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pbB/h7OcDLTENZAMlqrgPHDqleGuLS+XSh/+4bmYjVo=;
        b=pAmB6tB5L5Q0sXbpgw5MAvTI4uEVXOApuJPbfWOIyoio0S+Pk3ev+Xx+LtSaVDmZTb
         UtFs6xBq+HXY5ygUQ+qI7ayP+uN7rCJtM8Qo9UVtZesPJVPeKvFlcvws5jR2/iHFxv8Y
         veQ4oIX5N8YmBuVrhiXgkHYskpbffM0MwfPIRXC7NJyGDG5PAu/N2qWJVRrIBA6aDEf6
         liZndmGbC429jfE5e+Md/TpWVIyFUGja7Frb7Z1IKMKT4ruePVenI36Bw6OzDbXmKqlY
         AfTex7dzu322hFIm/ozi7mn3h55E6OP8ewbasszG/05oRQBr6/fSrgczdbozEEt+dWBj
         iLGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793823005; x=1794427805;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=pbB/h7OcDLTENZAMlqrgPHDqleGuLS+XSh/+4bmYjVo=;
        b=kVmtcoC/l1D7obVDadcwCwea9HzixwJPS0bcTodd/16g+oT2Q30ovaZyuWsPXmCPJ0
         1Bmlc6q/oCfbN1Ud0DzLfnYwZALusd3w68VKtONWR9gfylzOpQHsvj+EUOXNWqzXQ888
         w8TEaQGdP4FFR8hXSX7nE8vxayD2nVZxxTl3XqSLvWQMrl+vdiSKe/f38HwKxUthnBrP
         YOZtkJ3b31R/ymTLPoqAoy6kU/JOVzcsdgdkDKmKX09p9k87ekLAejnkI3YBNJ8IjJ46
         R6DqrMZhOwggaKPeB72ok+4y6x2C7KQ2DBRqJA1eYeWl9TW+mTIjCCgQMoeOMAdWtCCE
         +9Ow==
X-Forwarded-Encrypted: i=1; AKwUvByDZcwznLdcUTOXBCpJkEW6eKERhLU+83N6qjgELNuSDBsoSrq2lslEwLuGmqD9l9ws3PKmKzHnACBKUWs=@vger.kernel.org
X-Gm-Message-State: APuU4Z9xlJOzfcnSTl69qbvfJnmzCJv8kaSIk8uC8wnvfwHzxAufapzD
	2F0SWo6utQ/hL0H5rX0Ol6GkTheNthWZWLzmTpGS1VKr78bl1CRjwded
X-Gm-Gg: AYBFou2xPvJamtS609nDILQGSTSy5U/57LQjGDDsuldcuUTWWwk3EmkNLW3vEnS+cq5
	WGvwXl9BhKHfFE2+fKVs9V/DBfvLF4gXftaWPxtG7KMhGWJOLLQJSXFvsSROjKr5Yc8C7bi1rKY
	yOfaBkixch0HQh2TTNV8n7rmGza7K6bNGuV+YCsOPZQ44GXny6DHDxV7PGpKA7nR5drpRRSm7oE
	pGUC06XOaIAQ73e/tTekPybp+kkP7xGLLlluQnF7dK6KXG8jkk0cEl/7E1lkHlX1YjxqdU1spvR
	CBFJY/1uPCFvsYB23PxtSlJGZuFWBIYUxaS9dwvFnfl+Y+LgTJYEH26+ppkfxoIsSWZ1YPEeRHB
	/aAM3U/vYn2kwnvErJZgqKxxQ5jyE6dpW7WLOGwkqq160tVRXA13+0XXO3c0JJk3P7pWmaPtdRc
	uAELWC+3oJSXiTw8U/9N1NzKsNaXi2yRqix9WCfgEpduLTIjUgUH968iuCP+A+xPnkfuYNNXdLv
	SSYl/tGBfKWCGQkWEiatBOxyBr7nXQa3T8R5OfB13vjL8KuJELI99H01oXBqnbkkYmOpSF9gMA2
	FxPQNwi/1Ugcj/yIYQ5MwJPdMx2Fz/Mh+q9mz2iVrGuVKA5VaH6RoIv37t/ugag3Hyk9kVku2ZX
	BIbVIX5MPaJjzEHOp9ZanntohKLJ//q4uyBg4A6hIuHVs0Os=
X-Received: by 2002:a05:600c:6216:b0:4a3:5aea:21e5 with SMTP id 5b1f17b1804b1-4ac1737c533mr377961885e9.9.1793823004484;
        Wed, 04 Nov 2026 12:10:04 -0800 (PST)
Received: from center.jhjvjihww5qejoy14qwv1cc4td.frax.internal.cloudapp.net ([131.189.143.225])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b56eb4da1esm15954045e9.6.2026.11.04.12.10.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 12:10:03 -0800 (PST)
From: Orgad Shaneh <orgads@gmail.com>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wei Hu <weh@microsoft.com>,
	Konstantin Taranov <kotaranov@microsoft.com>,
	Simon Horman <horms@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Dipayaan Roy <dipayanroy@linux.microsoft.com>,
	Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>,
	Aditya Garg <gargaditya@linux.microsoft.com>,
	Erni Sri Satya Vennela <ernis@linux.microsoft.com>,
	Muhammad Falak R Wani <falakreyaz@gmail.com>,
	Jesse Brandeburg <jbrandeb@kernel.org>
Subject: Re: [PATCH net] net: mana: fix XDP_REDIRECT of pre-allocated RX buffers
Date: Wed,  4 Nov 2026 20:10:02 +0000
Message-ID: <20261104201002.2215474-1-orgads@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <autbwKmZPPWEj0Dq@boxer>
References: <20261102064324.806414-1-orgads@gmail.com> <autbwKmZPPWEj0Dq@boxer>
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Post: <mailto:linux-hyperv@vger.kernel.org>
List-Help: <mailto:linux-hyperv+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hyperv+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, Nov 04, 2026 at 05:22:24PM +0100, Maciej Fijalkowski wrote:
> On Mon, Nov 02, 2026 at 06:43:24AM +0000, Orgad Shaneh wrote:
[...]
> > -	act = mana_run_xdp(ndev, rxq, &xdp, buf_va, pkt_len);
> > +	act = mana_run_xdp(ndev, rxq, &xdp, buf_va, from_pool, pkt_len);
>
> I wonder if it wouldn't be better to work with rxoob objects which seem to
> carry the from_pool setting?

Thanks for the review.

The rxoob no longer describes this buffer when XDP runs.
mana_process_one_rx_pkt() calls mana_refill_rx_oob() before
mana_rx_skb(), and the refill puts the new buffer into the same rxoob:

	*old_buf = rxoob->buf_va;
	*old_fp = rxoob->from_pool;

	rxoob->buf_va = va;
	...
	rxoob->from_pool = from_pool;

So by the time mana_run_xdp() runs, rxoob->from_pool is the flag of the
replacement buffer. The flag of the received buffer survives only as
old_fp, which is what mana_rx_skb() already gets as its from_pool
argument and uses to free the buffer on PASS/TX/DROP. The patch passes
that same value one call further down, to mana_run_xdp().

The two can differ. Refills come from the page pool (or from
xdp_save_va, which only holds non-pool buffers), so on the first pass
over a ring of pre-allocated buffers XDP gets a buffer with
from_pool == false while its rxoob already says true. That first pass
is exactly where the bug shows.

Using the rxoob would mean moving the refill after XDP, which changes
what happens when a refill fails: today the packet is dropped and its
buffer stays in the ring. I preferred not to touch that in a fix.

If you would rather mana_run_xdp() take something other than a bool,
I can pass the xdp_rxq_info to use instead, chosen in mana_rx_skb().

Orgad

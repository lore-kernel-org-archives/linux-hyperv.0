Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EE7158124E;
	Wed,  9 Sep 2026 16:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788970094; cv=none; b=ZvbSMi+HqBxWdyuNCV4zj+rhWfIOFAaLpBcAxfEsEIYMfVdI1+oHHCRmcD7ljJNVlE5dUYHy5ekOFzmCVocJ7IW1szmOWFziMCzaRw5GcShF+D3ZUVUNcAB9e7w+wM1sZgAGlIa84+KOjz7JqJPAMFs8LnPqbOEeApS2V60+7e4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788970094; c=relaxed/simple;
	bh=qheTvuUD6icv5WzdI9gI1GKIhjR1ZjA0vPsnZH6KukM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AuUbsqPQfkIzXEwVlSdaBMGEXJYfsP/GmMhHbChlObbPetUPOuT2FmXw1/WvF4J1Pz5hOZURgy/5b5i3WPU0rnQWkvdGbOCRcVHXCJvjIyhmuEsIIa27eF9Mo/+OIpgEVHTa4GkmkVze8xheBU5fcr2M2sDMveya/jP7M5OZyDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B01PiU7B; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B01PiU7B"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 107771F00A3A;
	Wed,  9 Sep 2026 16:08:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788970092;
	bh=y43J6V5CnbKKUQhwSOC0RMYUS8d3xRV1ZMlsN19AqMQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=B01PiU7BKpTEH46oQ0dWb3GZCWUDMG9zj7ff+ito9KN6Yyi23KZFruzdSm/px1VXe
	 ZDKB89SDe+C/2Z/zE6uQ3kIjF+EUqJt7cz55jh3BXIpKtesPpDXrB8YMS8EaO1TyWx
	 h17ahQ7gDF/8I5sdBZZ19TS6j3JcmQ1MZ85vmWx6+2ppH0zDU2ylIWX/vp6mFrtyWY
	 ZxJ0ZWS53e4FopjV53TiukqMjAJoKe4noJmPa+PkM2foXCGbHcJK9eu2WYt2E5GJEG
	 Z5q9w1VzpsVEiZxKh/yFs/F72BYGQNLPX82FtmcYYD482Mnt8QFw1hxZoYO6EtqYSm
	 3C6DrremnAvsg==
From: Simon Horman <horms@kernel.org>
To: mhkelley58@gmail.com
Cc: Simon Horman <horms@kernel.org>,
	kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	longli@microsoft.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH v2 3/3] hv_netvsc: Leak send/recv buffers if GPADL teardown fails
Date: Wed,  9 Sep 2026 17:08:05 +0100
Message-ID: <20260909160805.698511-1-horms@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260907214902.9046-4-mhklinux@outlook.com>
References: <20260907214902.9046-4-mhklinux@outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://sashiko.dev/#/patchset/20260907214902.9046-2-mhklinux@outlook.com?part=3
---
hv_netvsc: Leak send/recv buffers if GPADL teardown fails

This commit addresses a bug where send/recv buffers were improperly freed if
GPADL teardown failed. It introduces calls to vmbus_leak_buffer() to safely
leak the buffers instead of freeing them when they might still be accessed by
the host.

Closes: https://lore.kernel.org/linux-hyperv/20260731201210.3653C1F00AC4@smtp.kernel.org/

> diff --git a/drivers/net/hyperv/netvsc.c b/drivers/net/hyperv/netvsc.c
> index 5cd084e5696cd..e9292c3fac925 100644
> --- a/drivers/net/hyperv/netvsc.c
> +++ b/drivers/net/hyperv/netvsc.c
> @@ -316,9 +316,11 @@ static void netvsc_teardown_recv_gpadl(struct hv_device *device,
>  		 * rather than continue and a bugchk
>  		 */
>  		if (ret != 0) {
> +			vmbus_leak_buffer(&net_device->recv_buf,
> +					  &net_device->recv_buf_chunks,
> +					  &net_device->recv_buf_chunk_cnt);

[Severity: High]
Could this lead to a NULL pointer dereference if NAPI is still polling
concurrently?

In netvsc_device_add(), NAPI is enabled and the VMBus channel is opened. If a
subsequent initialization step fails (like send_buf setup), the error path
calls netvsc_teardown_recv_gpadl().

If the GPADL teardown fails, vmbus_leak_buffer() will set
net_device->recv_buf to NULL. Because NAPI is not synchronized with this
teardown and is disabled later in the error path, a concurrent softirq could
execute this path in netvsc_receive():

    char *recv_buf = net_device->recv_buf;
    ...
    data = recv_buf + offset;
    ...
    ret = rndis_filter_receive(ndev, net_device, nvchan, data, buflen);

Since the code does not check for NULL, it passes the faulty data pointer
(NULL + offset) to rndis_filter_receive().

This would result in a kernel panic when trying to read from the pointer:

    memcpy(rndis_msg, data, RNDIS_HEADER_SIZE);

Is there a way to defer setting recv_buf to NULL until after NAPI has been
disabled?

>  			netdev_err(ndev,
>  				   "unable to teardown receive buffer's gpadl\n");
> -			return;
>  		}
>  	}
>  }

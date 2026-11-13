Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=170.10.133.124
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794577796;
	b=IUXgJqI/K+Ly2dJmMZJIZ7et44Xz017YBflV4gYSidfXuevVxGVCKCjEjAGIBlNyp3v7
	 BfcA5+eHu5Vw8IkhqCcXYgonJAq5d3XGjVu7wCq2TWEUYcFl9crAcfRsJEYgYL2UvEoNJ
	 CWuIk1JCCiCFB9Uuxn7GdeDhxqQa8OizDac92bEts1rN/+xciVAYXJmq8aEM6BlD5znML
	 d8M59PRVzOU8cwSF6XceaW4aknMM0vZEYaJ8dABnZMSqKWYkUFKCndy7197aCvY4AhQEZ
	 Ms43rHUcgztWBYsIhKVYnLtrBe4rR/gYkVTpRgkPNWaAD/DOSJTjFueSYaahOWN+gFQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794577796;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:In-Reply-To:References:MIME-Version:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type;
	bh=8e2MXnw38pYzH1XVs1yXJtejPbQN6bZltGajv/NaWc0=;
	b=WVHVBCJ1EPpZUT4iKdTwHz5we9hqTbLevnxmzmaAFGnCxwZ3SHvhNfTcLcJnr0DX4Sp1
	 xVVpWrpcIUoTh0O2FcGW5H6X/eC4TC2G45xkwghe4sUxNacr8zYaYuZ+NXX0+7fCgMjZQ
	 fvnOr8vfpYQbsBaY3li5I9JhJZYDCrNGwBZu3/ixakFA8WapU2KxB2oqZPBE+1hyAMhbS
	 gXfiXIcfGIacOLfdnN6q2qztY+MORV/3JFMs2xKzDT3VHPxGjiC2mb0W4kUIASr28+DRd
	 nQihC9WenMcCZVBJICUY66vf4wegxlFwq5Z85P+mB7e8GLjX9ngBOQfjxUA9fNKB8Kg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=dnr4bWaa;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=Ga5oluTv;
	arc=pass header.oldest-pass=0 smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00AA460A2635
	for <linux-hyperv@vger.kernel.org>; Fri, 13 Nov 2026 13:49:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 00AA460A2635
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=dnr4bWaa;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=Ga5oluTv
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794577795;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8e2MXnw38pYzH1XVs1yXJtejPbQN6bZltGajv/NaWc0=;
	b=dnr4bWaah9/wySNrHe71UxG7yxYO1hP4OJsDO4UuONplGfOBRiaQICVPWXH0a5xAfClVPc
	t+VpNg58eHK3YP5XWW59CAcUzV5E/GfH9p/c18EmHQRz6zpg7GqxOWWu1kW44oqkX5txvm
	zu2Lk64sIPPATltWgXHym6Mxatxh5HU=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-528-VX56JTloM7yVmi4Sdn6pLQ-1; Fri, 13 Nov 2026 08:49:53 -0500
X-MC-Unique: VX56JTloM7yVmi4Sdn6pLQ-1
X-Mimecast-MFC-AGG-ID: VX56JTloM7yVmi4Sdn6pLQ_1794577793
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-91eb0610cb9so12621086d6.3
        for <linux-hyperv@vger.kernel.org>; Fri, 13 Nov 2026 05:49:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794577793; cv=none;
        d=google.com; s=arc-20260327;
        b=aZGTBufMf/8OatSrnQSVfA5o04WrPOe1SkH0EOYuWG9PaxnzO0oA+D/8qa6Gi+wfV3
         apybu47HWKfuFjOw2XxwSbxQmel9L/tjx/o0fBzaTIduj8ZvN5DcW2rFF6P648mqTuns
         SuUEc7dya6lcfTTRClvg87q6k5fsdkMxWEVxLZjBC7ixXXuMTyz2dDRU+7De7bkE+11i
         AD8Pb/7vz/G23oogK/hGEWe5JU6lfO5UwC3f2CCWw898RUtK8c4bLvqKZEEb86D+VX2k
         6r4Wb5fMGtxGLckd966fgldR6mwZw7wC2534TUg6f+L6sEKu/+qqkHWjMrRsuaXkhgPT
         3eBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=8e2MXnw38pYzH1XVs1yXJtejPbQN6bZltGajv/NaWc0=;
        fh=Z5q/mlemRw0dGjga99KoXrD3cS6ukO7PUL1JxBVgkCM=;
        b=KAHof+BoVwgXEClUpYtM5eQKHp8CSukwp/V6kZTNOw067POgnurnCc07KwshBHu67O
         GNMkd41tuGzL3npy+MtxNYiQfTKP+U19aO7Ovv8bIK3Tgn3+OC0Hc9OL3CoRzCWjreWV
         Dy2Z2ZxGbjNF1+Yq4eqPdfy0ezSDcX/u0BIgsS4k15uBqBHvzC6Jyv/PPA3OYdfMTaUV
         Nc80HO4GqKwQCmTdWPm7V40MqkezD50MPYtFop/yqRyUVEQOx0dxvgJFoeHp65vmm1/l
         J+K95N7pANjAjT1zxZqBvSKQfz4vpbJDjm3G2kYL1cNhOuD80nHYZPV146+AsS6iJ5Zk
         WX9g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1794577793; x=1795182593; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8e2MXnw38pYzH1XVs1yXJtejPbQN6bZltGajv/NaWc0=;
        b=Ga5oluTv2VoCAk4tJJMwd4DcHxnzZN8P5RMMfsYuwHSiMT40x247pqXYZppw40aUfp
         AgXHj7O5P5EGzLh4fIFmrS2LDUH+QEQZYT3NfXESJ7+2AAzl/5iG4ssuum/lz5MnkbiY
         FEWaupRQi3hJm3DKU1Rj2ZQVesMwID+ZlD3yg4Dcq13ucBIA2y5CuZZ0qDg+hag5pCQ2
         rQ5GzjunzI61xrZyS6U/SOWzCL5dpAMnK6H42AAF/0so3HDc8I1e5CduBSEcu1Nj+iKT
         Na7YqNXXzrX2iDdPop6PnLFczlm8s6Y4c3Y6Takf75DT2e9wYXuz0ZE7I3UrxJfbFVUJ
         fD0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794577793; x=1795182593;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8e2MXnw38pYzH1XVs1yXJtejPbQN6bZltGajv/NaWc0=;
        b=BGBSe+/IWbWGTt27MgdDFWcYZoGqHRpIPvl6PtBkqvEqlZzEwq+9vJTHxu2aUm1kTg
         Gtyh9LUX2TXeR0Ls2ou3aRTerBwK8M/xzlSZ6seX2EEdBhRpB6+I6XE9C6G6LX2iBGcB
         W6Cpbx+Oyl6EL68cXQe5crpm4fBCr5oYARjZjJvK+dyirkcHfRQOgeB5zKeqCWNOoWwy
         TdIDULUoG9zkIRTMum59bu6CZHyTQZzO0J2UkMbJu8DiS22DQajlQyMCuVKuxtjheOC2
         aP13y0Cjvb7M5uUZE2GAfBvxfiHWJNT9av4AyzB/kxiIgUy5xEp3dPCp9qxEzXJBlDYe
         WtKA==
X-Forwarded-Encrypted: i=1; AL+hErEVQJICjiI7M5eT/7kNZek9v4YwTFjEhVQ9sQmHzlY7I2rJ8Cq+XJUUMpmplzn3+yOB5twEmKi/WLGgaK0=@vger.kernel.org
X-Gm-Message-State: APuU4Z+MwxSA0u+f/pDXJaqmvXGZTFq9+HahpNZtyhbzgJfawRayJK2/
	RjgkFKDm/jzxMsE7IzeIuJyS29wh9j7vvhTGiNrywdWTM5JYPDNhxdEiZg5AjMaLpullDSMt4e0
	Kj/A4MCpK07g/8T2Cue7DgfJ7Ii1raunjI+H02UXBjNvKwY0n/1ZwknoJMz8YRH9NNdORyA/YUn
	ji0ONNjBRDtE0hTYnxAC+ewy5TAnd2hIrLU6wk+cUh
X-Gm-Gg: AYBFou1SSwF81uDy4YSqIM+BbAArQD+XfPN3fVVcMQRHNCllDMZ24jmglzO5eAcA552
	P7G+3C/gXWm0NT3LGteYUXUyIY187CLuK0B7Y4v/gQYq6rirD/s3CI4ntvdh2qPVnqGJe2/fvYn
	fi7GlMcjgoMZdW7e1/V3HjcQShP1vk1izemZ+Q8Ah+6oPb7+HrBH2CIfM=
X-Received: by 2002:a05:6214:85cd:20b0:91e:89d8:a330 with SMTP id 6a1803df08f44-91f241f6d2bmr27649296d6.25.1794577793137;
        Fri, 13 Nov 2026 05:49:53 -0800 (PST)
X-Received: by 2002:a05:6214:85cd:20b0:91e:89d8:a330 with SMTP id
 6a1803df08f44-91f241f6d2bmr27648836d6.25.1794577792581; Fri, 13 Nov 2026
 05:49:52 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 13 Nov 2026 07:49:50 -0600
From: Sergio Lopez Pascual <slp@redhat.com>
In-Reply-To: <20261113080506-mutt-send-email-mst@kernel.org>
References: <20261113-vsock-dgram-support-v2-0-bacfc85b71ce@redhat.com> <20261113080506-mutt-send-email-mst@kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Post: <mailto:linux-hyperv@vger.kernel.org>
List-Help: <mailto:linux-hyperv+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hyperv+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Fri, 13 Nov 2026 07:49:50 -0600
X-Gm-Features: AclHuK9yYj2AE7jCL2Q7aluEqsTHouql9M7zvOo0Tu9GOsA54iFCZqauW8Q06G4
Message-ID: <CAAiTLFXvuHY=r8FPM7TFNTAO1oyco-brcc6YAc=YN432h87RSw@mail.gmail.com>
Subject: Re: [PATCH RFC v2 0/8] vsock: add datagram support to virtio and vhost
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>, Bobby Eshleman <bobbyeshleman@meta.com>, 
	Alexei Starovoitov <ast@kernel.org>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Bryan Tan <bryan-bt.tan@broadcom.com>, Vishnu Dasa <vishnu.dasa@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, Jason Wang <jasowangio@gmail.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Haiyang Zhang <haiyangz@microsoft.com>, 
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, bpf@vger.kernel.org, 
	linux-hyperv@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

"Michael S. Tsirkin" <mst@redhat.com> writes:

> On Fri, Nov 13, 2026 at 01:47:33PM +0100, Sergio Lopez wrote:
>> This RFC adds SOCK_DGRAM support to virtio-vsock and vhost-vsock through
>> the existing AF_VSOCK API. It is intended for guest and host services
>> that exchange independent requests, responses, or events and need message
>> boundaries and sender addresses without a stream connection or application
>> framing.
>>
>> VIRTIO_VSOCK_F_DGRAM gates virtio traffic in both directions. Each virtio
>> send carries zero to 64 KiB of payload in one VIRTIO_VSOCK_TYPE_DGRAM
>> packet. On the RX virtqueue, the device may split a datagram across
>> page-sized guest buffers.
>> START and EOM delimit the message; the guest reassembles at most 64
>> fragments and 64 KiB before delivering it to a socket.
>
> where do these limits come from? how does peer know not to send more?
>

The 64 KiB limit comes from VIRTIO_VSOCK_MAX_PKT_BUF_SIZE. The number of
fragments is a reasonable number to prevent the driver from putting too
much strain on the device.

Both limits should be part of the spec. This is the relevant part from
the draft I have put together so far:

+When VIRTIO_VSOCK_F_DGRAM is negotiated, each rx virtqueue buffer supplied
+by the driver MUST have room for the header and at least 1024 payload bytes.
+The driver MUST discard a received datagram packet whose \field{dst_cid}
+differs from the current \field{guest_cid} configuration value.
+The driver MUST reassemble consecutive fragments with matching address
+fields and MUST NOT deliver a partial datagram. It MUST discard an orphaned
+fragment, a fragment with an unsupported flag or operation, and any
+incomplete datagram interrupted by a new START or an unrelated packet. It
+MUST discard a datagram if its total length exceeds 65536 bytes or it has
+more than 64 fragments.

Thanks!
Sergio.


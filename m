Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795084110;
	b=UdgDiGgUi0VkIDm6SeyvCH01DFzlJMq7SKQhQpRx17uqyB4ClRp3kWje0wyiYApFUy9d
	 syV1oY0E3+kchxxo4naiA1whQzSumaCdMzZavY7iHysdODdK9XC662m3CqNi7oVa1MSuk
	 ZoVboKm1sehs8V0hOYbIHm2myUASz+mCGk8ZaPqnMX1gpyrCiu4wBt3QGdgxEEADiiaDN
	 JJvIK07Lvr0q2vxr4NYnHskYf/CKaNHXkQ56DhCnnGoGwVMHTJD0RjJ7zM1C8sDIyuD18
	 RkIiNCpxyjdiirD1IoyTDl52yscRdHAI6JQimtMLXUfZUmriDB5CXOXxz2rYJSA40/A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795084110;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:To:Cc:Subject:In-Reply-To:References:Date:
	 Message-ID:MIME-Version:Content-Type;
	bh=67HNtrDIxYfPbX2hk4h6A2Wbx5OSvimWbMoWJ2Xl9qo=;
	b=VJpeFe6YWEq/xpeOcuE9zPbCY8N/Q3Xt4gzV9zX9jNRgx4LlIN3tafJb8PqTVckTWAYn
	 VZUhk6YYBS95CLzN1fOsD5DM6bcalDpDed+Q6Q7QIGiTcITZRQyo+x/yJ8GDm9WKhxgC4
	 juUyvGetr9i63wv67By/Orl6vWvyjHkQRAkRTIn7VfUAVMHQV+zQGV8ucPCGWjqZf7Z14
	 EaV41AmtRzFZWiMlLzEeIRQjlM1SONOcbUyx/VA723C+QPTa6DGaJ1bBc+JUaNQsWhyvq
	 jxzD4tJ/MUpdE6AjDzKhRkzw3d9IgT6XIIqOopOoCDm3Ta0b5qrIp0lbxyGS8FqMjYA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ROluZ1kh;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=FibcjWiN;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6248606A32C
	for <linux-hyperv@vger.kernel.org>; Thu, 19 Nov 2026 10:28:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E6248606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ROluZ1kh;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=FibcjWiN
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795084109;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=67HNtrDIxYfPbX2hk4h6A2Wbx5OSvimWbMoWJ2Xl9qo=;
	b=ROluZ1khUy6Otmqt/e4vRs5SfN3q9zBbVV4ELrI7P8MNKJ86FMTdm9VhXQojY3Cnoix4Ip
	BEN8Rm5Y3o5WfLzZ+HpTykepbpH1bB6QTZsX+sF38VLqevLLDNon/3Rpjp2LrVh/BDWBbk
	qj7KtsuyAmdyQgua5rTyHyb6i9aRF2Y=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-600-vdxdPJLTNZy3VI0EveGs2g-1; Thu, 19 Nov 2026 05:28:27 -0500
X-MC-Unique: vdxdPJLTNZy3VI0EveGs2g-1
X-Mimecast-MFC-AGG-ID: vdxdPJLTNZy3VI0EveGs2g_1795084106
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-4a7c864000eso928265f8f.0
        for <linux-hyperv@vger.kernel.org>; Thu, 19 Nov 2026 02:28:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1795084106; x=1795688906; darn=vger.kernel.org;
        h=content-type:mime-version:message-id:date:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=67HNtrDIxYfPbX2hk4h6A2Wbx5OSvimWbMoWJ2Xl9qo=;
        b=FibcjWiN3HonGULrcDNFRW249x/7yokoU4798LEzwrfyG9WMlu10c2084uOuBVSk1t
         jQycAy3VZh/bsk56mayYCn6w4Bor0B0wHU/1zXf1qWh8dqf92KvmaQ4+OGkizHODvxCs
         MMayj8ouGDhrfiGiguwsNzysXiCB5jE8bEinYQIkKuS+yW0DITct9sFQpIT+cFA265S5
         Rk+odz3AIiOe8oWCNgJgkT9rfgLV9NlK6LGX90J5xNQaKJeriwWFO9q9yK+qQ0o7/DMR
         pTB4LjcQXeIqbJ0E0zJaLyqeS37FSfwaxNSbbSs2iUXgy3hM3LK6u8q689Ml8QkV0s+6
         QVng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795084106; x=1795688906;
        h=content-type:mime-version:message-id:date:references:in-reply-to
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=67HNtrDIxYfPbX2hk4h6A2Wbx5OSvimWbMoWJ2Xl9qo=;
        b=FTeCjsUYFhcCm1NkLNu0xZ30AJI2p0YbMMqg68rfT/nQc9cmog3TtRqOuBy3XAt95t
         vI+aAiWzUzJoj2sFCP4AfCkGLQYu4A2idZmsM7GjFzjbEHjyEUGWgluO3vG4e0T26YIY
         l9Pn6CbGE8gqcegK+Y/p5dyuNIf0Zkf8oRk9slIUDNn0OaZakCwIcxlvLAZQqvuxC8RN
         R29APME0MVjEm7+KA9ohHHRACdA/TlauPgXfSshL4sWjzcZ9GvCknB4o4zahdw/A5MCn
         UKP1gcAYec3tnrY1H1GCh18fq3J7HowDGbKn27V1QaB3Dl1USd3qUhca+XUz65jrNfds
         nRuw==
X-Forwarded-Encrypted: i=1; AL+hErHrg9NkQRbPHp008mrMBV7BFi1Yd9RQp1GGiVHXahaywB4KzBv4gGnFot3/F1XaPYOAQjULWKy8qThOEos=@vger.kernel.org
X-Gm-Message-State: APuU4Z+j2w2PjfHjiu9APjvXdKBBM/yg3Ggd6omA5IusYRY9dl+k58lw
	DS0Ui0Jm0fBf+pwm/hjugmHF3Yf7Oy6a6J+4GXSM9c2gfDztcqoZme935udHK2mfcNBwZxGO1Wq
	jpM9KDrou8rT9NteouSVRyYwj3hrRB9IwokdPlIFlneg7bS2ERqmzUc4PxpCdHsYA/Q==
X-Gm-Gg: AZFdTZfu2tO9/z7p2Oihn8oE/87J7I98J0JFZGd/Xa9yxVSJ/VZ9df42j76MM1y7JB2
	wABjcbM1UCCk0zLHuORj97gixJsEqGk97dPhIl+k+n9tMtCjE5u9bG4+ZTOjLS9NVVghRUq7Otf
	SnHLHtHI7LnynIY9AbQObDlairqWHi2S7zXoHTzYudKAKHZ2EGkO2huCCzWSdkXRo9gHX1vspl9
	HCqssUYTOr+k4IK/8i7l9WZHDfkYo+TyAVOGhevReZV25EgHlRB4uJrOgLxL/XT47S4EuE+EH6q
	rLLBwSktvOvsfCMIb0/EgbEpyW4XIP9mvfXpLW9hc3sqpxLGkvE2M2Q+JN6uVp3OfDv0kNyJA9N
	fJNBCTH2WbPVnG3rOlVlhU5gNnlPCTdqXCH7j8R1Qo5/e54YtdCYWGBu/oGcDzu8AIIST1g57I5
	ypaQc6kEgaaLxTTVg=
X-Received: by 2002:a05:6000:29c8:b0:49c:192f:cf20 with SMTP id ffacd0b85a97d-4a633a652femr8004625f8f.6.1795084105864;
        Thu, 19 Nov 2026 02:28:25 -0800 (PST)
X-Received: by 2002:a05:6000:29c8:b0:49c:192f:cf20 with SMTP id ffacd0b85a97d-4a633a652femr8004599f8f.6.1795084105479;
        Thu, 19 Nov 2026 02:28:25 -0800 (PST)
Received: from vkuznets-thinkpadx1carbongen12.rmtcz.csb (g3.ign.cz. [91.219.240.17])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4a65609391bsm9979145f8f.36.2026.11.19.02.28.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 02:28:25 -0800 (PST)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: Michael Kelley <mhklinux@outlook.com>, Mukesh R
 <mrathor@linux.microsoft.com>, Michael Kelley <mhklinux@outlook.com>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: "haiyangz@microsoft.com" <haiyangz@microsoft.com>, "wei.liu@kernel.org"
 <wei.liu@kernel.org>, "decui@microsoft.com" <decui@microsoft.com>,
 "kameroncarr@linux.microsoft.com" <kameroncarr@linux.microsoft.com>
Subject: RE: [PATCH V1 2/2] Drivers: hv: Fix bugs and issues around repeat
 hypercall
In-Reply-To: <MN2PR02MB6863A95F4A2E10D73BDBFE97D47A2@MN2PR02MB6863.namprd02.prod.outlook.com>
References: <20261114025313.1257042-1-mrathor@linux.microsoft.com>
 <20261114025313.1257042-3-mrathor@linux.microsoft.com>
 <MN2PR02MB6863E6C4F59864B7833681FCD47D2@MN2PR02MB6863.namprd02.prod.outlook.com>
 <fd130973-25d6-e706-6822-793f12ba2015@linux.microsoft.com>
 <MN2PR02MB68639EE1AC00187FDA3D5A42D47B2@MN2PR02MB6863.namprd02.prod.outlook.com>
 <bb569c87-1a60-c498-98e4-db519e4d7d24@linux.microsoft.com>
 <kupwlqagrw7.fsf@vkuznets-thinkpadx1carbongen12.rmtcz.csb>
 <MN2PR02MB6863A95F4A2E10D73BDBFE97D47A2@MN2PR02MB6863.namprd02.prod.outlook.com>
Date: Thu, 19 Nov 2026 11:28:24 +0100
Message-ID: <kupqzghglo7.fsf@vkuznets-thinkpadx1carbongen12.rmtcz.csb>
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Post: <mailto:linux-hyperv@vger.kernel.org>
List-Help: <mailto:linux-hyperv+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hyperv+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

Michael Kelley <mhklinux@outlook.com> writes:

> From: Vitaly Kuznetsov <vkuznets@redhat.com> Sent: Wednesday, November 18, 2026 6:02 AM
>> 
>> Mukesh R <mrathor@linux.microsoft.com> writes:
>> 
>> > On 11/17/26 09:41, Michael Kelley wrote:
>> 
>> ...
>> 
>> > Confirming, that it is same behavior all the way back to 2016.
>> >
>> >> Sounds good. FWIW, old TLFS version 2.0A, which is specifically
>> >> titled to cover Windows Server 2008 R2, has the paragraph
>> >> about hypercall continuation. So that functionality was evidently
>> >> present very early on. It is still curious that Vitaly found it
>> >> necessary to include the looping behavior in the Linux guest
>> >> code.
>> >
>> > Maybe Vitaly was running into a genuine bug, not sure.
>> >
>> 
>> I'm not sure either :-(
>> 
>> WS2012 was definitely around back then, not sure about 2008. It may also
>> make sense to add at least a debug print in case we find ourselves
>> running on something that old. AFAICS, even the TLFS version 2.0A
>> mentions PV TLB flush hypercalls. If looping is still required for these
>> old versions, we may introduce some very hard-to-find bugs if we drop
>> it.
>> 
>
> Vitaly -- I'll point out that support for running Linux guests
> on any Hyper-V older than WS2016/Win10 has been removed
> from the upstream code tree as of 7.4. 

Missed that, thanks for pointing out!

> The removal is
> impactful enough that 7.4 and later kernels won't boot in a
> guest on these older Hyper-V versions. Hopefully whatever bug
> you encountered is no longer present in WS2016 and later. But
> even if the looping is removed, the code could still check and
> warn on a hypercall completion with no error but not all reps
> completed. Then at least we'd know there is a problem.

Yes, WARN[_ON_ONCE]() should be sufficient.

-- 
Vitaly


Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBC963CAE99
	for <linux-hyperv@vger.kernel.org>; Wed,  8 Jul 2026 10:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783508236; cv=none; b=F52Ni0LZEB3hS6WPm/a5IdVAPMTqnYjgCg64/OIFsgT3PBlDFiGcQfFQ9xOb+Uwf+nrUUnKw/mBF79ZPShVjhOGKhp6ln3hrt4w5r2kvtxze7ADQ8kn5Uy049ALIJUwD1j05Ab7pI8KagoOYVQYKVW2t4gp0BWHOjcqtExsCQAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783508236; c=relaxed/simple;
	bh=M4cKxG7rn03qGW5kSZE88jYrpIP4zvhW58ZIabmPFvY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TYVHGXkNW45DourO5THGIsD2b3ff5maFiBSq2c/J1Qp8pXsTh4E4gI1PPLZm56NDTtDVWJnrxVvEnCAqUhATTw1J94dqcUOWkw8Xm71mckTp07gNDMzr32VLSIvQ/hffmoGZnQrntSIHmI9hfa5ydbQzPm7GHN8/ceURwCdSJOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=If6KMCXS; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ULFPsLx4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="If6KMCXS";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ULFPsLx4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783508232;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nRaQ/pUZXsFDjpZJaNCEg3QzvRcLSiDykic5pLM08Kc=;
	b=If6KMCXSG5buN4Guf+oe/g39ZjYAU8MTW/CvhUgoYYRa6mXXsxhSX+TlvnmOEnooHmd+mZ
	sl3ZASbvjbaF7MVN+eC26AlO36NE4xhqjMahqtyyIIgKw0gaB5Ah88kErR1jvVangmV8nT
	JyRFCEKh4GUpPCVZioikc0oSBw9pUWI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-117-uh9-m5zCM_-vPfGgRgGDCg-1; Wed, 08 Jul 2026 06:57:09 -0400
X-MC-Unique: uh9-m5zCM_-vPfGgRgGDCg-1
X-Mimecast-MFC-AGG-ID: uh9-m5zCM_-vPfGgRgGDCg_1783508229
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-493bdaf8549so5343495e9.2
        for <linux-hyperv@vger.kernel.org>; Wed, 08 Jul 2026 03:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1783508229; x=1784113029; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=nRaQ/pUZXsFDjpZJaNCEg3QzvRcLSiDykic5pLM08Kc=;
        b=ULFPsLx4MgS1nJYCzF9Up8vFmpTt1ubHVVRRucP4mZdO5ifPjHoUzRwX/dFpDHe2xq
         uSUdoykZk1UBaWMTsJHutUK+dN6DGvOti41yRtYL+/6wF7qHiM/WP9hBRr57iKq/p1I9
         EFZNvqY69L2rNObMq23cHE5zmxS0CUpJzETi3XANJ2T5BSy2zs/wx5+UYJqLi8nbyZ4/
         ejZu6dWdkBP+h2KjkPFQBGkw5pUndMCz9tAP1X4zZjNBrxmL49wZraNTSsgleKBKVXlv
         UkuYuYDY58t7Xob2CP5eSfOEY6ZUM5vAj5ClvxCYq+/3Zb5uMmFBxpFwo3WWV+zu+M1Q
         HRDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783508229; x=1784113029;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nRaQ/pUZXsFDjpZJaNCEg3QzvRcLSiDykic5pLM08Kc=;
        b=aOThUqHIV6hOVuzrBOQZQ6JzhLOm8kVrVHkyQAcUkgwYSIulyj22y985YVoX4xSZPt
         pjvspxi0QwjX4L41B50n2uGD0aqL1gGBCou0j7m4fVKVIYyzU9F8b7WQ/d3IY/iDcEZb
         4/tAGnATNhJnX72LhJH66NDhf5O3gmYJQASRYJj57M5mZ307s3YdSSgvHIpkc+eAH7of
         ARth7nIxOdovb+faiqn0rB8jjvKksLrRjSt7Cxsl46Tqf89xPI2j90K4Kwq5KHe3mTRF
         gLlsgVZOtxNJJOMsRhLXEnMXJv7Ktv6eqpl4sVvpqsfHRGeObDfK0hA/Y/btKTrfo89U
         PYHg==
X-Forwarded-Encrypted: i=1; AHgh+Rpxbb+JI9P/ypPrKf11gThJehifj213BWTG60DSfkL2qRuaQVB9ZSwwWQgrEOBulg1e6IiM0X2YbUemW18=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVo3P9qZg8I88WUzKl/l7/LXt7cpFFh5G/P6UVY6iuhxgK0IRM
	gD5/SPfrATJo9dl8WnrGKcDUe1ocHExoOpBr+zSYfIdJq6jQf8TRxv4QrAKhExPy6yvyY66L03L
	BtdsABd6q7kR8TwGytk1OdliWh9fAB8GDkC/xpyvYDpc66Yb0THiZwLgCaCAC9grYIHVCHGQJUA
	==
X-Gm-Gg: AfdE7cnNnughe7EH0ZPnKwgd2lutlCKhuXL/xPPQo82ShwK2n+wkBG0wo3hL5QIlGFH
	JphhllaRmFVO5+IrbI8CwmeG+oH91BLEt52koxKdAYM+AvU5cyvaMznexJ6xu61kOTXglnUwmPd
	zSwi3EsXF31S4Oc446IrOAQREc1jp16VyS9AAw14ptqrPmXinoDRjQS8LC55jSawAZJleC3olkY
	9nnmElxyOND/in5uFnAlItTALETH3UUvYRHwBO+2pYxevskQjy+dCXYTPKBqK06j7qcshDf1a5P
	TMzpqTqF9Bjnnry1hAyiz76h4Aj0fxdlWywUn22No0VXNc3yFV6og5UYSEPmZ1MN4TEs8bmr7WN
	NVTUjhpbp+I0yDPFQXwect3lxo89JerA7C5k8wxCPLvYeB1SMNvjD/cK7LhH0vVGZC3Rd9F0VSc
	BtTF3N+0+39W6G
X-Received: by 2002:a05:600c:34c3:b0:493:e79e:daa6 with SMTP id 5b1f17b1804b1-493e79edba5mr17133735e9.33.1783508228687;
        Wed, 08 Jul 2026 03:57:08 -0700 (PDT)
X-Received: by 2002:a05:600c:34c3:b0:493:e79e:daa6 with SMTP id 5b1f17b1804b1-493e79edba5mr17133315e9.33.1783508228188;
        Wed, 08 Jul 2026 03:57:08 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:5521:6b10:58fd:68f:7756:389d? ([2a0d:3344:5521:6b10:58fd:68f:7756:389d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493e0f5b811sm211634515e9.13.2026.07.08.03.57.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jul 2026 03:57:07 -0700 (PDT)
Message-ID: <d359508d-76a8-4df8-87ef-2767fe7fb40d@redhat.com>
Date: Wed, 8 Jul 2026 12:57:05 +0200
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3 1/2] net: mana: Validate the packet length reported
 by the NIC
To: Dexuan Cui <decui@microsoft.com>, kys@microsoft.com,
 haiyangz@microsoft.com, wei.liu@kernel.org, longli@microsoft.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, kotaranov@microsoft.com, horms@kernel.org,
 ernis@linux.microsoft.com, dipayanroy@linux.microsoft.com, kees@kernel.org,
 jacob.e.keller@intel.com, ssengar@linux.microsoft.com,
 linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org
Cc: stable@vger.kernel.org
References: <20260702041237.617719-1-decui@microsoft.com>
 <20260702041237.617719-2-decui@microsoft.com>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260702041237.617719-2-decui@microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/2/26 6:12 AM, Dexuan Cui wrote:
> Validate the packet length reported in the RX CQE before passing it
> to skb processing. The CQE is supplied by the NIC device and should
> not be blindly trusted.
> 
> Cc: stable@vger.kernel.org

This need a Fixes: tag, to help stable team backport.

No need to repost: just reply here, and I'll add it while applying the
patch.

Thanks,

Paolo


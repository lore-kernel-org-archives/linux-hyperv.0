Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A91DA3F1AB8
	for <linux-hyperv@vger.kernel.org>; Tue, 25 Aug 2026 10:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787652201; cv=none; b=lDJGAMhefqhMkykjeL57TKm7ox7eigtil0RnvNoMY5vJK//9s6sHu+/W5MSCGTSJBnvcniNWioBxyDcKLTt8SZZxRBE5zM6acFqeWRprnQtlu959qfC+I+s5+Y4HCPAZ+QSeFJ1IwQXq7pJE8Qy+1/spYtFZRTuznBC0byf8SkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787652201; c=relaxed/simple;
	bh=uhN4fxJ15enqo3k8CkDLZlRghvRaPv3HpnOP6VDNWkc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AQlblRmNgGJfrPKZV26HMzNYH9qaRpWJYBaEIdIkFsCzreZtq5Q28qqRNrcctJfZ6g+ksm3SB+/cHMkx3aGXFyQ3gywaFPcyDQuoKBMb7j2/q3cXjYbj8sDXy2l8DQFu/9EVxrKJ74urRpiAOLRpTzBw4TuJj5Segk5BSrI++w0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JPkb/I3Z; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=FL0L4TEw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JPkb/I3Z";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="FL0L4TEw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787652198;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NUhW54Gf8EXfhXYKN6isHtSeMLz3jtca0/EX8wxX+Ac=;
	b=JPkb/I3Z3elXoDr9ZQRAplXoQfbV3dRgq6vZ+ZY/bIaZJbXer8Fb5JWyaY+0DjLofahUbW
	iBh3+fTsecz9QinrIOtrvlgQtdEnhhMZYOQ2Uch+d9U2iftO/IlF8OSOwBOS3LBOiIyOPt
	QM6h1XEMbGF2JvhsiRoIaPIGqnI2s50=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-462-Kam0ttsZMP6TeXB4muYU8w-1; Tue, 25 Aug 2026 06:03:17 -0400
X-MC-Unique: Kam0ttsZMP6TeXB4muYU8w-1
X-Mimecast-MFC-AGG-ID: Kam0ttsZMP6TeXB4muYU8w_1787652196
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-c15e6109f9aso404510966b.2
        for <linux-hyperv@vger.kernel.org>; Tue, 25 Aug 2026 03:03:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1787652196; x=1788256996; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=NUhW54Gf8EXfhXYKN6isHtSeMLz3jtca0/EX8wxX+Ac=;
        b=FL0L4TEwZPqy4XIQGN+cT+RT6R1kvMehXCRUH+tSyz0+a+iJHy6HGK7Bl+0aemusqQ
         U+HXqyuQ961m79bJu4KxkODXKz3Qu6FVQWU3H7zeuMyjBW5vYoCBjgXkazHiL2eP/ZNB
         zhVn7+PA0q4aqrQ6wskhgzGRsFXUA1Ds2jPR8MU+AJ4q+b+iTHw7Tz0Ly7Wq2Zixhf/s
         2yrsztm/IBKuGydIMie/mWwta0YhyLMh+l+qrd7PRKuUKDuoPe7+LIlzvXnVLyD+VGaF
         SUb7OjfyTBInEgYChYh4a0ORvBFFniX5K0p48+fj9JDyY/08TOKSpngw7ir7pWRM4RBC
         xMSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787652196; x=1788256996;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NUhW54Gf8EXfhXYKN6isHtSeMLz3jtca0/EX8wxX+Ac=;
        b=fm+8WxxsdbYxDcSrQVyPbT9gUgTkMud9Kjn8VVEvx3lb+2bxTbj1lvTkqzadAahouc
         wJp/fWE7B597Fk2mWeM9y5dr2jYb5hQhRGybSXBQbw0R33EVctmO0XyLkgsSCtEy0kEB
         Iu8F+xGDvqslz/M7tfT1JIEs2f9vnvpkpwwtaaEEUXhbqKLmcPBzqzRIOSmTBdYGsmWJ
         nc7Nsn3T0ufmjqLYcZFUz9XRw7hsQ9ImtQZK7FOLR98u8oiSKoZ/pzfV6n/H7GptuJWN
         x0jiMAVVnSdNLSrnU/lQVoF7JwXJEgXllBRggDelpaPdx3XfwlJd1UKB4HVCjSfxyyTI
         3gxg==
X-Forwarded-Encrypted: i=1; AHgh+RqXfwk3GO/xAmHsGbjmpIwfwo1leyED1+lro1hjA5EQkSeOBleefsugF945pSHoj/ZX/tW8C5vpm5wjK68=@vger.kernel.org
X-Gm-Message-State: AFuF++mzoLxzrzzG27qSgYmMyzj9kgN8Yg+7C3fh10oBLO3L/rsJf2wv
	0C/f7M3aVcTSf02J0hAMacYXVT5AqkG1e3gp7tNdGt6KADqrKiJ23wOFB9iA6Gwg/Qch1uxR8E3
	bEfenONDRGdzQpUtsuLQefB56R23p71WrS7/7HF6HifTZSluM2y+zfZFTd5dxP21Utw==
X-Gm-Gg: AR+sD12KRla6HlKQn4jMIEnU6zD+Er3A09PKsl3o/0nQOSDoe7BHwyw6OZnPcEkQoa/
	fKebNh29zu1ENRvOr0GpQ41WgsQjykXQKdXxOFNyBydXSYaz7Cx8avUEBfzx5c+TTIQCJ/FkuVF
	NMM8TMyvW/ERDukqaLKpyNCmzeYkuMmCeJR2lf7MqhdwI/Q1tZmBaWONhxlrb7u7ombEj9Gd2zL
	NZbgeBFRIruO5OM0Il6QDOgoN89LWRpv3E29aTZbM1Eof9b+4zIqgoLoHB0zzKSeACcZNJEik7W
	VDULRhCzfMZBcEWu/ArHzVBu+lkEBxCtHpvv/SzJHsok0moElGvx9HuGhWx2i9mOz0WpoduVEjM
	Gsh3PwxZRSoOJFQh2XoeE4uSif40wwbeKhEL5kVPlTXfh32/8v7mgz5XMPPLbvb5HvriYgwiv
X-Received: by 2002:a17:907:a089:b0:c21:450d:cd88 with SMTP id a640c23a62f3a-c24924b8000mr2757838466b.6.1787652195914;
        Tue, 25 Aug 2026 03:03:15 -0700 (PDT)
X-Received: by 2002:a17:907:a089:b0:c21:450d:cd88 with SMTP id a640c23a62f3a-c24924b8000mr2757831066b.6.1787652195293;
        Tue, 25 Aug 2026 03:03:15 -0700 (PDT)
Received: from [192.168.188.103] (ip46-47-231-195.pool-bba.aruba.it. [195.231.47.46])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c249606b683sm1843812966b.5.2026.08.25.03.03.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Aug 2026 03:03:13 -0700 (PDT)
Message-ID: <478bf88c-cb76-416d-831a-5fa7856d65ce@redhat.com>
Date: Tue, 25 Aug 2026 12:03:12 +0200
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: mana: remove unreachable dead code in
 mana_bpf()
To: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>,
 Muhammad Falak R Wani <falakreyaz@gmail.com>
Cc: "K. Y. Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, linux-hyperv@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org
References: <DKWZHHOFA1F3.1EL2DMFNGMP0Y@gmail.com>
 <aoxThygUBWq0WqfS@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <aoxThygUBWq0WqfS@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/24/26 4:21 PM, Hamza Mahfooz wrote:
> On Mon, Aug 24, 2026 at 12:39:06PM +0530, Muhammad Falak R Wani wrote:
>> mana_bpf() declares an uninitialized 'ret' and falls through to a
>> trailing 'return ret;' after a switch statement whose every case
>> (XDP_SETUP_PROG and default) already returns unconditionally. This
>> statement is therefore unreachable dead code left over from an
>> earlier refactor, and it would return an uninitialized value if it
>> were ever reached.
>>
>> Drop the unused variable and the unreachable return.
>>
>> Signed-off-by: Muhammad Falak R Wani <falakreyaz@gmail.com>
> 
> Fixes: ed5356b53f07 ("net: mana: Add XDP support")
> Reviewed-by: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
Please note that the current guidance is no fixes tag for net-next changes.

Also this specific change does not address any real issue, it's just
code cleanup.

/P


Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795010511;
	b=qR8w95/z/spRpOcK8j062rBeSE4K0gKNS6HzvVduAmKchHRvM2qcF2I8fUxa/QAF3VvW
	 LYS9y2QnaiDdYEnf7LxdLZIGA9b3P/VvbKp49xcv523oBtCkjxW2PPItwvUEkrrpYbRr+
	 tNPVC/qI5DGI0Jvc//Pq4D1SaqVdvaxfeS6KRcs1c3Vrg4UeJ05VwvCKFvsYxKElfCNCK
	 etR5A8EuWo8lZdHQH4+7CSLC5SQKXpSexesfBges9rreZ5xmfL5pLnGbdjscIDkVgQRFu
	 /m/qNEp+Vfq6+C5p+URKfdvY31qdBNFHfxOyOKma8YttdKf2+vcSU+F/NLmi9hQln2Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795010511;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:To:Cc:Subject:In-Reply-To:References:Date:
	 Message-ID:MIME-Version:Content-Type;
	bh=PkSCWwmCdxKWhi5Q6TGdM63nZPvXC/gAB0JhnmD8Sl4=;
	b=HW72qrUn0pMmULuc82w5kwO7bPwlcejC9a+QVbUwRDCeRmmWY3X6ZEX65/G/JApVV4FT
	 FQX+3jj/tk297Wo85XqhGkHrCcqtkaJ9sKhi6p/N4MSov3Y8EV9FUxdJDmp8S+3e1hyOU
	 bF31h3vrvDaXC3NH9yvZifit2KP7MWepLUvh98N126Xq98Bdal4vk7p2LC7RHCFtLIhg3
	 UyWn1H6TFAim5vG6x7/ObrnBaB64kL2nhtqg43CaFXCD31uvNK4/GsqQ+B/flecEAa9p8
	 bphawiDrpvUbJE57/wei7ZCToeNwB/nfCK2+LKzAmlrAY6m3puCo3kzPsXpTLQLawXA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b="NIO/KqI8";
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=L+RQQmI+;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 751A3606A31C
	for <linux-hyperv@vger.kernel.org>; Wed, 18 Nov 2026 14:01:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 751A3606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=NIO/KqI8;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=L+RQQmI+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795010509;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PkSCWwmCdxKWhi5Q6TGdM63nZPvXC/gAB0JhnmD8Sl4=;
	b=NIO/KqI8Sq45lKsPVSNfd0ONoWrs8B/2vNxhk6qjz419tbKUvrgYYSVQ0y30Wk3BVP2Zu/
	t0atBPNGcjn4tPdpj7APfB/eredM+0zK2b6+4VyL1LCy9FXGA/YASgnHdXBKGaLcCZK0VY
	WWKW1FZb3hN1RzkBEaYvJ8nVzu+ygeY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-664-2bX-X0DHPyCcGU7UrD3UbA-1; Wed, 18 Nov 2026 09:01:48 -0500
X-MC-Unique: 2bX-X0DHPyCcGU7UrD3UbA-1
X-Mimecast-MFC-AGG-ID: 2bX-X0DHPyCcGU7UrD3UbA_1795010507
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4bb6bbc025aso8527995e9.3
        for <linux-hyperv@vger.kernel.org>; Wed, 18 Nov 2026 06:01:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1795010507; x=1795615307; darn=vger.kernel.org;
        h=content-type:mime-version:message-id:date:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PkSCWwmCdxKWhi5Q6TGdM63nZPvXC/gAB0JhnmD8Sl4=;
        b=L+RQQmI+X1Xcnt5ovpb0pxxf+zIUkB7fwH0bbxyFYcSNaVNQVG/jM6f1C/VFHP21Xb
         HPsQ2r/nesMG2B7knbWwlfUUeBDE4Ur8+iq1KbNTPfrGw2ZZg1Sx0loxAbp8Udg0lPBa
         vudfv3uc8RQ5zTAGA5gOwSmroOVk+lkNKVumHzoVOdGodjh3CKIL7dhpzhU8no6pwqYQ
         dXgUuVKv0K51oxKMfl45OnmUx0ejOqnQNdGf52mlEPkDbXofqgstUtKjfUJ9HpDr2HSc
         fym3HdcXwY0cnxiTGNO47FeZkQjlvSUzc0xTXbFXLH6IraTsvLycBkXa8DxCEGrqG4t9
         P73w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795010507; x=1795615307;
        h=content-type:mime-version:message-id:date:references:in-reply-to
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=PkSCWwmCdxKWhi5Q6TGdM63nZPvXC/gAB0JhnmD8Sl4=;
        b=B91nd1/jnVlMHY+ckNbOFyKuL3z0BqAFy7lBay9PDJXDX+JW9zsnTewMjyb7boGYz9
         kr6DiCMPDnsNQwB6c548KAZibJy+bUbRWS6jXf063gbaZwlxZr9ILlft8HXt5joIIF8g
         k64+SDi8XBVP3ohnGj1O8ztFwp/ZP9ZFHhIR6JD1Yz9Eo0YLGllk2pY6yvJYQHHvjkLy
         T8vnjvpSea8xk/rAOzEY9DWEv3cqET7ttMfIEaiS+wXYv4Ci0bDH5ALNiSx7VhplEzRG
         esI4K5pZreUBppuCkSa7K2ZF163T8S386oktEYZgaCHqKb8OYjaseWw1bTG56l6IIBnk
         Ofpg==
X-Forwarded-Encrypted: i=1; AL+hErHc1HSRSb/67de+lGiW87MKs/YjRRn7lyHboDen8KpwJKV8ve81UCAzcY3KglNsy6ekAPObYgnoQM+uqHo=@vger.kernel.org
X-Gm-Message-State: APuU4Z+w+FTQsb/mwtvRS9OuPOlN6B10NBfG0IGdWsEZNr2rYoCtlc3C
	rnO+LzoZ6Zn0LRZCF2ZldtN1vOQrJm/vayxbMdsZuE2KhfyfvGuR7HeLCuxlo3v72HiBKSj/5T/
	ALDrp0V3XE7veUETmKIzhbzRG+7Xfe0x6+/T60p4HBLWrhGw8MemnrXepAc2Sn8oD7w==
X-Gm-Gg: AYBFou30vZMFJESCTaevjgs6sgPZA8/B/aTvjqYLiEGcgNAyCqL1B1FaWkzu3i/oraS
	p62liSkRJ1yQCWv9OILdUxdnWO/hufBkS3xpcYuHveOTb2G9QeNTYv07IIlKwZIRgwoDtOXtBJj
	PTybp6RF3Edkgs9lBUk8SZnAzKJZyQurKZUc5Aca80GuiLQ9ZLrKsSZojXNCnPVv4aYeUVM8r7t
	D/TpQdV+7wU5rO0rE+3/OXC20LVGXlzMh8WN/axOUdAdXpRoYCHYxUjBRDWqf1w9IHcSz3c96yv
	oKbnASHokppIDo43vMWmDYucDdo+Nk9+g2q9Yp19E0u7JSOHEjRmdeaTbQAH96qL4pRGOipctOT
	bu9v03XGWOtnWdp7iU08cUWP/ZUk00cfFVAmEMcTM16BGkaxmO0s+2c1vrCi+rBkjirDyPzs+M+
	5RMjM/PPyYlJxf2SM=
X-Received: by 2002:a05:600c:6746:b0:4a2:729:f7ce with SMTP id 5b1f17b1804b1-4bb7da12d14mr51401075e9.8.1795010506650;
        Wed, 18 Nov 2026 06:01:46 -0800 (PST)
X-Received: by 2002:a05:600c:6746:b0:4a2:729:f7ce with SMTP id 5b1f17b1804b1-4bb7da12d14mr51400805e9.8.1795010506261;
        Wed, 18 Nov 2026 06:01:46 -0800 (PST)
Received: from vkuznets-thinkpadx1carbongen12.rmtcz.csb (g3.ign.cz. [91.219.240.17])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb7d29c614sm68878365e9.4.2026.11.18.06.01.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 06:01:45 -0800 (PST)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: Mukesh R <mrathor@linux.microsoft.com>, Michael Kelley
 <mhklinux@outlook.com>, "linux-hyperv@vger.kernel.org"
 <linux-hyperv@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Cc: "haiyangz@microsoft.com" <haiyangz@microsoft.com>, "wei.liu@kernel.org"
 <wei.liu@kernel.org>, "decui@microsoft.com" <decui@microsoft.com>,
 "kameroncarr@linux.microsoft.com" <kameroncarr@linux.microsoft.com>
Subject: Re: [PATCH V1 2/2] Drivers: hv: Fix bugs and issues around repeat
 hypercall
In-Reply-To: <bb569c87-1a60-c498-98e4-db519e4d7d24@linux.microsoft.com>
References: <20261114025313.1257042-1-mrathor@linux.microsoft.com>
 <20261114025313.1257042-3-mrathor@linux.microsoft.com>
 <MN2PR02MB6863E6C4F59864B7833681FCD47D2@MN2PR02MB6863.namprd02.prod.outlook.com>
 <fd130973-25d6-e706-6822-793f12ba2015@linux.microsoft.com>
 <MN2PR02MB68639EE1AC00187FDA3D5A42D47B2@MN2PR02MB6863.namprd02.prod.outlook.com>
 <bb569c87-1a60-c498-98e4-db519e4d7d24@linux.microsoft.com>
Date: Wed, 18 Nov 2026 15:01:44 +0100
Message-ID: <kupwlqagrw7.fsf@vkuznets-thinkpadx1carbongen12.rmtcz.csb>
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

Mukesh R <mrathor@linux.microsoft.com> writes:

> On 11/17/26 09:41, Michael Kelley wrote:

...

>
> Confirming, that it is same behavior all the way back to 2016.
>
>> Sounds good. FWIW, old TLFS version 2.0A, which is specifically
>> titled to cover Windows Server 2008 R2, has the paragraph
>> about hypercall continuation. So that functionality was evidently
>> present very early on. It is still curious that Vitaly found it
>> necessary to include the looping behavior in the Linux guest
>> code.
>   
> Maybe Vitaly was running into a genuine bug, not sure.
>

I'm not sure either :-(

WS2012 was definitely around back then, not sure about 2008. It may also
make sense to add at least a debug print in case we find ourselves
running on something that old. AFAICS, even the TLFS version 2.0A
mentions PV TLB flush hypercalls. If looping is still required for these
old versions, we may introduce some very hard-to-find bugs if we drop
it.

-- 
Vitaly


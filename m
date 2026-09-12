Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com [74.125.228.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB23B35DA6C
	for <linux-hyperv@vger.kernel.org>; Sat, 12 Sep 2026 06:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789195808; cv=none; b=UGlZmOuD/OiQG5jNjgixkIL+xc4CAywTP4iHhnlctLKakxr2yzqlY+QhdwubxOTzk+kP72fkaC9zgtZNxm56IYWE+vEPvxXpMoGChgKbA87QjwWshkwOBpmkvjPAS86XnFzQlgGHpi+V56DTGFetL3aGZb9YlnnansQ2nTjd25k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789195808; c=relaxed/simple;
	bh=sCdpZe2i/QHdtW679jX9SdR4a7+kZzZrKxfkIQPem7s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gngIQsORXLEBqxqTwdL/s4LtJDoLhXqlCY/ToJje04Ho13arhoNB3mgrXINr/BCsppRmQ6jewA3jzLTa9tAPefOH8aP8CmqUraoK18zRLgWoPiiPaRyTjmdpeDLajnFjuXLmduHXzgctC+plwLzD5PuH6ziKBltP+EWuUxDRZ4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Bssf86yg; arc=none smtp.client-ip=74.125.228.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Bssf86yg"
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c29703cb470so122812566b.0
        for <linux-hyperv@vger.kernel.org>; Fri, 11 Sep 2026 23:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1789195804; x=1789800604; darn=vger.kernel.org;
        h=content-type:in-reply-to:autocrypt:from:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=sCdpZe2i/QHdtW679jX9SdR4a7+kZzZrKxfkIQPem7s=;
        b=Bssf86ygnNcIOdpsdU4WXEa1ReCtbz3TI1Wl3uGEaUZtS7UPlvJQrdmweV/MNyXtEl
         yGbLEIYe+cLmLKuv+fwPCHwsvj40VRZWz9OC2opd2HS2aJf5O8QRupaW4mP3h9l0kgiB
         qwuThS3MR1F28jCuJ6i/q/7Ao0ozfRzUGV6h5Tg7P76wGtS37F0fzm1PxjbHCcuBxR1y
         ug094VTjCBsXaH8STSHhVxJLtrKA1saOnfhOfI5M+mIWlfzt2Gd0Qsb3oXu39qLrQiCs
         7RD+fZP6KLagHedMyx1Y9LtmElGDv0phG8KeQiztLO3T5sHAkprIzEpewBrtsiG/HtUz
         s61w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789195804; x=1789800604;
        h=content-type:in-reply-to:autocrypt:from:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sCdpZe2i/QHdtW679jX9SdR4a7+kZzZrKxfkIQPem7s=;
        b=ajApo3SYf199KHPs6bATdnRJriZV+4xOqd7TPvg0y9yfci3Zcsl8xfA3poxZLu7CGi
         lrrkBUv/txcmc1o4WgcLIPVRdNXMPQ9Ag9uvEzsL/b+ASWc9ouG9nQNyasJUszWdSTa+
         alu4pK4a+4fJICYftshtAw0TPUcVEeMBdHFQru7KLt77IUCl/svBplU6nrsK1r3c80fP
         rz3bSgoMoBIxYheXaP6KSW4TQeWxU7SXkAX/cmix1xwnIkEXN18IrRmPWy4XTGyIFSkZ
         ZETBFlxcEvrKGEd7hW2LM3Jqg21Sj160SNLpOxR5iP3TNTEp49+YCVEjk9vGr9gJIp2y
         Bl9g==
X-Forwarded-Encrypted: i=1; AKwUvBwr6sXey5SXomGhJdY40o6zs9n6OM3jg/EbmRm2pMFN0yjUunUVc7dgHntDyAA80u26e2dTz8ozJ17xmWc=@vger.kernel.org
X-Gm-Message-State: AFuF++k+m2Ncyd906i0EdtnVBO52vNt39idiWbpJ2LXjIRp1WEs2BBBj
	lZ0Rvp2yJDqlJtAOaAI6/6DUfOxKy6h0ApQRqJaVlhY0SmFtJgU427JN+5T3qXYNzGc=
X-Gm-Gg: AYBFou2K8taEn2eqcrP3myaf0MPU67o8tJAP6OAX525UjRTFwebAHQ8Vbbv6CEyC0db
	oi747udar6188eUgCJ5JLDYkflnOAlC32z3To0ULGkMgKxykY5eCJhTHltrSGv5FV7JfqE/8erY
	3xlOH/b06kxYJNXssN0tPF4fI9Cf7BpwivGh7YDi2GxsC8f15TYXSxr4nsjMWYIz+CQIk8OT0jM
	8dqA2WcfXCj8/y1nx1YUGety4L+zAwDpH7E3nkkJjGMw71cvFZA9gpbM/5WLdTjsIH77818SQSN
	bQL64Jbwnw7XQVoe5Kf+P0lqyPj+YBtsmXIFcSZ0cp+rr/a/ZHTsB6dvstyPcFAviBsqD2p2xlY
	p+PknQxXtays+lCMq4+i+ZancQ4mbV86eSVmKANDIlucHswUtJ8vOphnxCmXxykrUtqBjjF9Awt
	IsB7K1rtZ11eIdbTJe5esCv3MpYWXsCpvNn5m8TwyPawL5rtA+8dLADCt/nL/HPCwhti61cN1LS
	CrPcKt6y4/8eQ2MNax/iGtitHeWTFvx+6YWGr1Oj0dwZAeKWrWDnHP8OHjWD/vALzIv4AySJjua
	H8ecE/FkPXhRXiHiSVMpvAvh
X-Received: by 2002:a17:906:f591:b0:c29:462b:f917 with SMTP id a640c23a62f3a-c29666f739cmr698707866b.14.1789195804064;
        Fri, 11 Sep 2026 23:50:04 -0700 (PDT)
Received: from ?IPV6:2a00:12d0:af5d:ad01:5d3f:14e6:9bcb:5112? (2a00-12d0-af5d-ad01-5d3f-14e6-9bcb-5112.ip.tng.de. [2a00:12d0:af5d:ad01:5d3f:14e6:9bcb:5112])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2965c4e1ffsm159761166b.7.2026.09.11.23.50.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Sep 2026 23:50:03 -0700 (PDT)
Message-ID: <1e2adc53-87f4-42f3-8eda-cce828009e88@suse.com>
Date: Sat, 12 Sep 2026 08:50:02 +0200
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 13/13] x86/msr: Simplify some rdmsrq() use cases
To: Shreshth Srivastava <shreshth.srivastava@intel.com>,
 linux-kernel@vger.kernel.org, x86@kernel.org,
 linux-perf-users@vger.kernel.org, linux-hyperv@vger.kernel.org,
 kvm@vger.kernel.org, linux-coco@lists.linux.dev
Cc: acme@kernel.org, adrian.hunter@intel.com,
 alexander.shishkin@linux.intel.com, bp@alien8.de,
 dave.hansen@linux.intel.com, decui@microsoft.com, haiyangz@microsoft.com,
 hpa@zytor.com, irogers@google.com, james.clark@linaro.org, jolsa@kernel.org,
 kas@kernel.org, kys@microsoft.com, longli@microsoft.com,
 mark.rutland@arm.com, mhklinux@outlook.com, mingo@redhat.com,
 namhyung@kernel.org, pbonzini@redhat.com, peterz@infradead.org,
 rick.p.edgecombe@intel.com, seanjc@google.com, tglx@kernel.org,
 wei.liu@kernel.org
References: <20260821105709.1671132-1-jgross@suse.com>
 <20260911213310.381839-1-shreshth.srivastava@intel.com>
Content-Language: en-US
From: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Autocrypt: addr=jgross@suse.com; keydata=
 xsBNBFOMcBYBCACgGjqjoGvbEouQZw/ToiBg9W98AlM2QHV+iNHsEs7kxWhKMjrioyspZKOB
 ycWxw3ie3j9uvg9EOB3aN4xiTv4qbnGiTr3oJhkB1gsb6ToJQZ8uxGq2kaV2KL9650I1SJve
 dYm8Of8Zd621lSmoKOwlNClALZNew72NjJLEzTalU1OdT7/i1TXkH09XSSI8mEQ/ouNcMvIJ
 NwQpd369y9bfIhWUiVXEK7MlRgUG6MvIj6Y3Am/BBLUVbDa4+gmzDC9ezlZkTZG2t14zWPvx
 XP3FAp2pkW0xqG7/377qptDmrk42GlSKN4z76ELnLxussxc7I2hx18NUcbP8+uty4bMxABEB
 AAHNH0p1ZXJnZW4gR3Jvc3MgPGpncm9zc0BzdXNlLmNvbT7CwHkEEwECACMFAlOMcK8CGwMH
 CwkIBwMCAQYVCAIJCgsEFgIDAQIeAQIXgAAKCRCw3p3WKL8TL8eZB/9G0juS/kDY9LhEXseh
 mE9U+iA1VsLhgDqVbsOtZ/S14LRFHczNd/Lqkn7souCSoyWsBs3/wO+OjPvxf7m+Ef+sMtr0
 G5lCWEWa9wa0IXx5HRPW/ScL+e4AVUbL7rurYMfwCzco+7TfjhMEOkC+va5gzi1KrErgNRHH
 kg3PhlnRY0Udyqx++UYkAsN4TQuEhNN32MvN0Np3WlBJOgKcuXpIElmMM5f1BBzJSKBkW0Jc
 Wy3h2Wy912vHKpPV/Xv7ZwVJ27v7KcuZcErtptDevAljxJtE7aJG6WiBzm+v9EswyWxwMCIO
 RoVBYuiocc51872tRGywc03xaQydB+9R7BHPzsBNBFOMcBYBCADLMfoA44MwGOB9YT1V4KCy
 vAfd7E0BTfaAurbG+Olacciz3yd09QOmejFZC6AnoykydyvTFLAWYcSCdISMr88COmmCbJzn
 sHAogjexXiif6ANUUlHpjxlHCCcELmZUzomNDnEOTxZFeWMTFF9Rf2k2F0Tl4E5kmsNGgtSa
 aMO0rNZoOEiD/7UfPP3dfh8JCQ1VtUUsQtT1sxos8Eb/HmriJhnaTZ7Hp3jtgTVkV0ybpgFg
 w6WMaRkrBh17mV0z2ajjmabB7SJxcouSkR0hcpNl4oM74d2/VqoW4BxxxOD1FcNCObCELfIS
 auZx+XT6s+CE7Qi/c44ibBMR7hyjdzWbABEBAAHCwF8EGAECAAkFAlOMcBYCGwwACgkQsN6d
 1ii/Ey9D+Af/WFr3q+bg/8v5tCknCtn92d5lyYTBNt7xgWzDZX8G6/pngzKyWfedArllp0Pn
 fgIXtMNV+3t8Li1Tg843EXkP7+2+CQ98MB8XvvPLYAfW8nNDV85TyVgWlldNcgdv7nn1Sq8g
 HwB2BHdIAkYce3hEoDQXt/mKlgEGsLpzJcnLKimtPXQQy9TxUaLBe9PInPd+Ohix0XOlY+Uk
 QFEx50Ki3rSDl2Zt2tnkNYKUCvTJq7jvOlaPd6d/W0tZqpyy7KVay+K4aMobDsodB3dvEAs6
 ScCnh03dDAFgIq5nsB11j3KPKdVoPlfucX2c7kGNH+LUMbzqV6beIENfNexkOfxHfw==
In-Reply-To: <20260911213310.381839-1-shreshth.srivastava@intel.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------faqU8D6UM6LZgyWtdNphe2F6"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------faqU8D6UM6LZgyWtdNphe2F6
Content-Type: multipart/mixed; boundary="------------dL8jxm9dVU7kKr5WHApU9RgD";
 protected-headers="v1"
From: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
To: Shreshth Srivastava <shreshth.srivastava@intel.com>,
 linux-kernel@vger.kernel.org, x86@kernel.org,
 linux-perf-users@vger.kernel.org, linux-hyperv@vger.kernel.org,
 kvm@vger.kernel.org, linux-coco@lists.linux.dev
Cc: acme@kernel.org, adrian.hunter@intel.com,
 alexander.shishkin@linux.intel.com, bp@alien8.de,
 dave.hansen@linux.intel.com, decui@microsoft.com, haiyangz@microsoft.com,
 hpa@zytor.com, irogers@google.com, james.clark@linaro.org, jolsa@kernel.org,
 kas@kernel.org, kys@microsoft.com, longli@microsoft.com,
 mark.rutland@arm.com, mhklinux@outlook.com, mingo@redhat.com,
 namhyung@kernel.org, pbonzini@redhat.com, peterz@infradead.org,
 rick.p.edgecombe@intel.com, seanjc@google.com, tglx@kernel.org,
 wei.liu@kernel.org
Message-ID: <1e2adc53-87f4-42f3-8eda-cce828009e88@suse.com>
Subject: Re: [PATCH v3 13/13] x86/msr: Simplify some rdmsrq() use cases
References: <20260821105709.1671132-1-jgross@suse.com>
 <20260911213310.381839-1-shreshth.srivastava@intel.com>
In-Reply-To: <20260911213310.381839-1-shreshth.srivastava@intel.com>

--------------dL8jxm9dVU7kKr5WHApU9RgD
Content-Type: multipart/mixed; boundary="------------VU1m0sOTKOmOlXUOKddZrxGl"

--------------VU1m0sOTKOmOlXUOKddZrxGl
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMTEuMDkuMjYgMjM6MzMsIFNocmVzaHRoIFNyaXZhc3RhdmEgd3JvdGU6DQo+IEhpIEp1
ZXJnZW4sDQo+IA0KPiBJJ20gd29ya2luZyBvbiBhIHYzIG9mIERhdmUncyAieDg2L21zcjog
Q29uc29saWRhdGUgbmF0aXZlL3BhcmF2aXJ0IE1TUg0KPiBmdW5jdGlvbnMiIHNlcmllcyBv
biB0b3Agb2YgeW91cnMsIHNvIEkgdHJpZWQgdGVzdGluZyB0aGlzIHBhdGNoLg0KDQpZb3Ug
c2hvdWxkIGxvb2sgYXQgWzFdIGFuZCBbMl0gYXMgd2VsbC4NCg0KPiANCj4gV2hpbGUgSSdt
IGhlcmU6IHlvdSBtZW50aW9uZWQgeW91J2Qgc2VuZCBhIFYzIGFmdGVyIHJjMSBpZiBjb25m
bGljdHMNCj4gdHVybmVkIHVwLiBJcyB0aGF0IHN0aWxsIHRoZSBwbGFuPyBJIHdhc24ndCBz
dXJlIHdoZXRoZXIgdG8gYmFzZSBvbiB2Mg0KPiBwbHVzIHRoZSByZXNwaW5zIG9mIDQgYW5k
IDEzLCBvciB3YWl0Lg0KDQpJIGRpZCBzZW5kIG91dCBWMyB5ZXN0ZXJkYXkgWzNdLg0KDQo+
IA0KPiBNb3N0IG9mIHRoZSBjb2RlIHRoaXMgdG91Y2hlcyBjYW4ndCBydW4gb24gbXkgYm94
LCBzbyBJIGNvbXBhcmVkIGNvbXBpbGVkDQo+IG91dHB1dCBpbnN0ZWFkLiBCdWlsdCBwYXRj
aGVzIDEtMTIsIHRoZW4gMS0xMywgd2l0aCB0aGUgc2FtZSAuY29uZmlnIGFuZA0KPiBjb21w
aWxlciwgYW5kIGRpZmZlZCAib2JqZHVtcCAtZCIgb3V0cHV0IGZvciBldmVyeSAubyBpbiBi
b3RoIHRyZWVzLiBBbGwNCj4gOTM5NiBvYmplY3RzIGNhbWUgb3V0IGlkZW50aWNhbC4gVGhl
IDEtMTMga2VybmVsIGJvb3RzIGZpbmUgdW5kZXIgS1ZNLg0KPiANCj4gT25seSB0cmllZCB0
aGUgb25lIGNvbmZpZzogeDg2XzY0LCBnY2MgMTEuNS4wLA0KPiBDUFVfU1VQX3tJTlRFTCxB
TUQsWkhBT1hJTn09eSwgSFlQRVJWPXksIEtWTV9JTlRFTD15LCBLVk1fSU5URUxfVERYPXku
DQo+IA0KPiBUZXN0ZWQtYnk6IFNocmVzaHRoIFNyaXZhc3RhdmEgPHNocmVzaHRoLnNyaXZh
c3RhdmFAaW50ZWwuY29tPg0KDQpUaGFua3MuDQoNCg0KSnVlcmdlbg0KDQpbMV06IGh0dHBz
Oi8vbG9yZS5rZXJuZWwub3JnL2xrbWwvMjAyNjA5MTEwNzUyMTYuMzE0MjMwOS0xLWpncm9z
c0BzdXNlLmNvbS9ULyN0DQpbMl06IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xrbWwvMjAy
NjA5MTEwODQyMTEuMzE0OTk1Ny0xLWpncm9zc0BzdXNlLmNvbS9ULyN0DQpbM106IGh0dHBz
Oi8vbG9yZS5rZXJuZWwub3JnL2xrbWwvMjAyNjA5MTEwNzQ1MzAuMzE0MDgzMC0xLWpncm9z
c0BzdXNlLmNvbS9ULyN0DQo=
--------------VU1m0sOTKOmOlXUOKddZrxGl
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
kt+z4drzFUyEjLM1vVvIMjkUoJs=3D
=3DeeAB
-----END PGP PUBLIC KEY BLOCK-----

--------------VU1m0sOTKOmOlXUOKddZrxGl--

--------------dL8jxm9dVU7kKr5WHApU9RgD--

--------------faqU8D6UM6LZgyWtdNphe2F6
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmqk9hsFAwAAAAAACgkQsN6d1ii/Ey/S
1wf/QTQ5woUenjuZ7QkJEXIuWDT7pJrQQt4dQPrJUah9M9GRZ1uIegM3263zRi5Yv09bbadrYuM3
oLSnH3FWqDCembBNmlwXTlL+fkoRnIoAZZUApZHUyVZDqQZmyfjPpogjHlUhDfwnKZMJYRX5P/rH
AilfznPtW63O4zPeeCDF/q803mUv3UBxtP9PA4+Bhta4b9zcRpSHouBFVgOj/Eq6uj4bs9YPdYvE
jUpqgPbVXQzL6HUq79PPAUxs/Is+2tusB7d/OwA4UzeY0VN8Ky6zeJNAOv7xMxiFZeVh8RZ5Dk5w
ak4YEaJmufWhu4w8Bgx3uV5J/SvArlMv2MnItpdDew==
=kgkG
-----END PGP SIGNATURE-----

--------------faqU8D6UM6LZgyWtdNphe2F6--

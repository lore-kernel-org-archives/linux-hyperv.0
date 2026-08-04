Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0707B429CF0
	for <linux-hyperv@vger.kernel.org>; Tue,  4 Aug 2026 07:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785830248; cv=none; b=Le6deEjKlCM70+Au6gap33zzdL3CcLj4bPVZuI6f8TlDxQhxxkY5sFoHzY9NficNOmbEpq7u4jR99tIJBLJzn65ZrJRHhi18w6MQ9DwTZW79nAYh+BOSCCcdWDCKsu2tr43DzwsRNw1+lQgYclSec5FtdMZgl3/hYAI17A+rjsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785830248; c=relaxed/simple;
	bh=qVb1MOqU1bZoDcbi0BZfBIW2AUDTbUQ2MWUzyPm0KVs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XsXjlkOxu2phS+PVEpBy+PHoFjN/jFqN04Dl8clOAtpYhZCUMEne6/AMjxyC/pOSqSROQ03yC9OSYsUwYpg7/ho1Yk5jnQhc8nDLid7++ZRW1yLfwNGn7mmu8nEdIi84A9iy5dxvJKFRr1aRebAB050Z3a3nWNvNKMSYbNkjABo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ExQYqZPh; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ExQYqZPh"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-495590dde14so29168535e9.0
        for <linux-hyperv@vger.kernel.org>; Tue, 04 Aug 2026 00:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1785830245; x=1786435045; darn=vger.kernel.org;
        h=content-type:in-reply-to:autocrypt:from:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=qVb1MOqU1bZoDcbi0BZfBIW2AUDTbUQ2MWUzyPm0KVs=;
        b=ExQYqZPhyAKvRyHOTNi0qi+av770W39qLcKr00wXv/F1FzW9uAfqwoVfis/xSt+Nkl
         CZx8z39fjmw/o//i3jxyYcIQz6/dHHF1OHnVT98O8ROh7KJwdpjRFHppuuLFw0dvm4e+
         RRl9z8PVD0cPqmFOAXYaMKqoJjR5+rQam8UXq5/vFOUky3fQgfxQ9BUSxYgKawsqKNeR
         rwMe9M0ZSNNxxlgsuUai2G2iWXI0h9wGWF0oVQ5gyhtqsy6MSqHuJrCG2STaaeuf+4e2
         vegrXUjfyKhe8ja2u505J4J6TDOJfttzZd7CzFXA1qBJ/YzQt++eTMPX/bHunVqm05td
         OtjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785830245; x=1786435045;
        h=content-type:in-reply-to:autocrypt:from:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qVb1MOqU1bZoDcbi0BZfBIW2AUDTbUQ2MWUzyPm0KVs=;
        b=imFg/s17Ijd9KNImaAdai3jDqT9NjI1xKFRU37wTRxcLFClhU9jAKf2lwR3wlPdVaA
         aFbSEHH6zw7K+6WUeOgAkP2a8sc4EbqPf1rJfIS9vuZDT0DSRpfYsd2FgkbUYIeu3aBY
         QSLH7xsUD1nxwRl2uTNnNnm9wMnex7brRmN9HGrjqbgcxa2CfJEM/qmd193D/i6LHV/p
         rXIz7J0fIZQ/g6vlj5F9b4cz2lM3bArhEG7EAPntDUeHM10/QnLs2Btp2H/J0DgSgbMf
         DYQ2w0Wf6KT60QyVsIIOWMJezKyy105y5n5zd9IPSYGtyaeH47+13iR/Dpbt6pi9O66q
         Oc+g==
X-Forwarded-Encrypted: i=1; AHgh+RqDktqbakzRH7Dr1OX6BWdXhxwd/578YXSEygqdSmRmhMTPajLupnOc8TesSN7c/CCdNgLUSbq/UggnbFc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyl0/CRe/TJPsEpVsNasgoKCma847VUvZhqOU0E85M7a4OjPCcA
	P6NtzKx3Como9qFFoC79RE2P7xKfbMMZBDEYKFNYYEacFslvd18Gvkw9YwiLosDg3VA=
X-Gm-Gg: AR+sD11d8/WRmFTI8gp4oBIUwBqEa0FeZx5VmcIqAlGdmqVSIiprcbhTladOTt3Rpn5
	V+b+UTgMnoHL0Mdxp7CMq9c6uCLXc0FlgivX/oOPY7ArwQ5XavLkPa07Z1MdUiN8ON38aUsaEns
	Xb3nk3sJ6kDWPRHswqR7JtlSJuUZyO1sTST+86MiJ8CjL0JucpWsf6PvwSarxXHHdiAAQDTJV13
	jY9u71ynL5Qu6rRqdkOexfGdQGzXtrpeyzf49VaU0NDAvnlVEmNHrWhYAJ2pQvSSC9WDzgY8wOM
	4C17bIlfi2HUx7CACP9YMVQrZfPCWvtoC746SEXXu4bm6bPqqOroXKsRCaXxNR2ovDZF00eHbgq
	RSShMKapMCu2/FQ7Fu/MVZLiUjKT4JjoKZRxTwm2ElRfDnWj1ocpsitCaHUJvEbMnzsL3la/50m
	miPhGKxhoJ5cgqj4V0MgcTrc6nEj43jqZ0wBf9VFeUbSnjyeBV7sGZAlkTPQRd1M+0WFfs40GTz
	/S3YmjpeF8YOgZzRVMcO95l2xFSuZLQ0UEriJbZ06exvOqLhCi1K3KkhEISob8T3LHrsgpS+HDj
	phuUX9jGo2qtTyA=
X-Received: by 2002:a05:600c:8b54:b0:495:4859:8f9b with SMTP id 5b1f17b1804b1-4980c674f25mr345983915e9.9.1785830245215;
        Tue, 04 Aug 2026 00:57:25 -0700 (PDT)
Received: from ?IPV6:2a00:12d0:af5d:ad01:5d3f:14e6:9bcb:5112? (2a00-12d0-af5d-ad01-5d3f-14e6-9bcb-5112.ip.tng.de. [2a00:12d0:af5d:ad01:5d3f:14e6:9bcb:5112])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4994a0f7b86sm64048765e9.10.2026.08.04.00.57.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Aug 2026 00:57:24 -0700 (PDT)
Message-ID: <627c59ee-54b1-4f37-b849-c331a9d01618@suse.com>
Date: Tue, 4 Aug 2026 09:57:23 +0200
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] locking/qspinlock: Add contended_release tracepoint
To: Dmitry Ilvokhin <d@ilvokhin.com>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
 Boqun Feng <boqun@kernel.org>, Waiman Long <longman@redhat.com>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 "K. Y. Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>,
 Thomas Gleixner <tglx@kernel.org>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, Ajay Kaher <ajay.kaher@broadcom.com>,
 Alexey Makhalov <alexey.makhalov@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>,
 Josh Poimboeuf <jpoimboe@kernel.org>, Jason Baron <jbaron@akamai.com>,
 Alice Ryhl <aliceryhl@google.com>, Steven Rostedt <rostedt@goodmis.org>,
 Ard Biesheuvel <ardb@kernel.org>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>, Arnd Bergmann <arnd@arndb.de>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
 linux-hyperv@vger.kernel.org, virtualization@lists.linux.dev,
 kvm@vger.kernel.org, xen-devel@lists.xenproject.org,
 linux-arch@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 kernel-team@meta.com
References: <cover.1785778551.git.d@ilvokhin.com>
Content-Language: en-US
From: Juergen Gross <jgross@suse.com>
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
In-Reply-To: <cover.1785778551.git.d@ilvokhin.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------AEfGGk6p5V0hCBAWv3tcK3FA"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------AEfGGk6p5V0hCBAWv3tcK3FA
Content-Type: multipart/mixed; boundary="------------HRWVg0V4yc1LTGims01Et589";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Dmitry Ilvokhin <d@ilvokhin.com>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
 Boqun Feng <boqun@kernel.org>, Waiman Long <longman@redhat.com>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 "K. Y. Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>,
 Thomas Gleixner <tglx@kernel.org>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, Ajay Kaher <ajay.kaher@broadcom.com>,
 Alexey Makhalov <alexey.makhalov@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>,
 Josh Poimboeuf <jpoimboe@kernel.org>, Jason Baron <jbaron@akamai.com>,
 Alice Ryhl <aliceryhl@google.com>, Steven Rostedt <rostedt@goodmis.org>,
 Ard Biesheuvel <ardb@kernel.org>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>, Arnd Bergmann <arnd@arndb.de>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
 linux-hyperv@vger.kernel.org, virtualization@lists.linux.dev,
 kvm@vger.kernel.org, xen-devel@lists.xenproject.org,
 linux-arch@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 kernel-team@meta.com
Message-ID: <627c59ee-54b1-4f37-b849-c331a9d01618@suse.com>
Subject: Re: [PATCH 0/5] locking/qspinlock: Add contended_release tracepoint
References: <cover.1785778551.git.d@ilvokhin.com>
In-Reply-To: <cover.1785778551.git.d@ilvokhin.com>

--------------HRWVg0V4yc1LTGims01Et589
Content-Type: multipart/mixed; boundary="------------33sYuJhXGYzE04xG2wTAikO4"

--------------33sYuJhXGYzE04xG2wTAikO4
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMDQuMDguMjYgMDk6MTUsIERtaXRyeSBJbHZva2hpbiB3cm90ZToNCj4gVGhlIGNvbnRl
bmRlZF9yZWxlYXNlIHRyYWNlcG9pbnQgbGFuZGVkIGluIHY3LjItcmMyIGZvciBzbGVlcGlu
ZyBsb2Nrcw0KPiAoNGYwNzBjY2I0ZGM0ICJsb2NraW5nOiBBZGQgY29udGVuZGVkX3JlbGVh
c2UgdHJhY2Vwb2ludCB0byBzbGVlcGFibGUNCj4gbG9ja3MiKS4gU3BpbmxvY2sgc3VwcG9y
dCB3YXMgZHJvcHBlZCBmcm9tIHRoYXQgc2VyaWVzLiBUaGlzIG9uZSBhZGRzIGl0DQo+IGZv
ciBxdWV1ZWQgc3BpbmxvY2tzLg0KPiANCj4gVGhlIGV4aXN0aW5nIGNvbnRlbnRpb25fYmVn
aW4vY29udGVudGlvbl9lbmQgdHJhY2Vwb2ludHMgZmlyZSBvbiB0aGUNCj4gd2FpdGVyIHNp
ZGUuIFRoZSBob2xkZXIncyBpZGVudGl0eSBhbmQgc3RhY2sgY2FuIGJlIGNhcHR1cmVkIGF0
DQo+IGNvbnRlbnRpb25fYmVnaW4gdGltZSAoZS5nLiBwZXJmIGxvY2sgY29udGVudGlvbiAt
LWxvY2stb3duZXIpLCBidXQgb25seQ0KPiBmb3IgbG9ja3Mgd2l0aCBhbiBvd25lciBmaWVs
ZCB0byByZWFkOiBtdXRleCBhbmQgcndzZW0uIHFzcGlubG9jayBoYXMNCj4gbm9uZSwgc28g
YSBjb250ZW5kZWQgc3BpbmxvY2sgY2Fubm90IGJlIGF0dHJpYnV0ZWQgdG8gaXRzIGhvbGRl
ciBhdCBhbGwuDQo+IEV2ZW4gd2hlcmUgdGhlIG93bmVyIGNhbiBiZSByZWFkLCBpdCByZWZs
ZWN0cyB0aGUgaG9sZGVyJ3Mgc3RhdGUgd2hlbiBhDQo+IHdhaXRlciBhcnJpdmVzLCBub3Qg
d2hlbiB0aGUgbG9jayBpcyByZWxlYXNlZC4NCj4gDQo+IFRoaXMgc2VyaWVzIGFkZHMgYSBj
b250ZW5kZWRfcmVsZWFzZSB0cmFjZXBvaW50IHRvIHFzcGlubG9jayB0aGF0IGZpcmVzDQo+
IG9uIHRoZSBob2xkZXIgc2lkZSB3aGVuIGEgbG9jayB3aXRoIHdhaXRlcnMgaXMgcmVsZWFz
ZWQuIFRoaXMgcHJvdmlkZXM6DQo+IA0KPiAtIEhvbGQgdGltZSBlc3RpbWF0aW9uOiB3aGVu
IHRoZSBob2xkZXIncyBvd24gYWNxdWlzaXRpb24gd2FzDQo+ICAgIGNvbnRlbmRlZCwgaXRz
IGNvbnRlbnRpb25fZW5kIChhY3F1aXNpdGlvbikgYW5kIGNvbnRlbmRlZF9yZWxlYXNlDQo+
ICAgIGNhbiBiZSBjb3JyZWxhdGVkIHRvIG1lYXN1cmUgaG93IGxvbmcgdGhlIGxvY2sgd2Fz
IGhlbGQgdW5kZXINCj4gICAgY29udGVudGlvbi4NCj4gDQo+IC0gVGhlIGhvbGRlcidzIHN0
YWNrIGF0IHJlbGVhc2UgdGltZSwgd2hpY2ggZm9yIHNwaW5sb2NrcyBpcyBub3QNCj4gICAg
YXZhaWxhYmxlIGJ5IGFueSBvdGhlciBtZWFucy4NCj4gDQo+IFRoZSB1bmxvY2sgcGF0aCBt
aWdodCBiZSBxdWl0ZSBob3QsIHNvIHRoZSB0cmFjZXBvaW50IGlzIG1hZGUgYXMgY2hlYXAN
Cj4gYXMgcG9zc2libGUsIHRvIGtlZXAgaXQgdXNhYmxlIGluIHByb2R1Y3Rpb246DQo+IA0K
PiAtIHg4NiB3aXRoIFBBUkFWSVJUX1NQSU5MT0NLUz15LCB3aGljaCBpcyB3aGF0IGRpc3Ry
aWJ1dGlvbnMgc2hpcCwgc3dhcHMNCj4gICAgdGhlIHVubG9jayBpbXBsZW1lbnRhdGlvbiB2
aWEgc3RhdGljX2NhbGwoKSB3aGVuIHRoZSB0cmFjZXBvaW50IGlzDQo+ICAgIGVuYWJsZWQu
IFRoZSBkaXNhYmxlZCBwYXRoIGlzIGJ5dGUtaWRlbnRpY2FsIHRvIHRvZGF5J3M6IHRoZSBz
YW1lDQo+ICAgIGlubGluZSBtb3ZiLCBubyBOT1AgYW5kIG5vIGNhbGwuDQo+IA0KPiAtIEV2
ZXJ5d2hlcmUgZWxzZSBhIHN0YXRpYy1icmFuY2ggY2hlY2sgaXMgY29tcGlsZWQgaW50bw0K
PiAgICBxdWV1ZWRfc3Bpbl91bmxvY2soKS4gT24geDg2XzY0IHRoYXQgaXMgYSBzaW5nbGUg
Tk9QIG9uIHRoZSBleGVjdXRlZA0KPiAgICBwYXRoLCB3aXRoIHRoZSBjYWxsIHRvIHRoZSB0
cmFjZWQgaGVscGVyIGVtaXR0ZWQgb3V0IG9mIGxpbmUgYW5kDQo+ICAgIHVucmVhY2hhYmxl
IHdoaWxlIHRoZSB0cmFjZXBvaW50IGlzIG9mZi4gT24gb3RoZXIgYXJjaGl0ZWN0dXJlcyBh
IGZldw0KPiAgICBtb3JlIGluc3RydWN0aW9ucyB0byBtYW5hZ2UgYSBzdGFjayBmcmFtZSBs
YW5kIG9uIHRoZSBleGVjdXRlZCBwYXRoDQo+ICAgIHRvbywgc28gdGhlIGdlbmVyaWMgcGF0
aCBzaXRzIGJlaGluZA0KPiAgICBDT05GSUdfUVVFVUVEX1NQSU5MT0NLU19UUkFDRV9DT05U
RU5ERURfUkVMRUFTRSAoZGVmYXVsdCBuKS4NCj4gDQo+IENvc3RzIGFuZCBtZWFzdXJlbWVu
dHMgYXJlIGluIHRoZSBpbmRpdmlkdWFsIGNoYW5nZWxvZ3MuIEJyaWVmbHksIG5vDQo+IHRo
cm91Z2hwdXQgb3IgbGF0ZW5jeSBjaGFuZ2UgaXMgbWVhc3VyYWJsZSBvbiBlaXRoZXIgeDg2
XzY0IG9yIGFybTY0DQo+IHdpdGggUVVFVUVEX1NQSU5MT0NLU19UUkFDRV9DT05URU5ERURf
UkVMRUFTRT15Lg0KPiANCj4gVGVzdGVkOiB4ODZfNjQgd2l0aCBQQVJBVklSVF9TUElOTE9D
S1M9eSBhbmQgPW4sIGFybTY0LCB0cmFjZXBvaW50IG9uDQo+IGFuZCBvZmYsIGRpc2Fzc2Vt
Ymx5IGNoZWNrZWQgaW4gYm90aCBzdGF0ZXMsIGxvY2t0b3J0dXJlIHdpdGggdHJhY2Vwb2lu
dA0KPiBvbiBhbmQgb2ZmLg0KPiANCj4gTm90IGNvdmVyZWQ6IHFyd2xvY2ssIGFuZCBhcmNo
aXRlY3R1cmVzIHdpdGggZnVsbHkgY3VzdG9tIHFzcGlubG9jaw0KPiBpbXBsZW1lbnRhdGlv
bnMgKGUuZy4gUG93ZXJQQykuIFRoZSBzdGFjayBmcmFtZSBtYW5hZ2luZyBpbnN0cnVjdGlv
bnMgb24NCj4gYXJtNjQgc2hvdWxkIGJlIGF2b2lkYWJsZSwgYnV0IHRoYXQgaXMgbm90IGRv
bmUgaW4gdGhpcyBwYXRjaHNldC4NCj4gDQo+IFBhdGNoIDEgaXMgUGV0ZXIncyBkcmFmdCBm
cm9tIFsxXSBhbmQgaXMgbWlzc2luZyBoaXMgU2lnbmVkLW9mZi1ieS4NCj4gUGV0ZXIsIHBs
ZWFzZSBhZGQgaXQgaWYgeW91IGFyZSBoYXBweSB3aXRoIHRoZSBwYXRjaC4NCj4gDQo+IFsx
XTogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsLzIwMjYwNjAzMTIwODExLkdXMzQ5MzA5
MEBub2lzeS5wcm9ncmFtbWluZy5raWNrcy1hc3MubmV0Lw0KPiANCj4gRG1pdHJ5IElsdm9r
aGluICg0KToNCj4gICAgbG9ja2luZzogRmFjdG9yIG91dCBxdWV1ZWRfc3Bpbl9yZWxlYXNl
KCkNCj4gICAgbG9ja2luZy9xc3BpbmxvY2s6IEFkZCBjb250ZW5kZWRfcmVsZWFzZSB0cmFj
ZXBvaW50DQo+ICAgIHRyYWNpbmcvbG9jazogVXNlIFRSQUNFX0VWRU5UX0ZOKCkgZm9yIGNv
bnRlbmRlZF9yZWxlYXNlDQo+ICAgIHg4Ni9wYXJhdmlydDogVHJhY2UgY29udGVuZGVkX3Jl
bGVhc2Ugb24gdW5sb2NrDQo+IA0KPiBQZXRlciBaaWpsc3RyYSAoMSk6DQo+ICAgIHg4Ni9w
YXJhdmlydDogVXNlIHN0YXRpY19jYWxsKCkgZm9yIHRoZSBwYXJhdmlydCBzcGlubG9jayBv
cHMNCj4gDQo+ICAgYXJjaC9taXBzL2luY2x1ZGUvYXNtL3NwaW5sb2NrLmggICAgICAgICB8
ICA2ICstLQ0KPiAgIGFyY2gveDg2L2h5cGVydi9odl9zcGlubG9jay5jICAgICAgICAgICAg
fCAgNCArLQ0KPiAgIGFyY2gveDg2L2luY2x1ZGUvYXNtL2NwdWZlYXR1cmVzLmggICAgICAg
fCAgMSAtDQo+ICAgYXJjaC94ODYvaW5jbHVkZS9hc20vcGFyYXZpcnQtc3BpbmxvY2suaCB8
IDIxICsrKysrLS0tDQo+ICAgYXJjaC94ODYva2VybmVsL2t2bS5jICAgICAgICAgICAgICAg
ICAgICB8ICA1ICstDQo+ICAgYXJjaC94ODYva2VybmVsL3BhcmF2aXJ0LXNwaW5sb2Nrcy5j
ICAgICB8IDYzICsrKysrKysrKysrKysrKysrKysrKy0tLQ0KPiAgIGFyY2gveDg2L2tlcm5l
bC9zdGF0aWNfY2FsbC5jICAgICAgICAgICAgfCAyNyArKysrKysrKysrDQo+ICAgYXJjaC94
ODYveGVuL3NwaW5sb2NrLmMgICAgICAgICAgICAgICAgICB8ICA1ICstDQo+ICAgaW5jbHVk
ZS9hc20tZ2VuZXJpYy9xc3BpbmxvY2suaCAgICAgICAgICB8IDM4ICsrKysrKysrKysrKy0t
DQo+ICAgaW5jbHVkZS90cmFjZS9ldmVudHMvbG9jay5oICAgICAgICAgICAgICB8IDEwICsr
Ky0NCj4gICBrZXJuZWwvS2NvbmZpZy5sb2NrcyAgICAgICAgICAgICAgICAgICAgIHwgMjAg
KysrKysrKysNCj4gICBrZXJuZWwvbG9ja2luZy9tdXRleC5jICAgICAgICAgICAgICAgICAg
IHwgIDQgKysNCj4gICBrZXJuZWwvbG9ja2luZy9xc3BpbmxvY2suYyAgICAgICAgICAgICAg
IHwgMjIgKysrKysrKysrDQo+ICAgdG9vbHMvYXJjaC94ODYvaW5jbHVkZS9hc20vY3B1ZmVh
dHVyZXMuaCB8ICAxIC0NCj4gICAxNCBmaWxlcyBjaGFuZ2VkLCAxOTUgaW5zZXJ0aW9ucygr
KSwgMzIgZGVsZXRpb25zKC0pDQo+IA0KPiANCj4gYmFzZS1jb21taXQ6IDVlNjAxYWIzNjE1
Yzg2YmU3YzQwNjhjZTk5MmY5NDY1NDY5M2EwMzINCg0KRm9yIHRoZSB3aG9sZSBzZXJpZXM6
DQoNCkFja2VkLWJ5OiBKdWVyZ2VuIEdyb3NzIDxqZ3Jvc3NAc3VzZS5jb20+DQoNCkknbSBj
b25zaWRlcmluZyBzb21lIGZvbGxvd3VwIHBhdGNoZXMgcmVwbGFjaW5nIHRoZSByZW1haW5p
bmcgcGFyYXZpcnQNCmNhc2VzIG5vdCBjb3ZlcmVkIGJ5IENPTkZJR19QQVJBVklSVF9YWEwg
d2l0aCBzdGF0aWNfY2FsbCgpLCB0b28uDQoNClRoaXMgd2lsbCBhbGxvdyB0byBkcm9wIHRo
ZSAzMi1iaXQgcGFyYXZpcnQgcGF0Y2hpbmcgY29tcGxldGVseS4gOi0pDQoNClRoZSBxdWV1
ZWRfc3Bpbl91bmxvY2soKSBob29rIHdhcyB0aGUgbWFpbiByZWFzb24gSSBkaWRuJ3QgZG8g
dGhhdCB5ZXQuDQoNCg0KSnVlcmdlbg0K
--------------33sYuJhXGYzE04xG2wTAikO4
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
kt+z4drzFUyEjLM1vVvIMjkUoJs=3D
=3DeeAB
-----END PGP PUBLIC KEY BLOCK-----

--------------33sYuJhXGYzE04xG2wTAikO4--

--------------HRWVg0V4yc1LTGims01Et589--

--------------AEfGGk6p5V0hCBAWv3tcK3FA
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmpxm2MFAwAAAAAACgkQsN6d1ii/Ey+9
Agf+IWx5eXJ7mO6oP+n4rxGw46J5o8kxhJQXckuPe4UqJ4KZp2eDhMwkS/QfmUPt+V4ojeOdZa1V
t5qalPRfTCjVf4ZjarkTErmzJEGtvM5UFOPA1nJBFIGlV8VkDzRzYXof0c0ySuzecPKbh7pY3vUz
VAUq0Q4EI6/WZY9jlKSQPoVjFFnIaWF5MoA2mGETIaZNXIBKSb/JmKfyRKxoY+u6IIeXrzl3wnIp
VRnKsfQY36idWLXCtgq72WaTEl8HBUfpg0cTNGX0Fs6DZ4wH41e/KenwyCtV/RoC9vMyVKhvshqA
JQOnAn0AVEbRYSsu6FmlqT/H4mCv6HrNanDhE76nUA==
=gT7a
-----END PGP SIGNATURE-----

--------------AEfGGk6p5V0hCBAWv3tcK3FA--

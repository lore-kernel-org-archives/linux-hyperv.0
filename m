Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.2
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793084391;
	b=lXfGDHzvavaMOEClhAivAXK9iDVBJ1QtMhz/FiyZqdcpqmZeeSyHAyD20wYqs1BwZ67N
	 k5slHUedrGlkGulhY0oFJiD9JKbEU4rnjvjllZQuUC8k56VV8exBAy2AGwMzEXitX+DVo
	 5oBbEz7VpP82ADDVFxuCYWdzFKRg2qGmKZfcUfTIdc9tqQLZv8CgGE7J12CIRpgSqOwtu
	 QvsZtAs1w2aAtWb4fIRnWWc95oCZ3Z/xkgSXylseau1/qTsDM1sOSqRRmHL6BpSkz6X86
	 JrFzKqnRdvQai3qFvoVPdBaDx1HC1yP61Leg2v6CSD4Slmqm2KqlDgkmMo9FXUxOidg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793084391;
	h=DMARC-Filter:DKIM-Signature:Date:From:To:Cc:Subject:X-Priority:
	 X-Mailer:In-Reply-To:References:X-NTES-SC:Content-Transfer-Encoding:
	 Content-Type:MIME-Version:Message-ID:X-Coremail-Locale:X-CM-TRANSID:
	 X-CM-SenderInfo:X-Coremail-Antispam;
	bh=dAK6xOr/uhosYMFj8zdGYk01ALFi2akXc8OJgF7kpwc=;
	b=lcLo2LLFXTU9KWhWf7LEUHfvzvH8Tr37ywQ5LtEB+K/iLAvM+KPscMJ1/z35EXFyJ1NW
	 fXswNY/HaOzDVFbvOgH1aUxVIK5of8T9GN/ZT5vOIBt6HXSOjimUVEI+s2t7DirHHmRUT
	 xXwslDQ4lpOHV+KCMy8pEUKexXF5XXpfn4JB9Uk/Bd61RKTOltb04IEcz7zCA4JZrjEr/
	 QeAzGGV87FbUHSa7wIF4Y5AfW3i6oOlnw31mEsM/5qz7FmJkNhfEGWIFx4DoVGI5Jv71H
	 kdUjHQWiVSfsQzdU83tWwJXZ7PdHyzaO+LiAbEvzfXo0LgvjsYin8KRlJJiGZHG2QSg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=nhSQ8MNF;
	arc=none smtp.remote-ip=220.197.31.2
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07202606A320;
	Tue, 27 Oct 2026 06:59:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 07202606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=nhSQ8MNF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
	Message-ID; bh=dAK6xOr/uhosYMFj8zdGYk01ALFi2akXc8OJgF7kpwc=; b=n
	hSQ8MNFtGabwQzGxx3HAlsAXBajpR7ntvvSqDbAg1CCYHCOuyBNucTeBKysbAc3A
	bZh6HfwFcmz3xmd5SPnMzW72pp6J8TZNpOZJaZKjhEGb6HWRQTCkSC4YLjIGR2TA
	q8WVfkktjArO+FRuVUtHSw3ek66bw3cJDSo65TgZQc=
Date: Tue, 27 Oct 2026 14:59:19 +0800 (CST)
From: "jiale yao" <19888972804@163.com>
To: "Kameron Carr" <kameroncarr@linux.microsoft.com>
Cc: "Haiyang Zhang" <haiyangz@microsoft.com>, "Wei Liu" <wei.liu@kernel.org>,
	"Dexuan Cui" <decui@microsoft.com>,
	"Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
	"Stephen Hemminger" <stephen@networkplumber.org>,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re:Re: [PATCH v2 2/2] Drivers: hv: vmbus: copy dynamic IDs before
 dropping the lock
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.4-cmXT build
 20260511(2e539873) Copyright (c) 2002-2026 www.mailtech.cn 163com
In-Reply-To: <d04125b1-1228-4322-a455-3b8970167239@linux.microsoft.com>
References: <20261021143323.338146-1-yaojiale02@163.com>
 <20261021143323.338146-3-yaojiale02@163.com>
 <d04125b1-1228-4322-a455-3b8970167239@linux.microsoft.com>
X-NTES-SC: AL_Qu2SAfyTu0su7yGYbOkcn08ShO49XMOyvfoi2YFTc8EFhwzy3T8rZFVlLHfY28mULw+2ux6vQhhcw+doWoNAVrXH5F+X/NUsSMptF9f6lQ==
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Post: <mailto:linux-hyperv@vger.kernel.org>
List-Help: <mailto:linux-hyperv+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hyperv+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-ID: <768c8007.587f.1a17c2801ce.Coremail.19888972804@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:gigvCgD3v0DHS+BqFQBhAA--.1557W
X-CM-SenderInfo: x1dryxhdohiji6rwjhhfrp/xtbC8AfWEWrgS8cjFQAA3A
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

QXQgMjAyNi0xMC0yNCAwODo0MToxNywgIkthbWVyb24gQ2FyciIgPGthbWVyb25jYXJyQGxpbnV4
Lm1pY3Jvc29mdC5jb20+IHdyb3RlOgo+T24gMTAvMjEvMjAyNiA3OjMzIEFNLCBKaWFsZSBZYW8g
d3JvdGU6Cj5bLi4uXQo+PiBAQCAtODYwLDEzICs4NjIsMTcgQEAgc3RhdGljIGludCB2bWJ1c19t
YXRjaChzdHJ1Y3QgZGV2aWNlICpkZXZpY2UsIGNvbnN0IHN0cnVjdCBkZXZpY2VfZHJpdmVyICpk
cml2ZXIKPj4gICAqLwo+PiAgc3RhdGljIGludCB2bWJ1c19wcm9iZShzdHJ1Y3QgZGV2aWNlICpj
aGlsZF9kZXZpY2UpCj4+ICB7Cj4+IC0JaW50IHJldCA9IDA7Cj4+ICsJY29uc3Qgc3RydWN0IGh2
X3ZtYnVzX2RldmljZV9pZCAqZGV2X2lkOwo+PiArCXN0cnVjdCBodl92bWJ1c19kZXZpY2VfaWQg
ZGV2X2lkX2NvcHk7Cj4+ICAJc3RydWN0IGh2X2RyaXZlciAqZHJ2ID0KPj4gIAkJCWRydl90b19o
dl9kcnYoY2hpbGRfZGV2aWNlLT5kcml2ZXIpOwo+PiAgCXN0cnVjdCBodl9kZXZpY2UgKmRldiA9
IGRldmljZV90b19odl9kZXZpY2UoY2hpbGRfZGV2aWNlKTsKPj4gLQljb25zdCBzdHJ1Y3QgaHZf
dm1idXNfZGV2aWNlX2lkICpkZXZfaWQ7Cj4+ICsJaW50IHJldCA9IDA7Cj4KPk5pdDogdGhlIHJl
b3JkZXJpbmcgb2YgdGhlc2UgZGVjbGFyYXRpb25zIGlzIHVubmVjZXNzYXJ5Lgo+SW4gYSBzdGFi
bGUgcGF0Y2gsIHdlIHNob3VsZG4ndCBpbmNsdWRlIGFueSBwdXJlbHkgc3R5bGUgY2hhbmdlcy4K
Pgo+LS0gCj5SZWdhcmRzLAo+S2FtZXJvbgo+Cj4+ICsKPj4gKwlkZXZfaWQgPSBodl92bWJ1c19n
ZXRfaWQoZHJ2LCBkZXYsICZkZXZfaWRfY29weSk7Cj4+ICsJaWYgKCFkZXZfaWQgJiYgIWlzX2h2
c29ja19jaGFubmVsKGRldi0+Y2hhbm5lbCkpCj4+ICsJCXJldHVybiAtRU5PREVWOwo+PiAgCj4+
IC0JZGV2X2lkID0gaHZfdm1idXNfZ2V0X2lkKGRydiwgZGV2KTsKPj4gIAlpZiAoZHJ2LT5wcm9i
ZSkgewo+PiAgCQlyZXQgPSBkcnYtPnByb2JlKGRldiwgZGV2X2lkKTsKPj4gIAkJaWYgKHJldCAh
PSAwKQo+PiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9oeXBlcnYuaCBiL2luY2x1ZGUvbGlu
dXgvaHlwZXJ2LmgKPj4gaW5kZXggOWUxMDlkOTFhYTE0Li4wZjA0MjNlOGExODQgMTAwNjQ0Cj4+
IC0tLSBhL2luY2x1ZGUvbGludXgvaHlwZXJ2LmgKPj4gKysrIGIvaW5jbHVkZS9saW51eC9oeXBl
cnYuaAo+PiBAQCAtMTI2NCw2ICsxMjY0LDcgQEAgc3RydWN0IGh2X2RyaXZlciB7Cj4+ICAJCXN0
cnVjdCBsaXN0X2hlYWQgbGlzdDsKPj4gIAl9IGR5bmlkczsKPj4gIAo+PiArCS8qIFRoZSBkZXZp
Y2UgSUQgcG9pbnRlciBpcyBvbmx5IHZhbGlkIGR1cmluZyB0aGUgcHJvYmUgY2FsbGJhY2suICov
Cj4+ICAJaW50ICgqcHJvYmUpKHN0cnVjdCBodl9kZXZpY2UgKiwgY29uc3Qgc3RydWN0IGh2X3Zt
YnVzX2RldmljZV9pZCAqKTsKPj4gIAl2b2lkICgqcmVtb3ZlKShzdHJ1Y3QgaHZfZGV2aWNlICpk
ZXYpOwo+PiAgCXZvaWQgKCpzaHV0ZG93bikoc3RydWN0IGh2X2RldmljZSAqKTsKPgo+CgpUaGFu
a3MgZm9yIHlvdXIgcmV2aWV3LCB0aGUgdXBkYXRlZCBvbmUgaXMgaGVyZSwgaHR0cHM6Ly9sb3Jl
Lmtlcm5lbC5vcmcvYWxsLzIwMjYxMDI3MDY1NjQyLjIyODAyOTctMS15YW9qaWFsZTAyQDE2My5j
b20v

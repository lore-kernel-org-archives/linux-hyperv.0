Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B1853EA942;
	Sat, 17 Oct 2026 07:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792222871; cv=none; b=nNuukKJrYgCVtzm/YZ4buphre5xscvKScOo35vk6iz/ejRhXY56fis7LJG4JZG4WkADdZWEgBYLhVwOm/2hBzuXmSZ5eX9n1Hrigk01dqGQFKMQsA+BbjV7zuHGm8IK6kAF4WYwB+Qc/BOtL47U37fVlN47lsnSPU/zNoTLDpzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792222871; c=relaxed/simple;
	bh=IwjlrqWkRswrl0eUuI23hZ1RaCjZOI+5bKih4kQSfjo=;
	h=Date:From:To:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=DZ5kw/VAmAY/KSSMgsqMirNzwJjCdsUElZuTaYTDUH4c7TajIzHvQHLazaOeL8lliEGkTgc0gswhHvj0SWVffsLP+x3SYT5FH6vL6eyL22PDP7PiiIV/9C/6Brjw55y2CdsuEVS8V6/zoiGCl1u/hoUMEXi3iMhsP+lS94iz93w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Vm0twJ1Y; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Vm0twJ1Y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
	Message-ID; bh=IwjlrqWkRswrl0eUuI23hZ1RaCjZOI+5bKih4kQSfjo=; b=V
	m0twJ1YLDABn5KoNB46p0qjFg3mQ+M5RL4eBQ7Q/b9/GLYlwibZHbgpXVCMr5jJN
	3qUkcAhTUwAIoImEdRaVlJz+SN/kV3ShJcS9ro1R7VBCg3foWz3c0J/ijHp02DcV
	fwPW/v60NSPMcFHIcAS+6lMnO1jmICAwSwCNiF/mP0=
Date: Sat, 17 Oct 2026 15:40:45 +0800 (CST)
From: "jiale yao" <19888972804@163.com>
To: "Haiyang Zhang" <haiyangz@microsoft.com>, "Wei Liu" <wei.liu@kernel.org>,
	"Dexuan Cui" <decui@microsoft.com>, linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re:[PATCH] Drivers: hv: vmbus: Check ACPI companion before use
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.4-cmXT build
 20260511(2e539873) Copyright (c) 2002-2026 www.mailtech.cn 163com
In-Reply-To: <20261017064313.3816553-1-yaojiale02@163.com>
References: <20261017064313.3816553-1-yaojiale02@163.com>
X-NTES-SC: AL_Qu2SAP6ZvUAv4yWfbekdnEkQgO0/WsS1vfQu2Y5Wc+wEgCbN4z0YdHxaDHHN8e6DOSarnDiOagNHzNRcb4JHQEamNL2nZuS3kSC7JbHqdQ==
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <3f41f884.18f3.1a148ce5a95.Coremail.19888972804@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:ZygvCgDnX2V9JtNqSfxaAA--.146W
X-CM-SenderInfo: x1dryxhdohiji6rwjhhfrp/xtbCzR04cmrTJn0uUgAA3E
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

QXQgMjAyNi0xMC0xNyAxNDo0MzoxMywgIkppYWxlIFlhbyIgPHlhb2ppYWxlMDJAMTYzLmNvbT4g
d3JvdGU6Cj5QbGF0Zm9ybSBkcml2ZXJzIGNhbiBiZSBmb3JjZWQgdG8gYmluZCB0byBkZXZpY2Vz
IG91dHNpZGUgdGhlaXIgbWF0Y2gKPnRhYmxlcyB0aHJvdWdoIGRyaXZlcl9vdmVycmlkZS4gdm1i
dXNfYWNwaV9hZGQoKSBhc3N1bWVzIHRoYXQgZXZlcnkgYm91bmQKPmRldmljZSBoYXMgYW4gQUNQ
SSBjb21wYW5pb24gYW5kIGRlcmVmZXJlbmNlcyBpdCB3aXRob3V0IGNoZWNraW5nLgo+Cj5SZXR1
cm4gLUVOT0RFViB3aGVuIHRoZSBjb21wYW5pb24gaXMgYWJzZW50IHRvIGF2b2lkIGEgTlVMTCBw
b2ludGVyCj5kZXJlZmVyZW5jZS4KPgoKRml4ZXM6IDljODQzNDIzODA0MSAoIkRyaXZlcnM6IGh2
OiB2bWJ1czogQ29udmVydCBhY3BpX2RldmljZSB0byBtb3JlIGdlbmVyaWMgcGxhdGZvcm1fZGV2
aWNlIikKCj5TaWduZWQtb2ZmLWJ5OiBKaWFsZSBZYW8gPHlhb2ppYWxlMDJAMTYzLmNvbT4KPi0t
LQo+IGRyaXZlcnMvaHYvdm1idXNfZHJ2LmMgfCA4ICsrKysrKy0tCj4gMSBmaWxlIGNoYW5nZWQs
IDYgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKPgo+ZGlmZiAtLWdpdCBhL2RyaXZlcnMv
aHYvdm1idXNfZHJ2LmMgYi9kcml2ZXJzL2h2L3ZtYnVzX2Rydi5jCj5pbmRleCA0NjkyNjg3Y2Ri
ZjMuLjI4ZjQ1OTY3OTQwNiAxMDA2NDQKPi0tLSBhL2RyaXZlcnMvaHYvdm1idXNfZHJ2LmMKPisr
KyBiL2RyaXZlcnMvaHYvdm1idXNfZHJ2LmMKPkBAIC0yNTcxLDEwICsyNTcxLDE0IEBAIEVYUE9S
VF9TWU1CT0xfR1BMKHZtYnVzX2ZyZWVfbW1pbyk7Cj4gI2lmZGVmIENPTkZJR19BQ1BJCj4gc3Rh
dGljIGludCB2bWJ1c19hY3BpX2FkZChzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQo+IHsK
PisJc3RydWN0IGFjcGlfZGV2aWNlICphbmNlc3RvcjsKPisJc3RydWN0IGFjcGlfZGV2aWNlICpk
ZXZpY2U7Cj4gCWFjcGlfc3RhdHVzIHJlc3VsdDsKPiAJaW50IHJldF92YWwgPSAtRU5PREVWOwo+
LQlzdHJ1Y3QgYWNwaV9kZXZpY2UgKmFuY2VzdG9yOwo+LQlzdHJ1Y3QgYWNwaV9kZXZpY2UgKmRl
dmljZSA9IEFDUElfQ09NUEFOSU9OKCZwZGV2LT5kZXYpOwo+Kwo+KwlkZXZpY2UgPSBBQ1BJX0NP
TVBBTklPTigmcGRldi0+ZGV2KTsKPisJaWYgKCFkZXZpY2UpCj4rCQlyZXR1cm4gLUVOT0RFVjsK
PiAKPiAJdm1idXNfcm9vdF9kZXZpY2UgPSAmZGV2aWNlLT5kZXY7Cj4gCj4tLSAKPjIuMzQuMQo=


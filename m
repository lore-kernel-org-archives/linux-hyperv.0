Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.92.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794590639;
	b=31kOQaawCL6WsGeVtjCtYUvUdihMjFLZm7YWOavYHjbR2U4l/GRG6+K8GcydNOMGcAYU
	 TEYBIcP435W9Osmzhef9FX1jB/YgcKbr4BKnQqBFJ7MYoBIRaY9kIK2CGLw3Eo369LRRM
	 kfEvzyzqKcuVaQV+WGeig9stGMjjeVyLDkslxmx+HouJRRO3jos6V8x5Fl+WI6j1GtSDJ
	 GNvNs/yKNIOMM7JaszUemj+hGBDs9jxQKNSP+gPxHlSUc00vrCefegYenpNpqdGjhx/Pa
	 6zmlsdT8ymzMQMFLXLZfznJ9V1IKtR3s1VB1hBQBHTJ6f1hfIO9bHqa419Xgzn7UElg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794590639;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:CC:Subject:
	 User-Agent:In-Reply-To:References:Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-SRS-Rewrite;
	bh=Ew9UgtFA4rDTtY7AGkMrs82Yniw5oWvXqP8fEBNcYZ4=;
	b=GHMh9/G0f0YHjzfVDN68+zbUyB+R3uUGu4w8YBo2JraaDRNi0Bx0VYd1elL4NnLFxkIf
	 d7x+9U6qMkY9H0nf/wKv7h0dh3ZWyUSd45b9Pn+0zqdfqOvJL9oitvdD+Z7rOX3crgEHi
	 KchJYoNfmodpQ88jokuwls8wGkJTZ+H2eN9NDldAvk+dKa7saJoulSy0okjbKdyT33GIK
	 WTsUHSn01tlVJeDgPEK2TUo8V4JPbTyqt1SdFe5okZ7pRV4V84jT3xkEiH49buisXM2BY
	 lbkOT/tGapItfj+6obv6ruhTpyVuerkA8Q4MGWBYalUeNqhyjrJLzcvIrwGuPzgaEDA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=none smtp.mailfrom=desiato.srs.infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=OXyFPV9w;
	arc=none smtp.remote-ip=90.155.92.199
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35C7360A382D;
	Fri, 13 Nov 2026 17:23:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 35C7360A382D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=OXyFPV9w
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:MIME-Version:Message-ID:References:In-Reply-To:Subject:CC:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=Ew9UgtFA4rDTtY7AGkMrs82Yniw5oWvXqP8fEBNcYZ4=; b=OXyFPV9wCCp2DJ5oxXckRwRkkq
	lAuw2cBv85id6X3BjoTcjiwVGLe/+2tYJwDrTnzSI4LTYd+DQBqLV3GiqS+ti441JkSsdUVsLpUU6
	BcvFw/CaKopk49tYNukFfbNHEqWNxBawKeMVmxc9zmYGuB0LKlZF45T47qoKKIHhNIwUgsPB3bgR8
	P74DsKcvdJ5Wkg+FCyUSDrIjDy+9cBVDv5Kl0ACNdRvbNg5/2kwcwIJEcW20KAalKLH+aF2eHTF/f
	oAJOXFiP94jbEMuJVMaqdOCgI8NkRtXTSlVgzSp6rL3KJV6zjEavddF1XczybsE3eHcwe8r7gFWo0
	VBEAsMCg==;
Received: from [69.196.88.181] (helo=ehlo.thunderbird.net)
	by desiato.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRv0E-0000000BaB4-1vOS;
	Fri, 13 Nov 2026 17:23:54 +0000
Date: Fri, 13 Nov 2026 10:23:46 -0700
From: David Woodhouse <dwmw2@infradead.org>
To: Sean Christopherson <seanjc@google.com>
CC: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hyperv@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-doc@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
 Vitaly Kuznetsov <vkuznets@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, Joerg Roedel <joro@8bytes.org>,
 Tom Lendacky <thomas.lendacky@amd.com>,
 James Bottomley <James.Bottomley@hansenpartnership.com>,
 Thara Gopinath <tgopinath@linux.microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Michael Kelley <mhklinux@outlook.com>,
 Nicolas Saenz Julienne <nsaenz@amazon.com>,
 Nikolas Wipper <nik.wipper@gmx.de>, Mushahid Hussain <hmushi@amazon.co.uk>,
 Sriram Nambakam <snambakam@linux.microsoft.com>,
 Zack Rusin <zack.rusin@broadcom.com>,
 Doug Covelli <doug.covelli@broadcom.com>, Thomas Gleixner <tglx@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H . Peter Anvin" <hpa@zytor.com>, Jonathan Corbet <corbet@lwn.net>,
 Randy Dunlap <rdunlap@infradead.org>, Shuah Khan <shuah@kernel.org>,
 Paul Durrant <paul@xen.org>, Xin Li <xin@zytor.com>,
 Francesco Lavra <flavra@baylibre.com>,
 =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@ventanamicro.com>,
 Liran Alon <liran.alon@oracle.com>, Arbel Moshe <arbel.moshe@oracle.com>,
 David Woodhouse <dwmw@amazon.co.uk>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v2_0/4=5D_KVM=3A_x86=3A_hyper-v=3A_For?=
 =?US-ASCII?Q?ward_unimplemented_hypercalls_to_userspace?=
User-Agent: K-9 Mail for Android
In-Reply-To: <avdEkNbqPWamMErl@google.com>
References: <20261113170535.79246-1-dwmw2@infradead.org> <avdEkNbqPWamMErl@google.com>
Message-ID: <5F8F490B-BC93-41EA-B77E-9EC108C09DBE@infradead.org>
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Post: <mailto:linux-hyperv@vger.kernel.org>
List-Help: <mailto:linux-hyperv+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hyperv+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by desiato.infradead.org. See http://www.infradead.org/rpr.html

On 13 November 2026 10:10:40 GMT-07:00, Sean Christopherson <seanjc@google=
=2Ecom> wrote:
>On Fri, Nov 13, 2026, David Woodhouse wrote:
>> From: David Woodhouse <dwmw@amazon=2Eco=2Euk>
>>=20
>> KVM implements a fixed set of Hyper-V hypercalls and fails every other
>> code with HV_STATUS_INVALID_HYPERCALL_CODE=2E A VMM that wants to
>> implement more of the TLFS, such as the VSM hypercalls Windows uses for
>> Virtualization Based Security, never sees them=2E
>>=20
>> This series adds KVM_CAP_HYPERV_FORWARD_HCALL=2E As with KVM_CAP_XEN_HV=
M
>> and KVM_CAP_EXIT_HYPERCALL, KVM_CHECK_EXTENSION returns a bitmask of
>> features and KVM_ENABLE_CAP takes the subset to enable, rejecting any
>> bit the kernel does not report=2E The first feature,
>> KVM_HYPERV_HCALL_FORWARD_UNKNOWN, sends the hypercalls KVM does not
>> implement, and extended hypercalls in fast form, out through the
>> existing KVM_EXIT_HYPERV_HCALL exit, whose format does not change at
>> all=2E
>
>I'm not a fan of fowarding unknown hypercalls=2E  It seems like it would =
be quite
>easy to end up with a mess where it's difficult for KVM to implement "nat=
ive"
>support without breaking userspace=2E
>
>How much code (and ongoing churn) would it be to add an allowlist of hype=
rcalls
>to forward to userspace?  And then obviously require userspace to configu=
re its
>forwarding "intercepts"=2E

I'm following the model we used for Xen support, where the default assumpt=
ion is that we do everything in userspace, then accelerate only what's abso=
lutely necessary in the kernel=2E

Userspace can opt *in* to having the kernel support certain hypercalls, an=
d later patches waiting in the wings already add the in-kernel VTL switchin=
g enabled via a bitmask when enabling the capability=2E=20


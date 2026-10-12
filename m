Received: from va-1-114.ptr.blmpb.com (va-1-114.ptr.blmpb.com [209.127.230.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 416A443CE58
	for <linux-hyperv@vger.kernel.org>; Mon, 12 Oct 2026 07:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.230.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791788476; cv=none; b=e3xOTDh9DKzKfBUAZ2YzHZnOVY2v85N/cCvQ1YutsWSs7zh3IHudXed7ll/h3mZqqQjFHelCXMEPm7HWgeZrRzr23qz24ygWIylbpEen7EzHT6NS2dOi/Ar4//u9Y5wO4Jl6MnpLW2q8a5hkFi7GwPlU0WIZqBsuCZajbbxtorY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791788476; c=relaxed/simple;
	bh=Xk3hbaaEMQ+lW6c3+RYQ4qvYM/R/WfCEOwoYIh/ZUfc=;
	h=Date:To:Subject:Content-Type:References:Mime-Version:In-Reply-To:
	 Cc:From:Message-Id; b=ZzLvQiiD1epeu5r1eE6wcEBzh3aASGNBaRJTVaQKLBQ/DFFpfzdJx0/c1seFPneErsPeOW5LTh/3+lOEWXdqRZLpN5tmgD0zWjrtA9mvVwAbnDTgFRmlcFDfzn4dBP+5cIwekprCHAf91dhPy/pYmoU6VIE3kByagkk6Hgj9m8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=WVjp/Aut; arc=none smtp.client-ip=209.127.230.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="WVjp/Aut"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1791788469; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=Xk3hbaaEMQ+lW6c3+RYQ4qvYM/R/WfCEOwoYIh/ZUfc=;
 b=WVjp/Autx4bG5GFj2ZHkrZpk2KC/ZK4iFphjhhTztNAY++fAx41oYgyeR0gHbxDzR5l4St
 2gBFrG/jLxVjOQx2v2tkXKjoOuxHTLImFB08Io1dsjjOMWdryTGfRweOy30VHhs0sAV2r2
 Ty/8tRrujPrqYN/5+KknoOr7chLgoU1mFkCz/odWCjybN0GHBS2XNdYlqfP5HDtrwHvjmG
 U/0alOxcRZxs99HlpWym6vrg+N8HEc3BIOu01UcfwmZ9FnoLH69G5M+EKNbak0SKPBBFqS
 E4RB1ppeRd2v0VCKHbNjYSsgD3ZG+pgB057+rX5e1cu90a9Z5McoMCFr/TCn+w==
Date: Mon, 12 Oct 2026 15:00:49 +0800
X-Original-From: Fengnan <changfengnan@bytedance.com>
To: "Naman Jain" <namjain@linux.microsoft.com>, 
	"Michael Kelley" <mhklinux@outlook.com>, 
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [RFC PATCH 0/3] nvme-pci: yield completions under scheduler pressure
Content-Type: text/plain; charset=UTF-8
References: <20261009050556.2817978-1-namjain@linux.microsoft.com> <MN2PR02MB6863FBC36CE4F1D6419F0E8BD4922@MN2PR02MB6863.namprd02.prod.outlook.com> <04d88297-1732-4761-ae82-d68c441a7156@linux.microsoft.com> <3f4a11ea-bbc0-4dc5-9720-3447346739cf@linux.microsoft.com> <1c7c7fd9-e2e6-41ac-ac97-9c4d71b1c2fc@bytedance.com> <8bff7953-a9df-4ede-b3de-a4df558946a9@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
In-Reply-To: <8bff7953-a9df-4ede-b3de-a4df558946a9@linux.microsoft.com>
User-Agent: Mozilla Thunderbird
Content-Transfer-Encoding: quoted-printable
Cc: "Keith Busch" <kbusch@kernel.org>, "Jens Axboe" <axboe@kernel.dk>, 
	"Christoph Hellwig" <hch@lst.de>, "Sagi Grimberg" <sagi@grimberg.me>, 
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"Luigi Rizzo" <lrizzo@google.com>
From: "Fengnan" <changfengnan@bytedance.com>
Message-Id: <758e4c6b-1b1a-4191-baeb-3f9799783ee6@bytedance.com>
X-Lms-Return-Path: <lba+26acc85b2+e076f0+vger.kernel.org+changfengnan@bytedance.com>

=E5=9C=A8 2026/10/12 14:48, Naman Jain =E5=86=99=E9=81=93:
>=20
>=20
> On 10/9/2026 5:06 PM, Fengnan wrote:
>> Hi Naman:
>>
>> This is an issue I hadn=E2=80=99t noticed before.
>> I'll take a closer look at this issue later.
>>
>> Regarding testing, there are a few points to note:
>> 1. My patch has been updated to V2, https://lore.kernel.org/linux-nvme/2=
0260826061546.56006-1-changfengnan@bytedance.com/
>> 2. In my experience, when do performance tests, it=E2=80=99s best to do =
precondition
>> first and then execute an ABBA test; this ensures reliable results.
>> 3. IIRC, disabling interrupts in the QEMU kernel does not actually disab=
le hardware
>> interrupts; QEMU still handles them, which has a significant impact on p=
erformance testing.
>> Perhaps you could test this on a physical machine.
>>
>> Also, I=E2=80=99d like to ask: does this softlockup issue only occur on =
QEMU+ARM?
>> or does it also occur on x86 physical machines?
>> Have you tried enabling the =E2=80=9CPosted Interrupt=E2=80=9D feature i=
n VM? Maybe this will solve
>> this problem in VM.
>>
>> Thanks.
>=20
> Hi Fengnan,
> Thanks for the suggestion.
>=20
> I was using QEMU just for sanity, all the test results are based on exper=
iments in an Azure ARM64 Hyper-V VM. I could not create enough load on my l=
ocal QEMU VM to cause a lockup, so I am relying only on the Azure VM I have=
. I would not rule out x86 for this issue, as we have seen spurious lockups=
 in the fleet, which are more common on certain SKUs, but my current experi=
ments are limited to arm64. The proposed solution should solve it for both.

I set up a test environment on my own this morning.
Although I wasn't able to reproduce the soft lockup issue, I did observe
I/O latency of several hundred milliseconds.

>=20
> The guest exposes a GICv3 CPU interface and Hyper-V vPCI maps the NVMe MS=
I-X vectors as guest GIC SPIs. I do not see an ITS, LPIs/vLPIs, GICv4 VPEs,=
 or another direct virtual interrupt injection interface exposed to the gue=
st. Also, posted/direct interrupts would reduce host-to-guest interrupt inj=
ection overhead, but the lockup here occurs after delivery, while nvme_irq(=
) repeatedly drains completion queues in guest hardirq context. So I would =
not expect posted interrupts alone to provide the missing scheduling bounda=
ry.

I'm thinking that adding a scheduling check to my patch should also resolve
this issue.
That would be simpler and more acceptable, we can work together to refine i=
t.

Thanks.


>=20
> Thanks,
> Naman

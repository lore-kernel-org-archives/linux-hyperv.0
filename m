Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA49E37B417;
	Tue,  7 Apr 2026 21:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775597274; cv=none; b=sh85v9/gWVgTT6iULdZTYm6vwSsgqZyQgB4ApXlr+04J9sqTp+H9BoYI+jmnUCEEbJX04FvQmLTeV2cyfGE8hTCGyUEs4QBq2ID0pPKy+bRgaPMlbSN2HQulaZYz2ndfLobFrcHt9q2N/QUgxrp6ooohtJik9qbAusi+Q48LE+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775597274; c=relaxed/simple;
	bh=B4odXIE0QR59wsvp1uOeG7m+uJCzDYHZ+BI5tluJGnU=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=FLAIxZ/WSdvQfLSTCWc/On3i4nDVRWQyVme+ELRyoN50f8EPi5U+/vMq38cZOU+3yzqGZmJsf7h5/cVVoR8uzAt0cXJFUHilhZg8EWgHLLJ7Z4jq+ro9DXL4iL50PBgScsRBw3NjwSEGtuhp8OjxMqeKTeMY8DLeGHl1HQZmouI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=EF/knWks; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="EF/knWks"
Received: by linux.microsoft.com (Postfix, from userid 1241)
	id A330720B710C; Tue,  7 Apr 2026 14:27:52 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A330720B710C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1775597272;
	bh=gua1rJ2//juRcUa6OcrpOLj8Rr8TgNSdg1Kq9K9DKlg=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=EF/knWksSk8uVxu/NNkV9LBoPvoBtiU1/VFaaJhe0eb7oNmi7hDL86PINjm9jrsoj
	 HUp/2g2POUpF6ltsHJlvwvav+fnfWFwtqGrj0le3TgKjJiAHJX+igaWBCeAXgS5hlv
	 R7tAObbdDJw0gnbI2DPL9dGe88dLyKH4H052LoVo=
Received: from localhost (localhost [127.0.0.1])
	by linux.microsoft.com (Postfix) with ESMTP id A0FAE30705A5;
	Tue,  7 Apr 2026 14:27:52 -0700 (PDT)
Date: Tue, 7 Apr 2026 14:27:52 -0700 (PDT)
From: Jork Loeser <jloeser@linux.microsoft.com>
To: Anirudh Rayabharam <anirudh@anirudhrb.com>
cc: linux-hyperv@vger.kernel.org, x86@kernel.org, 
    "K . Y . Srinivasan" <kys@microsoft.com>, 
    Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
    Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>, 
    Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
    Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
    "H . Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>, 
    Michael Kelley <mhklinux@outlook.com>, linux-kernel@vger.kernel.org, 
    linux-arch@vger.kernel.org
Subject: Re: [PATCH v2 4/6] mshv: limit SynIC management to MSHV-owned
 resources
In-Reply-To: <20260406-ninja-civet-of-tornado-67ff54@anirudhrb>
Message-ID: <134ce833-544-24eb-883-b190a888b31c@linux.microsoft.com>
References: <20260403190613.47026-1-jloeser@linux.microsoft.com> <20260403190613.47026-5-jloeser@linux.microsoft.com> <20260406-ninja-civet-of-tornado-67ff54@anirudhrb>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Mon, 6 Apr 2026, Anirudh Rayabharam wrote:

> On Fri, Apr 03, 2026 at 12:06:10PM -0700, Jork Loeser wrote:
>> The SynIC is shared between VMBus and MSHV. VMBus owns the message
>> page (SIMP), event flags page (SIEFP), global enable (SCONTROL),
>> and SINT2. MSHV adds SINT0, SINT5, and the event ring page (SIRBP).
>>
>> Currently mshv_synic_init() redundantly enables SIMP, SIEFP, and
>
> The redundant enable is probably a no-op from the hypervisor side so it
> probably doesn't hurt us. The main problem is with the tear down.

It's an MSR intercept. If we can replace this by an "if()" we shave a few 
cycles.

> An alternative approach could be: check if SIMP/SIEFP/SCONTROL is
> already enabled. If so, don't enable it again. If not enabled, enable it
> and keep track of what all stuf we have enabled. Then disable all of
> them during cleanup. This approach makes less assumptions about the
> behavior of the VMBUS driver and what stuff it does or doesn't use.

It would, yes. Then again, we drag yet more state and make debugging more 
complicated / less clear to reason what happens dynamically. I had been 
debating this briefly myself, and ultimately decided against it for that 
very reason.

Best,
Jork

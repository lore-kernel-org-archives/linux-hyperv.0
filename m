Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.171
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792602514;
	b=4V0G/yWRwrbj7/JkvGva7nzhhy3VDqhPT3PRa1abu96LjGdRmklBxcckO/hO8rO80KgS
	 2/2Xqc6q97poyYo3CAGn/pQC/rFmkBP7U4XmIAEXj2gP8j0ReL0t2AVGGFDr4DhxIV3CC
	 MWorwLWUufLHv5lDqH2nIf3g6TQ95kAtKBP/QzQjQzAAlTrVzDPxvkfNmbV99oUxV4LXv
	 Xo6ceUp+TkLyo4singOyZR3PIbDJHM9aQKE/LH/ONfuAt1/NBvDOO2lsIbuiskw5bL7Ek
	 3k6S1vvIyg/RROhdHtjOqcrgVWCKTGKw1lvbQuGq3d1IxThkc3PeALzj6RJebsPvAYQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792602514;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=fGCGePjfI8XXuGHsrc0ohceeeEG6k7P8lw+rhpyAdzM=;
	b=GfqlUosUb9uJx1H8HQs+3lb+3JXMCsleOOdZabike0+C/Toq71V73801bQtIQ3pDTADi
	 hHFzLOtOpSRVQyxJujcQymCwMmYM6Qt+xwWTnaaGj4qu2viyACOIBN24Y1g+m09g/mjGW
	 yUqFdfsRG8QV/edRkGyP9wFOZ4NMrjuiespflyGE3IFCMS1ZaskWVAkbFyHu8ysOd5fB2
	 c0f1ujlfS6xJMA0K1aLkIGLoYhkAaXHMmjmaN9+et4UDlKkE9fyqQRDjs0BlJJF+KKJvL
	 DuCfcCmBFY9uZ+xyCOt5OSmJEQL9MG9MZysO0vMS4r7ATd+xwozSDYOaeQw7OS6+o9A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Zv9mNbCB;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.171
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29EFE606A31D
	for <linux-hyperv@vger.kernel.org>; Wed, 21 Oct 2026 17:08:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 29EFE606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Zv9mNbCB
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-3ab07d956f2so6291711fa.0
        for <linux-hyperv@vger.kernel.org>; Wed, 21 Oct 2026 10:08:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792602512; cv=none;
        d=google.com; s=arc-20260327;
        b=P0CkuwanSSjqifFfC0lvrT1Ug1lqCuZLMxdHECXUI2uiSDS4b9ThDx8mDFNw2QlqVf
         pbUXZAOQjNQZRAC8/CUnYov2q4oB3nTIw708GUVONzytr22Q2h1xWtXLw40H9wP7Qjyb
         aZgthHO7qi+kD6myhxpJIGOfsJMo9Y/UsZP8t0QbZmzQZtEfd5emwQYoqH9zdNDo4xwk
         nfWspqeu6d6zsPXFw41YYT/NeHtWNksMEocCEDwjuCfgbc7o5gxEZ3A8RcIIgDYui9zv
         3QKhH1wgUhbrTHRqopHGKxpFqYZKhBuIPDPRu3jsduQqKv+QSdNrp3NlzNMfo6X6vgyf
         E6Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=fGCGePjfI8XXuGHsrc0ohceeeEG6k7P8lw+rhpyAdzM=;
        fh=Uq2xn1zpG14dowgpP+CFEkm62k0D2DZ5scfkKqVmyS0=;
        b=T70jBHaPsbggwdROEZMu29P/3PcNbQOtoFEZy5I/NGgmGBtIQDmCJTxA91qR0vDTcq
         LVTvG1jGjQggDXpnJwSw96J6PcKC5XZj7K1XOWPbK2h/woN+x8zh5k4ir7OF7Eb7nwqy
         ObEfeSZq1ra/LwrDO01wSu9gA+GDfLnWu33s/H4RHJoF10B6fZQoGbPoWaI6OKSID6lK
         VoeSDA5iC6hNUGnfuTtNYC9/R5L108E6mpvhv3JaBIVZ4IRr6BUWRl1vIBGNg8jJB3ek
         UxaRaQixbZq6yhCm+mJE4pH2WVLEBhU1gcHg4jAlPYIkHSW9jMrqlJbkp+5ymoiRH2kQ
         pDYA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792602512; x=1793207312; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fGCGePjfI8XXuGHsrc0ohceeeEG6k7P8lw+rhpyAdzM=;
        b=Zv9mNbCBqDhn0djUp1ft6TyzbbWXWgYiBxpOGnriI2ekUCE+VtPTgnJI0nj5538Qty
         nWC+VbfES4c9ruBxf+x1AAJnm+GxvBw3P8GPFCbMMXwFxnhPH0BEoTCYg4oBdw0t+AUw
         o23nnSkwr0OpaxOpHrO7q7+6ElPDKIjw46lzhiJYoh07wmir4/IiHMjcYHGAzePGOJG1
         kUCnH8QPnexeoB3qxfm1A3ucseoXQ3M8oOQYh7ol2nxONOg/ajPzMyk/btIpNdDhJXup
         u1++3vUUJAGiqv/qQX9siWJtQ0cBrLyo4f2PjhX0mcDbsVZJFOeiD/H+f8RzvJ66C2DS
         SGOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792602512; x=1793207312;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=fGCGePjfI8XXuGHsrc0ohceeeEG6k7P8lw+rhpyAdzM=;
        b=BCVwzO28GUem1Y4i/eLOE8k5UKGBOX+46GYJ0g/BoRD9tJCXO10DVwg7ElAWliiiNI
         ytkGvze9sdTwP7onCg2QM+ZMB7De8VhiVFmEg38Y2+DuSH4yUBFO6sQdDQEZjO3+HKWq
         RqGC9QB1/cHvx4vymjA7QavwS7C+9ji9bK2yfRQ1JXDpwau9Cgy3IuXGmbiB5rkMYYKO
         8M3mb//ykCzV69Hbj7WB86DxRKo2TTOfAV+UH8wtGB+/mKmINSitfBWlzinIhb2fHXbS
         ER8OEYH0Vk/Qnj87PNqLAnJjgZPJr3Od1we2bHGPYPYlV6VBUQPvRUp3YB7B2jKMQHGh
         PoQQ==
X-Forwarded-Encrypted: i=1; AKwUvBziMY8f1q7w7GSUxZygnG1Lrqux2fKMzt2fpqIKlobo7PEBwyWWaNkBRPLuNYtvZzYm7YpgoiC7FNvAyk4=@vger.kernel.org
X-Gm-Message-State: AFq9FYLmRVLDczsri+GmQdaMpRH+jNt4UXuY9BWkIcZXB1CIDPVy7MLr
	Yzfg0P3gQL2XzCgbUgyGOMiWt/5SJxAkvKYL0sMdFnrRHe6MFPMmTbseXpxhZhWhSXB5g/Ogrhy
	nKG8+oA5iYN1JZQD2TZuJ7M8aqHVR0ewgaiAe
X-Gm-Gg: AYBFou18FKaEtFgvSvYH0p2BwHZoygG66fhPrvT22UkN1QIlffSMLRXwXsXa0ZcouMt
	x0JYW1lDi+QMLK7Rk3n7Lk/ohHTe+LXNoel9hBqeS24phDe2iLdB1+jkADrmExMPJuTPaC7RoyJ
	0p0RqrlVralmXr/EfT3b2GS+qqfn1Zn3hFOrKIOwamWoaigrrnwIJb+52f66mMbnIhDXz1SFL5n
	RRelgoB05JA+Cen77hkpl+OvhYQTxwiUmz09TqczGrH4KUjaT/dDb7yl+hy0jY7vVUa315MTdB1
	I0N0/lWjlMaQ2EF4/dupRDgHgS6B3GMAtDTxjEfGYlluiheeMxg1RBpHa3rhWEBXxe/wz62i9uI
	Gv3ysGjRekWo7lLtcbqmCPatpBivJC8I4O2Bk
X-Received: by 2002:a2e:b8c7:0:b0:3a9:d9db:61b0 with SMTP id
 38308e7fff4ca-3ac441b9da4mr7661721fa.24.1792602512104; Wed, 21 Oct 2026
 10:08:32 -0700 (PDT)
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Post: <mailto:linux-hyperv@vger.kernel.org>
List-Help: <mailto:linux-hyperv+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hyperv+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261012042851.389128-1-oss.patchbox@gmail.com> <20261021071853.GF851443@liuwe-devbox-debian-v2.local>
In-Reply-To: <20261021071853.GF851443@liuwe-devbox-debian-v2.local>
From: Yuho Choi <oss.patchbox@gmail.com>
Date: Wed, 21 Oct 2026 13:08:19 -0400
X-Gm-Features: AclHuK_5n4DvXcr46txfd26PyChDfZ8Vzl1LcIm1g1VksjW8svHx4dm9Csz8zzw
Message-ID: <CAGG=RgAxjGkcMC9NjxqrCQmbgordQeZ9vqAFayuRo5q1sY9ZxA@mail.gmail.com>
Subject: Re: [PATCH v1] mshv: Don't free overlay pages after a failed unmap
To: Wei Liu <wei.liu@kernel.org>
Cc: "K . Y . Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, 
	Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>, 
	Jinank Jain <jinankjain@linux.microsoft.com>, 
	Nuno Das Neves <nunodasneves@linux.microsoft.com>, 
	Easwar Hariharan <easwar.hariharan@linux.microsoft.com>, 
	Praveen K Paladugu <prapal@linux.microsoft.com>, Tianyu Lan <tiala@microsoft.com>, 
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 21 Oct 2026 at 03:18, Wei Liu <wei.liu@kernel.org> wrote:
> I would like to get an error or a warning here, too. Can you send v2?

Thanks for the feedback.
I will add an error/warning log to hv_unmap_stats_page()
as well and submit v2 shortly.

Thanks,
Yuho

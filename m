Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.168.131
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795505878;
	b=CEKZ0OZUzqMCYRaNgTI/tNGZVTqpiQdDqKCmD+CxRRE4afpFuQtxZbIIOLzUMleMUXS0
	 ohYYaxt3Lz6Uo0ojDPDMc+nj/6RuH5V3KXpcniNS3uqycgaDdfTl/ccEURn33N+k7nG3m
	 dOUq8jNuTxYaBy8I40XMUyQ4lLwK1SlTPK9qpHh5hPslFRnejMuIqIRq7qB6A0qgzdX9U
	 j+PD843jfLC2mpWJY0arN7+xs0jpZTH9oGG8fwAjnP8l4O5u7Ha+PbAwV9xuap/QECKgi
	 NPEiG5Vriuig9+Z6sWuobqcpJ1Iptns6BLMZsm8qB5cObyosIP5yquvHS8LHnZCGjPw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795505878;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:Content-Transfer-Encoding:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=WLDBCseQttjsh+YgjaRZ95arQzmquJXtwPce4pg+uuw=;
	b=idvXtUFDeRWIvHL8s9Jkmtb8yPHZixFrThEBHIMJcHV+7G6MDLbMZZpqffqDaPe8EtUK
	 QFpuEKJVTUkGA3R596WKHqxawFAWEJJ1ZOh+/MI048diqzdJPSEoBRNvtQq1cuPMpvDBg
	 CxBABsnARBV/9Mj/IbWo40zC4pS8DlWgcXmOWJs+0iTblkbGSevGlvX9HC/4bC4/4mDn3
	 SGwIqnd7X9s07h7qT/l69iqYeecNVbheXG90A75/VPuplrummT0L9LnsjY6MPE/J0+M0t
	 rDpxK6xnXiI4P96Odc8HMeSwIKTta20cHg/0J9Yza7EmIi79JVKiCpFDb8fpWPrfjYg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=jB2OhFnb;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=S1+Iax5U;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9292606A333
	for <linux-hyperv@vger.kernel.org>; Tue, 24 Nov 2026 07:37:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D9292606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=jB2OhFnb;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=S1+Iax5U
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AO2k6F23225397
	for <linux-hyperv@vger.kernel.org>; Tue, 24 Nov 2026 07:37:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	WLDBCseQttjsh+YgjaRZ95arQzmquJXtwPce4pg+uuw=; b=jB2OhFnb5kcQJfBh
	9PooZCIYHGNUVjDcGwumXONQT2rphRiM+HKb+Z5rBcfoZ9URBb6HmUCKyU398p1z
	0DE3n1unAJCPGSKA9qHqDKxoWrwnFiNfWRaB4F0mZuQ+gIyw7qVkk0rFFWIT+hr0
	xlGvD+nbKD4m1GM6eRm0zn5N+zABS6NWAAQ4zM+xLUUTfkXPLcKrmGNQSuaj6NVk
	LSMFCUkYtOrVzKgsE9JjRJp/p/+NgBxqv/l5UGfpSyCfsEnsySH6HhHWtAFvnFTH
	QiJHfUK8nig+0y+RvbrdRu8nHxWlPz45JWmVSfVxj87VvZ9rM/3qatNGi8g/YvkN
	LVZ85g==
Received: from mail-yx1-f71.google.com (mail-yx1-f71.google.com [74.125.224.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j4x8f1sjp-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hyperv@vger.kernel.org>; Tue, 24 Nov 2026 07:37:56 +0000 (GMT)
Received: by mail-yx1-f71.google.com with SMTP id 956f58d0204a3-67be4f2f42eso7121960d50.0
        for <linux-hyperv@vger.kernel.org>; Mon, 23 Nov 2026 23:37:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795505875; cv=none;
        d=google.com; s=arc-20260327;
        b=ZPS4P+8GWhL8dDGarcTN98RWkQ4Bk7Dp1OleXHc96GPcNl5bRUATPUVaiQcrNUXSOv
         VdU3s2IcU9dUvrmLOeMCHfy9NMrTev+GxFssOpXjnB2iWxbTPV2LfIo8n3OWIZhQziGc
         Kg/Y58y9JptBOUTOm4R12fTwLo+5uQS/3miIELUXJHYkF6zG7SkYRifjrAF+1zomZgBr
         rS4lIJeV/5unrq0FY48D5fbEfOC2SeGw/hemdl9r1JShxxl8gRvedWVwP6IBTCPyRm0C
         HreXZ6vBMiqxD0pQw/1JldA7h9Tu+Qze1nMXmIjvN6CsS9/cSznNUzVSMHRVQdEF7rar
         DEsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WLDBCseQttjsh+YgjaRZ95arQzmquJXtwPce4pg+uuw=;
        fh=fBDR9PAt52KcmFRs9pZR3vnrUywQTGm+morYSPBZ0rk=;
        b=JF1kaSXJkw8oapPGPUZaPPIZodgM6I2Et1zESy2lz80VBfVEqo2an33w70o1O/tVjG
         c2Q7HWzmwA2CQJqSC97gNevMb1Ca8N9oIzL6eAD4wUUmkpu91h+46IfM9WDr2pkxCYZ6
         odjWnCBzJRO0FLhzT5AMA65TqbKoZaMokYK6+IJ+xG1eQC58w9ZoU7j7UwNEpIAo3Zi/
         IBbhDkEC52otpc4edsL87wLiQE5QqS63/X9++we0woVq5MJPGdb7wmcflzI7b2HJvseT
         ZzWOQf1nhlK2QiIjGfA7S19i3sXbe0EWhzLh36vPQ3JtyAbgwZVN5QJE0sWzH6BnpO3H
         +dhA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795505875; x=1796110675; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WLDBCseQttjsh+YgjaRZ95arQzmquJXtwPce4pg+uuw=;
        b=S1+Iax5UjwdrBfjmC61+6GR7Ef9vLvndZMhbV6RF5f5jjGfM0fKOFIGSb9cZxbE499
         ufQ0Iw9iW/MkroytuRNTzxKljpJElsFF8w9uRLGP7Avq+RZTb57Ul1XAJRZ5qQA1kqxg
         7jbG878tFdG6DzFw+/37L1jhd6FV1aCc7/cXrp+cfOfsQhmbgR+jpkWB2+0CyWhWN8/h
         yrF5TtN9QZy1tEKAfvOEpPuv5AnxPa6u6OCgoeLhGxjDwK43OfnV/PUQdhSEXPtDxnYS
         FFlkC6lp8vy68Kr1OCdhQERS5xVbG1XGyggIdSHRH/KZmZy1PSroQztV131DD4SIsduA
         xQvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795505875; x=1796110675;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WLDBCseQttjsh+YgjaRZ95arQzmquJXtwPce4pg+uuw=;
        b=HiLmjUr8VQf7MEeLtJ86QPORuNs/23uqRe1sLTBVxaxeRNEQuUGA67XH9smyvp8FHV
         +CbdTYqa6D9SPfk6BvftVpdiFlUp4r2y9gQkb5zXrTmuaTTy4oH3R6tHx5FA4/5mfa1c
         CP8gCvgMx69xrL5c8bClzLrI9Ha1Xpbt1qmKHAuF0Hhh1NeSrt69c31nMRlUlyUt3BGX
         SFdp/UFc2K0CKYs+gi1+p4osiNCTerRGOPiNxKqmN1yl0bsfzk1okKFHc2SwoNEwrDnJ
         11Snh/HhUJ7Wgw/y3hmRQ3YjlQ8pd9c2fNXhP5B1Q2E6T9laoevAp1fWrclOOvoZwlSU
         yx4w==
X-Forwarded-Encrypted: i=1; AL+hErGAkWJsD3H37mDqTjTtA9YQcslBMpnVpuhCb2sVn/c/YxHKYY7H/oLG8IO3bP1ye5WAZ7CsL03tG0GY7/o=@vger.kernel.org
X-Gm-Message-State: APuU4Z+NbdxzkiAG2r5ych/Us9tIb9JRBi3h/J//X5SJxyZa5v+gFdrL
	J3eU32UOKvCQobOm3f2/yiWQBf0dVQacA/bQNfEVEFZlu/FOkewQIOYU/3iEqczQV/Sofi9r86a
	AfnWU8LMO9cSYfpf8+r28e4RjoXWYMM/kCU7UxEDZdxjrTsbzTtD7RR8BMpG921WVIQfDrwLTxb
	gCd647kc6gBoTDsP1FI3wu451REemGjF6X0xjOZHg4OA==
X-Gm-Gg: AZFdTZcmJsGqUNtv0PYFghTUutxawf8+ocl3M8YTAG2wSKDJWKW3gTLraDcEyxVPmt0
	Yaa1W28j6V9iuiEkhyYIcYxFFrkh92fTHEAyvnTuuPYL3FaZXeDqwB7QH7u46ppBmHpHEV0vF7M
	Ix2fmgXHjfF/ks6byANkr399bZxYsorXG8tgiw42GX4Zle0G2ZYD+vOJs164W8I7NOerPsvhAJA
	T79sZqjCPvOaHe73NkT3kHbCCf3XszKGSMVPiGk
X-Received: by 2002:a05:690e:450d:10b0:677:cbfc:be28 with SMTP id 956f58d0204a3-67df447c2b9mr2926870d50.75.1795505874943;
        Mon, 23 Nov 2026 23:37:54 -0800 (PST)
X-Received: by 2002:a05:690e:450d:10b0:677:cbfc:be28 with SMTP id
 956f58d0204a3-67df447c2b9mr2926857d50.75.1795505874551; Mon, 23 Nov 2026
 23:37:54 -0800 (PST)
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Post: <mailto:linux-hyperv@vger.kernel.org>
List-Help: <mailto:linux-hyperv+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hyperv+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261105-late-2026-mmap_prepare-v1-0-c56aadfbab8a@kernel.org> <20261105-late-2026-mmap_prepare-v1-11-c56aadfbab8a@kernel.org>
In-Reply-To: <20261105-late-2026-mmap_prepare-v1-11-c56aadfbab8a@kernel.org>
From: Jens Wiklander <jens.wiklander@oss.qualcomm.com>
Date: Tue, 24 Nov 2026 08:37:43 +0100
X-Gm-Features: Aa3M54q5vxZ2pH5GHxV6_gcu1Tnc83EBXhtYw1pJ9H77Fl7U3CQoqAKpEumRrbk
Message-ID: <CAGgiveX=Z5gS7iJWBanyysVUStDRbgTnVktQwJySXw_-xL+sUA@mail.gmail.com>
Subject: Re: [PATCH 11/14] tee: convert shm mmap hook to mmap_prepare
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        Shrikanth Hegde <sshegde@linux.ibm.com>,
        Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowangio@gmail.com>,
        =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Jan Kara <jack@suse.com>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        =?UTF-8?B?T25kcmVqIE1vc27DocSNZWs=?= <omosnacek@gmail.com>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@codeconstruct.com.au>,
        Ryan Chen <ryan_chen@aspeedtech.com>,
        Billy Tsai <billy_tsai@aspeedtech.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>, Jens Wiklander <jenswi@kernel.org>,
        Sumit Garg <sumit.garg@kernel.org>,
        Scott Branden <scott.branden@broadcom.com>,
        Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Richard Cochran <richardcochran@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, xen-devel@lists.xenproject.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        kvm@vger.kernel.org, linux-hyperv@vger.kernel.org,
        virtualization@lists.linux.dev, linux-sgx@vger.kernel.org,
        selinux@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-arm-msm@vger.kernel.org,
        op-tee@lists.trustedfirmware.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI0MDAzMCBTYWx0ZWRfXxgTrvhsS3noF
 j56+im7jq142mRyowGq3YmOe3ntaSD9eUaPEu5LCNFFXqjgs7+AXQU8BWdXKpR+OxTTjbALaVk3
 00xe8I3CPdg7XFB8zeZ03i9ErW7N/0U=
X-Authority-Analysis: v=2.4 cv=JbgpPkKV c=1 sm=1 tr=0 ts=6b053ed4 cx=c_pps
 a=ngMg22mHWrP7m7pwYf9JkA==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=YMgV9FUhrdKAYTUUvYB2:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=97S62Xg_vF6B0O42EdoA:9 a=QEXdDO2ut3YA:10 a=yHXA93iunegOHmWoMUFd:22
X-Proofpoint-GUID: 7a2pEPZfOnrtFkQ8xQgvVtBg9SZJ5kRm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI0MDAzMCBTYWx0ZWRfX0W/f7jvxg8gL
 JBK3z7F+y//18/UJHh+AlSUkjGztetYS2WmoNagDw5iact2zXh1K2OWob74pB0x0D1sVKL/lTU/
 dx0XbWgkE9iErNqFMNWYSYKQdUBx2xn47FEVBVhs82LJ7NuWA2NetwybcafhGIxGXzI5G5fbkft
 iWB/aMY6BgvcgMKw5AeUw9NjqdPT2hPgIM3iCovR6I2z1kiGzM72WJJoDvgg52clihfjNYTGwtZ
 0aEI9TLwghGHWjYDFeq5f6iLhWIladIfCn7M+c/8YOoouuk6s4kZ1Ay5UAt9mPvjOJZG5dXgeQr
 rd8tcp5kyYg8FeW6GMHH68ZNk08MOjgp5GY9nDmXYepW/Q7QSVcSAAOjTlsuQmGBbF4Q/Hew+mm
 HtBI5UPJpZU3uhyO9Bl8nByyWPNkvGwQ1py5HjKdUJLWcEv3SriH83/3BrjLUhFT1Q8i99jCels
 /cY1/CMuWfybdYBXIwg==
X-Proofpoint-ORIG-GUID: 7a2pEPZfOnrtFkQ8xQgvVtBg9SZJ5kRm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-24_01,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 lowpriorityscore=0 malwarescore=0 spamscore=0
 impostorscore=0 suspectscore=0 clxscore=1011 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611240030

On Thu, Nov 5, 2026 at 10:08=E2=80=AFPM Lorenzo Stoakes (ARM) <ljs@kernel.o=
rg> wrote:
>
> Move from the deprecated mmap hook to the new mmap_prepare hook, using th=
e
> PFN remap mmap action to map the shared memory.
>
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> ---
>  drivers/tee/tee_shm.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)

Reviewed-by: Jens Wiklander <jens.wiklander@oss.qualcomm.com>

Thanks,
Jens

>
> diff --git a/drivers/tee/tee_shm.c b/drivers/tee/tee_shm.c
> index daa4af1e089e..8fcbf0232aeb 100644
> --- a/drivers/tee/tee_shm.c
> +++ b/drivers/tee/tee_shm.c
> @@ -567,10 +567,9 @@ static int tee_shm_fop_release(struct inode *inode, =
struct file *filp)
>         return 0;
>  }
>
> -static int tee_shm_fop_mmap(struct file *filp, struct vm_area_struct *vm=
a)
> +static int tee_shm_fop_mmap_prepare(struct vm_area_desc *desc)
>  {
> -       struct tee_shm *shm =3D filp->private_data;
> -       size_t size =3D vma->vm_end - vma->vm_start;
> +       struct tee_shm *shm =3D desc->file->private_data;
>
>         /* Refuse sharing shared memory provided by application */
>         if (shm->flags & TEE_SHM_USER_MAPPED)
> @@ -580,17 +579,18 @@ static int tee_shm_fop_mmap(struct file *filp, stru=
ct vm_area_struct *vma)
>                 return -EINVAL;
>
>         /* check for overflowing the buffer's size */
> -       if (vma->vm_pgoff + vma_pages(vma) > shm->size >> PAGE_SHIFT)
> +       if (desc->pgoff + vma_desc_pages(desc) > shm->size >> PAGE_SHIFT)
>                 return -EINVAL;
>
> -       return remap_pfn_range(vma, vma->vm_start, shm->paddr >> PAGE_SHI=
FT,
> -                              size, vma->vm_page_prot);
> +       mmap_action_remap_full(desc, shm->paddr >> PAGE_SHIFT);
> +
> +       return 0;
>  }
>
>  static const struct file_operations tee_shm_fops =3D {
>         .owner =3D THIS_MODULE,
>         .release =3D tee_shm_fop_release,
> -       .mmap =3D tee_shm_fop_mmap,
> +       .mmap_prepare =3D tee_shm_fop_mmap_prepare,
>  };
>
>  /**
>
> --
> 2.56.0
>

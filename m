Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96D07474274
	for <linux-hyperv@vger.kernel.org>; Tue, 15 Sep 2026 22:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789510894; cv=pass; b=j6Ycq+RioWV5bcXZ5rXnEpcHGIfDoJU7S+VUc3uRLLmlUr35YDI9iNIFkVwU79Aj7a9BgVcOAKmg5RsZgVgTO5v41qs8Q2L1T6Xi+MQ/t40S0A0MyT/Udl/KQMddwRxHgbO1i6M5SqUbnc6t22+ZmoQA+pfg2oIUyL19EbY20ws=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789510894; c=relaxed/simple;
	bh=zMEH3dKvgIFeOLNgenpgNKtSSPQyo3I2Bi4hOFPx7Sw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hRjEY6GhYqeNtkIuoHAh48h39NdOEHEWD5TdcUWEB6SQs6iGQnyKRjJCkX2jC8ey/BZ2DUVNZdPfq+KfSHDyWbxcncMsv2XSZn+xs2IMlKdEOlZqJM+GuHbrjdt0QfvJmNDRisrzhm0bDexRKKyiEGE6rLJ1tYiJQtUfNk9YGso=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IV/k2TQj; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=aB07AtjI; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IV/k2TQj";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="aB07AtjI"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68FLZ0iH079873
	for <linux-hyperv@vger.kernel.org>; Tue, 15 Sep 2026 22:21:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=
	qcppdkim1; bh=hnJAniUUz5UpK0eAzqlFlmnyP+PG3E6KxIttKsrRd1w=; b=IV
	/k2TQjkUrsTGpshqW8f1AkLpzgE6WqJLnJXyVNHKYz8mozA+vLQbIOpShvI99Nvk
	BGk11nj45xZQZMebNdo7NiYw/EO7W5wcvHVc8eAkRKtGrNMclkKkbe3unomYvdUd
	vFaT1byqggr1zubtRjDzuTG9pECEQdOzFAiv4kdIU3d7CXM0IsQ27dhrP8NvQBkU
	TlOdMgPnM8h4FF25SXM2n03VFD94RLvjnLlaGSHHxie20ptztZeSDX3B4EelrzMT
	n1DLEJiB1mKEp0dVH3Si7JCiMZpC8ZcIigaByfbQDV2F2ANWVcL1rru5kNRyAlZ9
	ag1DWjYpUlLQQuGalXdA==
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com [209.85.160.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gqageh57e-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hyperv@vger.kernel.org>; Tue, 15 Sep 2026 22:21:31 +0000 (GMT)
Received: by mail-oa1-f70.google.com with SMTP id 586e51a60fabf-4574f1cac98so10163381fac.3
        for <linux-hyperv@vger.kernel.org>; Tue, 15 Sep 2026 15:21:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789510891; cv=none;
        d=google.com; s=arc-20260327;
        b=h3PG2sCXBB2XF2br+6blEIk5Mnus4v7KSY7eSJrRqqQnpUd92pQ/YA13svbZZQl4dz
         +v9K9PMZNNhToZ6poc59aQGo/Yn/Orunbxweou8w0TlZ0XfSMywTHcvAXUTmkbWSdUq+
         rmS6OFmnN7aRkdPkKkCml8kjQgOT1C/TBBFjT5FGexdpG6JRB69PeeKj6jlbu6dD8iUv
         HuT75e/V2Sw++Vqq4wnVkaWr0HfcfS0W2570I5lU2kWmsCoMqQ4JD2v8XoFo15wV3SgB
         vxeLrowOBnu/o7ViWYdJqItfKzq90pAYOHtGTWa+I8zeMx2Iu7h1lvKtNAHVLbZ1n00p
         VtjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:dkim-signature;
        bh=hnJAniUUz5UpK0eAzqlFlmnyP+PG3E6KxIttKsrRd1w=;
        fh=5R7aWs4qQWiyasyqb4ltCPS59hsxdvsRLfAqA+UDg1Y=;
        b=n5iQyop3qfM6Aot5uF1F8EtMNrJ2HiGwwT4ruZfBUw/ZTlhCi0Q2BY9+keX/0wsHVB
         BGKioHiookf2ecmvFK3koiza5GinSUx3VYGNrc8iU8nNxZqftYIgGx2NWHbdR0NDVg4q
         LeZv5npBuBIsDfw6a5tHW3vypsMkbo7N23DUNfdV59otenDkOd6Km/8MdNFRbs5k2JPQ
         9rl7vJLVY9fyHTX/UFzIdHr8BZeOUaUeL1cryIiIH9rEhP3o02htjjAKSHIqwDXWE/WL
         gap62KGVCSKA/JwbH/2I4t5tjX75JtmLvqPyVdjV+4vOQ9r5zRTsmyj8g8a90OvN6whT
         ip7g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789510891; x=1790115691; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:reply-to:in-reply-to:references:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=hnJAniUUz5UpK0eAzqlFlmnyP+PG3E6KxIttKsrRd1w=;
        b=aB07AtjIKjPYRGcvBSuVUhbZlxd1+55zy/NhIuvnz19m7qssQTpE/4jhghs82a98Dx
         rtzGuCLITyYJpv6qqsfwRyWf2V/rvp/BavfnHKk+3jeYdHSZJCYDfk5x4efzm884vIfW
         UjGKSA8ySqC+bc1butY/HkkuCwEw+HH62Uipjk8j8bjqvTXRubAdUvP+c5BJvALTKQeE
         2MFV1Wjr7h5QJcQaotkuVTv077nzlClUSJUJjEEq6X2ukv02bdE+qejZx/+uCM7gRcPt
         xEQKVpHKyQ6abdYF/Q1vdcAj2ZFa315JGdv0g44dh8zUZEwY87qYbRStthdyfxwDukm3
         Mbpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789510891; x=1790115691;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:reply-to:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hnJAniUUz5UpK0eAzqlFlmnyP+PG3E6KxIttKsrRd1w=;
        b=jzvcNRfBIlSOsPwBRPv2DAoTRR5wbVWexq1zusjD4kOf5FytDOV8TjnqVLkP+CEV3w
         xpHaEuMQnujhfXeGQXmDB/YiKlM8qNNzFFMjlEPNmz1npgLiI/KNl9L7kYrTRQL1Ei/2
         ERR0RWrU6dyZ/8T1jd0qCHSuZqal4r4PX/LU8n0dRaBT1y9aXmL0MN6fuI3BX0SWJPbP
         qdoeRKBLsEvaMmsGR6ZYDG1VN22qW2tkGzXOFDd8lHXl7JjhJ6F3qxqrOQu7lSNGXVU9
         bq8bnOoL8dWaxkrDP9dXsvmZZYY45sNsmNC9yP8LEZsdaYPpsCHphz230fWQUw35cI0n
         415w==
X-Forwarded-Encrypted: i=1; AKwUvBwytkPYiRcvT1osou8mGdKHLnneV6/ptDF0BWHxCW7yUKzcB4pjcLxSf9NIxDkvkodXXzxCoVgRdaaFEYc=@vger.kernel.org
X-Gm-Message-State: AFuF++nJ2Lp+CmsOxx5FK8+D8z74xPZg8dxFTE+YvTxKoDTq9cO63Cvl
	t/mZojKXNuTm+hoAsvEFOU7kFSN4b7OrZ2vDxgPjSbfFf1jKUYx9V58bZ+YICbaoZmCd49cWGvH
	Q4zXzbvjGS7OFKkE56w2PCGnINn7VFa9MQVdF7BdN5CLFohs5t/DRQ3o/4PIlHqPAaoQM1zEvcm
	JNCMvh7Gl29J0q1faQMbSTestgp4GyM2C5v1oK4mHLKg==
X-Gm-Gg: AYBFou29YN9+kaCcyvgUypsvmCbqQAJEVYTSH5MTs9Sr68xyHKylRUGpDb1p3INhT7c
	0JJTyogNDRu/6OZS3macgpRZUwu6GOjbL6L8JKWk+5anfeyzXD9DyjpTBiP432dl07iLep+oYLr
	SlXvp+RIe1BLSiVa9z04I1Mo5T+sOKKclYcS1Myus0YErzeedzEszJlDbZ
X-Received: by 2002:a05:6870:30f:b0:45e:2de4:95f1 with SMTP id 586e51a60fabf-4847584c51dmr189757fac.2.1789510890849;
        Tue, 15 Sep 2026 15:21:30 -0700 (PDT)
X-Received: by 2002:a05:6870:30f:b0:45e:2de4:95f1 with SMTP id
 586e51a60fabf-4847584c51dmr189724fac.2.1789510890430; Tue, 15 Sep 2026
 15:21:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260915-work-fd-reserve-unify-folded-v1-0-4d5217d6b246@kernel.org>
 <CAHk-=wjeamU=_RYT9cR3dZJ2N-Teo-N1+aYh7jwhrB=iWXD0cg@mail.gmail.com>
In-Reply-To: <CAHk-=wjeamU=_RYT9cR3dZJ2N-Teo-N1+aYh7jwhrB=iWXD0cg@mail.gmail.com>
Reply-To: rob.clark@oss.qualcomm.com
From: Rob Clark <rob.clark@oss.qualcomm.com>
Date: Tue, 15 Sep 2026 15:21:18 -0700
X-Gm-Features: AcwNN1UxxSxAxz0XPK7niSod0Tx_HsUs-C3mKdcqDSaFkh659BGkCorPygYZGHE
Message-ID: <CACSVV028AdnTYa6OKDeoJYCau58uTkKMgEdqTn7crNSV8QZxOA@mail.gmail.com>
Subject: Re: [PATCH RFC POC 00/50] file: handle files on syscall exit
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>, Jann Horn <jannh@google.com>,
        Jan Kara <jack@suse.cz>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Oleg Nesterov <oleg@redhat.com>, linux-alpha@vger.kernel.org,
        linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
        linux-hexagon@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org,
        linux-parisc@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-um@lists.infradead.org,
        Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org,
        netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-gpio@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, bpf@vger.kernel.org,
        David Airlie <airlied@redhat.com>, virtualization@lists.linux.dev,
        kvm@vger.kernel.org, kexec@lists.infradead.org,
        linux-hyperv@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE1MDMyNiBTYWx0ZWRfX9O9JvlKk8T0s
 tzfzGm9BedJZMUMJcr20WZcKdrIbVTxiRlozMXkiWjNbcYeBo1fhrNo5Y5PuZYTP++xeXhZ6Td7
 Jp/7KWCaMn1//ZVfVK+Z5+TjPswCn/Q=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE1MDMyNiBTYWx0ZWRfXyf9XbbRH+XMG
 Vumo6fSDKqz5gTQ7Frh2zRwDiFAth/6LNML4viR70gf+BUVU5+l2RSR+eU43pz6PizConPWRMW1
 8dRB04z8twDVKGsZF8Bw3hdwymdTgX6d80JSfaCgZiZZynZxkKQcdHSg+7Vv5J/yn9hgag6Lhln
 ZmSHBn4BQ3u9EluajJEhwm9HDiuDbrnjvCqD0Ek0mAWzlbEvZmZ+bvO/A73kqfQPHZeNxHSexxW
 AZfyDIlSsKZHJnDE9fXw7DyQDgNMpOM7VwRx7VU2lR+olY7gts8t9lW8Xe/9O2mmrr/CbHIVP7O
 fyaY7f/Zn6d+7U6ZM4o4KxS4tGlZtWh/F9euy2pcbYe5I0uHEQVWkPd3RAx2N9ai+PLBR5xf6Te
 Zmnx/qAOkdD39OaEwNW4B3Iu2yU2r5gpfqC68JEowC1e0kk1LP+cMjGpGxPzKQ0ZFfHlGM0aidg
 mZLNk8q/E+mSc+utRaQ==
X-Proofpoint-GUID: rI6ssaKzrvH-pR6A05HTh0IIJ2lTohdr
X-Proofpoint-ORIG-GUID: rI6ssaKzrvH-pR6A05HTh0IIJ2lTohdr
X-Authority-Analysis: v=2.4 cv=PcZqFShd c=1 sm=1 tr=0 ts=6aa9c4eb cx=c_pps
 a=nSjmGuzVYOmhOUYzIAhsAg==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yx91gb_oNiZeI1HMLzn7:22 a=Z4Rwk6OoAAAA:8 a=VwQbUJbxAAAA:8
 a=2Rxv5svHm-zNKBYa0PsA:9 a=QEXdDO2ut3YA:10 a=1zu1i0D7hVQfj8NKfPKu:22
 a=HkZW87K1Qel5hWWM3VKY:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-15_05,2026-09-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 suspectscore=0 malwarescore=0 impostorscore=0
 clxscore=1011 lowpriorityscore=0 priorityscore=1501 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609150326

On Tue, Sep 15, 2026 at 9:02=E2=80=AFAM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Tue, 15 Sept 2026 at 04:31, Christian Brauner <brauner@kernel.org> wro=
te:
> >
> > TL;DR, this lets arch code handle fd install and cleanup. fd_prepare()
> > allocates a descriptor like get_unused_fd_flags() does and records it i=
n
> > a slot on the task. fd_stage() attaches the file to that slot and
> > returns the number.
>
> Honestly, I am *not* a fan. At all.
>
> I think this adds complexity rather than removing it.
>
> The diffstat tells a story:
>
> >  106 files changed, 962 insertions(+), 861 deletions(-)
>
> in how this adds a hundred lines more than it deletes.
>
> But to make things worse, it adds them in bad places: low-level
> architecture assembly code.
>
> Those extra lines are *not* making complicated code simpler. Quite the
> reverse. They are taking fairly straightforward "just deal with errors
> with normal cleanup in the place where it makes sense" and makes the
> *straightforward* case simpler, while making the big picture more
> complicated and subtle, and adding new code to places that are not
> simple and just blindly do somethign that makes no sense in that
> context.

With fd's it is more than just about error rollback.. exposing an fd
to userspace mid-way thru an ioctl is an easy security bug to write..

OTOH, "just use FD_PREPARE() / fd_publish()"..

BR,
-R

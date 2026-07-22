Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 725E5345CC0
	for <linux-hyperv@vger.kernel.org>; Wed, 22 Jul 2026 13:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784726546; cv=pass; b=IA7Bd1rsjhLWZL5tXhA/RuOiAMEeuAYuZ/OlX6OoyH7Zg0eo+RsWQqiYR7iJwBliiM2+5D4Fvst5Iy+IvM63y4CznTaa+Y7n7QQXJ/TaDmZ/sKVWuZdVTafuRUvXDre4AZeSU40VONVxMMEklnW3NbWteu/rjdpeUztNp1kLVGs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784726546; c=relaxed/simple;
	bh=qmiyIr57vbl256lcBs8+wUl2H2pAknANl9v4R+ZJB/s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NajIgiXFnFmfr/dApn9tZFRUisC6uZzpkywAzi53Z9VVRmRvKjNIsW2r0I3gm30TqKndXKyC+SXPKJajsskFU5JmC5AetOx/wzmTnSX+kB2Yp40etUasuuKWJotozkIhQ3yjYEPsKa+/KBRRr7/MbLL6FggPCLbJ7gmYIeYrPVY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H20TUlqi; arc=pass smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H20TUlqi"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-c9cf07d2df6so7889459a12.2
        for <linux-hyperv@vger.kernel.org>; Wed, 22 Jul 2026 06:22:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784726545; cv=none;
        d=google.com; s=arc-20260327;
        b=bN/Uxv4Ojp6rfvpvuoUAI+bRvL3+4teHTUzEO7j3itG/eMBmNC6ZUXCTzDMdN09kBS
         r1ZAL2xdjoK6WZv+C4XFmmDchSp3SCp2zam/cI6f0Xl1+dDhoxns6zgJNxn2985hYV7B
         1pdRTqNuv2LlHikvisYTUF2s+oSuv48l8EYKhXfUcSEOh9T9on0ZG3GKM0nSZ9wA7Vgk
         BRjmw6I+G9okmjM0NSOqZaSd2RXKcSSTE/niuG8hfMtfaTrTsddVfoDjdwhi8qlB7/qF
         6uC4gHq77R78X+Ben/drQueKpctQW5VXsvkhSlkSpNIThhNiHZpUKufs3Q0a7zuI00rw
         hOjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qmiyIr57vbl256lcBs8+wUl2H2pAknANl9v4R+ZJB/s=;
        fh=zCjNMf3nWtsHOQnVKnxSGRUYgXCX8GWau+cwPzLkeRw=;
        b=axZv9ylnO7RLX79TQs+3Y27j3TB7M7fymdSRwt92HkjCIeBV9N7SwowxrpPkzx4Pt5
         6dJuiTlg7od56DzS9Mxq26e/h/sc7yfjcfYyI856O2bN2EF0Aa6pbAWPQl8LImF34XGz
         jegt8sFQePaCgUaSmDlFxqaj2hl+8bcioo7E55Y9eW/nl76Hd+oV1nsHvU6vVz34zHuG
         k3OtLoQMUfzLM4OwJZU4lFB9p2J7kXVbP3lcqzvROWEGdF56Xxx4vQjJ8nPHc4IpXiGH
         z1XJc6eYbJFbepKTEwbBLJ4weJZRi4JrXkuNw/B5AxRViHd7EH83rROw3Ju8WMslYjte
         sJzg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784726545; x=1785331345; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qmiyIr57vbl256lcBs8+wUl2H2pAknANl9v4R+ZJB/s=;
        b=H20TUlqiPMO7DNKOTymkZUf5OcRCNkn1Mm663xwCAu3bSXoayju6fnXEGl9SLcNVb5
         EDbTz5n0dA7/LyQN1ldyxNhtojbk8ExtfqN36NeBxIWWjxM7C8Glxrh5wHWFMwm6T6ez
         ZsejQTUofChvKtVra9C9GYGKKf+VPwOSe7oF3LEXjgNC3LWnlrUTdy+0dSfIHJHxHiED
         ucvOmHDmatcWHXqGzI8Mr80i2e6APDc/YmanPF2Q9ANIM0UCSkkqV2hXEFQI7ulTYGqj
         6fuSYvVtNzI1N9tL10+8ZlxI8pp1La4VXVxyL6/APvkHwodmi/csG5is9VUMUS7YRvuz
         XIcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784726545; x=1785331345;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qmiyIr57vbl256lcBs8+wUl2H2pAknANl9v4R+ZJB/s=;
        b=LibPm3VjbeVo0/ercXELQhwWna1ZE+oSI6nNh6EmYnfUxocFNjX7RMd+TiCT18Scpa
         36ssm9xNwP8Ag/919H04hvL1jg+drhYZ6O8Mclvda4pt4z/Vsrk8tWRCWFpY4LEKdOjA
         JC9Elj0w0qRLk695hGM64qTH89dySMFPncbvwW4yUJ8crgM2FsFqTVqhOHRY0YktkjRk
         g/+YJ9MP++3hHF469SyrWaszCW9/rqHTLUfBRN/6JkMDU6K7HXbs/f+mmV9e1GxkFet2
         8IaeKgKGb8phwbNjQXsAf++c3W1ZsNdpm48bxgcL7Z4wTAMzu3nFRXsmHuEeQz9S+b3M
         GmkA==
X-Forwarded-Encrypted: i=1; AHgh+Rrm39u1FNxhta9lDhG38ZLUj6tihQn92WJD2x85VzRF39z5LbmHFzDJ2rMnlNC9y++1CDqQESoRh3sWZBg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz57f1ydnyJkUzAtcqXsr0t+xRZdU6XNseJmbiLwkwLFA9ppJPw
	SK6MC291p7myhA/lIoBIZV89OvzU3Ed1aW/YEf2slZkNNa77deqXZdZS3P/+uPkcZAtVwqNn6Kq
	Zpv0w7N8NrofsIe6M9FuO5UKTTRs9PhY=
X-Gm-Gg: AR+sD11btrL8Hj3BHz/zIP3tFGnYU2V2a0PFMN92e8zW50PzrQTiXGSPC0XMxbgSoaI
	vrd/KWaqpHixGbKSjumfW71AvQdpOm/iGbev0u8i5xZ2uVxKm9rsqz7ugAJCjgaNp/V/SnLD/rw
	P3zwFY6brQkPYuPPLBfa/L/cqPWjF18Q81/HFjgNOLSsPU6BEYpdH36gDwJuw63B/GqAhPclwOu
	KWacvEomyN0XxndB4UZnDRgfhSRRGRp63LzsQTF83GYlUEEo1Wqa5M0jCE7fA==
X-Received: by 2002:a05:6a21:4c0c:b0:3bf:a698:ce4c with SMTP id
 adf61e73a8af0-3c3ad945355mr23423906637.58.1784726544848; Wed, 22 Jul 2026
 06:22:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260717001837.635756-1-hargar@linux.microsoft.com>
In-Reply-To: <20260717001837.635756-1-hargar@linux.microsoft.com>
From: Tianyu Lan <ltykernel@gmail.com>
Date: Wed, 22 Jul 2026 21:22:07 +0800
X-Gm-Features: AUfX_mwhmkCOsNsXPV0ACycuzvOQqvDNq8RMof8ERNVQlHSDf_d_-pY-CdrhG-o
Message-ID: <CAMvTesCqSMZKQm0WcrW4cXJ6zAFYFnamW=5eNJje5HKeLr=6aQ@mail.gmail.com>
Subject: Re: [PATCH v2] Drivers: hv: vmbus: add VTL2 redirect connection ID
To: Hardik Garg <hargar@linux.microsoft.com>
Cc: "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, 
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, 
	Saurabh Sengar <ssengar@linux.microsoft.com>, Michael Kelley <mhklinux@outlook.com>, 
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 17, 2026 at 8:18=E2=80=AFAM Hardik Garg <hargar@linux.microsoft=
.com> wrote:
>
> VMBus sends CHANNELMSG_INITIATE_CONTACT through a Hyper-V message
> connection ID. Older protocol versions use VMBUS_MESSAGE_CONNECTION_ID,
> while protocol version 5.0 and newer normally use
> VMBUS_MESSAGE_CONNECTION_ID_4.
>
> For a VTL2 kernel using VMBus protocol 5.0 or newer, the host
> may expect INITIATE_CONTACT on either the redirect connection ID or
> VMBUS_MESSAGE_CONNECTION_ID_4. There is no capability indication that
> identifies which ID is active, so the driver must determine it at runtime=
.
>
> During VMBus negotiation, the redirect ID is tried first because it is
> used by VTL2 configurations with VMBus redirection enabled. If the
> redirect ID is unavailable, the host rejects it synchronously with
> HV_STATUS_INVALID_CONNECTION_ID, allowing fallback to the standard ID.
>
> Return a distinct error for an invalid Initiate Contact connection ID so
> this fallback does not mask other post-message failures or
> protocol-version rejections. Preserve the existing connection ID
> selection for older protocol versions or when running below VTL2.
>
> Signed-off-by: Hardik Garg <hargar@linux.microsoft.com>

Reviewed-by: Tianyu Lan <Tianyu.Lan@microsoft.com>




--=20
Thanks
Tianyu Lan

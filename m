Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.48
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793671951;
	b=KaauttX3FaR8uWHB/ZcUwYj+5lhnqF1YbPrfp851QzmPShJSqiuEkeTvDKM16kiuZP9G
	 UxspeIEeS+2fnFAzEQLues7BfVwQFIFE4ai7KoIQ1kH1irRj99raZRnB+fuN2Zo3sBMFg
	 J953cAtTHjP9GEi8G0jTq4Hgyn+d3yS2x0KDkGfZz31zz2H1o/vB3QQmtS9tTdZOuQwDz
	 E8ritFo0gunXHN0gYggfDmqp88uPeeX7nxxHZumocdBmP0Y5JkWCZxFs2r+sCrdWX8i65
	 KwZpRAwn1KMlXJdDLZ12pLG9BCPX1bIGiFbcdpDWlrzRqgYJJDsk4wwFn4N31cmDFUA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793671951;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=gbxtANkKD+no5T6EiXK6Tea/adYVuoSud4wUlEix+Yo=;
	b=ggMHoTf0Wik2zhijNkEOXl1oC6e06POX72QGLpOtVDLrbYqTfxIf/yaXjKMyenS2qoEQ
	 bmK0v7GPQAeZYVJvKB11ykDjZ0d7GTWLfR9MmuPLfsQQTZPuxHr+DI5QEvOJLvh5g8n8x
	 JfpVTkFy+LlaanyINqaR3ufIBT48YivKEZiS1pg4LsTdx+JG2WOd1ZpAs7NRrSWlIFPxx
	 sMlhtW1PyaXUdL5bsh9y7Y+Rw3M5eQEI0FjDI+fBgLpmCGK7TeRZ6z5RynspAPRlJ13Xp
	 I21gSRpBKQ7/vAbb8i1H7wdTPHXd8DWO1GBb5mYdmCjRtURvygtUWF88QwXqtYncnug==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fF6G9Jhk;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.48
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C32DC606A32E
	for <linux-hyperv@vger.kernel.org>; Tue,  3 Nov 2026 02:12:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C32DC606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fF6G9Jhk
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-91c9cfd8b1bso42490216d6.1
        for <linux-hyperv@vger.kernel.org>; Mon, 02 Nov 2026 18:12:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793671950; cv=none;
        d=google.com; s=arc-20260327;
        b=n0t3wOLjTopwkDzK4DOU3rgiOqPzrakLB3avOK+4Asips4g/3Rt0H10t04NuKx1Uf2
         Iprzw0rOVBweWVx82pZM0K0QejCRF8Slz9XwFCNsUJBVRVsnB8VT7SWpVDglr3Mn3+Om
         B98WH8jPOE8RfN8BZUBTRkbDh3HP85qTyGSd8I9qYUJUzu9oqnSfkkAjPsNKlZKW7Ej+
         ApUWKmUXjl6c1gUzc1Dd81UtCQtOqmbj+7FB+RmsBBCWC3vrCrHSRbn1A82RUIDOrfy0
         4aRkhTS4YuqNCjmyQSEkYmVpmMIwGTzJui09vjUgBstSZH8jHv1lIR1TnMXBdaIwoRtC
         nu+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=gbxtANkKD+no5T6EiXK6Tea/adYVuoSud4wUlEix+Yo=;
        fh=CdSiEIL3gteScfV5dHQiSGIXSQfdPnwU2HMIw26+dSU=;
        b=NK6j3LzO1oOzIzd45eIhvq14YwVmF+GsphZLA5dPrc5Uhp8rK/ZyjNMjO4ls1K+PE+
         HZG88rsEOUZWpt3gj5uvy/AXQcCUTjfwWitaYwVbEFX3Yf79k51YLYeU5dOlReDSMMOl
         LbsCpdAVb5xaaW7Px23BU7N7VmJ6c188AL1VRyKcnQyly7XwXO8KPDwuJNbpy430cuiA
         OWEh+DDPa4PcXy1pJVJYmZmX8jBdiRn7r0h1P/8MD9SfRsyIO1ou030Puv/1AT+9siiu
         s/xIw8V46oZ6DRqm+vsn2FYt0pQJLZ86u0v0Xm61WORotPmt2/xi/MXeW/1VlylKWTGm
         R/aQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793671950; x=1794276750; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gbxtANkKD+no5T6EiXK6Tea/adYVuoSud4wUlEix+Yo=;
        b=fF6G9Jhk66eL2YXQUxSOw+szWa/NhEq79A2zPZQQzPiUgVMfgGeuZOOKG8KL4Qf5/f
         /Vlq7oZGdPTmWtI2vO/ONJ9ixUgGU+hQnkxA86yN5VBnHpMLfQdA/CSv/TtV29ZvNY9d
         +bvU24SjSIrs5JoFQsMrQ2wfXz7F53jvyRwVJSieB4K05orjtGfa7jHaRAOL1Ya+SKqC
         gCqKxVTHJpwXhdON6MwmTMWbQD+bNNJ7JYrnNbmlDevNYPY6nOnpnstG1f2xma4oZPNc
         JgfJ3GbMPdRN3jfaWDpwbFtioHNzS9yJXyXsy4u07dlfU3ccv/Hi5fb2zrU1yTHTEor6
         dWdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793671950; x=1794276750;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=gbxtANkKD+no5T6EiXK6Tea/adYVuoSud4wUlEix+Yo=;
        b=pdbI5OmpHW8CCdqqObZsc+FKkVVByGn+PYbuEF8ccPbWRoW9slJfjaHrJmwkyxPxRL
         A17CM1C/XT+kPE8DV0hME1lfARPlQo2iMSi+6ypDDcPuxgqq5Gcqvu8jcc+7FLta/bEd
         ISGN6WQvdwuahl3bTmVvdDhJsVUhGiAx/xDZf1b9AP9rhAFhdEQ3h8yuPKZiuT7w4dQl
         kFAx07vzhfzldVmz5kiSU/NDrY1IWV05dhslj7VFifYSi2pEZyewABLmUINUYUQbdHtc
         1KddD9g1XRRMxpPrGkU297j1dAGlHD628QRFtJitp8aJxwNgQGVxzhK0qrk3/lD1KulW
         VsPg==
X-Forwarded-Encrypted: i=1; AKwUvByqie6rMcusUaCpMZyin5u7OM2FnMcjPf32Fgj0NcYqdYOUrhH0L616E2HnHQ1Kk8K4kvgkkZ6824B0WNY=@vger.kernel.org
X-Gm-Message-State: APuU4Z+agFnL+R6PB3rrgP/06uo2piE2KCdH/0kz/5zATzTO1g+SlRTl
	ZCKJuyFJp/c6oTvozOVLTexqpupTKR9l2bw/smXpz/WLJLgb8cyaxLrDRjXQEftEy8QQ7gdGWZ2
	GgYZdbFOjzby7VmweKuFo+K6YxCJgu+4=
X-Gm-Gg: AYBFou1Aynsza1xaCraRpaNEr7q61v6eqAI+FrUFJxrVkqg1LYVSGCazcwMyQyO+rjT
	Fd77JgG5uCleIDidlrA6FNoQWvnWq+/DudhEWV6apc6/QzHX4R1l3ISXweuBLrechy15Bi/Me2R
	KWNaiRUAQ95CJTAXSop3o41243vEyOpj4LIFaGsuvj92w2jwMCXqfzJzOO/kGtT0eYbVxxJ+Wyv
	sgG5ASoqqEDHHGNILnUpS8llBc+7w4cPol5WEwElHZ5MwVXyghjyHOUa9MQqMYZdPtAdtZJIYIi
	cOBdf4G1Ij5jugk/UTSrnGkeDv6HuIpc5pJzkbAzkzYtGZaleiEKuSYQ7/g8NXIo/TkmJZFZ425
	p9Gy86lavculPCRjaaFKUkcC5Bwoc977x9chDhArYOCFDrdyOva/MDT9OUGcdj9ZKUvLPjCAws/
	n689LGKIzsiNSoxg0+I8bboww0h4cvPmcueWn7k2dF5UTyLCxFfFpQeJyrTaJRj4rD2w+nQtySr
	5YbCt2Ug9zeJow76LcMlm8N1w==
X-Received: by 2002:a05:6214:e87:b0:91c:7a51:ee57 with SMTP id
 6a1803df08f44-91ca4aeaac5mr203416566d6.15.1793671949650; Mon, 02 Nov 2026
 18:12:29 -0800 (PST)
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Post: <mailto:linux-hyperv@vger.kernel.org>
List-Help: <mailto:linux-hyperv+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hyperv+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261101022257.52819-1-mhklinux@outlook.com>
In-Reply-To: <20261101022257.52819-1-mhklinux@outlook.com>
From: Daniel Pereira <danielmaraboo@gmail.com>
Date: Mon, 2 Nov 2026 23:12:17 -0300
X-Gm-Features: AclHuK9uvtjaaPHlebO_GILeXhtM4eF9Xw6fUbaddVzuMdSO3LAS3jPBYG1eB3c
Message-ID: <CAMAsx6eCrbcseb=eM_GW+3k2YF3t38Was35oQHW+3UkidsvKWA@mail.gmail.com>
Subject: Re: [PATCH 1/1] Documentation: hyperv: Update docs for PCI pass-thru
 device support
To: mhkelley58@gmail.com
Cc: mhklinux@outlook.com, haiyangz@microsoft.com, wei.liu@kernel.org, 
	decui@microsoft.com, corbet@lwn.net, skhan@linuxfoundation.org, 
	rdunlap@infradead.org, linux-kernel@vger.kernel.org, 
	linux-hyperv@vger.kernel.org, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Michael Kelley <mhkelley58@gmail.com> writes:

Hi !

> +and unmask interrupts. It becomes the parent domain for the per
> +device IRQ domain created by the normal Linux driver for the

I think "per-device" should have a hyphen here too, since it's an adjective.

> +"irqchip@<paddr>" domain created by the GICv3 driver when it
> +initiaizes the virtual GICv3 hardware provided to the guest

Is "initiaizes" a typo? Shouldn't it be "initializes"?

> +device's MSI/MSI-X registers/tables. The guest writes a virutal

I think this one is also a typo, right? Shouldn't it be "virtual"?

> +Once the host-valid MSI message is obtained, the guest must treat it
> +as a black-box that the guest does not interpret or modify. The only

"black box" (no hyphen) it's used as a noun here, so it shouldn't be hyphenated.

> +valid guest action is to write it to the MSI/MSI-X registers/tables
> +using the .irq_chip_write_msi_msg function on the HV-PCI-MSIX-<PCIaddr>

struct irq_chip has no .irq_chip_write_msi_msg; shouldn't this be
.irq_write_msi_msg? Same in the last paragraph.

Thanks,
Daniel

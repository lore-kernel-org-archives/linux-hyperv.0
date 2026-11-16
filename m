Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794827834;
	b=GrP24LNzvlL8IoALcmJUZxijbyXc+Bpfp1qjV6BF1XlxCO0wTJhBR7zryNAadw+wQ8eK
	 RFgtH4coELQgpmTIwHjaFrEi4XRoodKXtnEAbYwMXmpEAdVvuq2y0idvIOT9Lvjyw+QtS
	 pvUC4LdVvTTQ/Pcc9Xpc8odNYYxYbsa39jucTBrbYpZ/ZJ5YrYDnqFv8Oe+OlLeZVf8qP
	 IZ9VAd7fp2FRUC5tQPqlsaO0iu/fAZsuCTNd9+d3EsU/r2NaAFXDhtO8allRmsk8/H/wW
	 nTFYIzogEJyqCjezCiWbQ5awUjVAltoXlskUG5NV8KOgzmdNxMZ66TxP9WL3w+ncUTQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794827834;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=ITw6ygw2AXNWGd7QRacWknaddhmjMVGAScdWdo2ralM=;
	b=F9LxTbv8aPQLdW332zxoMpQpP/CoRgNad0R0OCKLv1aP2Yh1T2QBPA4CPu2zAhFO5xJ2
	 kGY6D1WbVDUjoezrB2YxningwYAg0/FmoGALTWO3N9jD411LUXROuCTA2V7MMEipMEF06
	 QCYeKr9GC1RJNBzBH0bFyFn1IYy7icXCGSjFAYvUv3HmgzNj+TdAxwBCuCX6tdaN6pboi
	 aeOiEr8rJqmf/opsTA07GKkBpjCAF3adccSh4APWD/bHGPsRn8x199/8H8vhQ7IoIefSG
	 g29lXHodp2aXdJLM9loZwHZ3oKeW8Oc4z4FbXkpLhoCEDW4if0JRmhNWZwyKR+Wrz0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rVdhtEjQ;
	arc=none smtp.remote-ip=209.85.221.47
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61C63606F1E5
	for <linux-hyperv@vger.kernel.org>; Mon, 16 Nov 2026 11:17:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 61C63606F1E5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rVdhtEjQ
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-49a92144733so1271426f8f.0
        for <linux-hyperv@vger.kernel.org>; Mon, 16 Nov 2026 03:17:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794827833; x=1795432633; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ITw6ygw2AXNWGd7QRacWknaddhmjMVGAScdWdo2ralM=;
        b=rVdhtEjQT5FeVSjeb6g1KeCSlR5WAzfAQy36NgBy24G8Giox2QE9LPzzbt6UaGFg20
         dmoHkqnkTYm0HKTFVPgXMm50xQ7zxGmwscbQp9b2ezCn9mA436p3+7JIgS1yW8dgeXC9
         nfYhNw53+TIFpt6+SE4H+9FUJIhbR8zphpCjI1+mIXv8dvNLdbmO05X5YWYCAlkPK7eb
         f6iCEfx46EWybkK2aiebuDDLI6wMPFOvAPoZC07MvR6rqVRHexrTmKf50yOkAIscUDkB
         SZu3GAngH4UyKACxxK2RRwNXPcsz6NLOW7SZFKczhfldBlGdj5FDcsiVAzFHA7oS8Ygd
         nDGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794827833; x=1795432633;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ITw6ygw2AXNWGd7QRacWknaddhmjMVGAScdWdo2ralM=;
        b=OccBY0Tcf+rljCyv62W/jRn0WDn43RJVNJt6XienkW2q+8N89bdaNbLrJDobgICw1b
         eR25jKLXoxRAphB3kegO2V3lTSqc3W+PBudMUCc+ArmFaI0kCFPXw+Fq0O1xZvaFMggo
         qLkFpr/6RO757vo/QVrHcZLeFoggwZklxic3KvGBICWNoiV9HfihkE5HIXxDJYZel6r3
         DO+DkR/QGlFHNt47869G5rWCJSa+nmQyjZUqnvU/1shv/o+pIAqW4TSCn4ovSvwwagBe
         n0hOFPARm1bF2PfbENzUTgxUO3Bg8HGmBLratevbsV1imOZeu8yekfsCiQWdnfsYc26z
         rKbA==
X-Forwarded-Encrypted: i=1; AL+hErHpK1XTtJBGHONtbe19hwkuRW/jCzQZ9/rWa0mErcsWsVhaWzdObja8dNhgTcpx4z8ojYR4kax6DYUDFfs=@vger.kernel.org
X-Gm-Message-State: APuU4Z8nU/TEw+ok2ff2IPdTdEVppkkKNJmzN/ZHsrXWW7YqDpFcMGse
	itk7jeM13Oj4OCtDF2hOiI2Yv3vZclmbciARUvfhuAIlR4Cud53hhaxN
X-Gm-Gg: AZFdTZfSD8ej6HgoDP07HcQyLqD/B6IbjH2hVOg0oEY0ZK97DgxkVktWTZWKwNIom4g
	61BKgtgEhmBTRFMr8njEWarfwPpGMJxECHOQr3btY+ChpLlTCkCxk6KpTcx+9X6nblX0vk1um9E
	7Enak2B1yZEpa3HKdlP1FmnAsWM1V9CA85ayIbfWf0qNbMm9ohG1V1zIsuAvhQfUzHIBpdvFKxl
	+bi5fxKmDESzPDnRg7/55Oy2t4b62qe+lnOyJ4UkmnDeUpnv0P/FrhOIgjskQz6b5nbmHFCyYO3
	eswI9P0aMRnqGFcV8CGL9y7cJ0rmMGMjq2Y2lYqNhm7b7oHeOpZVBnnBBvh+0p1+XhcxKxUbxwE
	u2ZMsQgS2S91HIoUIt4ayyA4nKVnjlA0/OmYgEqB0G6+N98SvlxRBI2k+cVHPviNPxt9ezncNH5
	8s19qBBH9qfvY592gj4Pi7LOzkeZVHNX78Lg4EEBxwVL42wA+hlisp4kPwYlPsM/opPgM+DIVVi
	xuZHoi1dwnsKOBkV6huWXgtNoYVPhVz0It/n/Rj7AtQxIWymOR91ZXsQ0a0MdjmbhSXL0etvW1Q
	WbVHrnQRkm8Dj9l0RwUiWYdmvA5EYXy/lZJMwqU0pDlqN1z5zDXX+tENJna03jsVnZYjROF1Jtg
	e8H4fFWsNpAWT
X-Received: by 2002:a5d:6f07:0:b0:490:f98f:addc with SMTP id ffacd0b85a97d-49c71d48742mr21084457f8f.27.1794827832625;
        Mon, 16 Nov 2026 03:17:12 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c8d286480sm39476298f8f.7.2026.11.16.03.17.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 03:17:12 -0800 (PST)
Date: Mon, 16 Nov 2026 11:17:11 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Pavel Popov <pavel.e.popov@intel.com>, Bjorn Helgaas
 <bhelgaas@google.com>, Logan Gunthorpe <logang@deltatee.com>, Arnd Bergmann
 <arnd@arndb.de>, Leon Romanovsky <leon@kernel.org>, Lukas Wunner
 <lukas@wunner.de>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar
 <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, x86@kernel.org, Jim Chow
 <jim.chow@broadcom.com>, Radu Rugina <radu.rugina@broadcom.com>, Alexey
 Makhalov <alexey.makhalov@broadcom.com>, Wei Liu <wei.liu@kernel.org>,
 Michael Kelley <mhklinux@outlook.com>, Nathan Ciobanu
 <nathan.d.ciobanu@linux.intel.com>, bcm-kernel-feedback-list@broadcom.com,
 virtualization@lists.linux.dev, linux-hyperv@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 3/3] PCI/P2PDMA: Allow P2PDMA on Intel Xeon server
 CPUs
Message-ID: <20261116111711.7b473feb@pumpkin>
In-Reply-To: <avqhIQ2krd1qgp6K@infradead.org>
References: <20261111234439.4098-1-pavel.e.popov@intel.com>
	<20261111234439.4098-4-pavel.e.popov@intel.com>
	<avqhIQ2krd1qgp6K@infradead.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Post: <mailto:linux-hyperv@vger.kernel.org>
List-Help: <mailto:linux-hyperv+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hyperv+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 15 Nov 2026 22:22:25 -0800
Christoph Hellwig <hch@infradead.org> wrote:

> On Wed, Nov 11, 2026 at 04:44:39PM -0700, Pavel Popov wrote:
> >  #ifdef CONFIG_X86
> > +/* Intel Xeon CPUs whose host bridges support p2pdma */
> > +static const struct x86_cpu_id p2pdma_intel_cpu_ids[] = {  
> 
> Why is this in drivers/pci/ instead of behind a clean abstraction in
> arch code?
> 
> (and the fact that the CPU vendors still haven't managed to provide
> a firmware interface to expose the P2P capabilities is just insane)
> 

Isn't it a motherboard issue?
Since it depends on all the PCIe bridges on the motherboard.

IIRC P2P can also deadlock under load.
So it needs to be use with extreme care.

David

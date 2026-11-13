Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=204.191.154.188
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794543234;
	b=d1+veOYSZ5bK7bvsJ5e7nKvPsX7Hk2orx/5ubrRCLoCS72Vl+xQMJO6jc44EbAyvPUMa
	 xyFUXZqbEarDjSPCcq9f1v1GafFQd3lSHKfNLq/JfRFXHuyqnnvGTQ5gblJtTLXLMSofj
	 i0ix7l9KYuKgEuLfeBT7gsA5GVWou3iHWlJ6qQoj0IHWA7yCYmaxdS21ZgWfgForO6SQv
	 2vOzp2pmDogtIHRx1P1Ua8p4nW/4UayHEs/Prr3j7ByrpdghDIxfD6a8373E+eDV8hOJf
	 AmpwbsP34izXRMgzIB2g+vZlmY9phUWabR26F0aItlvS1pKyAa/Etu1PNMBDuLnGhOQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794543234;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Date:MIME-Version:
	 User-Agent:To:Cc:References:From:Content-Language:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-SA-Exim-Connect-IP:
	 X-SA-Exim-Rcpt-To:X-SA-Exim-Mail-From:X-Spam-Checker-Version:
	 X-Spam-Level:X-Spam-Status:Subject:X-SA-Exim-Version:
	 X-SA-Exim-Scanned;
	bh=t8tcyekJjJKe7+3oQ/y4h6CrPoVxFjqtW2GeBDEriJk=;
	b=QCgO0hX7MfysiQLv0GZ0Q5cHe1vdDoRbrBLdMirwXHiG0oiybJF7SV4q6jEcP8H2Xbzp
	 vrHmGLUK4zhaQAL64J33QlPCOWQibfVYLuZwQsSbu3YbWNZW3UN1gqMOrfae+HWCcULK2
	 6mTcovZKViUj6a3ONVNWsOPXjeI78a8LpwaMlOBX94nCFoX68w3MJZ7DGGRlvy400zTos
	 vhbhU/co6H2IIU7bv/7XJxOVrREt7enrQ6lzv212OUBHe+MKG7ru8IzdzaE2FLs4DgMfI
	 xjuVsPlijF4QBU/FFjlg6NV/ukpMwdTnaa1tb8es67IWGPajhrEm1nH99AH+VkRi4Nw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=deltatee.com;
	spf=pass smtp.mailfrom=deltatee.com;
	dkim=pass header.d=deltatee.com header.i=@deltatee.com header.a=rsa-sha256 header.s=20200525 header.b="iL/L5jG4";
	arc=none smtp.remote-ip=204.191.154.188
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FFAA606A321;
	Fri, 13 Nov 2026 04:13:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5FFAA606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deltatee.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.a=rsa-sha256 header.s=20200525 header.b=iL/L5jG4
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
	MIME-Version:Date:Message-ID:content-disposition;
	bh=t8tcyekJjJKe7+3oQ/y4h6CrPoVxFjqtW2GeBDEriJk=; b=iL/L5jG40YbGRv92VmS7dbxETL
	xWJfx5uZJMEs01ubumop9lnv3Z7gxj0yYPdAOVGwVWDDki6IT5XV5x+bniFzr0XZbeVDJGpVF6hYw
	lRXMzeCDoBNN4sF0KdwsM9sxlDqsBZb15XhSpuWBumGO+MPyzHGuJ/0/IIkwN/O7k6+Eq/6T+WL3p
	ee++OR6XYkvDl27vv52z6v/hwjJhl5W7KmXkhAg4ta4GnlUJe+qAc06dUAKIlFya+/PQBjHQi5pXi
	1FltGDZPafrQsaGMhPjGkGu2HE0gFJxJy+Kkzm/nz5yJkhpfeyGM9/emY4xn43Q5XVygW4VazWwS8
	uWEyuHSQ==;
Received: from [104.157.31.28] (helo=[192.168.1.251])
	by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.2)
	(envelope-from <logang@deltatee.com>)
	id 1xRifX-00000002Scx-0QNs;
	Thu, 12 Nov 2026 22:13:44 -0600
Message-ID: <73041030-b374-4320-8908-5d1fecd38c50@deltatee.com>
Date: Thu, 12 Nov 2026 22:13:20 -0600
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Post: <mailto:linux-hyperv@vger.kernel.org>
List-Help: <mailto:linux-hyperv+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hyperv+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Pavel Popov <pavel.e.popov@intel.com>, Bjorn Helgaas
 <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>
Cc: Leon Romanovsky <leon@kernel.org>, Lukas Wunner <lukas@wunner.de>,
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, Jim Chow <jim.chow@broadcom.com>,
 Radu Rugina <radu.rugina@broadcom.com>,
 Alexey Makhalov <alexey.makhalov@broadcom.com>, Wei Liu
 <wei.liu@kernel.org>, Michael Kelley <mhklinux@outlook.com>,
 Nathan Ciobanu <nathan.d.ciobanu@linux.intel.com>,
 bcm-kernel-feedback-list@broadcom.com, virtualization@lists.linux.dev,
 linux-hyperv@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261111234439.4098-1-pavel.e.popov@intel.com>
 <20261111234439.4098-2-pavel.e.popov@intel.com>
From: Logan Gunthorpe <logang@deltatee.com>
Content-Language: en-CA
In-Reply-To: <20261111234439.4098-2-pavel.e.popov@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 104.157.31.28
X-SA-Exim-Rcpt-To: pavel.e.popov@intel.com, bhelgaas@google.com, arnd@arndb.de, leon@kernel.org, lukas@wunner.de, tglx@kernel.org, mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, jim.chow@broadcom.com, radu.rugina@broadcom.com, alexey.makhalov@broadcom.com, wei.liu@kernel.org, mhklinux@outlook.com, nathan.d.ciobanu@linux.intel.com, bcm-kernel-feedback-list@broadcom.com, virtualization@lists.linux.dev, linux-hyperv@vger.kernel.org, linux-arch@vger.kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Level: 
Subject: Re: [PATCH v5 1/3] asm-generic: Add <asm-generic/cpu_device_id.h>
X-SA-Exim-Version: 4.2.1 (built Sun, 23 Feb 2025 07:57:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)



On 2026-11-11 5:44 p.m., Pavel Popov wrote:
> <asm/cpu_device_id.h> exists only on x86, so generic code that
> matches on x86 CPU models has to wrap the include in #ifdef
> CONFIG_X86.
> 
> Add an empty generic version, so the header can be included
> unconditionally. The CPU match tables themselves still need
> CONFIG_X86 for the model defines.
> 
> Suggested-by: Leon Romanovsky <leon@kernel.org>
> Link: https://lore.kernel.org/r/25a0cdb4-9c4f-4531-bdf2-8d09eedd0883@app.fastmail.com
> Signed-off-by: Pavel Popov <pavel.e.popov@intel.com>

That's simpler than I thought and seems good to me:

Reviewed-by: Logan Gunthorpe <logang@deltatee.com>

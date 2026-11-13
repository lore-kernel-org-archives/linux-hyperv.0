Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=204.191.154.188
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794543250;
	b=XXXZ8v9bf68KZgE+zaA7oeWwMuQRWCgiojoi4u9xJahrrMWBDyK4RuEaOYGa5N+XpYJS
	 9OrvexKZnq7BlMRdhfvPfw6sGyFSicXXPqtg1Mwq9HBeiMWb7Q7x2lFkRIjabqrTr24vR
	 iuC/PgomBPwRYXDtJq+JJByu7Uw2QuisbBSoP32Hp1N0osWpDJ7qk7ceJxH8vbQmshein
	 NX+Y7cOTEku51qDrAkr5a/6deSJgNIb7AF7dVXcG0beaVfuQVs5ojTXTwbd8tCf6Btmsc
	 YhA6RzGuxTYstcCQ400MIGi1MWRe4yWa0ju9qfGCP+mhh5wbUXKdq6yK8ctpl1GAKZg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794543250;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Date:MIME-Version:
	 User-Agent:To:Cc:References:From:Content-Language:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-SA-Exim-Connect-IP:
	 X-SA-Exim-Rcpt-To:X-SA-Exim-Mail-From:X-Spam-Checker-Version:
	 X-Spam-Level:X-Spam-Status:Subject:X-SA-Exim-Version:
	 X-SA-Exim-Scanned;
	bh=NnWPwV3Od7dMZnl2bAJ1KswdoL6wbDTGD+CrdT/Hc1w=;
	b=Dp0Y+1F2nidLEWUQKCBDemCOBqaGoehZn7zRmxQtB60eaJ14ZxwNAaKWiHecbtCw5WnJ
	 wZPrwt3I9lUVvvfwIkWisol1E+Q+Maxze88NqlqytkhEyS1cd0En9FEREmDB27T6/8gPg
	 Cd68YpPD+TxExxdZ8l6+om5zqVri+5dM+5XTxrzOnz51warXpn4nbBdS52EYCxv3RyX4m
	 EHdWjHQ2vrMR1xWm/+BiNSfbFH44AJ4Z3tLJSR18Yir6Rh5/fdlU5k7DYCd957NsbMg63
	 TYatHOJ0XvuvcMH8FPw//zFUIg4filNFHUPWlUpx/JiIyrtkR4Rdch6VUAmctYYkg6w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=deltatee.com;
	spf=pass smtp.mailfrom=deltatee.com;
	dkim=pass header.d=deltatee.com header.i=@deltatee.com header.a=rsa-sha256 header.s=20200525 header.b=HVZDgqa0;
	arc=none smtp.remote-ip=204.191.154.188
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AADF606A321;
	Fri, 13 Nov 2026 04:14:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9AADF606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deltatee.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.a=rsa-sha256 header.s=20200525 header.b=HVZDgqa0
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
	MIME-Version:Date:Message-ID:content-disposition;
	bh=NnWPwV3Od7dMZnl2bAJ1KswdoL6wbDTGD+CrdT/Hc1w=; b=HVZDgqa00tu8tua4KqXGm6d4Zw
	trBkWj/28jkfeGKr4VhA92jYi2Eq3/t9kVD4FPQVXWFlKBw7rEQJS9PsLkqI65GPKgfT1B7D9MhCI
	kv6Hyh2H8QVn/8Qfu4APx96+Tbq5YmhgvIn9pIXtwKEex8at5Bvog1JbvbrD7dmAFgDeNfifebOwU
	XZc+IGEeCx4hEF8EZ2uMg6gPMBqCJ232nUMXeQMLJy5RbEwOcMUvvEdThj+8Lvtqr6LEILEisFwzQ
	fXJ5wzYrXrXr5SngymjpAMJyVvLSBraDWFH8RPj5rRWIQOTGSXmXqNVFHIWFOTqfkZXI1UEUCPdNg
	9VAOmIVw==;
Received: from [104.157.31.28] (helo=[192.168.1.251])
	by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.2)
	(envelope-from <logang@deltatee.com>)
	id 1xRifr-00000002SdL-0S94;
	Thu, 12 Nov 2026 22:14:04 -0600
Message-ID: <a51df894-1361-4954-b73b-32c35afbe200@deltatee.com>
Date: Thu, 12 Nov 2026 22:13:51 -0600
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
 <20261111234439.4098-3-pavel.e.popov@intel.com>
From: Logan Gunthorpe <logang@deltatee.com>
Content-Language: en-CA
In-Reply-To: <20261111234439.4098-3-pavel.e.popov@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 104.157.31.28
X-SA-Exim-Rcpt-To: pavel.e.popov@intel.com, bhelgaas@google.com, arnd@arndb.de, leon@kernel.org, lukas@wunner.de, tglx@kernel.org, mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, jim.chow@broadcom.com, radu.rugina@broadcom.com, alexey.makhalov@broadcom.com, wei.liu@kernel.org, mhklinux@outlook.com, nathan.d.ciobanu@linux.intel.com, bcm-kernel-feedback-list@broadcom.com, virtualization@lists.linux.dev, linux-hyperv@vger.kernel.org, linux-arch@vger.kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Level: 
Subject: Re: [PATCH v5 2/3] PCI/P2PDMA: Move CONFIG_X86 #ifdef out of
 cpu_supports_p2pdma()
X-SA-Exim-Version: 4.2.1 (built Sun, 23 Feb 2025 07:57:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)



On 2026-11-11 5:44 p.m., Pavel Popov wrote:
> cpu_supports_p2pdma() has an #ifdef CONFIG_X86 block inside the
> function body. Put the whole function under #ifdef CONFIG_X86 instead,
> with a stub returning false for !CONFIG_X86.
> 
> No functional change.
> 
> Suggested-by: Logan Gunthorpe <logang@deltatee.com>
> Signed-off-by: Pavel Popov <pavel.e.popov@intel.com>
Thanks for the cleanup:

Reviewed-by: Logan Gunthorpe <logang@deltatee.com>

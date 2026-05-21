Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAE1E36B04E;
	Thu, 21 May 2026 20:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779394558; cv=none; b=RK3wEAEVwMHv0mcCVQV8antS2eypB72LI2/eHNL45rpcVf3eTT56Uf20YN3qsok9pw1wnEFU6COimKV3Ti8cfgyw5GlpWPiZ0G7NTpjc14s439T5elc4MdWwhK1WgWYAn5l8JgEEIpLioJH4u18uii2O+aV1LtGMr/OWPmmK7Vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779394558; c=relaxed/simple;
	bh=XV3LCNKsMMGdGizWeQn3CZsbbO8KKJNgpCkcknnZAOs=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=M/llDuMTNXfV8XDgBoQ/ivRs75IaakJ4AA1pGUkmqtWutzk0zC6V0rHIJpV0O6VRbMD29Z73fHpUeitj7+UwqO0Otxe28qAISqcfcSRpO18GHgYlG/aOo+LcYKwUCoOl9DjEhT2XfeUSllMJvHU3h2ZbcD00AkRZb/K/cbBInZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=rwAeBb/n; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=K+5DqTio; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="rwAeBb/n";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="K+5DqTio"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 003F314000E4;
	Thu, 21 May 2026 16:15:56 -0400 (EDT)
Received: from phl-imap-05 ([10.202.2.95])
  by phl-compute-04.internal (MEProxy); Thu, 21 May 2026 16:15:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1779394555;
	 x=1779480955; bh=mDberM7Cc4ZWn9v0QJ8beiSXraUDPMufIqhWnRtAAyo=; b=
	rwAeBb/nTKxJyf0UnDoQZIqOb5QsFXWo+8Hy6si/7j9ob40Puj/nJOd1SSIUoIL8
	7SHyipD9ibuQVCks1w3AfP8uxf+anaowGRtXzLIEGnfb0vYKkoeBdZ7mIkAi8MkM
	fcUb13N3Dbo+jAGGVKL3zRFVBepaIN1FDDLh3l9QQBw1XNsufvAXtVCZVsxjfj/Q
	WbTuz+Bry+miLPxwsAoFUIUhth96ZeNdk9FgOToJkbyMtFE+D8Kick1I4LF89ghu
	Z3A4ZXcVZIni741uufR+QbebEpzPk4DU1J7cwJpiNxutvk0VaUh16alIwRmm2FDO
	ZNLbT8qMjIU/mYqBL0LBnw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1779394555; x=
	1779480955; bh=mDberM7Cc4ZWn9v0QJ8beiSXraUDPMufIqhWnRtAAyo=; b=K
	+5DqTio4LldGb+c5ffGkJLnkbx3VSS6sdi0uXfhMa5I7SkkPTAQvLdmf5VdNacdY
	6hTWik6qpiMSnehmwjxLackC6ryza6JnWKHz/eKWk9OBHP236ifrYnJI39NdLFV1
	fN7SNsV6LpYubnfH8yHNeTglUULW1sZv4KrwqFWI7eVoVkBITOykJeuHCVNknzoo
	nxRwRXeBG8+dZ4YNG6r0btbDn0ootOOxQGcWLWqodUlgUS+eDOe1kVAqfzYHiH+u
	+pDeqs0s4BJZGIykZoG+cgbXcQb/Sj0Nsqcqp4RqcE+lmFtdDwZpvOUlNqBmxy8k
	tOaEys9U5W+aAZeZYmHjA==
X-ME-Sender: <xms:-2cPasoCMvQEVdU7F7YZziVY5H_dQXL4dZoPYu6u7xC8TcOssO15LA>
    <xme:-2cPatd_k4GpQQ7xfPr7xWYVARGG8CBxba-UicMr_6wXd5i7RMwU86UkopcYe7fW2
    iRhpbhodwfIpCopz9L1jN6y4g031KXiw06Rs87DNU6Ziy0yDUYeMQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddugeekgeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedftehrnhgu
    uceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrthhtvg
    hrnhepfefhheetffduvdfgieeghfejtedvkeetkeejfeekkeelffejteevvdeghffhiefh
    necuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggvpdhnsggprhgt
    phhtthhopedutddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepfigvihdrlhhiuh
    eskhgvrhhnvghlrdhorhhgpdhrtghpthhtohephhgrmhiirghmrghhfhhoohiisehlihhn
    uhigrdhmihgtrhhoshhofhhtrdgtohhmpdhrtghpthhtohepjhhlohgvshgvrheslhhinh
    hugidrmhhitghrohhsohhfthdrtghomhdprhgtphhtthhopeguvggtuhhisehmihgtrhho
    shhofhhtrdgtohhmpdhrtghpthhtohephhgrihihrghnghiisehmihgtrhhoshhofhhtrd
    gtohhmpdhrtghpthhtohepkhihshesmhhitghrohhsohhfthdrtghomhdprhgtphhtthho
    pehlohhnghhlihesmhhitghrohhsohhfthdrtghomhdprhgtphhtthhopehmhhhklhhinh
    hugiesohhuthhlohhokhdrtghomhdprhgtphhtthhopehlihhnuhigqdhhhihpvghrvhes
    vhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:-2cPas0UCVt7DENYNaHwwSn7o1V8v4lWcumKt5b0_18MYSVYsmzXhg>
    <xmx:-2cPalWPAkFbHsrINejb9ofE1LjfD_qJ6VryiP4xKoaP5QfEpt5gaQ>
    <xmx:-2cPauOoh8oFPq2eskzJ2l1V8-FXYdWLgzbuRKW5Z01L7X7O0UfPxg>
    <xmx:-2cPao2tp5-XyDP20tPbJ7EOJKN_jq5ENu5wA15gVounj1E2MfcfGg>
    <xmx:-2cPaqb6hBNwhQeu5w8owS4ZQko9_vwtHhZLzSIEo3J01NdEWv_atVp4>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 4524A182007A; Thu, 21 May 2026 16:15:55 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AHuF2nQGlf17
Date: Thu, 21 May 2026 22:15:33 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Michael Kelley" <mhklinux@outlook.com>,
 "K. Y. Srinivasan" <kys@microsoft.com>,
 "Haiyang Zhang" <haiyangz@microsoft.com>, "Wei Liu" <wei.liu@kernel.org>,
 "Dexuan Cui" <decui@microsoft.com>, longli@microsoft.com,
 "Jork Loeser" <jloeser@linux.microsoft.com>, linux-hyperv@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, hamzamahfooz@linux.microsoft.com
Message-Id: <b3c6144a-beb1-44ff-9a7d-bad61a1b3829@app.fastmail.com>
In-Reply-To: <20260521164921.1995-1-mhklkml@zohomail.com>
References: <20260521164921.1995-1-mhklkml@zohomail.com>
Subject: Re: [PATCH 1/1] mshv: Add conditional VMBus dependency
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, May 21, 2026, at 18:49, Michael Kelley wrote:
>
> Existing code ensures that the VMBus driver loads first if it is
> built-in. The VMBus driver uses subsys_initcall(), which is
> initcall level 4. The MSHV root driver uses module_init(), which
> becomes device_init() when built-in, and device_init() is
> initcall level 6.
>
> Reported-by: Arnd Bergmann <arnd@arndb.de>
> Closes: https://lore.kernel.org/all/20260520074044.923728-1-arnd@kernel.org/
> Signed-off-by: Michael Kelley <mhklinux@outlook.com>

Looks good to me, thanks for fixing it!

Acked-by: Arnd Bergmann <arnd@arndb.de>

>  	/*
>  	 * VMBus owns SIMP/SIEFP/SCONTROL when it is active.
>  	 * See hv_hyp_synic_enable_regs() for that initialization.
>  	 */
> -	bool vmbus_active = hv_vmbus_exists();
> +#if IS_ENABLED(CONFIG_HYPERV_VMBUS)
> +	vmbus_active = hv_vmbus_exists();
> +#endif

I would usually write this as 

        if (IS_ENABLED(CONFIG_HYPERV_VMBUS))
                  vmbus_active = hv_vmbus_exists();

for readability, since the hv_vmbus_exists() declarations is still
visible and the IS_ENABLED() check avoids the link failure.

      ARnd

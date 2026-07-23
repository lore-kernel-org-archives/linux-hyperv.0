Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E60373F8252
	for <linux-hyperv@vger.kernel.org>; Thu, 23 Jul 2026 10:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784801913; cv=none; b=g4Ti1IlOMUfPOIJr5edOTaLeRLjWs+7mGiGTUQCH0hd7uxgaaYPwEY4HSY2RTEXyM/A4DXVM4fDbrS/KiwHatHmAJdd2IxJ8YzyfdloeszRt/pPRccl7rSd1NKVN3EH6xZoctFEmogKLmrZG9Q4oWkROexTlWG22g+gyEDSWQAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784801913; c=relaxed/simple;
	bh=zkE1CxynhhuX45SZ6JJT+YmMZiFe1viNbE9YBLAS9Uk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=E8KcJTNV9SDeOtg2npBF8GrfFpd7AQI7kvWBjdznB02QpPuzpO3D8fJeyGt4t1AwZWjdt7iT459j+tej8dofCUgnOj4eVJWORhN5PYg/WUWWVgLGreKGnCVC2hZvNmmeav8fkZ8orzJlHzRI3rxnlsSJQfzOIxf+4x/OxWPIka0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=By/GacvL; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Nyv8cTFq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="By/GacvL";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Nyv8cTFq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784801910;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c9dgMMoQ1YTrpRt1/B5y0R7DlFAMJKah05nee02sPkU=;
	b=By/GacvLSsvBat7gXEbrU4TErEaK6cK4Iz2JfTRlvINrC0FWMD54eWfuf+34gZEbXivfmk
	cIeK4tibE+x/eE9tca+QBypgE8428xheGSssa4jF2HgMyg0ytMRGWW5VRpTBHNaxsxErTA
	ZuzSr9jC8KaFuiiIYH29wLZDI9F/60A=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-641-xjfxtNX3OdCWJtKlFAliGw-1; Thu, 23 Jul 2026 06:18:28 -0400
X-MC-Unique: xjfxtNX3OdCWJtKlFAliGw-1
X-Mimecast-MFC-AGG-ID: xjfxtNX3OdCWJtKlFAliGw_1784801907
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-49544a639e9so2304615e9.1
        for <linux-hyperv@vger.kernel.org>; Thu, 23 Jul 2026 03:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1784801907; x=1785406707; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=c9dgMMoQ1YTrpRt1/B5y0R7DlFAMJKah05nee02sPkU=;
        b=Nyv8cTFq6wSkw9CFQGc+//PSIWnzoPn5H/e48wHEr3Pee2m2t8sfuEdKXoNR1f2HOG
         OYUzltGeNuGWsGLWewvuSYuRcH5RAkOvCn7Q4Ea/g/H8/Ge0SB1O+I31RfgT4KaYb3qb
         7A6cFWMJTiPiFF1vQDKuJ6kI7rVfIAB/kvfrou+vhW5OjQy3O8U9rr4BDr2bKvJjSwKr
         E238Co3rmqPohu54YH4nnW2gzQR5lDY3ysz5wmPFTVQPjhYIYgRZbN8gPJaJe27WzTKC
         I3N/TiNtHxa4yVzvhpHCoobLTVxNFkv1v56C671Ki/IxWFQWnHspCBM0hh9zY/mX78gH
         ficA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784801907; x=1785406707;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=c9dgMMoQ1YTrpRt1/B5y0R7DlFAMJKah05nee02sPkU=;
        b=H+LqLggVA54CO2ZznjAGtcAO7UqDZYvUV6qPypqXMMgjiZoQHnRXNEX4kEnX14UnEJ
         ziAcY5HY9abAWicMmerV18EZzHJf8htmc+UbRUf8gjdUyATYsXoAS77+qUvkXUxvOx3i
         QhnHelIzYP+aPF4sAYlzife/rmkzvaiREITXOb+D/gV0myFzg0MP8LBjwgr6dpvYNC89
         D9ZydLJlRaiuwi22bSb34ib5usB6c4XM83yz1bTtPSAHrZ1nZVyfC4b6YYsvBRZmyEVj
         zbgYnnRrO49pUyyxvgrNHd7MagqermBFNgvry9ZlkGBQRZnG4+QvcFJvH1yGMsajlDef
         +h4Q==
X-Forwarded-Encrypted: i=1; AHgh+RpP94LmULY25wb3K8JzEF5vhQx04+V4kmmJXQFD3b+w6vrXbJ5mP33iTdpqi1LxSxG30DPoPHMuFqWWE+s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzf1XnTGEa2qcfhSPCfiwENHEmGlZiRNMaLhS8NNbJ655Lo2baw
	4u6IkXoDp++mIuQecZLVJP985XbiKHej16KfNcG6SFhG47VnbLzYGOmu+lPs9awpJr3OoBoXKXa
	t6VXfESyS9zwR/ZxugIk5jgvTh+6Q311NiVPpI09P+eovilyJrp7YXn+7rkBPgC6H3Q==
X-Gm-Gg: AR+sD13YXJ05ORYFI6caCQzn1WlX+obbFM1ZosI93OktZa2ut10QExskeNZ08TlQFR2
	2tidu3oSiWB6F7BCksxVIzNn3W5DpHrbE585GszMVP57BMZeUIbGvkUbw61eSFi8qKR/vl/V8BR
	ahBWJbyz3rMOP3hIWnfn8gFfOFscrFUPCUqXUStumPk4n/mlN6VWqiBEwNwl9wJg6haBDGmhpq0
	ZpWC49iF3M0bxNzhG0JdmFSzugVhryE2aIRxoCxeynndQay7Unht7XUWzNet7CcEH7qiJHHqD+9
	G/6zzzZeeNyboC7CALYitax049y+ccO9Lkdn+qUTopXBostfR5dfp2dwncDBNVW0mq2iekNnd3W
	Nx/+Rdt3XH1cSj22Uasa2Q4MwuxFwde5yrchTPRoiMJVvsOJlU/wPHFP3WFOR+0pnitycZWvH+g
	Z4VQ==
X-Received: by 2002:a05:600c:4ecd:b0:493:c77c:108a with SMTP id 5b1f17b1804b1-49573d218camr25163905e9.36.1784801907444;
        Thu, 23 Jul 2026 03:18:27 -0700 (PDT)
X-Received: by 2002:a05:600c:4ecd:b0:493:c77c:108a with SMTP id 5b1f17b1804b1-49573d218camr25163275e9.36.1784801906974;
        Thu, 23 Jul 2026 03:18:26 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:5521:6b10:58fd:68f:7756:389d? ([2a0d:3344:5521:6b10:58fd:68f:7756:389d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4956a6354a3sm218761215e9.10.2026.07.23.03.18.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jul 2026 03:18:26 -0700 (PDT)
Message-ID: <d2014044-d410-466a-ae66-2a173dbdba82@redhat.com>
Date: Thu, 23 Jul 2026 12:18:22 +0200
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v12 4/4] net: mana: recover port on attach
 failure in ethtool operations
To: Dipayaan Roy <dipayanroy@linux.microsoft.com>, kys@microsoft.com,
 haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, leon@kernel.org, longli@microsoft.com,
 kotaranov@microsoft.com, horms@kernel.org, shradhagupta@linux.microsoft.com,
 ssengar@linux.microsoft.com, ernis@linux.microsoft.com,
 shirazsaleem@microsoft.com, linux-hyperv@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-rdma@vger.kernel.org, stephen@networkplumber.org,
 jacob.e.keller@intel.com, dipayanroy@microsoft.com, leitao@debian.org,
 kees@kernel.org, john.fastabend@gmail.com, hawk@kernel.org,
 bpf@vger.kernel.org, daniel@iogearbox.net, ast@kernel.org, sdf@fomichev.me,
 yury.norov@gmail.com, pavan.chebbi@broadcom.com,
 schakrabarti@linux.microsoft.com, gargaditya@linux.microsoft.com
References: <20260711041415.3008868-1-dipayanroy@linux.microsoft.com>
 <20260711041415.3008868-5-dipayanroy@linux.microsoft.com>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260711041415.3008868-5-dipayanroy@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/11/26 6:10 AM, Dipayaan Roy wrote:
> When mana_attach() fails during ethtool ring size or channel count
> changes, the port is left in a broken state with no recovery
> mechanism, requiring manual intervention to bring the port back up.
> 
> On VM SKUs without a netvsc fallback interface, this results in
> complete loss of network connectivity to the VM.
> 
> Fix by scheduling queue_reset_work when mana_attach() fails. The
> preceding patch ensures mana_detach() always completes its full
> teardown (netif_device_detach + cleanup), so the reset handler's
> mana_detach() takes the "already detached" early return, preserving
> port_st_save for a successful mana_attach() recovery.
> 
> When mana_attach() fails, choose retry values that maximize recovery
> chances: if the operation was an increase, fall back to the previous
> working values; if it was a decrease but still above default, fall
> back to defaults; otherwise use the minimum supported values.
> 
> Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>
> Tested-by: Aditya Garg <gargaditya@linux.microsoft.com>
> Signed-off-by: Dipayaan Roy <dipayanroy@linux.microsoft.com>
sashiko gemini sees quite a bit of problem with the above approach:

https://sashiko.dev/#/patchset/20260711041415.3008868-1-dipayanroy%40linux.microsoft.com

Also, changing user-setting in case of fallback is quite a bad thing to
be avoided.

Skimming over the code, it looks like than pre-allocate all the
resources and to a replace instead of detach/attach() looks feasible. I
suggest investigating such path. I also think that this last patch (and
possibly 2/4) could/should be in separate series.

Finally and most relevant thing; AI review comments should be explicitly
acknowledged by either debating them or addressing them. In both cases a
reply on the ML is expected.

/P


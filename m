Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.10
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793265053;
	b=hXvmOy4LvdnLgFbwjs6gq7Pn/jnWoVsnsLDLN/fNhT9SxZoQiado73EfaZd2B6yz3q80
	 jUtlMxhrnwMf64+lecA//bK/2bvJcJl3CchzOu6AZAAzPFSSsHQL5Oxe3HRp0wt0LFiZ5
	 TvnwNX5/G/FdieRdmFNe0uS5vmBEJ0XxSKHajikCECMtQu74tHU6OMnEMIoD01iT7WJ0D
	 D5klvFIXKhsrrl6aIbPHUvNuSwmvQUONZS+kG7PHsxHylq3IQiGlxFcptShAbOHAbOLQ1
	 1KN1BbjHIEpAg2LSvfIKWkJzbGxWLaRTlfToe2QPeWOvbLbI+XT3VNOVmHe0BE1KiPg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793265053;
	h=DMARC-Filter:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Content-Language:To:From:Subject:Cc:Content-Type:
	 Content-Transfer-Encoding:X-ZohoMailClient;
	bh=F6DWSfLtE1W+1C0pQQKBI9xMcUjOnxnYXDzXRNrRD/M=;
	b=Ewg2D/E11V6Lj6Rz6J+29CUS8OlJ5tbmaKDH72cAO/7RdZSy3TtcZcV6kDVt+0rui8aC
	 i4DtOXTAb2JwMeHmPAKZ8odbM0LHvERiiQVZ/jtCMHeDRX0ISzTS6g22EP/b7XpE9G9jj
	 wr1Vs2c6VTd+WglM+lfTqxQ0D+OTuTHrr+s61r5tCabBpwptwPoB74PY5R85M7CIUjPwo
	 96SFYu9MfEsD0TbflrfO33do8LPXk0Vb03PtibiUsdi1wMH0/p7uXyZbLNKurW4cVkEJ2
	 mCCNzrVbljI+FnMvQIDpsWFw6AEmKrfgoCtqrkBCqobtU2wsPcIiVJdZ7tpDO0KKY9A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=boussejra.com;
	spf=pass smtp.mailfrom=boussejra.com;
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.10
Received: from sender5-op-o10.zoho.com (sender5-op-o10.zoho.com [165.173.182.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56685606A31A;
	Thu, 29 Oct 2026 09:10:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 56685606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=boussejra.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=boussejra.com
ARC-Seal: i=1; a=rsa-sha256; t=1793265046; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=EWl9mqwxlrEB3biAxPHkWeGzFfPcQGUTHaqKlxVynSIDpIv81pLjjWhZKxxO7zmHprOcfR4ulycbHpi37OLhb56qT6gssz4T6u3+I0dZNvFeskzp01mYXR/zAZmAJaJZmL/kIOaGnOC5ycgc7Opxee7fPTsM0M1Cl8BpJ9T4EsI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1793265046; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=F6DWSfLtE1W+1C0pQQKBI9xMcUjOnxnYXDzXRNrRD/M=; 
	b=n0Ovo7hsQZug9icVG0q4BbDzJGPdcOypVOGOOsJxxzx9uX7HcLFHUvBLbbldO5e8Y/LMTUmYnjnMBeB/ygCYqh71fF/CRrICg5ufyC6GQ4IqPuH9qjyXfQNnkYVhT3zQVpV6zBdobh1RBcScCwaUachjOFDZu26Q3tasLxs34vE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	spf=pass  smtp.mailfrom=amir@boussejra.com;
	dmarc=pass header.from=<amir@boussejra.com>
Received: by smtp.zohomail.com with SMTPS id 1793265044668760.2367521296013;
	Thu, 29 Oct 2026 02:10:44 -0700 (PDT)
Message-ID: <40fb2352-4859-4334-849b-f6a4229605a1@boussejra.com>
Date: Thu, 29 Oct 2026 10:10:42 +0100
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
Content-Language: en-US
To: linux-hyperv@vger.kernel.org, netdev@vger.kernel.org
From: Amir Boussejra <amir@boussejra.com>
Subject: hv_netvsc: user-configured RSS indirection table is zeroed on MTU
 change
Cc: amir.boussejra@gatewatcher.com
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Hi,

On Azure/Hyper-V, any MTU change on an hv_netvsc interface silently zeroes a
user-configured RSS indirection table, so all RX traffic lands on ring 0.

Reproducer in our case (any multi-queue hv_netvsc NIC, ethtool and ip only):

```
  ethtool -X eth0 hkey $SOME_KEY equal 4
     ethtool -x eth0             # See conf
     ip link set eth0 mtu 1600     # must differ from the current MTU
     ethtool -x eth0               # all zeros in indirection table
```

With the table left to the driver (ethtool -X eth0 default) the same MTU
change is harmless: the table comes back correctly spread.

Confirmed with kprobes on 6.12.90 - these all fire on the MTU write:

```
     netvsc_change_mtu
     netvsc_detach
     rndis_filter_device_remove
     netvsc_attach
     rndis_filter_device_add
```

[`netvsc_change_mtu()`](https://github.com/torvalds/linux/blob/v6.12/drivers/net/hyperv/netvsc_drv.c#L1209)

An MTU change re-creates the device:
[detach](https://github.com/torvalds/linux/blob/v6.12/drivers/net/hyperv/netvsc_drv.c#L1233), 
then
[attach](https://github.com/torvalds/linux/blob/v6.12/drivers/net/hyperv/netvsc_drv.c#L1239).

The detach [frees the RSS indirection 
table](https://github.com/torvalds/linux/blob/v6.12/drivers/net/hyperv/rndis_filter.c#L1622)
(`rndis_filter_device_remove()`), and the attach
[allocates it 
zeroed](https://github.com/torvalds/linux/blob/v6.12/drivers/net/hyperv/rndis_filter.c#L1557)
with `kcalloc()` and refills it only if
[`(!netif_is_rxfh_configured(net))`](https://github.com/torvalds/linux/blob/v6.12/drivers/net/hyperv/rndis_filter.c#L1572)
(`rndis_filter_device_add()`).



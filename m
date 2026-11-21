Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=5.133.65.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795253164;
	b=BQ7E9/ASeD1b1nM4s67xMCHWYKprIzTgC/dIk3Od6AoZBhb8W1E8PKZYK7WBHTJU1Xju
	 3Eu7Te4quESH2GO0P9F9uMd5896v0yk1OT8jnKnFiUQL1PsoaMt6hfesJL7Eww1VfmZLv
	 eOo+JBgbA/hi5+zfguleZ65buzCqvi2do6nIDUfirU7NgDRYYHblgJqU8b4vb2oDSZbYT
	 PEVNi0hocTpxQ8PDmCNgRUkv6K0YYKIBKB5n6ZJ7pONQ8wTrGYG759vbY48atAgOftA4S
	 HJtmELnvpWltotCie3wiqrXg61iPwbxFKg2fAId3o/IJSs+QD8opbJA4+ZhOTxvi+sA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795253164;
	h=DMARC-Filter:Received:Received:From:To:CC:Subject:Thread-Topic:
	 Thread-Index:Date:Message-ID:Accept-Language:Content-Language:
	 X-MS-Has-Attach:X-MS-TNEF-Correlator:x-originating-ip:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=1bT0q/aRVAH1jqWgPlGl1hakvgxsdFRMmxHIa/Gd7i4=;
	b=gPMT4IckBTSc9jRO+/Zirc5ND+QADNyH2M7ibeuRj4SzelxYAhQ7qeFjWQXGtJShItyk
	 R5wcMwlEdDybXO6A3BLFoYUF6knYunIItv/9s0Pj8ljk4+x+rAXHZefDJRg/31IPdMG6c
	 lfMRk6Nc7w48qjWo51O/SMC92fIw967Kacx89sceSBGHOWmC8saU0K/bnFjEWndjvbMvW
	 pkHkjCCVJzLA4MGtjQar8T7m+aWjZd4g0rfC7R/EmMP5HluXfh81/bNqwruG59KIrgzTV
	 GbYLh1eKihjH4FHqz0PUikASKuDyM2vXO5CaZYMvsSy8rmeSt1T6HNrqAJznfnXSaCg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=sysadmins.club;
	spf=pass smtp.mailfrom=sysadmins.club;
	arc=none smtp.remote-ip=5.133.65.174
Received: from mail.sysadmins.club (mail.sysadmins.club [5.133.65.174])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8178B606A32A
	for <linux-hyperv@vger.kernel.org>; Sat, 21 Nov 2026 09:26:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8178B606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sysadmins.club
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sysadmins.club
Received: from srv-mbx-01.corp.admin.ck.ua (10.12.12.18) by
 srv-mbx-01.corp.admin.ck.ua (10.12.12.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.12; Sat, 21 Nov 2026 11:26:23 +0200
Received: from srv-mbx-01.corp.admin.ck.ua ([fe80::4c8f:70ba:30f7:d6a2]) by
 srv-mbx-01.corp.admin.ck.ua ([fe80::4c8f:70ba:30f7:d6a2%5]) with mapi id
 15.02.1258.012; Sat, 21 Nov 2026 11:26:22 +0200
From: Artem Matviychuk <asm@sysadmins.club>
To: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
CC: "haiyangz@microsoft.com" <haiyangz@microsoft.com>, "wei.liu@kernel.org"
	<wei.liu@kernel.org>, "decui@microsoft.com" <decui@microsoft.com>
Subject: [BUG] hv_balloon: hot-add request larger than 64 GiB is truncated
 (page_cnt:24), host and guest memory accounting diverge by 64 GiB
Thread-Topic: [BUG] hv_balloon: hot-add request larger than 64 GiB is
 truncated (page_cnt:24), host and guest memory accounting diverge by 64 GiB
Thread-Index: AQHdeZpfp9xvKZzBj0GMzHtgieYyKg==
Date: Sat, 21 Nov 2026 09:26:22 +0000
Message-ID: <5c4f93c2d38443348ef29b57547c10c0@sysadmins.club>
Accept-Language: en-US, ru-RU, ru-UA
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Post: <mailto:linux-hyperv@vger.kernel.org>
List-Help: <mailto:linux-hyperv+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hyperv+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Hello,=0A=
=0A=
On a Linux guest with Dynamic Memory, a single hot-add request larger=0A=
than 64 GiB seems to be truncated to its low 24 bits of page count.=0A=
The host then accounts for memory the guest never added, and later=0A=
balloons the guest far below its configured minimum.=0A=
=0A=
Setup=0A=
  Host:  Windows Server 2022, build 10.0.20348.5756=0A=
  Guest: Debian 13, kernel 6.12.113+deb13-amd64, Generation 2 VM, 32 vCPUs=
=0A=
  VM memory: startup 32768 MB, minimum 32768 MB, maximum 131072 MB,=0A=
             buffer 20%, Dynamic Memory enabled=0A=
  hv_balloon: protocol version 2.0, hot_add=3DY, auto_online_blocks=3Donlin=
e,=0A=
              memory block size 128 MB=0A=
=0A=
What happens=0A=
  The guest commits about 105 GiB (Committed_AS) shortly after boot.=0A=
  About 50 seconds after boot the host grows the VM to its maximum.=0A=
=0A=
  Guest log:=0A=
    Memory: 32514644K/33553344K available=0A=
    hv_vmbus: hv_mmio=3D[mem 0xf8000000-0xfed3ffff],[mem 0xfe0000000-0xffff=
fffff]=0A=
    [   52.772118] hv_balloon: Max. dynamic memory size: 131072 MB=0A=
  No "hot_add memory failed" or "Memory hot add failed" messages.=0A=
=0A=
  Host, same second (Hyper-V-Compute-Admin, event 10020):=0A=
    The dynamic memory balancer could not add memory to the virtual=0A=
    machine because its configured maximum has been reached=0A=
=0A=
  Host view afterwards:=0A=
    Get-VM: MemoryAssigned 128 GiB=0A=
    Hyper-V Dynamic Memory VM counters:=0A=
      Memory Add Operations          2=0A=
      Added Memory                   98526 MB=0A=
      Guest Visible Physical Memory  131072 MB=0A=
=0A=
  Guest view afterwards:=0A=
    MemTotal 63.3 GiB, lsmem: 64G online, 0 offline=0A=
      0x0000000000000000-0x00000000f7ffffff   3.9G=0A=
      0x0000000100000000-0x0000000fdfffffff  59.5G=0A=
      0x0000001000000000-0x0000001027ffffff   640M=0A=
    /sys/kernel/debug/hv-balloon:=0A=
      pages_added            : 8388608    (32768 MB)=0A=
      pages_onlined          : 8388608=0A=
      max_dynamic_page_count : 33554432=0A=
=0A=
Arithmetic=0A=
  Boot memory ends at 0x808000000. The high MMIO window starts at=0A=
  0xfe0000000. If the host sends two hot-add requests,=0A=
    1) 0x808000000-0xfdfffffff     =3D 32128 MB=0A=
    2) from 0x1000000000 upwards   =3D 131072 - 32768 - 32128 =3D 66176 MB=
=0A=
  then request 2 is 16941056 pages, which does not fit into=0A=
    union dm_mem_page_range { struct { __u64 start_page:40;=0A=
                                       __u64 page_cnt:24; } finfo; ... }=0A=
  16941056 mod 2^24 =3D 163840 pages =3D 640 MB, which is exactly the size=
=0A=
  of the range the guest added above the MMIO window, and=0A=
  32128 + 640 =3D 32768 MB matches pages_added exactly.=0A=
  I did not capture the requests on the wire; the two sizes above are=0A=
  derived, not observed. The host counter shows 98526 MB added, which is=0A=
  222 MB more than 131072 - 32768; I cannot explain that difference.=0A=
=0A=
Consequence=0A=
  The host believes the guest has 64 GiB more than it has. When the=0A=
  guest's committed memory dropped from about 107 GiB to 43 GiB, the host=
=0A=
  removed about 58 GiB by ballooning. The guest went from MemTotal=0A=
  63.3 GiB to about 4-5 GiB within 10 minutes (minimum is 32768 MB) and=0A=
  stayed there, logging=0A=
    hv_balloon: Balloon request will be partially fulfilled. Balloon floor =
reached.=0A=
  every 5 minutes. The host reported pressure 73 and returned nothing:=0A=
  assigned 68.4 GiB, demand 50.6 GiB by its accounting. At that point:=0A=
    pages_ballooned 15634328 (59.6 GiB), MemTotal 3.9 GiB.=0A=
  This happened twice, each time after a sharp drop of Committed_AS.=0A=
=0A=
Control=0A=
  Another VM on the same host with the same kernel, startup 32768 MB and=0A=
  maximum 49152 MB shows no discrepancy: assigned 48 GiB, 48G online.=0A=
=0A=
Questions=0A=
  1. Is page_cnt:24 the actual wire format, so that the host must not=0A=
     send a range above 2^24 - 1 pages, or does the host encode larger=0A=
     ranges differently?=0A=
  2. The guest reports resp.page_count for what it added. The host seems=0A=
     to account the full request anyway. Is that expected?=0A=
=0A=
The page_cnt:24 field is the same in v6.12 and in current mainline.=0A=
As a workaround I plan to lower the VM maximum so that no single=0A=
hot-add range can exceed 64 GiB.=0A=
=0A=
I can provide full dmesg, the debugfs output and host counters, and I=0A=
can test patches on this configuration.=0A=
=0A=
Thanks,=0A=
Artem Matviichuk=0A=

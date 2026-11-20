Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.12
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795179329;
	b=f83Qyv5bMuP7ARP05jITE+EzkNetVIFsUTOkza2vX/98+j080reSdhjwnFtShQHJXZoC
	 xR4zVHbrj8zR7x78zjM7qKaYAEFJqI/6m//TbjHvkB8astT0Gd+ECKOK2Fhkz9mHdns9D
	 lQKMItOjnKZBY0KZzUXzFbUDkDsnctsezqsDnG+3PMpoUNejSBRWffu688hpig8KHs6Qg
	 NhUY1nlTia6ahwP+Wpygl39IyXEj0n/jkEGVraC5fhW1FfN5EiNa5dnbxIhpe/wVWPYQB
	 KigkuPd4BtWhzrikGvnMV0wuTx349gcT/iTgrvDM7FPIv49GcDdU9zT3tCUADFN3ySA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795179329;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:Date:To:cc:
	 Subject:In-Reply-To:Message-ID:References:MIME-Version:Content-Type;
	bh=I8RObEtMvkht1sbLCyliak2Fn1H/lGUtdD84tJEgvVY=;
	b=bA9HN+uA7jC1HK2GwsplPDKI/v5B+tLY4Gdn0ZZsYXpdaGKjP5F/xdYD6REpNXeDF877
	 FATGA3tMwfAHlAb+mYRD883WE8hbo+uBBmtS+Lgt2RdVbDgHmg+oRGYmKRrljEDdWhWXo
	 oplnjMsp3abxRw5DWkTSooz0Z2uFSWIPxBgt8Nv7rRaGtUTX2GOEgPL6GOJCEB3qZiKZJ
	 J32+5xZXZXORlDu3pKGfMje0yJKqxJTcUP6fGML1VhHsvmAFDq+zY8j2BSpqLlUFPiXgf
	 7T6rvt0VAub5sOIEAblkJo2wjiO2chrVC2PPU1HsniPown/RH193p+jw4Gtj8ZwavCg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=GE1UtLxN;
	arc=none smtp.remote-ip=198.175.65.12
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA074606A325;
	Fri, 20 Nov 2026 12:55:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AA074606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=GE1UtLxN
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795179329; x=1826715329;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=FAjrkmqEdpuogErud616lvLHOdrZZqc+RsavMU4L/pM=;
  b=GE1UtLxNZSHGc5r+9YqH6L0hOAiyCX9I2GiUtLDJApJHPgbpQpaY9mKW
   /UkOk2g3hiOGGwt1OTLz9nuLoiw5EJibEFWyLGYUX+iGJJ5PrlW9eJGvy
   hbQ+ol/pf5ppuPXmSCCtC9MxrcS5iTdu/nQO/LvTRetyDKDM1FD+N+AP+
   mz3O95AngCToUoRKA7PIKhz3ecoCGfVqVZmFDVfSDLjof3TuJlw+XvkL4
   hCWCnWdqMcpkL0sBewVCitguioXnpMM51uBY61ZJBD1X0OdhcW/milVE3
   8OWSTyCdftQy1TVZD6hi7PBD1SNr7BQQ2JONC5EBFD1Pp9hjM1sZJA3Cx
   w==;
X-CSE-ConnectionGUID: FLz9hZJJTk6/qcp6EYSMeg==
X-CSE-MsgGUID: i3qbBPznSQqEovsbjP9Fhg==
X-IronPort-AV: E=McAfee;i="6800,10657,11971"; a="3940543"
X-IronPort-AV: E=Sophos;i="6.27,222,1787036400"; 
   d="scan'208";a="3940543"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 04:55:28 -0800
X-CSE-ConnectionGUID: MzCm/SCVTdqar30HlSLj+g==
X-CSE-MsgGUID: Bk8lltboQPyJbqZH3OmAJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,222,1787036400"; 
   d="scan'208";a="12533922"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.16])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 04:55:23 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 20 Nov 2026 14:55:20 +0200 (EET)
To: Michael Kelley <mhklinux@outlook.com>
cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, 
    Bjorn Helgaas <bhelgaas@google.com>, 
    Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, 
    Rob Herring <robh@kernel.org>, 
    =?ISO-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kw@linux.com>, 
    Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
    Dexuan Cui <decui@microsoft.com>, 
    Lorenzo Pieralisi <lpieralisi@kernel.org>, 
    =?ISO-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kwilczynski@kernel.org>, 
    Manivannan Sadhasivam <mani@kernel.org>, 
    "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>, 
    "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 12/13] PCI: hv: Convert to
 pci_assign_unassigned_bus_resources()
In-Reply-To: <MN2PR02MB68637F500EFB95B333A87429D47A2@MN2PR02MB6863.namprd02.prod.outlook.com>
Message-ID: <a1520d14-ad7d-c9cf-5a7d-628d04ede311@linux.intel.com>
References: <20261116152403.2672-1-ilpo.jarvinen@linux.intel.com> <20261116152403.2672-13-ilpo.jarvinen@linux.intel.com> <MN2PR02MB68637F500EFB95B333A87429D47A2@MN2PR02MB6863.namprd02.prod.outlook.com>
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Post: <mailto:linux-hyperv@vger.kernel.org>
List-Help: <mailto:linux-hyperv+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hyperv+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1259283716-1795179320=:1182"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1259283716-1795179320=:1182
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 18 Nov 2026, Michael Kelley wrote:

> From: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com> Sent: Monday, No=
vember 16, 2026 7:24 AM
> >=20
> > The pci-hyperv driver scans the bus and assigns resources using
> > pci_bus_assign_resources(). That function makes bridge window sizing
> > disjoint from the assignment phase and is going to be removed.
> >=20
> > Convert pci_bus_assign_resources() to
> > pci_assign_unassigned_bus_resources(). If no other bridges are involved=
,
> > the extra sizing should be no-op.
>=20
> I tested this series on an x86 VM in the Azure public cloud that has
> 5 NVMe devices and a Mellanox VF NIC. All 6 devices are PCI pass-thru
> devices in the VM that are initially set up using the pci-hyperv.c driver=
,
> so each device has its own root bus and bridge. No issues were seen in
> a basic smoke test.
>=20
> I added some debug code to pci_assign_unassigned_bus_resources(),
> and indeed the "for_each_pci_bridge()" loop found nothing as each
> device was setup. So __pci_bus_assign_resources() was called with an
> empty add_list, and as expected, the new execution path is equivalent
> to the old pci_bus_assign_resources() call.
>=20
> Question: Your cover letter says drivers that call pci_assign_resources()
> directly are not covered by this series. pci-hyperv.c *does* call
> pci_assign_resources() directly in hv_pci_allocate_bridge_windows().
> Is that a problem? I don't understand all the details of the PCI resource
> assignment well enough to judge for myself. :-(

There's a small name mixup here.

pci_assign_resources() is to graft a device's resource (or a window) into=
=20
resource tree, whereas that calls pci_add_resource() adding windows to the=
=20
root bus and that seems to occur before there is anything underneath. At=20
this point, there's nothing to do for the resource fitting and assignment=
=20
algorithm (it iterates the devices underneath).

=2E..So I don't see a race here related to pci_assign_resources().

Most entrypoints of the fitting and assignment algorith input bus, and I=20
don't think anything in kernel would as to assign resources underneath=20
that root bus. Only pci_assign_unassigned_resources() looks for all root=20
buses, and that is only called from arch init code so I don't think vfio=20
setting up it host bridges matters with that call.

There seems to be, in general (not just hyperv), some races that are=20
unrelated to resource setup in host bridge setup and scanning. I'll see=20
what I can do but it'll be in a separate series and those seems to fall=20
under can-shoot-oneself's-own-foot category.

Thanks for taking a look.

--=20
 i.

> In any case,
>=20
> Tested-by: Michael Kelley <mhklinux@outlook.com>
>=20
> And at least to some degree,
>=20
> Reviewed-by: Michael Kelley <mhklinux@outlook.com>
>=20
> >=20
> > Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> > ---
> >  drivers/pci/controller/pci-hyperv.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controll=
er/pci-hyperv.c
> > index 824cf27e85e6..8eff3e9b325f 100644
> > --- a/drivers/pci/controller/pci-hyperv.c
> > +++ b/drivers/pci/controller/pci-hyperv.c
> > @@ -2549,7 +2549,7 @@ static int create_root_hv_pci_bus(struct hv_pcibu=
s_device *hbus)
> >=20
> >  =09pci_lock_rescan_remove();
> >  =09hv_pci_assign_numa_node(hbus);
> > -=09pci_bus_assign_resources(bridge->bus);
> > +=09pci_assign_unassigned_bus_resources(bridge->bus);
> >  =09hv_pci_assign_slots(hbus);
> >  =09pci_bus_add_devices(bridge->bus);
> >  =09pci_unlock_rescan_remove();
> > --
> > 2.47.3
> >=20
>=20
>=20

--=20
 i.

--8323328-1259283716-1795179320=:1182--

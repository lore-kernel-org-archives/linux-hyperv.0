Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazolkn19012083.outbound.protection.outlook.com [52.103.20.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 932AA371076;
	Thu, 24 Sep 2026 18:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.20.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790274214; cv=fail; b=Vkggz47WTgsF6Ge0w8RCDwo9oUCCrImYiLkOHyvXs0a4TeMr+PfGeK91tUtTdvT9ERNkb8LJ09tASH9JiHiA2Huh9bilee/06SqQ/tHVIEWO94vMJKe2rp+VioDwGr7J1hjRwhNQT5m+z4TjUFo845e+LDKeucwYP8c3vg0kokU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790274214; c=relaxed/simple;
	bh=q0rdpwaS5MpBRJcLcp7Djfao/QNq7JRJD2dH/tk84R4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Xl5mHmWJge5YUaUzIKnZKR8QXs5ZFNeMd28ljB+9Wd7STihFMhzhwTXaReD00bKSpqFH6MiMkS0568p1BQxhm8hrz2etfUrLjltqPMC1zRw/fY8+dE1vQnx4c17zdQ/l59JO3Fh4MqektRJbjq2baFyB87wD2xC1Swr3tRCzshw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=YpFeJiSe; arc=fail smtp.client-ip=52.103.20.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="YpFeJiSe"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C/eTVBeoOXtJnNYqeVAY/DVnFbbYnN4rZX/n0+ZtlU55O05hZl0EEa0wwtcmnc92zKQNZegeSlcI3mI93rlQzARRwu8Dw3JkqtxQWZ3Bh/1KIZO7u/XxpVVPS17BBxhnoB39CDPje9oXsDCVRpGyDxd9Vq4DDlkn8Q878L+cIr8su/akJi9nqMwIGOyAsJB3duTrAfycd8bB33frbSUsGH70Ma1QHALHhSZbWeMqPvTAk7tR242LWj2lsbW6YAmyMFyn9B85q9LBP1sqPNPIpClyNiuzz/pNlxNJ7+I5HOHY8Rnz+WIkHDjIhP6Xa6tiaMyhGltUjc2amV7sCFCUJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AaQBRqyQ8BguKICXnDxN/P7wzgzzTS9g1uHQLsoV+b8=;
 b=vPXkJkbXst5eWZsussoB4DrSyiy1ZpmqF7+8HHzMoznNStbQnh2iq/oyDbM0h2vRhjASa6HAC7yZq3eRoPRyV7d/Km4zfTWbfB7oTYQYhLhwZtEffeDnwds3ihfYAIhlZcmZPTcDyH+WMI2jc83nprBxg/iKzeCdei2IokuXyqpuZzniedHz9Zg6hDOK8PQtbi1ECU6xlcSbgGZQcuZUkZflCANHj2XUh/SvOqy/PBaiU6bmyNvwftVSYywHndDvAZb/FU6TqhJaXgg+Gykvjs3Hg2ENtkbhQ2hQMP6q3s+vd52bbXKDuxb8FlViN8EeNL1+XMRvCzT9GMq7ITczSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AaQBRqyQ8BguKICXnDxN/P7wzgzzTS9g1uHQLsoV+b8=;
 b=YpFeJiSeGK9YGsnF1SQCWbpeHTNpqzZC08+nmKs6SNkR1EgR8+3X4dDVqIENFzF5aE6trkixcrOA+PGMsgKE70QURRoMzkAO22ew9OJiB1aQmitSKCDjCLiVNV39BtLNvBfN/15K47ieEhM47eDp6Z2uj+iRfcQuvWS4Gstovq9A4ayg+DBjHs3u+/+2hOIUYy4IM47vI4DZU1WPTYdmbxd2l62+di82CPq0cuz1t8kdDU+73snQIEledO/lwVrWZ7yWiQ0oSJpdtgHWrtMLxXpB557B6OqZytyQPmAb8RVBibxToGIjBOFT346s4Xjx9acyWXIdjk+WjZO2AUzT0A==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by MWHPR02MB10521.namprd02.prod.outlook.com (2603:10b6:303:286::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Thu, 24 Sep
 2026 18:23:28 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%5]) with mapi id 15.21.0451.014; Thu, 24 Sep 2026
 18:23:28 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich
	<dakr@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux on
 Hyper-V List <linux-hyperv@vger.kernel.org>
CC: Linux ACPI <linux-acpi@vger.kernel.org>, LKML
	<linux-kernel@vger.kernel.org>, Linux Driver Core Development
	<driver-core@lists.linux.dev>
Subject: RE: [PATCH v2] driver core/ACPI: Introduce companion_bus_register()
Thread-Topic: [PATCH v2] driver core/ACPI: Introduce companion_bus_register()
Thread-Index: AQFaPXDaltCSjsbsGnWHrXxa2Wl6TrfifnxggAGqK4A=
Date: Thu, 24 Sep 2026 18:23:27 +0000
Message-ID:
 <SN6PR02MB41575266A4580339E186E5D9D4812@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <6329043.lOV4Wx5bFT@rafael.j.wysocki>
 <SN6PR02MB41577ECCDB3E757B8859AE7FD4822@SN6PR02MB4157.namprd02.prod.outlook.com>
In-Reply-To:
 <SN6PR02MB41577ECCDB3E757B8859AE7FD4822@SN6PR02MB4157.namprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|MWHPR02MB10521:EE_
x-ms-office365-filtering-correlation-id: 5714feec-1fe4-4ff6-eca1-08df1a68edf5
x-ms-exchange-slblob-mailprops:
 suo+AMQROd7awkY+uqD1IG9kXGqTcr3cp0PLuJLCBqAUmsvZZOzpwq+AdW1WVwj4cX49wVL2FbStVitwqwWz0QGHsh6jp9JPTdcC2mOAKUStFoCM1fF1ANzDClv3kiG5VF8zTdcSTRS5G7x7SZQFj+59+GHNpjoM4L5reKpcaPX3hGBcHBbjIh6l5pjFXhrOYZLPfVcaA1mFmKwY6FRrlEMaFMeFAblBqDS8J0Uvyh/WXC6wKf+X9KsYD6GIQi/JUqALsjoLwqwATiwwYU24sR7ayhLA/Fr2bWlAdvuSbARJzMjQ28EzVQzl+6gipO2YjIW/ojpfvXruJW8ji4W4H0wuYqWNYJOIROtOacOGtvBeAdcDOORXWrsRs94b0vY9efyiJomHVBRi2EL1If6axffilP45xCu19D4bjgvpFblrOYAUo5cZj471mtGioy5cpqSawUbtMdN0htitEYhk8M3OIw/i5q/5ZT78L3n4rootWM0S+3FFzIFGn5Z72Mk1lfOMrrXqyX1J8WBNTgJk0tMu3em1EVrauO9tF+NoRiLDS+TrqSjZ2SCvMedY29bzAB0BNYI4lUnBoaFDZNH16U7qbG/2xhk20/2H+EcGugh5ILtxXquqEAs97DQdlYiH4iZTfTJNHABWpySXbujs2x0GJrsbd3w5dOWkwqUZN8Jsji7dZWl8eO/nJH7xHJ+WbFXyTYdyX3ICS9V35iIAMYc1T2HZpSE1mhjClE5QPTWeoca7NKT9F8NAI1KQX0uXCaAz+uFVqRMJM3V+oN68UVZ8k8U9/tcRPL0NjzjHl6CBsLepmjFnOWMINLdKG9Wokd4xdALUOJohcJLz437BmA==
x-microsoft-antispam:
 BCL:0;ARA:14566002|8060799015|13091999003|19110799012|51005399006|8062599012|31061999003|55001999006|37011999003|15080799012|41001999006|12121999013|24021099003|25010399006|56899033|3412199025|440099028|4302099013|102099032|12091999003|40105399003|2607281247196008|1602099012|1141799003|10035399007;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?zTfH65OO95FVFquj6oBAGTmbqhnrBBgL/CPDDHmN26Wy1jegl77JtGQXZO21?=
 =?us-ascii?Q?AuFCKd68jNn8RG01qOc5aOzlLCCPEQd6oyiWeEIEQ/eaGo9BhOxIsduN+5no?=
 =?us-ascii?Q?MRlLpU48x2b5pG3lnU87EqZYlqgGLHit6TdzQ4e3kX6OZAEVMnPC/RissSBr?=
 =?us-ascii?Q?06zVifXJLroJr9yzdWZj/w1w6v1DK2Vl2ncR/L+fb504WRyeS+24Cwo5dkxt?=
 =?us-ascii?Q?Ol9FlQ8OjGcxAZurNGk1toCC859ZcjZShdukcvFApzvO5sz7j9X/B4IHoRjX?=
 =?us-ascii?Q?TJqsW1QRF5QpwrceSXFrDYDeI3Py3aiNNmKihyIADwv5+BoiR1qVGUVaDGtk?=
 =?us-ascii?Q?Q12yheb1nAYapR1kkflnvkvnN1smB1xmToz4r724kzJw+gbdWwco8ppIa6Bh?=
 =?us-ascii?Q?w1gPMDrP/8HSfr1Dzk1X6RFk8upsJrKcgPOzNQ/mQ/shumgJbN3a8HvwrgoD?=
 =?us-ascii?Q?270tZuRAIysbfg/oBkl+BRzdOmELQtQDKgrccYeOTizNWAsTDspX1o4cU74I?=
 =?us-ascii?Q?gEHjeeMtzgxeyFF79XybY17ZLjh38YdLQoECPQMK9vKocz2Aw+uAkBRoCLe/?=
 =?us-ascii?Q?1rYeFATjUcvC1fA6lkRyvL5LdgdfCotMATF3wCue5oz5QKPmqtGHZ7UnFq/S?=
 =?us-ascii?Q?Zu2ENuSR6aYs2IIYJ0jWeOBDFr5Dag+ZOHi4YrYBpgLxyd9twP4T7vDxPeKd?=
 =?us-ascii?Q?N/8H+n0tzyu0+rCCzm0fXiVgL/qWXBhcnaIxAjbZZpuEOMKyA6y46fzEPrMg?=
 =?us-ascii?Q?TWyWrkcbFUFWdiB9+0ifwObPG9ea+rCTU+5Ae7wta7HK9jO4vvbetswHwyHu?=
 =?us-ascii?Q?Vy/m4KqgnnCFlQZ5uqSPnWZFlzgPATaSPNCJD/idAea3M6VZgwyHGw30Jtm2?=
 =?us-ascii?Q?Xjg+77wA6IXdxTNXXkFZEAzU/8sLlB4EeJ2zQTVf+tfnJYGWGbl8cUOH9Azs?=
 =?us-ascii?Q?AJo0013edDFwa4alr8d9DBR7sTLixcEBN5gTDXGpoUdLmoHTutzQBYXNghGB?=
 =?us-ascii?Q?FwV2ZvBqdIglesWYceKecq1EBs6SPcGuelS0o2JAi1z1WJxkJO+ssawh1Aew?=
 =?us-ascii?Q?80Ef9IHDd082icg5nyDrEqWctfQKCsxgetCFGC5ojNqNfwX0+CtLQcJWa4IG?=
 =?us-ascii?Q?Zo5iC34hcHhBZT3FwkEePcncj22cvOFSIczJk3yJ2VkiDnNZPb2l1E5M3TiE?=
 =?us-ascii?Q?B2ix+Hexdb5KpuMm?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?NDr9QMrocSlMRVSC5cHH7Q5bN5rXTTA9K5U/U1VtK/azIZNVxTv+nJbjvf2z?=
 =?us-ascii?Q?7VvpEtbZjzxEfzORNU8UEVVcL+X5Jgva7+uFz/kvK8LikL9kKB+7XAnRIChH?=
 =?us-ascii?Q?CjAzIjYuOk9+eLL3yFDNgNBaIIa2d5DzjeTRYYRz+RTMe3JEzEw0yQbV4k6e?=
 =?us-ascii?Q?zbQnxAAUKzVkgmmSUcVCkkqhmE7+bPyEpUzKVUD/58KZKKznl9q11Woi3FCU?=
 =?us-ascii?Q?CQwWPuKEcXvQPS0JjcdF3yhq4HROjGVwPHZ+BOHd+h+aQqam7buro/ZhH4u9?=
 =?us-ascii?Q?0D9OpQuYrpusyDtLDCQNaU+M60bCkD9mRD3Scm3tMwYoDSgyaPbXPT4gK0tw?=
 =?us-ascii?Q?V/9ggXS5luQBiwLZDVbNJzpgFGiVjkTb+FVBsxdWYZMLWZM9NTYnpISzm8Xc?=
 =?us-ascii?Q?in3Xs/fk3UC2PgvFk4kw2MITN1UNmmplZE4v2Oc+Z4RoS3XrA+TKBYxkbjrj?=
 =?us-ascii?Q?7R1H0iPvPxxs3BUisgeQ1rOSFEaZIk+iMc0/j/D2d4nF9Qhb8uePzo1O+m1r?=
 =?us-ascii?Q?YkmfkEruJT1IUY4FIijt0b39tAQ3D9cM5GjrIi2Qrv5fz9zNhozLvJVlG7P+?=
 =?us-ascii?Q?/K5Jtj7kQTnF/KJdytat3+fh/IPRs5ZRsuBXEMfiw1wp3oy1DX+ckg6dobN8?=
 =?us-ascii?Q?zN6KGNAqNwnT6aXWCOw1uFhuRu2BWDWovKZu+jYWF8LAW8WswdKT0sFUtRFS?=
 =?us-ascii?Q?xyhf5DQEtyKMgJi9YzxHD16VDF9XWYm+79hxO3WatYXAuk7yTVyAeXLRLA1A?=
 =?us-ascii?Q?iNXwRcF0yNOo0O8ktk6g1TBkb5h/3PADNmxI2X1L0+FE0jgisg9R2Tjbx77g?=
 =?us-ascii?Q?+9p3jGRvg9gFV03OwC/pF0z9+yKSemGo7Blo/9iOhrGI70JxSV+2s69e/PYA?=
 =?us-ascii?Q?hQN/j0uVzGpWHEuPJXdETNN8HMBoa7cD8yKAoCoOCX5xsWojCphjIU+7uxkN?=
 =?us-ascii?Q?Ngyy7FpCRFYluDMDLaiU032dUG5TQHEITmowjQhmIdJD/3meY3rdOAst9IEv?=
 =?us-ascii?Q?bQxh/WFIMuHB3jKnIE3WzcXPL9aPHt7AWOES7UUcsIjWupxoAXpdYtjuwGR4?=
 =?us-ascii?Q?hH5jEjpw4/qALQVizYp0qTFKIGPh8fClNWBpoQPI/q0D1/XXOlol55HbPCi/?=
 =?us-ascii?Q?XDbw9YrAICnC0fy9cnZrV2qzlLIFSSDJ3okhDyDcFY1STnZ/mlEQLs/xcA0c?=
 =?us-ascii?Q?fq0r0BMBdvaH2IYOxCtOd1k3DUa0Cv3qpUizBcgSiQfSj5aiMkZfwKTM6g/I?=
 =?us-ascii?Q?6/+HTLhfxUCqOwC6zTbIJi/in3BMqnVJo39LBqoIUf9b0G67Dc6Nrp8+Yr2y?=
 =?us-ascii?Q?nC5UoZ7NfReL9F+KR0VapR9weqGm5Gw0e5BbuhvKce5G5C1eg4UNsvFMcZDZ?=
 =?us-ascii?Q?JRdXgFo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR02MB4157.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 5714feec-1fe4-4ff6-eca1-08df1a68edf5
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2026 18:23:28.0555
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB10521

From: Michael Kelley <mhklinux@outlook.com> Sent: Wednesday, September 23, =
2026 10:06 AM
>=20
> From: Rafael J. Wysocki <rafael@kernel.org> Sent: Wednesday, September 9,=
 2026 9:41 AM
> >
> > The ACPI bus type does not allow drivers to be registered, so the sysfs
> > attributes related to drivers created for it and its devices are
> > useless, and its drivers/ directory is always empty.  All of that is
> > confusing and wasteful.
> >
> > To allow skipping the creation of those sysfs attributes, introduce a
> > "companion" bus type concept and add a special registration function fo=
r
> > registering "companion" bus types, companion_bus_register().
> >
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>=20
> As a heads up, this patch breaks Linux guests booting on Hyper-V.
> Something goes wrong in the VMBus driver getting loaded and
> initialized (drivers/hv/vmbus_drv.c). It may be that the VMBus
> driver is doing something wrong or making an invalid assumption.
> I'll debug the problem today or tomorrow, but any insight you can
> offer would be appreciated. I'm working with linux-next20260921.

Here's what I've learned so far:

1) The problem is apparently due to systemd-udevd being unable
to load modules with the VMBus bus driver or any of the
individual drivers for VMBus devices.

2) I'm testing on Ubuntu 20.04 with systemd version 245. The
problem reproduces on a different 20.04 instance. But everything
works correctly on Ubuntu 24.04 with systemd version 255.

3) If the VMBus bus driver and key VMBus device drivers are
compiled as built-in instead of as modules, the Ubuntu 20.04 system
will boot.

4) If I keep your patch, but change companion_bus_register() to=20
pass "true" as the second argument instead of "false", then the
/sys/bus/acpi/drivers directory is created as before, and everything
works. Also, only adding back the .match function as you suggested
does not make any difference.

5) The VMBus bus is enumerated in the ACPI DSDT. The individual
synthetic devices that are logically on VMBus are not -- they are
"offered" by Hyper-V to the guest at runtime via a custom protocol.
The synthetic devices end up with paths like:

/sys/devices/LNXSYSTM:00/LNXSYBUS:00/ACPI0004:00/MSFT1000:00/<some GUID>

My conclusion is that for some reason, the older system-udevd has
a dependency on the /sys/bus/acpi/drivers directory being present.
This isn't a kernel problem per se, but there's an implicit ABI of sorts
that assumes the existence of the "drivers" directory.

To confirm all this more precisely, I'm trying to find a clever way
to get an strace of systemd-udevd when it errors out due to the
missing "drivers" directory, and somehow relate that back to the
git history of systemd-udevd.

Thoughts?

Michael

> > ---
> >
> > v1 -> v2:
> >    * Address Sashiko feedback regarding possible leaks of references in=
 two
> >      places:
> >
> >      https://sashiko.dev/#/patchset/8753121.T7Z3S40VBb%40rafael.j.wysoc=
ki
> >
> > ---
> >  drivers/acpi/bus.c         |    8 -----
> >  drivers/base/bus.c         |   72 ++++++++++++++++++++++++++++++++++--=
---------
> >  include/linux/device/bus.h |    1
> >  3 files changed, 57 insertions(+), 24 deletions(-)
> >
> > --- a/drivers/acpi/bus.c
> > +++ b/drivers/acpi/bus.c
> > @@ -1120,11 +1120,6 @@ EXPORT_SYMBOL_GPL(acpi_driver_match_devi
> >                                ACPI Bus operations
> >     -------------------------------------------------------------------=
------- */
> >
> > -static int acpi_bus_match(struct device *dev, const struct device_driv=
er *drv)
> > -{
> > -	return 0;
> > -}
> > -
> >  static int acpi_device_uevent(const struct device *dev, struct kobj_ue=
vent_env *env)
> >  {
> >  	return __acpi_device_uevent_modalias(to_acpi_device(dev), env);
> > @@ -1132,7 +1127,6 @@ static int acpi_device_uevent(const stru
> >
> >  const struct bus_type acpi_bus_type =3D {
> >  	.name		=3D "acpi",
> > -	.match		=3D acpi_bus_match,
> >  	.uevent		=3D acpi_device_uevent,
> >  };
> >
> > @@ -1451,7 +1445,7 @@ static int __init acpi_bus_init(void)
> >  	 */
> >  	acpi_root_dir =3D proc_mkdir(ACPI_BUS_FILE_ROOT, NULL);
> >
> > -	result =3D bus_register(&acpi_bus_type);
> > +	result =3D companion_bus_register(&acpi_bus_type);
> >  	if (!result)
> >  		return 0;
> >
> > --- a/drivers/base/bus.c
> > +++ b/drivers/base/bus.c
> > @@ -738,6 +738,11 @@ int bus_add_driver(struct device_driver
> >  	if (!sp)
> >  		return -EINVAL;
> >
> > +	if (!sp->drivers_kset) {
> > +		error =3D -ENXIO;
> > +		goto out_put_bus;
> > +	}
> > +
> >  	/*
> >  	 * Reference in sp is now incremented and will be dropped when
> >  	 * the driver is removed from the bus
> > @@ -930,15 +935,7 @@ static ssize_t bus_uevent_store(const st
> >  static struct bus_attribute bus_attr_uevent =3D __ATTR(uevent, 0200, N=
ULL,
> >  						     bus_uevent_store);
> >
> > -/**
> > - * bus_register - register a driver-core subsystem
> > - * @bus: bus to register
> > - *
> > - * Once we have that, we register the bus with the kobject
> > - * infrastructure, then register the children subsystems it has:
> > - * the devices and drivers that belong to the subsystem.
> > - */
> > -int bus_register(const struct bus_type *bus)
> > +static int bus_register_internal(const struct bus_type *bus, bool use_=
drivers)
> >  {
> >  	int retval;
> >  	struct subsys_private *priv;
> > @@ -960,7 +957,7 @@ int bus_register(const struct bus_type *
> >
> >  	bus_kobj->kset =3D bus_kset;
> >  	bus_kobj->ktype =3D &bus_ktype;
> > -	priv->drivers_autoprobe =3D 1;
> > +	priv->drivers_autoprobe =3D use_drivers;
> >
> >  	retval =3D kset_register(&priv->subsys);
> >  	if (retval)
> > @@ -976,10 +973,12 @@ int bus_register(const struct bus_type *
> >  		goto bus_devices_fail;
> >  	}
> >
> > -	priv->drivers_kset =3D kset_create_and_add("drivers", NULL, bus_kobj)=
;
> > -	if (!priv->drivers_kset) {
> > -		retval =3D -ENOMEM;
> > -		goto bus_drivers_fail;
> > +	if (use_drivers) {
> > +		priv->drivers_kset =3D kset_create_and_add("drivers", NULL, bus_kobj=
);
> > +		if (!priv->drivers_kset) {
> > +			retval =3D -ENOMEM;
> > +			goto bus_drivers_fail;
> > +		}
> >  	}
> >
> >  	INIT_LIST_HEAD(&priv->interfaces);
> > @@ -989,9 +988,11 @@ int bus_register(const struct bus_type *
> >  	klist_init(&priv->klist_devices, klist_devices_get, klist_devices_put=
);
> >  	klist_init(&priv->klist_drivers, NULL, NULL);
> >
> > -	retval =3D add_probe_files(bus);
> > -	if (retval)
> > -		goto bus_probe_files_fail;
> > +	if (use_drivers) {
> > +		retval =3D add_probe_files(bus);
> > +		if (retval)
> > +			goto bus_probe_files_fail;
> > +	}
> >
> >  	retval =3D sysfs_create_groups(bus_kobj, bus->bus_groups);
> >  	if (retval)
> > @@ -1016,9 +1017,41 @@ out:
> >  	kfree(priv);
> >  	return retval;
> >  }
> > +
> > +/**
> > + * bus_register - register a driver-core subsystem
> > + * @bus: bus to register
> > + *
> > + * Once we have that, we register the bus with the kobject
> > + * infrastructure, then register the children subsystems it has:
> > + * the devices and drivers that belong to the subsystem.
> > + */
> > +int bus_register(const struct bus_type *bus)
> > +{
> > +	return bus_register_internal(bus, true);
> > +}
> >  EXPORT_SYMBOL_GPL(bus_register);
> >
> >  /**
> > + * companion_bus_register - register a companion bus type
> > + * @bus: companion bus to register
> > + *
> > + * A companion bus is a bus without drivers.  Devices that belong to i=
t can be
> > + * bound to other devices as their "companions" and represent interfac=
es that
> > + * can be used by the drivers of those other devices.  They may also b=
e used for
> > + * the enumeration of those other devices.
> > + *
> > + * The ACPI bus is a specific example of a companion bus.
> > + *
> > + * Registering a companion bus is like registering a regular bus excep=
t that it
> > + * skips the creation of sysfs interfaces related to drivers for @bus.
> > + */
> > +int companion_bus_register(const struct bus_type *bus)
> > +{
> > +	return bus_register_internal(bus, false);
> > +}
> > +
> > +/**
> >   * bus_unregister - remove a bus from the system
> >   * @bus: bus.
> >   *
> > @@ -1415,6 +1448,11 @@ struct device_driver *driver_find(const
> >  	if (!sp)
> >  		return NULL;
> >
> > +	if (!sp->drivers_kset) {
> > +		subsys_put(sp);
> > +		return NULL;
> > +	}
> > +
> >  	k =3D kset_find_obj(sp->drivers_kset, name);
> >  	subsys_put(sp);
> >  	if (!k)
> > --- a/include/linux/device/bus.h
> > +++ b/include/linux/device/bus.h
> > @@ -113,6 +113,7 @@ struct bus_type {
> >  	bool need_parent_lock;
> >  };
> >
> > +int __must_check companion_bus_register(const struct bus_type *bus);
> >  int __must_check bus_register(const struct bus_type *bus);
> >
> >  void bus_unregister(const struct bus_type *bus);
> >
> >
> >


Return-Path: <SRS0=8B77=Q4=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4B36C43381
	for <linux-hyperv@archiver.kernel.org>; Thu, 21 Feb 2019 17:27:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8FD72080D
	for <linux-hyperv@archiver.kernel.org>; Thu, 21 Feb 2019 17:27:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="MonMwmmh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725845AbfBUR1o (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Thu, 21 Feb 2019 12:27:44 -0500
Received: from mail-eopbgr710108.outbound.protection.outlook.com ([40.107.71.108]:8863
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725831AbfBUR1n (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 21 Feb 2019 12:27:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=har4a5wkbDcApNQIJj/KQYb5Wm3+0Y110WfDXxHMX8s=;
 b=MonMwmmhwUaDyr7QHlMconyQBOFyd8ZvzrDUF43iuBAPNSsPox1A+Vgw8zWlRn1NwQ9H/xGCFakMbJ53SX48gZkQQu7Lo2SjpJbC45JFEh7VP2nxj1RyXYwPdi7/9BbfxFpjt7lhhtH9A5QRAUtpQVIA+N+/5Rx/CcVTfsfndQk=
Received: from DM5PR2101MB0918.namprd21.prod.outlook.com (52.132.132.163) by
 DM5PR2101MB1061.namprd21.prod.outlook.com (52.132.128.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1665.2; Thu, 21 Feb 2019 17:27:37 +0000
Received: from DM5PR2101MB0918.namprd21.prod.outlook.com
 ([fe80::ec2d:d32b:e611:553f]) by DM5PR2101MB0918.namprd21.prod.outlook.com
 ([fe80::ec2d:d32b:e611:553f%9]) with mapi id 15.20.1665.006; Thu, 21 Feb 2019
 17:27:37 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     "lantianyu1986@gmail.com" <lantianyu1986@gmail.com>
CC:     Tianyu Lan <Tianyu.Lan@microsoft.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "mchehab+samsung@kernel.org" <mchehab+samsung@kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "nicolas.ferre@microchip.com" <nicolas.ferre@microchip.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        KY Srinivasan <kys@microsoft.com>,
        vkuznets <vkuznets@redhat.com>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "sashal@kernel.org" <sashal@kernel.org>,
        "dan.carpenter@oracle.com" <dan.carpenter@oracle.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
Subject: RE: [PATCH V4 2/3] HYPERV/IOMMU: Add Hyper-V stub IOMMU driver
Thread-Topic: [PATCH V4 2/3] HYPERV/IOMMU: Add Hyper-V stub IOMMU driver
Thread-Index: AQHUwhUChdXB9clmF0W3TeUetJI4UqXqj7jg
Date:   Thu, 21 Feb 2019 17:27:37 +0000
Message-ID: <DM5PR2101MB091885D1CD3761322191CAAFD77E0@DM5PR2101MB0918.namprd21.prod.outlook.com>
References: <1549894824-26623-1-git-send-email-Tianyu.Lan@microsoft.com>
 <1549894824-26623-3-git-send-email-Tianyu.Lan@microsoft.com>
In-Reply-To: <1549894824-26623-3-git-send-email-Tianyu.Lan@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-02-21T17:27:35.7497325Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=2314f9d2-8068-4997-b1ee-d7df58594c90;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d6ac9747-8df8-442b-cdd0-08d69821dff1
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:DM5PR2101MB1061;
x-ms-traffictypediagnostic: DM5PR2101MB1061:
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-exchange-diagnostics: =?us-ascii?Q?1;DM5PR2101MB1061;23:MaJOFkD3zwvcwJBWFxrA5hdhJ0zJWLQYiNGUUJT?=
 =?us-ascii?Q?JmFhjcpGpmRenz030zeHsAqRuOiAzTAhU4N9R3zB60LGgnBPu0mmr5iR4hsu?=
 =?us-ascii?Q?kXMWNTeUALFIMAMnGyGMzIqUK8gYuJVUjh/pwATYhwTwgBb4XqaeOdZ9ml6i?=
 =?us-ascii?Q?k/GmYk3CZGKLlnQ3oeqQK+BcMAWkCpWgqE+GVN9iY+jRQZtAAM6a9kyUsd/t?=
 =?us-ascii?Q?bDz7uU8hlsu0Q/CVIXU5OBykmOJzRqjy8t6MaAyZnyuug4mycNyGNOLaVfnM?=
 =?us-ascii?Q?U7ayWAF2eBuaqZU0/mrtWnR5sRCOS62NWUvUdv8t8wsQshGy1K4O7Ei2Er9K?=
 =?us-ascii?Q?OnWnHhs7RSYnodFB+PhmQPubV1jm3jZw3/mHmyClZ1ZDPa9tF/vCUkVYDBjY?=
 =?us-ascii?Q?J2JfmPCowmzPd88YHnVuIcwJcKUo4xiguZuwtnUmKc8da5dsNulHlwQGlxpw?=
 =?us-ascii?Q?EmNOIAR/848yJnVplyc0sE0LJoubtAiFFDUF31vyz8wVtZJJkMwWk1PhwYAz?=
 =?us-ascii?Q?++PUonDMjIuAX7NfeGjaKmitTC7ksJFpniW9lab0BnrNnTqckFhSyndxXE6z?=
 =?us-ascii?Q?cOUFtYC+/YodTUYVVaxrYkWYGAUPM3YAjWQa1KA6io2DO6lSYOv82mURbiJB?=
 =?us-ascii?Q?wDcVuHAo1+BFvZWWhS3EREswdttlkPv9zj4Lds4HEtN4GOUyCX4RSJk8NvM+?=
 =?us-ascii?Q?4urUGTvCgmloVYstYF3/lvMWKTHaaRqsrrivie0gEndZ/7Sydg7jyEdqgkE3?=
 =?us-ascii?Q?eDecv6jm4CsYQA6IPINFoEGC1JYFl+duyfjRFEMiRaxPErK5acOOlilqSnIe?=
 =?us-ascii?Q?L6PFwS5m/x/y/yta+f7AuwbhgN9B6RcCGVRV4JLAhqH3CAws/aDBymOZnVkl?=
 =?us-ascii?Q?KGnY0XO5Di1B1DGdjFar05Oyf9WelGDM+7O2ZAIECXsRYOYyF4iAz8uvyL75?=
 =?us-ascii?Q?StiMimncQC6wZUocpCkkBTkFocTnsqouPfnSXp5PvLbfjnfFXWYM87Vux1ns?=
 =?us-ascii?Q?P3bpAe+7AIZ9RoxyRl4eymQ4yl5buzxlGWOUwgdVTUGmZSMk7XzYdDNPdKlw?=
 =?us-ascii?Q?j+c8CnlsAz00ypBKbAXuAIDH+cJQ9xo6/T5bCcQhSZ1vmJYR3hInfP5VZVE4?=
 =?us-ascii?Q?nAERmG3mNSd7vyrbDM9aLJadAt0WrXOEnHC3ThOYYiXDcSCixqvK8SXsFA/4?=
 =?us-ascii?Q?nMOEqg8Ub3UCTxx+8ZKTwVak0Yn6aMvOyF/OvKBj9ctRb86sfGy7a7BRzijU?=
 =?us-ascii?Q?0S2cXllKYcxbCFyxQ5Jf7DGHUcfg7c0z7YNDkZEyI0VG6hd094EQu6WfhKn9?=
 =?us-ascii?Q?Qockgr2MEHBrJpbVu3bwMl1R1AaXqNK+jsF9I7SZd581ymFgxt9k1BVWpdEp?=
 =?us-ascii?Q?E2Llt00pfzyYoeCmbPKTzaE0h3z316cNtMEIz2zS4PF5gdGCc+F161W3G8pC?=
 =?us-ascii?Q?vxUo8K2+PfVil1XbQmanr6b6gdo7j8tFwhelweXLFoIml/BfGCKIN?=
x-microsoft-antispam-prvs: <DM5PR2101MB1061FF38E7C5588CD7D2001ED77E0@DM5PR2101MB1061.namprd21.prod.outlook.com>
x-forefront-prvs: 09555FB1AD
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(346002)(136003)(39860400002)(396003)(376002)(189003)(199004)(5640700003)(5660300002)(9686003)(86612001)(2501003)(7416002)(11346002)(446003)(6916009)(3846002)(6116002)(102836004)(6436002)(86362001)(229853002)(81156014)(81166006)(68736007)(476003)(97736004)(105586002)(8936002)(53936002)(1411001)(55016002)(256004)(106356001)(8676002)(8990500004)(99286004)(2906002)(7736002)(305945005)(2351001)(7696005)(71200400001)(6246003)(71190400001)(66066001)(74316002)(76176011)(4744005)(486006)(4326008)(186003)(316002)(6506007)(10090500001)(26005)(25786009)(22452003)(10290500003)(33656002)(6346003)(478600001)(14454004)(54906003)(1361003);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1061;H:DM5PR2101MB0918.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mikelley@microsoft.com; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: wgZgUSslFQpY15O3FrH4F215UHn0vnhQPPYWqAgmtmtUudagnNO0TBAFP/B8iPCE/OsH691TR8m41MZ+HL5Uz5LbkoM+0xybsT1kaseUVNlXBAlx61/Df3sA/+qYoYiczr+2nOz36/kkNEiV2AAeTWvDtZwqK1tFT8rCXW/+GijL1MXjqoI7gn+K1xmn5QVpKoftfN8K6JA6V2N6Tjnw2VdrgapR2XNBDglifSrso9rmhHRvcEBi/SfU8dyseRbLzXqOgZERHv45qkKom2trj8LgV1HpDkFZwU9OsrOaTgIZFKCvAzypkc3qMvQq7kozHZMiBZkDFPSshRRRoWzaGiYMWyE/mvq/kBxe48D4QyMMhv/rkUvKXB1/2rRhzjKSwFMXUElKZxslqmdWlr2/pby1yMAtMtmAgIwyMUUs/F4=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6ac9747-8df8-442b-cdd0-08d69821dff1
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2019 17:27:37.7492
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1061
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: lantianyu1986@gmail.com <lantianyu1986@gmail.com> Sent: Monday, Febru=
ary 11, 2019 6:20 AM
> +	/*
> +	 * Hyper-V doesn't provide irq remapping function for
> +	 * IO-APIC and so IO-APIC only accepts 8-bit APIC ID.
> +	 * Cpu's APIC ID is read from ACPI MADT table and APIC IDs
> +	 * in the MADT table on Hyper-v are sorted monotonic increasingly.
> +	 * APIC ID reflects cpu topology. There maybe some APIC ID
> +	 * gaps when cpu number in a socket is not power of two. Prepare
> +	 * max cpu affinity for IOAPIC irqs. Scan cpu 0-255 and set cpu
> +	 * into ioapic_max_cpumask if its APIC ID is less than 256.
> +	 */
> +	for (i =3D min_t(unsigned int, num_possible_cpus(), 255); i >=3D 0; i--=
)

The above isn't quite right.  For example, if num_possible_cpus() is 8,
then the loop will be executed 9 times, for values 8 down through 0.
It should be executed for values 7 down through 0.

> +		if (cpu_physical_id(i) < 256)
> +			cpumask_set_cpu(i, &ioapic_max_cpumask);
> +
> +	return 0;
> +}

Michael

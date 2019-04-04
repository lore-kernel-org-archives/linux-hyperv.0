Return-Path: <SRS0=ldGZ=SG=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77336C4360F
	for <linux-hyperv@archiver.kernel.org>; Thu,  4 Apr 2019 03:30:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 490B82133D
	for <linux-hyperv@archiver.kernel.org>; Thu,  4 Apr 2019 03:30:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Fol2SPEe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726738AbfDDDas (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Wed, 3 Apr 2019 23:30:48 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:36772 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726360AbfDDDar (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 3 Apr 2019 23:30:47 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x343OUaM044798;
        Thu, 4 Apr 2019 03:30:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=2zpkVrYlG8RlUEo6FKZ3He5jYZgyeIglZvoGsdlS27M=;
 b=Fol2SPEeasgiJZA4XmexEqQvXhXTj2mkdK+v6BSutu9aTkW6g3An5wQqvI+tpxaC6kkq
 PCj7w8ezvQGnVtbTWX4CCJZrhHX7o9rmOJjyHFGNXYJOSKMKcFaD85KZY9t71JC1/X6+
 WDjedXXd2MUyKUor3DrJsS245b9UWylIBqK87kCdWla5M0cTeRSW98e3SzBBgUbbpsyu
 hBtlE4PblZu7nMTLKfiKZtRxj2BX/NLIgGuzOpz2ZIXgy87nipXmNn57/JA6IuVR1tZu
 TLJqoZDb2Ac/4qKeOq4G7B6erxxO84qaH7ORnGtUKc0gi9Gi8N5xZtMVBwfVPsjb1YXu 2A== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2rj13qcfbj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 04 Apr 2019 03:30:40 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x343Todk086853;
        Thu, 4 Apr 2019 03:30:40 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 2rm8f6ehm2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 04 Apr 2019 03:30:39 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x343Ucix010650;
        Thu, 4 Apr 2019 03:30:38 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 03 Apr 2019 20:30:38 -0700
To:     Michael Kelley <mikelley@microsoft.com>
Cc:     KY Srinivasan <kys@microsoft.com>,
        "martin.petersen\@oracle.com" <martin.petersen@oracle.com>,
        Long Li <longli@microsoft.com>,
        "James.Bottomley\@hansenpartnership.com" 
        <James.Bottomley@hansenpartnership.com>,
        "emilne\@redhat.com" <emilne@redhat.com>,
        "linux-hyperv\@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-scsi\@vger.kernel.org" <linux-scsi@vger.kernel.org>
Subject: Re: [PATCH v2 1/1] scsi: storvsc: Fix calculation of sub-channel count
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <1554134985-8671-1-git-send-email-mikelley@microsoft.com>
Date:   Wed, 03 Apr 2019 23:30:35 -0400
In-Reply-To: <1554134985-8671-1-git-send-email-mikelley@microsoft.com>
        (Michael Kelley's message of "Mon, 1 Apr 2019 16:10:52 +0000")
Message-ID: <yq18swqtpk4.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9216 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=923
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1904040022
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9216 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=971 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1904040022
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org


Michael,

> When the number of sub-channels offered by Hyper-V is >= the number of
> CPUs in the VM, calculate the correct number of sub-channels.  The
> current code produces one too many.

Applied to 5.1/scsi-fixes, thanks.

-- 
Martin K. Petersen	Oracle Linux Engineering

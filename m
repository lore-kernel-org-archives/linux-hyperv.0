Return-Path: <SRS0=ldGZ=SG=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39AEBC4360F
	for <linux-hyperv@archiver.kernel.org>; Thu,  4 Apr 2019 03:31:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01C0A2133D
	for <linux-hyperv@archiver.kernel.org>; Thu,  4 Apr 2019 03:31:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="wrX2x83D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726694AbfDDDbu (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Wed, 3 Apr 2019 23:31:50 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:50954 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726167AbfDDDbu (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 3 Apr 2019 23:31:50 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x343OV03039749;
        Thu, 4 Apr 2019 03:31:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=rvMyld07lEQ9CIWLvUMFMwd4DjXMrssZ6GIzVHFyWlg=;
 b=wrX2x83DK8g+8HYvPFRHdUm9abehTdipqRdqnY/cmhQCZCU6Slg6/5BsOvtFH3EmXv02
 QjNNWIdfCxMhFc94IRjt//93mdl9De1LmHndtgjgHlKNLaWEyBBqz6LPTdsQ4LWWZ3Ie
 4li3QvH7oyY8Aq0bTOtwvfm/NULBAczGvWmbxQmOhv02UmpRxkpdGeY3fx4CsIch3d5x
 OsxA5Uw9uh5fe5tnGarxeTqLwaKg7/SSAR2Q+ZtB5Rx2ThkB952XoUv3ZZq1z3V1NPCB
 WjQC5uCYWzYIjRL4OvWptQtOK1iOjOtwSag7JXgAPZRoIB9e9jZfi40nq1RMKMiIkzT8 ZQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2130.oracle.com with ESMTP id 2rhwydcq95-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 04 Apr 2019 03:31:43 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x343VJWp114018;
        Thu, 4 Apr 2019 03:31:43 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 2rm8f5pjpj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 04 Apr 2019 03:31:43 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x343VgG8009595;
        Thu, 4 Apr 2019 03:31:42 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 03 Apr 2019 20:31:42 -0700
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
Subject: Re: [PATCH 1/1] scsi: storvsc: Reduce default ring buffer size to 128 Kbytes
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <1554154871-10305-1-git-send-email-mikelley@microsoft.com>
Date:   Wed, 03 Apr 2019 23:31:39 -0400
In-Reply-To: <1554154871-10305-1-git-send-email-mikelley@microsoft.com>
        (Michael Kelley's message of "Mon, 1 Apr 2019 21:42:06 +0000")
Message-ID: <yq14l7etpic.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9216 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=686
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1904040022
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9216 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=728 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1904040022
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org


Michael,

> Reduce the default VMbus channel ring buffer size for storvsc SCSI
> devices from 1 Mbyte to 128 Kbytes. Measurements show that ring buffer
> sizes above 128 Kbytes do not increase performance even at very high
> IOPS rates, so don't waste the memory. Also remove the dependence on
> PAGE_SIZE, since the ring buffer size should not change on
> architectures where PAGE_SIZE is not 4 Kbytes.

Applied to 5.1/scsi-fixes, thanks.

-- 
Martin K. Petersen	Oracle Linux Engineering

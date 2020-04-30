Return-Path: <SRS0=GxS9=6O=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E9F8C47247
	for <linux-hyperv@archiver.kernel.org>; Thu, 30 Apr 2020 16:37:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C0B42082E
	for <linux-hyperv@archiver.kernel.org>; Thu, 30 Apr 2020 16:37:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726576AbgD3QhQ (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Thu, 30 Apr 2020 12:37:16 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:56712 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbgD3QhP (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 30 Apr 2020 12:37:15 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jUCBV-000583-GC; Thu, 30 Apr 2020 10:37:13 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jUCBT-0003Sj-B6; Thu, 30 Apr 2020 10:37:12 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        virtio-dev@lists.oasis-open.org,
        virtualization@lists.linux-foundation.org,
        linuxppc-dev@lists.ozlabs.org, linux-acpi@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-hyperv@vger.kernel.org,
        linux-s390@vger.kernel.org, xen-devel@lists.xenproject.org,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Michal Hocko <mhocko@suse.com>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        Baoquan He <bhe@redhat.com>
References: <20200430102908.10107-1-david@redhat.com>
        <20200430102908.10107-3-david@redhat.com>
        <87pnbp2dcz.fsf@x220.int.ebiederm.org>
        <1b49c3be-6e2f-57cb-96f7-f66a8f8a9380@redhat.com>
Date:   Thu, 30 Apr 2020 11:33:53 -0500
In-Reply-To: <1b49c3be-6e2f-57cb-96f7-f66a8f8a9380@redhat.com> (David
        Hildenbrand's message of "Thu, 30 Apr 2020 17:52:35 +0200")
Message-ID: <871ro52ary.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jUCBT-0003Sj-B6;;;mid=<871ro52ary.fsf@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/rjTp6/iiXIJNS/hMPK4PB5d8gU9GVdPg=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH v2 2/3] mm/memory_hotplug: Introduce MHP_NO_FIRMWARE_MEMMAP
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

David Hildenbrand <david@redhat.com> writes:

> On 30.04.20 17:38, Eric W. Biederman wrote:
>> David Hildenbrand <david@redhat.com> writes:
>> 
>>> Some devices/drivers that add memory via add_memory() and friends (e.g.,
>>> dax/kmem, but also virtio-mem in the future) don't want to create entries
>>> in /sys/firmware/memmap/ - primarily to hinder kexec from adding this
>>> memory to the boot memmap of the kexec kernel.
>>>
>>> In fact, such memory is never exposed via the firmware memmap as System
>>> RAM (e.g., e820), so exposing this memory via /sys/firmware/memmap/ is
>>> wrong:
>>>  "kexec needs the raw firmware-provided memory map to setup the
>>>   parameter segment of the kernel that should be booted with
>>>   kexec. Also, the raw memory map is useful for debugging. For
>>>   that reason, /sys/firmware/memmap is an interface that provides
>>>   the raw memory map to userspace." [1]
>>>
>>> We don't have to worry about firmware_map_remove() on the removal path.
>>> If there is no entry, it will simply return with -EINVAL.
>>>
>>> [1]
>>> https://www.kernel.org/doc/Documentation/ABI/testing/sysfs-firmware-memmap
>> 
>> 
>> You know what this justification is rubbish, and I have previously
>> explained why it is rubbish.
>
> Actually, no, I don't think it is rubbish. See patch #3 and the cover
> letter why this is the right thing to do *for special memory*, *not
> ordinary DIMMs*.
>
> And to be quite honest, I think your response is a little harsh. I don't
> recall you replying to my virtio-mem-related comments.
>
>> 
>> Nacked-by: "Eric W. Biederman" <ebiederm@xmission.com>
>> 
>> This needs to be based on weather the added memory is ultimately normal
>> ram or is something special.
>
> Yes, that's what the caller are expected to decide, see patch #3.
>
> kexec should try to be as closely as possible to a real reboot - IMHO.

That is very fuzzy in terms of hotplug memory.  The kexec'd kernel
should see the hotplugged memory assuming it is ordinary memory.

But kexec is not a reboot although it is quite similar.   Kexec is
swapping one running kernel and it's state for another kernel without
rebooting.

>> Justifying behavior by documentation that does not consider memory
>> hotplug is bad thinking.
>
> Are you maybe confusing this patch series with the arm64 approach? This
> is not about ordinary hotplugged DIMMs.

I think I am.

My challenge is that I don't see anything in the description that says
this isn't about ordinary hotplugged DIMMs.  All I saw was hotplug
memory.

If the class of memory is different then please by all means let's mark
it differently in struct resource so everyone knows it is different.
But that difference needs to be more than hotplug.

That difference needs to be the hypervisor loaned us memory and might
take it back at any time, or this memory is persistent and so it has
these different characteristics so don't use it as ordinary ram.

That information is also useful to other people looking at the system
and seeing what is going on.

Just please don't muddle the concepts, or assume that whatever subset of
hotplug memory you are dealing with is the only subset.

I didn't see that flag making the distinction about the kind of memory
it is.

Eric





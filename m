Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22C904B5CD2
	for <linux-hyperv@vger.kernel.org>; Fri,  9 Oct 2026 11:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791545323; cv=pass; b=Nq57JMT8bGbxL/B8hybZVJ0uF+8QLc/h24LxHMDHQEMq9dwXfbEEuGO4mfD+fISh5WfQrB/NYjmyHGPlDZXpzyxnHKJVib3ciYxHbqEh0Vq7xWi8tVLr6ye4qbYzsl6yvnQoIUJeM2xCMPavhDkgglCLhEhaJmzhkRI4EadQKRA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791545323; c=relaxed/simple;
	bh=u/p/0JZR2McKImKLOvzu+CckfUo7KtjVVtwmdCUEiC0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FNz7Cw440Rui3T398fzJqC1ZGg3BE7n0WuqHPlReag0BJmM9tQWVj18K8BR6aY4GBHN7dWE4+fWLQ/E9zW1nGeAEqEryXZn+CNRpiHcZ4E4rN5uPLdGYkMw6Cc9NxbP/UWDyJ6SKWyF8rqtDnaAS/y6rFLnbfooazjxQGJM3MFs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=L2N7QDnJ; arc=pass smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="L2N7QDnJ"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2db33db4de9so51785ad.0
        for <linux-hyperv@vger.kernel.org>; Fri, 09 Oct 2026 04:28:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791545314; cv=none;
        d=google.com; s=arc-20260327;
        b=Wm1aBmkKGpl8lNzib3GdqIcX0KlMa9D5/FNC5kWRGbCew0QzlPqxLKFp3ZxW9CBL5h
         0lfqSa48rL3R6WSXDOg7YnFd0/XhXa4geQNFIl6cd3n8jyx1x0dZsZWh1yPwS0J6TrhT
         wT25Xup9Mzs1Aq/Lcr54jxOwvuthJQouljv9T7+YLm/Goj3yhJSH2oi+AmCa5ADQ8NMB
         te5fzTuA0nzUFcgokqTCoAvZO+OQZdxA+wb/SfAldBHUzOdN5KHzbWjU3l7CIvuV5qhA
         9mnRt/TUm1OhfTYCgNrzGdvzhGj8tKRiicT1k+58V0zb5pft5NYjctg2R9gKpsMcCjM6
         LkyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=sO6+wgHmizERNlE89bUfmYnUemgnXAS4GsjCPxo/9Xs=;
        fh=3Sq8rGICSbPn9w5LY2OD9JE11jbATl/2Fek3cKFZb0I=;
        b=M/mBjXkarlRl8Iguz8sIKCRcCau5BDGAJDAi417KIohJCrrcQ2DZ5dNqmT3JiI8V50
         Mn0h/cPFstuNQw5gEwhS7llDfmUdtBh/yKOjxR6wT78KOemtRSTd/tdyXdMwtLTy5XiZ
         uu0pfqY8SZxgI6X8ee9VSZaQbrCVhq63Tpm9hPp6ht1SoDdmjUcMMCwHLdq0KHcG9l+N
         L8TASsTIShJ0byAo/8JPmXsHv/UDOw0pvegVZZhDkDHRUyT598p/vcGlT3m4s0oR2zoC
         2AtCVnBX43sA3YkkYoVLYfGz+2nTWR82FjqlEOFuQ05tYWvLNxdDQKyI1+eLP1ElA8aP
         xOzQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791545314; x=1792150114; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=sO6+wgHmizERNlE89bUfmYnUemgnXAS4GsjCPxo/9Xs=;
        b=L2N7QDnJYrFNMi+8d+0I4LI9ztIVzwn6PaFld7M5tQ0fqdH2TgxjX59T+MYFDSvxt+
         0xCcx6FUUVVgv2y0kBy+MFDB6BtHftX5shgHocDqGcC8PJO7shfbz4la2Jk9plGr1xvV
         Hh+A05nL4R3vWvc0ns6B+Vk7K40FGiYnbGPcF4UGHTi7HjTIYRe0z2jz+GSQeMHHaBtZ
         W9D+mpx+m7YPpZp8gfujes0+y390NjXOaZLFo5lsk/g0WaxUX/gFAXshvEjmuSA797x+
         nblRVBD1/yz5IRvXaJ3D+YcFOseAEQpnKo2NwwGy1XPcLogqLx1SxZHS0kPocaGdZ+YQ
         +VPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791545314; x=1792150114;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sO6+wgHmizERNlE89bUfmYnUemgnXAS4GsjCPxo/9Xs=;
        b=Sb7LFKDDakH6BtJ9D6ac9oQccyVCjrlXrtFwTB3m04IMwMQ1KLY31THTmCYjTXObtz
         mYlZ2NbuGfIjtNr+lkRThhVIELdnWg97N+iHnCSU3ZmeyK2dwhs36uXrhfe/X/YmiDm+
         GuVT4Qy1gfaL6amUc0ebCJuoOxLfGZ1RSn2Y7/fjTjmpmos5+fpCGkaYQDt0nx98IKuo
         R//9x3L+pInYlWpwJvtNNMbebpfW2sWr9pgBsOQyE1a74r0e64aNcqVZ5KvFLNsXFgw1
         +bEMWWtPzNmCcqzH83NEa+avPneepSwRyKfTRM0SpK2Six9uDvZxo0QGwfyfFkyve5JF
         bOOw==
X-Forwarded-Encrypted: i=1; AKwUvByCItUbf/iN8diyPcDG/2Fl+Q3kIbi5Wd5uMPwMEl5Enq+UJn5Jk3+l2BqQ91QOOOq2NPP3oEuEGTr5sms=@vger.kernel.org
X-Gm-Message-State: AFq9FYLAzrQUqlzwwaetwXEHxPf9/cG2uAD8kQbztuvnDigCnStB2GeN
	4/JcLhaXG6Tcbw5cgpUcBo1fSGG9MwEDJif1rVTbP7nKXZU44kTwnwsRp0DRQeqQMru2IjGvieA
	zv52CAxeosODjQZoqfOULhRDjnXw4bDTlWNk9sK/t
X-Gm-Gg: AYBFou0vXrX0wqUcWKcpYz1oHjnEfQKEyjm80Ocoh6CLU97tzviSPnBtQ62L6noAFSa
	fJxT+Z0HFnpiCc6oevJp6jD/0zGoRpDqlUxYech4JksreSTPUr+/AbktrdJZmVqBx5CcVJJ2JTW
	qxMFjUrGMDVBMRdhcD/YJ0qj9eII119a6RjXorNttv+pQ61cngdg1+oNAkb4p+SjI8/xAli9fXv
	A6AeAVn+l0c2cqNypdk3PVb/PU/QuFqxNOMy2YnR6vyI/Jk5HGP3UyXcPG6PfVpENzxjrFtTlbw
	1rbPtnzL6qOfH2RlhEy8QDVSsjpp/w/zvfHqX4Mw3SjI8wvdtXIUQlMD
X-Received: by 2002:a17:902:f70b:b0:2bd:3bfd:74f1 with SMTP id
 d9443c01a7336-2e83db4bc44mr3303955ad.2.1791545313585; Fri, 09 Oct 2026
 04:28:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261009050556.2817978-1-namjain@linux.microsoft.com>
 <MN2PR02MB6863FBC36CE4F1D6419F0E8BD4922@MN2PR02MB6863.namprd02.prod.outlook.com>
 <04d88297-1732-4761-ae82-d68c441a7156@linux.microsoft.com> <3f4a11ea-bbc0-4dc5-9720-3447346739cf@linux.microsoft.com>
In-Reply-To: <3f4a11ea-bbc0-4dc5-9720-3447346739cf@linux.microsoft.com>
From: Luigi Rizzo <lrizzo@google.com>
Date: Fri, 9 Oct 2026 13:27:57 +0200
X-Gm-Features: AclHuK9lXMeYD06lb7uudSY49mGzzzPnQZe8BJ1Av8Eu26jyJ3pnC-vn0cZ5MeA
Message-ID: <CAMOZA0Ljw-DueDP3WvmtYe4x9Y_fNaptAo+3Hv8xzYHOZi9vbQ@mail.gmail.com>
Subject: Re: [RFC PATCH 0/3] nvme-pci: yield completions under scheduler pressure
To: Naman Jain <namjain@linux.microsoft.com>
Cc: Michael Kelley <mhklinux@outlook.com>, 
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, Keith Busch <kbusch@kernel.org>, 
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, changfengnan@bytedance.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 9, 2026 at 12:17=E2=80=AFPM Naman Jain <namjain@linux.microsoft=
.com> wrote:
>
>
>
> On 10/9/2026 12:21 PM, Naman Jain wrote:
> >
> >
> > On 10/9/2026 11:24 AM, Michael Kelley wrote:
> >> From: Naman Jain <namjain@linux.microsoft.com> Sent: Thursday, October
> >> 8, 2026 10:06 PM
> >>>
> >>> On systems with several fast NVMe controllers, completion interrupts =
can
> >>> keep returning to the same CPUs faster than scheduled work can run. E=
ach
> >>> handler may drain only a small number of completions, but the combine=
d
> >>> interrupt stream can still prevent scheduler and watchdog progress.
> >>
> >> See this recent proposal [1] that sounds like it is addressing the
> >> same or a
> >> similar issue. And there is this [2] more global approach. It's
> >> worthwhile to read
> >> through the discussion on both threads. I haven't done a detailed
> >> comparison
> >> of either vs. your proposal.
> >>
> >> Michael
> >>
> >> [1] https://lore.kernel.org/linux-nvme/20260818033846.53790-1-
> >> changfengnan@bytedance.com/
> >> [2] https://lore.kernel.org/lkml/20260819124341.4185621-1-
> >> lrizzo@google.com/
> >>
> >
> >
> > Thanks for sharing these Michael. I'll check more on these, and try it =
out.
> >
> > Regards,
> > Naman
>
> ++ authors of these two series, for awareness and if there is some
> configuration in their patches I should be trying to fix these lockup
> issues.

I see your thorough analysis below, thanks for the details.
Is there any reason why you used nvme.use_threaded_interrupts=3D0 ?

Setting to 1 moves the work to a kernel thread and seems to be the
best way to prevent too much work in the hardirq and the soft lockup.

I am surprised that GSIM fails to prevent the soft lockup, though:
under high load the sequence of events (starting from unmoderated)
should be the following:

1. HW sends MSIx interrupt, not blocked by anything
2. SW calls handle_fasteoi_irq() --> handle_irq_event() --> ... -->
action->handler() which starts processing
3. HW possibly sends another MSIx interrupt
4. SW handle_irq_event() completes
5. SW irq_start_moderation() starts the timer, __disable_irq() and
sets IRQD_IRQ_INPROGRESS | IRQD_MODERATED
6. if #3 happened, or another HW interrupt comes before the timer expires:
  SW handle_fasteoi_irq() finds IRQD_IRQ_INPROGRESS | IRQD_MODERATED both s=
et,
  and does not call handle_irq_event(), postponing the call
7. when the timer expires, the pending interrupt is reinjected.

The above suggests that we should see some pauses between runs of
action->handler(),
at least for a single queue per CPU.

Do you have any way to look with perf and bpftrace at the CPU
processing interrupts,
to see what keeps it busy (the pause between 6 and 7 should keep it
well below 100%)
and try to verify whether the calls to hndle_irq_event() are actually space=
d
as the sequence above describes?

Having multiple interrupts on the same CPU mean that the gap
between interrupts for one can be used by others, and that may
definitely make the CPU 100% busy in hardirq.

Again to address these cases, nvme.use_threaded_interrupts=3D1 would
greatly reduce the time spent in hardirq, moving the bulk of the work to so=
ftirq
hence at least becoming interruptible.

cheers
luigi

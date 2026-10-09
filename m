Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD4552475CF
	for <linux-hyperv@vger.kernel.org>; Fri,  9 Oct 2026 14:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791557951; cv=pass; b=Qm+JPD0jCz5LnjVrsT3qR1orIG3KK9uTJjFLDMQrhnvIEhICIcRwJTllvUMvdlndk0alSX/ger1NUJfzJY4YzrlDO/EyuP8+KC+yvGXUCyzC3DS1FFbe1WiWOK9LNXm/eyVx6NGljQ1T0sFBT3Ax7DV3aiUFmgTmz7VRwp2/Rfo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791557951; c=relaxed/simple;
	bh=hjyMjRDUj3huXfMRsPcqgEYwlBdJI0RxsrzOfxC0wbo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pMilm5nxLYYm9/v7dJnXgUobmHQrpr1LnHc/dr4C8KmIu36Og2jdebLFza243mPEQUKfaxl1hRt8l6Wx3m400ZR/iJDRogaEH0PDni+NiDS+u9yuz3V/O37gy4mVv9U6kh3BgWzeE+BoWqLuKbKrQufdzsE+XThssOpL52ekAY8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=E7s8kTZF; arc=pass smtp.client-ip=74.125.82.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="E7s8kTZF"
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-169be2dfbacso5136c88.0
        for <linux-hyperv@vger.kernel.org>; Fri, 09 Oct 2026 07:59:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791557949; cv=none;
        d=google.com; s=arc-20260327;
        b=H42qnbYRG4cGmo7FEu0wPNrPcy2iYuSpb/FdJSNyzhEszFLNghcSzu6O1mtrINCAod
         Z+atB3qV16/5HNlQfvB0p2nBBG9lXzxMUk3nRaVt9+QGu+ZNvZWJczSHNoNVBavGSwJt
         lw277AXgN75sTmkMe+qTZ+hrSS5Y4EGe4Me9T//IZSg72xiOmvdwIpr1ffUlvKPf3PJE
         ZAyDQMQe3b/n+vke18M5XpGiXg5uZJQTLKpTcUa9NsQjudJ6abMZiGqVsy6D3Zpo8JqF
         HV425/K4cf0chiyBgFh+vnzncL0XP+iFgZCtwlVOLjapH5w4vBOqM2iS/hgZNZHz9IXR
         5Ppw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/deJepVSy1q46FcuWbk27eGOV5yZN7U0qk5r5k6TxfI=;
        fh=cKw8troD9rfnE9KeZJUX2mjFZe4s3oEgopXDa2suWto=;
        b=FId6D/rSCIPtCMo4y6nUfPae7wiifjx+1DBr4hsYQX7xx5pjDEehqDx6BunHaHYu2r
         rVnhRop4DAtBnNFgzcVjiP3pDBssqBTsPsgZ1hnQePZT4hM6d0ErldLujimFY+5jzlTx
         iwHjSMCURjgDgStmiVO3VyOoCGTwu80K9OPQFA8JONNKWYkS9YsnQdTbPS4+N/u+C3Y6
         fX2cG/wc8OyNArogRUJl7atOyhBX5yxsTZldiKKMqVI/2LSEp6qULj1u5gWBnqvf2rLT
         kkOspQCkZ09tiOnCRzHUyQ/Jxwe4eUTFokvY9SbFnc2gExtztWsIPvOxg4Zn8H7x2X9d
         BZmw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791557949; x=1792162749; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/deJepVSy1q46FcuWbk27eGOV5yZN7U0qk5r5k6TxfI=;
        b=E7s8kTZFCzCn0nwPfaFHDDPfj6OAn8lDdKgvL1MAC3/0+y0PKZGTBDTyZqZadSeQXP
         RxnXPYZjp95+W7cYIw2RAC/j1VEBA9Tdx8ONYhwpc94jGkDXZZEFxcC15lWbzFDSViBt
         Nyj+qO4eKMlwy2tDTTxa/8YUJPYASGyGAfkquh6rHt9xLkXOA/wMmwcwTpG1b/xhwBQc
         oNj8kTUWLIRR31ycA1jvD/PZ6ZDHK0BD9h8R0QLFsfk7kdJe5E8v4J5nESNjzTiRdmor
         BL8N2HBnnduyS37cgnw8NK2bJx2pJxS+aIjnTAzMkvZiKn9i8XgF01xZ4eMoWoKSHzc9
         SHew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791557949; x=1792162749;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/deJepVSy1q46FcuWbk27eGOV5yZN7U0qk5r5k6TxfI=;
        b=ecu4MqIcK3X/4QIFxLxK0+Wu05y2PsLMhl5LW5QgPEn8hUUIuHt+3uiiCfib/OfKwB
         7Gv3s9+d2Q21QBEiYJpGXzSvItSms8MPAh6mkMcor04fh7fWSKVqIloiHkLp2RUt/4Qy
         az3kaedCVPdt1Is4WLttMewm4XFsi8TMpo5aCfLnyjfYfY7WO78fZCiAyce3YebyBt7D
         dLLGMvCjUJd6u0pUJaiBoL+sVP60vquihND8jFbAb8skNI0VqO0zPOcg0TJMiqIEzT/6
         sy0Q+PBBxOYAWr9hzPs5kJxK4Dfoe2JVIgQIsPsknukwmDpBFBulcpC/2mQWwlIMp9nr
         4njg==
X-Forwarded-Encrypted: i=1; AKwUvBzcXbcIRNbDKlJ/OGlO0JLi0FwcXvh1kyxnYtwYInQnwwatuKlJhz7NPGgkLlEA+GAomfOHcn62qUAZpBU=@vger.kernel.org
X-Gm-Message-State: AFuF++lWZVQ148GoGdTMw1EzVnd8UCleKzoe8hHA+C/53Z+OT04cz+BM
	y6VlWNnpQHrWYKNSaUaI7WybncBEQxZU9hnkC4dUzD4BCPbTYQOpMBMJI3Jh+Cfyd4+9OTqbsLF
	SxKiFGzrpt1W2UjAWvCWhcVwKeyQNXJdu3mhnGnIR
X-Gm-Gg: AYBFou3ZGWqX94I3ZzzhQz8wtjrHRn24t8RFv+Lbmcay8zRIR62a2xNTYKU8W15oXYs
	0iJQSRfBT0GLIOs/fS0+TOEjasA+tL4yBIHt5OvVws6YfKyG23iCZbNaqeiO+1ml37AhElMD6S6
	63LLfYPPY4g1WKSzI75Agt7A/NOtmtAU7fYM8o8X57hHjTNWFYYEbD2riyK1wgf7rqV9NthJuVY
	Fgo7UzDa/bAzfMwpOEactjdutmZ0gCo6WwRf8yXrTk35th8+EF3wodxGCTRuefmWMzYzc4D3V/8
	2eSQ8mjuMoD2kktUegoxo66HIrMubUsZrRkUcek/JN8SRGnHBjYWaFi8
X-Received: by 2002:a05:7022:40c:b0:151:f5f7:b423 with SMTP id
 a92af1059eb24-16a4cec574emr313527c88.10.1791557947600; Fri, 09 Oct 2026
 07:59:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261009050556.2817978-1-namjain@linux.microsoft.com>
 <MN2PR02MB6863FBC36CE4F1D6419F0E8BD4922@MN2PR02MB6863.namprd02.prod.outlook.com>
 <04d88297-1732-4761-ae82-d68c441a7156@linux.microsoft.com>
 <3f4a11ea-bbc0-4dc5-9720-3447346739cf@linux.microsoft.com> <CAMOZA0Ljw-DueDP3WvmtYe4x9Y_fNaptAo+3Hv8xzYHOZi9vbQ@mail.gmail.com>
In-Reply-To: <CAMOZA0Ljw-DueDP3WvmtYe4x9Y_fNaptAo+3Hv8xzYHOZi9vbQ@mail.gmail.com>
From: Luigi Rizzo <lrizzo@google.com>
Date: Fri, 9 Oct 2026 16:58:29 +0200
X-Gm-Features: AclHuK-m9limdcYUcwxZk2GykJcipkv6UowoA2Ws1KR0RewlWyRADdHddO4VXeo
Message-ID: <CAMOZA0KJoS4GFrKmaGa7+qMCNktTUg-YpkzX_EoA2KfAW3iN_g@mail.gmail.com>
Subject: Re: [RFC PATCH 0/3] nvme-pci: yield completions under scheduler pressure
To: Naman Jain <namjain@linux.microsoft.com>
Cc: Michael Kelley <mhklinux@outlook.com>, 
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, Keith Busch <kbusch@kernel.org>, 
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, changfengnan@bytedance.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 9, 2026 at 1:27=E2=80=AFPM Luigi Rizzo <lrizzo@google.com> wrot=
e:
>
> On Fri, Oct 9, 2026 at 12:17=E2=80=AFPM Naman Jain <namjain@linux.microso=
ft.com> wrote:
> >
> >
> >
> > On 10/9/2026 12:21 PM, Naman Jain wrote:
> > >
> > >
> > > On 10/9/2026 11:24 AM, Michael Kelley wrote:
> > >> From: Naman Jain <namjain@linux.microsoft.com> Sent: Thursday, Octob=
er
> > >> 8, 2026 10:06 PM
> > >>>
> > >>> On systems with several fast NVMe controllers, completion interrupt=
s can
> > >>> keep returning to the same CPUs faster than scheduled work can run.=
 Each
> > >>> handler may drain only a small number of completions, but the combi=
ned
> > >>> interrupt stream can still prevent scheduler and watchdog progress.
> > >>
> > >> See this recent proposal [1] that sounds like it is addressing the
> > >> same or a
> > >> similar issue. And there is this [2] more global approach. It's
> > >> worthwhile to read
> > >> through the discussion on both threads. I haven't done a detailed
> > >> comparison
> > >> of either vs. your proposal.
> > >>
> > >> Michael
> > >>
> > >> [1] https://lore.kernel.org/linux-nvme/20260818033846.53790-1-
> > >> changfengnan@bytedance.com/
> > >> [2] https://lore.kernel.org/lkml/20260819124341.4185621-1-
> > >> lrizzo@google.com/
> > >>
> > >
> > >
> > > Thanks for sharing these Michael. I'll check more on these, and try i=
t out.
> > >
> > > Regards,
> > > Naman
> >
> > ++ authors of these two series, for awareness and if there is some
> > configuration in their patches I should be trying to fix these lockup
> > issues.
>
> I see your thorough analysis below, thanks for the details.
> Is there any reason why you used nvme.use_threaded_interrupts=3D0 ?
>
> Setting to 1 moves the work to a kernel thread and seems to be the
> best way to prevent too much work in the hardirq and the soft lockup.
>
> I am surprised that GSIM fails to prevent the soft lockup, though:
> under high load the sequence of events (starting from unmoderated)
> should be the following:
>
> 1. HW sends MSIx interrupt, not blocked by anything
> 2. SW calls handle_fasteoi_irq() --> handle_irq_event() --> ... -->
> action->handler() which starts processing
> 3. HW possibly sends another MSIx interrupt
> 4. SW handle_irq_event() completes
> 5. SW irq_start_moderation() starts the timer, __disable_irq() and
> sets IRQD_IRQ_INPROGRESS | IRQD_MODERATED
> 6. if #3 happened, or another HW interrupt comes before the timer expires=
:
>   SW handle_fasteoi_irq() finds IRQD_IRQ_INPROGRESS | IRQD_MODERATED both=
 set,
>   and does not call handle_irq_event(), postponing the call
> 7. when the timer expires, the pending interrupt is reinjected.
>
> The above suggests that we should see some pauses between runs of
> action->handler(),
> at least for a single queue per CPU.
>
> Do you have any way to look with perf and bpftrace at the CPU
> processing interrupts,
> to see what keeps it busy (the pause between 6 and 7 should keep it
> well below 100%)
> and try to verify whether the calls to hndle_irq_event() are actually spa=
ced
> as the sequence above describes?
>
> Having multiple interrupts on the same CPU mean that the gap
> between interrupts for one can be used by others, and that may
> definitely make the CPU 100% busy in hardirq.

Following up on the multiple interrupt sources on one CPU, you could
try something like this:
every time an interrupt source comes while the timer is active,
increment a counter.
When the timer expires and the counter is > 0, add as many "gaps" as
there were sources.
This should restore the invariant that every interrupt source gets one
run per moderation interval,
and the adaptive control loop should adjust the value to hit the target

--- a/kernel/irq/irq_moderation.h
    +++ b/kernel/irq/irq_moderation.h

    @@  struct irq_mod_state {
    +    unsigned int        kicked;
         unsigned int        sleep_ns;
    --- a/kernel/irq/irq_moderation.c
    +++ b/kernel/irq/irq_moderation.c
    @@ bool irq_moderation_do_start(struct irq_desc *desc, struct
irq_mod_state *m)
             /* We need moderation, start the timer. */
             m->timer_set++;
    +        m->kicked =3D 0;
             hrtimer_start_range_ns(&m->timer, ns_to_ktime(m->sleep_ns),
                            slack_ns, HRTIMER_MODE_REL_PINNED_HARD);
    +    } else if (READ_ONCE(irq_mod_params.timer_push)) {
    +        /* Timer armed: record the kick, timer_callback() will
push it forward. */
    +        m->kicked++;
         }
    @@ static enum hrtimer_restart timer_callback(struct hrtimer *timer)
         lockdep_assert_irqs_disabled();

    +    /* Push the timer forward by sleep_ns for each kick received
while armed. */
    +    if (m->kicked) {
    +        hrtimer_forward_now(timer, ns_to_ktime((u64)m->kicked *
m->sleep_ns));
    +        m->kicked =3D 0;
    +        return HRTIMER_RESTART;
    +    }
    +

cheers
luigi

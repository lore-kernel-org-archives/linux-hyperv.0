Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32D9642125F;
	Thu, 27 Aug 2026 17:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787852098; cv=none; b=D2/hfCvvK1eEScrec3w/I2hb1qUTjbx4/wDRytCIfMMesL+RQUeuo3+JA354Z4VoKxjDL+tYdW7qxAewY9rHviT9QRYcFBWaa/iwzaGN9hyEluoWp0qpSW6HM9tlyPlyVGoc5r8UNLANohi9Dtk6G9bEhekqYXI7wIi0wkbL0RE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787852098; c=relaxed/simple;
	bh=HIYz2kIXhv1C4lh+L3uA2mr5Px+nz+onXV60RWtd3NQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ri3Fsy++eoKD3U1mR7muWm0x0sqOTeb4Z6+Lt2XAHWobiDw/SDCbHeF0+q9agehvcH6fAIaFKnIgc+HbxciCyJBjL8cMABlTsr7T1xl+kJJ6MENIx8HyMe9ucMOHVZ+t0Rkr7PuUhVV9crkRqhPETSRaP7t4criAMdDKuCCeIy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=JDTuz51W; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="JDTuz51W"
Received: by linux.microsoft.com (Postfix, from userid 1127)
	id B6B5720B7167; Thu, 27 Aug 2026 10:34:23 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B6B5720B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1787852063;
	bh=PRM4WsYYCbTuuUkMBHLU01nQ7CqrfJwf9ezzBDEDiA8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JDTuz51WYfRjLQHX5p8dgR5B9SyCSIS9i2mbOHECoUjLkXLAyPAAnmUTXHs/dFj63
	 aQMPDrnOSHxpIZBBGcXXQ798WHA2nQaqomr0QnGhIe1t33PrPX1ttWntYzO2/6fU3Z
	 IOHWG6i6QTlCoH4xXGwDPinGzZpvQK0AXqDVdAAI=
Date: Thu, 27 Aug 2026 10:34:23 -0700
From: Saurabh Singh Sengar <ssengar@linux.microsoft.com>
To: Michael Kelley <mhklinux@outlook.com>
Cc: Long Li <longli@microsoft.com>,
	Naman Jain <namjain@linux.microsoft.com>,
	Sahil Chandna <sahilchandna@linux.microsoft.com>,
	KY Srinivasan <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>,
	Dexuan Cui <DECUI@microsoft.com>,
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	"kwilczynski@kernel.org" <kwilczynski@kernel.org>,
	"mani@kernel.org" <mani@kernel.org>,
	"robh@kernel.org" <robh@kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] PCI: hv: Warn when wait_for_response() waits indefinitely
Message-ID: <apB1HytkO5xu7jP6@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20260825051850.2438816-1-sahilchandna@linux.microsoft.com>
 <736091cf-8d00-415e-a890-e2dfa6739325@linux.microsoft.com>
 <SA1PR21MB66836C32FD0FABD94B45D7F6CEAF2@SA1PR21MB6683.namprd21.prod.outlook.com>
 <SN6PR02MB41578D73327A61FD3D7412C2D4AD2@SN6PR02MB4157.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN6PR02MB41578D73327A61FD3D7412C2D4AD2@SN6PR02MB4157.namprd02.prod.outlook.com>

On Thu, Aug 27, 2026 at 04:07:06PM +0000, Michael Kelley wrote:
> From: Long Li <longli@microsoft.com> Sent: Tuesday, August 25, 2026 10:01 AM
> 
> [snip]
> 
> > >
> > > Basically something like this:
> > >
> > > #define PCI_RESPONSE_WARN_TIMEOUT_SEC 300
> > >
> > > static int wait_for_response(struct hv_device *hdev,
> > >                   struct completion *comp) {
> > >      unsigned long warn_at =
> > >          jiffies + secs_to_jiffies(PCI_RESPONSE_WARN_TIMEOUT_SEC);
> > >      bool warned = false;
> > >
> > >      while (true) {
> > >          if (hdev->channel->rescind) {
> > >              dev_warn_once(&hdev->device, "The device is gone.\n");
> > >              return -ENODEV;
> > >          }
> > >
> > >          if (wait_for_completion_timeout(comp, HZ / 10)) {
> > >              if (warned || time_after_eq(jiffies, warn_at))
> > >                  dev_warn(&hdev->device,
> > >                       "PCI response received after prolonged wait.\n");
> > >              return 0;
> > >          }
> > >
> > >          if (!warned && time_after_eq(jiffies, warn_at)) {
> > >              dev_warn(&hdev->device,
> > >                   "PCI still waiting for response.\n");
> > >              warned = true;
> > >          }
> > >      }
> > > }
> > >
> > > Regards,
> > > Naman
> > 
> > This looks better.
> > 
> 
> I like getting the "response received" message if the response
> eventually does come in. It's a judgment call, but I would be OK
> with outputting the "still waiting" message after each wait interval
> rather than doing it only once. And I would make the interval smaller
> than 300 seconds. Five minutes is a long time to wait and wonder
> what's going on when things are hung. 60 or 120 seconds would
> be OK -- a line in dmesg every 1 or 2 minutes doesn't seem like
> spamming to me when something is fundamentally broken.
> And probably don't expect a VM in this broken state to keep running
> for hours -- the sysadmin or automatic monitoring software will
> reboot it to get it working again.

I will also vote for repeated message as long as interval between two
messages is greater than 60 seconds.

- Saurabh

> 
> Just my $.02. Outputting the "still waiting" message only once is
> also OK. Your call.
> 
> Michael

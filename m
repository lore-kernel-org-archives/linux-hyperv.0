Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8E03472556;
	Fri, 28 Aug 2026 15:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787929203; cv=none; b=eRQcDCb6UhpEFF+Bm2F4BLhhQHHurszgpIRr88iQarAhSbDOw8x9tbu9qfTLq8L3insPeqwcyTzlK2V+gg8+MjiISa4snhBoT0vnHy16YK8XfE2cisG05oltaTdNTG407zzDXfClPzAzVB3pnSoYRuuiHnNMWeshyN4Hzjfp+q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787929203; c=relaxed/simple;
	bh=38onK1o1gHvw39n2XLdvAtcmso6JmG1BwndGXXbA0Sw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JE6eq0sHb+Hqffqhu8ya0adRt4x4gbaeYGz+R3zhcZBVTqArJVLtFhdd3vxIcuJVDCt3QEgrCqq3i6K4EAMpteujudgfjrsCnobEoS6L6lQmdDVGChU9FIrx+oXUTA5ayLwdllBFW5AFSQj3hPMkN0DSH/5tv2h58frW0qELfDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=ozgv3VeT; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="ozgv3VeT"
Received: by linux.microsoft.com (Postfix, from userid 1216)
	id B4BDB20B7167; Fri, 28 Aug 2026 07:59:27 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B4BDB20B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1787929167;
	bh=tj8jagAHnEhGGg0kyqoCcJokLn7outmwNO0bz5pGUJs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ozgv3VeTorRXNyuFxp+ws1izYXRh1lDPCpW6yEvgkfLbqkVt13XT7x8+a8+u8PTgW
	 sE0tCKGkhShnMQGObB1ckgldSMBxgTmpfP72WO2g2RJmJzs4a731/h8PbrHptSgkxO
	 lBHLeHKmK6ZA6gWN/l68pQDWYc1a7H607/XyccjQ=
Date: Fri, 28 Aug 2026 10:59:27 -0400
From: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
To: Naman Jain <namjain@linux.microsoft.com>
Cc: Saurabh Singh Sengar <ssengar@linux.microsoft.com>,
	Michael Kelley <mhklinux@outlook.com>,
	Long Li <longli@microsoft.com>,
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
Message-ID: <apGiT0ZKIetmsbn8@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20260825051850.2438816-1-sahilchandna@linux.microsoft.com>
 <736091cf-8d00-415e-a890-e2dfa6739325@linux.microsoft.com>
 <SA1PR21MB66836C32FD0FABD94B45D7F6CEAF2@SA1PR21MB6683.namprd21.prod.outlook.com>
 <SN6PR02MB41578D73327A61FD3D7412C2D4AD2@SN6PR02MB4157.namprd02.prod.outlook.com>
 <apB1HytkO5xu7jP6@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <27277d1e-fd41-4dc9-aea2-eae3773ba322@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <27277d1e-fd41-4dc9-aea2-eae3773ba322@linux.microsoft.com>

On Fri, Aug 28, 2026 at 11:10:22AM +0530, Naman Jain wrote:
> 
> 
> On 8/27/2026 11:04 PM, Saurabh Singh Sengar wrote:
> > On Thu, Aug 27, 2026 at 04:07:06PM +0000, Michael Kelley wrote:
> > > From: Long Li <longli@microsoft.com> Sent: Tuesday, August 25, 2026 10:01 AM
> > > 
> > > [snip]
> > > 
> > > > > 
> > > > > Basically something like this:
> > > > > 
> > > > > #define PCI_RESPONSE_WARN_TIMEOUT_SEC 300
> > > > > 
> > > > > static int wait_for_response(struct hv_device *hdev,
> > > > >                    struct completion *comp) {
> > > > >       unsigned long warn_at =
> > > > >           jiffies + secs_to_jiffies(PCI_RESPONSE_WARN_TIMEOUT_SEC);
> > > > >       bool warned = false;
> > > > > 
> > > > >       while (true) {
> > > > >           if (hdev->channel->rescind) {
> > > > >               dev_warn_once(&hdev->device, "The device is gone.\n");
> > > > >               return -ENODEV;
> > > > >           }
> > > > > 
> > > > >           if (wait_for_completion_timeout(comp, HZ / 10)) {
> > > > >               if (warned || time_after_eq(jiffies, warn_at))
> > > > >                   dev_warn(&hdev->device,
> > > > >                        "PCI response received after prolonged wait.\n");
> > > > >               return 0;
> > > > >           }
> > > > > 
> > > > >           if (!warned && time_after_eq(jiffies, warn_at)) {
> > > > >               dev_warn(&hdev->device,
> > > > >                    "PCI still waiting for response.\n");
> > > > >               warned = true;
> > > > >           }
> > > > >       }
> > > > > }
> > > > > 
> > > > > Regards,
> > > > > Naman
> > > > 
> > > > This looks better.
> > > > 
> > > 
> > > I like getting the "response received" message if the response
> > > eventually does come in. It's a judgment call, but I would be OK
> > > with outputting the "still waiting" message after each wait interval
> > > rather than doing it only once. And I would make the interval smaller
> > > than 300 seconds. Five minutes is a long time to wait and wonder
> > > what's going on when things are hung. 60 or 120 seconds would
> > > be OK -- a line in dmesg every 1 or 2 minutes doesn't seem like
> > > spamming to me when something is fundamentally broken.
> > > And probably don't expect a VM in this broken state to keep running
> > > for hours -- the sysadmin or automatic monitoring software will
> > > reboot it to get it working again.
> 
> I think this is a main point of this discussion. FWIK, this is not
> automatically recovered as of now, ever. With these changes, we could get
> dmesg logs completely filled with this same log, which does not add any
> value. On the other hand, I was suggesting Sahil if this problem is not
> recoverable by Azure fabric layer or other monitoring services, and is
> extremely rare and the VM is unusable, perhaps we should consider adding a
> bug/timeout in this path instead of just logging about it.
> 
> Regards,
> Naman

Along with what everyone else has suggested I would suggest printing out the
state of the device's VMBus channel (i.e. the child_relid and inbound and
outbound status in particular). Since, that information is useful to the hv
guys and should help disambiguate between "host never picked it up" vs. 
"host picked it up but never replied."

Hamza

> 
> > 
> > I will also vote for repeated message as long as interval between two
> > messages is greater than 60 seconds.
> > 
> > - Saurabh
> > 
> > > 
> > > Just my $.02. Outputting the "still waiting" message only once is
> > > also OK. Your call.
> > > 
> > > Michael
> 
> 

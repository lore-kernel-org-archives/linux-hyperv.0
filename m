Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 983924F4CE8;
	Mon, 19 Oct 2026 12:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792413588; cv=none; b=UdrXJD4bZmG+3YWnvk4MdqCkBfiauCusy0t7gmehg2r6bv0nVSU70jZBTwE/K3R8qRIOTm2oulf+/CZwTu77vkWNnE1VWE2hY3GVA3zsSc9qQgRSJVyxlEgvl3MhyQI0V3fWoP0t/b92bUUjKEmpbGDSKIzyBgSwf35eTofHisw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792413588; c=relaxed/simple;
	bh=pXmwrBo6dLNLkbP8HSIjATa8tntP/iItXRS9BRdu81U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fSs/xFjGC/i+5Gs+zV+5GVgrsJ3OAHK+FBdpBfT5fwu8OTZBSfFpehnrhT65Hw+rscFtByeiRQ3lKZY4Bm0/naWfaFOxvvgO3iG4vQ2KxEUN2fUNXEihLmjxiPHU9LGHpQiqnKzA1DDfk3+ry3XUaVjlIbw7CzvtwouqTbABA68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=V3n7kcuV; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="V3n7kcuV"
Received: by linux.microsoft.com (Postfix, from userid 1216)
	id 961C620B7168; Mon, 19 Oct 2026 05:39:26 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 961C620B7168
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1792413566;
	bh=kBdEuTY6MQ+H0utY/zhuUL3qVvLCYjNeXyFJ+yLQZis=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V3n7kcuVKUm1AhJ6PZXwKO3w+wpYgHfp6NxT20jOMNoqOTV45Tg06yE6wp4wSgqKx
	 X0idintsIYgYI9ISj3lG+XfGIgM1sHzuUbmHeza6Is5bTn+wvkcGBLehldfj//Nanm
	 s/kzrvPD7ZG0ZI/ipNOSZLw9ZF9j8bWRY9X4YVC4=
Date: Mon, 19 Oct 2026 08:39:26 -0400
From: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
To: sashiko-reviews@lists.linux.dev
Cc: linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH 2/2] PCI: hv: add vPCI device reset support
Message-ID: <atYPfibVVa+nyyb9@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20261016235940.942090-1-hamzamahfooz@linux.microsoft.com>
 <20261016235940.942090-2-hamzamahfooz@linux.microsoft.com>
 <sashiko-outbox-175060@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <sashiko-outbox-175060@kernel.org>

On Sat, Oct 17, 2026 at 12:12:00AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Low] PCI: hv: hv_pci_reset_device() passes 3 arguments to wait_for_response()
> --
> 
> commit 5767f2b6950e5dc7da0b5c142f971d8282c27a56
> Author: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
> 
> PCI: hv: add vPCI device reset support
> 
> This commit negotiates Hyper-V vPCI protocol version 1.5 and implements the
> reset_root_port() callback on pci_host_bridge by sending a PCI_RESET_DEVICE
> request over the vPCI VMBus channel.
> 
> > diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
> > index 89816a2bd7cd3..4bb4ca6da1f7b 100644
> > --- a/drivers/pci/controller/pci-hyperv.c
> > +++ b/drivers/pci/controller/pci-hyperv.c
> 
> [ ... ]
> 
> > @@ -1397,6 +1401,52 @@ static int hv_pcifront_write_config(struct pci_bus *bus, unsigned int devfn,
> >  	return PCIBIOS_SUCCESSFUL;
> >  }
> >  
> > +static int hv_pci_reset_device(struct pci_host_bridge *bridge,
> > +			       struct pci_dev *pdev)
> > +{
> > +	struct hv_pcibus_device *hbus =
> > +		container_of(bridge->sysdata, struct hv_pcibus_device, sysdata);
> > +	struct pci_child_message reset = {};
> > +	struct hv_pci_compl comp_pkt;
> > +	struct pci_packet pkt = {
> > +		.completion_func = hv_pci_generic_compl,
> > +		.compl_ctxt = &comp_pkt,
> > +	};
> > +	enum hv_pcibus_state state;
> > +	int ret;
> > +
> > +	/* Do not take state_lock: eject holds it while removing/locking pdev. */
> > +	state = READ_ONCE(hbus->state);
> > +	if (state != hv_pcibus_probed && state != hv_pcibus_installed)
> > +		return -ENODEV;
> > +
> > +	init_completion(&comp_pkt.host_event);
> > +	reset.message_type.type = PCI_RESET_DEVICE;
> > +	reset.wslot.slot = devfn_to_wslot(pdev->devfn);
> > +
> > +	ret = vmbus_sendpacket(hbus->hdev->channel, &reset, sizeof(reset),
> > +			       (unsigned long)&pkt, VM_PKT_DATA_INBAND,
> > +			       VMBUS_DATA_PACKET_FLAG_COMPLETION_REQUESTED);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = wait_for_response(hbus->hdev, &comp_pkt.host_event,
> > +				"PCI_RESET_DEVICE");
> 
> [Severity: Low]
> Does this compile when CONFIG_PCI_HYPERV is enabled?
> 
> In drivers/pci/controller/pci-hyperv.c, wait_for_response() only accepts two
> arguments:
> 
> static int wait_for_response(struct hv_device *hdev,
> 			     struct completion *comp)
> 
> Passing "PCI_RESET_DEVICE" as a third argument in hv_pci_reset_device()
> causes the build to fail with too many arguments to wait_for_response().
> 

Not sure what tree this was applied to, but that function has 3 params
as of mainline commit ca039df94983 ("PCI: hv: Warn when
wait_for_response() waits indefinitely").

> > +	if (ret)
> > +		return ret;
> > +
> > +	if (comp_pkt.completion_status == STATUS_NOT_SUPPORTED)
> > +		return -ENOTTY;
> > +
> > +	if (comp_pkt.completion_status) {
> > +		pci_err(pdev, "Hyper-V device reset failed: %#x\n",
> > +			comp_pkt.completion_status);
> > +		return -EIO;
> > +	}
> > +
> > +	return 0;
> > +}
> 
> [ ... ]
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20261016235940.942090-1-hamzamahfooz@linux.microsoft.com?part=2

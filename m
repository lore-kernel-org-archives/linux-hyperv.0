Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58FB13D5652;
	Tue, 11 Aug 2026 17:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786469802; cv=none; b=E5OopHTV7Ntox7gZejeNu4PwnezruReIt3ZMQ/x/RxOdy+Bm91GV+wlnevCdTIZSRFIeo9UVZ26FngV/FTjCIkZiwCheIYwn4ScUllNDRbL0lMHiuxm2FG7jv0RoV0gY0QMC89umKlLstKn/cQ7nA3Zr5tcAWdXhOq61wGb2rgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786469802; c=relaxed/simple;
	bh=R2+DA3JIXt29PpRgb06h0/Lfi4nOBtEDB95587kTMEQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ssAFhYhoZEu6y92Ndcct+6EO8ruP1iuwffzseuSgrmKc/CU+ylilFBeiJ9yT8DsTaRVG0PJcwuwNhPBydLa7kctpzre2FMJDFdmfcFrR6BzYlMoxm4J40ZyCtLj6vl6GB1fH1EYRf/enuit1uFRXuatqsQ0A2T4mVD+Kbg47BVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TTpVjpRR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TTpVjpRR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C1401F000E9;
	Tue, 11 Aug 2026 17:36:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786469800;
	bh=ovqsCP+te5b6m0rzBKx7ArddWmlNyNr7xBcwXmKAcRc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=TTpVjpRRcay3bDQfGq4t41rGRV5opcKp3iYDL1FyUe3PyWTGqAvI+a1M8h+2AWa8B
	 rVPzjN4+Isl4AM1/ITuEVlYKvluPVjBst47BMeBP4+b6S3QZzR0zFuGgHrzDPcrco/
	 wsf2AlNVHtwj4GyL8cky49S+mRCm7uBHxialkbfbaosSHAsHvHuGCexU8Xmmx7i/Gn
	 U+lL8rVekwsiyZdvTWGZVQrycIvX3WhPyksFay+iz9V8at0VcqA6rlgq9X5FE4duwb
	 A1UUCZoAeiFUSFCzrCPoICO7VV8XTxgFzI20JvljU2D8owSEB3SXqsjhxF8/xeQvSv
	 vBCWaD+poMchA==
Date: Tue, 11 Aug 2026 10:36:39 -0700
From: Wei Liu <wei.liu@kernel.org>
To: Michael Kelley <mhklinux@outlook.com>
Cc: "wei.liu@kernel.org" <wei.liu@kernel.org>,
	Linux on Hyper-V List <linux-hyperv@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC 2/2] PCI: hv: Add vPCI device reset support
Message-ID: <20260811173639.GA2714057@liuwe-devbox-debian-v2.local>
References: <20260724230844.3259741-1-wei.liu@kernel.org>
 <20260724230844.3259741-3-wei.liu@kernel.org>
 <SN6PR02MB4157BC49B4B8A6FD7C7B5FEED4DD2@SN6PR02MB4157.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <SN6PR02MB4157BC49B4B8A6FD7C7B5FEED4DD2@SN6PR02MB4157.namprd02.prod.outlook.com>

On Tue, Aug 11, 2026 at 04:10:33PM +0000, Michael Kelley wrote:
> From: wei.liu@kernel.org <wei.liu@kernel.org> Sent: Friday, July 24, 2026 4:09 PM
> > 
> > Hyper-V vPCI protocol version 1.5 adds a RESET_DEVICE request for projected
> > PCI functions. Negotiate the new protocol version and issue the request
> > through the vPCI VMBus channel from the PCI controller reset callback.
> > 
> > Use the existing VMBus response path. Return -ENOTTY when the host reports
> > STATUS_NOT_SUPPORTED so PCI core may try another reset method.
> > 
> > Signed-off-by: Wei Liu <wei.liu@kernel.org>
> > ---
> >  Documentation/virt/hyperv/vpci.rst  |  2 +-
> >  drivers/pci/controller/pci-hyperv.c | 61 +++++++++++++++++++++++++++++
> >  2 files changed, 62 insertions(+), 1 deletion(-)
> > 
> > diff --git a/Documentation/virt/hyperv/vpci.rst b/Documentation/virt/hyperv/vpci.rst
> > index b65b2126ede3..6bfee7225c14 100644
> > --- a/Documentation/virt/hyperv/vpci.rst
> > +++ b/Documentation/virt/hyperv/vpci.rst
> > @@ -65,7 +65,7 @@ exchange messages with the vPCI VSP for the purpose of setting
> >  up and configuring the vPCI device in Linux.  Once the device
> >  is fully configured in Linux as a PCI device, the VMBus
> >  channel is used only if Linux changes the vCPU to be interrupted
> > -in the guest, or if the vPCI device is removed from
> > +in the guest, or if the vPCI device is reset or removed from
> >  the VM while the VM is running.  The ongoing operation of the
> >  device happens directly between the Linux device driver for
> >  the device and the hardware, with VMBus and the VMBus channel
> > diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
> > index cfc8fa403dad..d3c0fd5e1d8e 100644
> > --- a/drivers/pci/controller/pci-hyperv.c
> > +++ b/drivers/pci/controller/pci-hyperv.c
> > @@ -68,6 +68,7 @@ enum pci_protocol_version_t {
> >  	PCI_PROTOCOL_VERSION_1_2 = PCI_MAKE_VERSION(1, 2),	/* RS1 */
> >  	PCI_PROTOCOL_VERSION_1_3 = PCI_MAKE_VERSION(1, 3),	/* Vibranium */
> >  	PCI_PROTOCOL_VERSION_1_4 = PCI_MAKE_VERSION(1, 4),	/* WS2022 */
> > +	PCI_PROTOCOL_VERSION_1_5 = PCI_MAKE_VERSION(1, 5),	/* GE, device reset */
> 
> I wish there were a better way to identify the Hyper-V version than internal
> code names that mean nothing to the Linux community. "GE" refers to
> Germanium, which would be the Build 26100 series, right?
> 

Yes, you're right about Germanium. I see the numbers also match, though
I don't have a clear idea that the numbering will stay the same.

> >  };
> > 
> >  #define CPU_AFFINITY_ALL	-1ULL
> > @@ -77,6 +78,7 @@ enum pci_protocol_version_t {
> >   * first.
> >   */
> >  static enum pci_protocol_version_t pci_protocol_versions[] = {
> > +	PCI_PROTOCOL_VERSION_1_5,
> >  	PCI_PROTOCOL_VERSION_1_4,
> >  	PCI_PROTOCOL_VERSION_1_3,
> >  	PCI_PROTOCOL_VERSION_1_2,
> > @@ -90,6 +92,7 @@ static enum pci_protocol_version_t pci_protocol_versions[] = {
> >  #define MAX_SUPPORTED_MSI_MESSAGES 0x400
> > 
> >  #define STATUS_REVISION_MISMATCH 0xC0000059
> > +#define STATUS_NOT_SUPPORTED     0xC00000BB
> > 
> >  /* space for 32bit serial number as string */
> >  #define SLOT_NAME_SIZE 11
> > @@ -136,6 +139,7 @@ enum pci_message_type {
> >  	PCI_BUS_RELATIONS2		= PCI_MESSAGE_BASE + 0x19,
> >  	PCI_RESOURCES_ASSIGNED3         = PCI_MESSAGE_BASE + 0x1A,
> >  	PCI_CREATE_INTERRUPT_MESSAGE3   = PCI_MESSAGE_BASE + 0x1B,
> > +	PCI_RESET_DEVICE                = PCI_MESSAGE_BASE + 0x1C,
> >  	PCI_MESSAGE_MAXIMUM
> >  };
> > 
> > @@ -1397,10 +1401,66 @@ static int hv_pcifront_write_config(struct pci_bus *bus,
> > unsigned int devfn,
> >  	return PCIBIOS_SUCCESSFUL;
> >  }
> > 
> > +static int hv_pcifront_reset(struct pci_dev *pdev, bool probe)
> > +{
> > +	struct hv_pcibus_device *hbus =
> > +		container_of(pdev->bus->sysdata, struct hv_pcibus_device, sysdata);
> > +	struct pci_child_message reset = {};
> > +	struct hv_pci_compl comp_pkt;
> > +	struct pci_packet pkt = {
> > +		.completion_func = hv_pci_generic_compl,
> > +		.compl_ctxt = &comp_pkt,
> > +	};
> > +	enum hv_pcibus_state state;
> > +	int ret;
> > +
> > +	/* Device reset was added in vPCI protocol version 1.5. */
> > +	if (hbus->protocol_version < PCI_PROTOCOL_VERSION_1_5)
> > +		return -ENOTTY;
> > +
> > +	/* Hyper-V exposes projected functions directly on the root bus. */
> > +	if (!pci_is_root_bus(pdev->bus))
> > +		return -ENOTTY;
> > +
> > +	if (probe)
> > +		return 0;
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
> > +	ret = wait_for_response(hbus->hdev, &comp_pkt.host_event);
> > +	if (ret)
> > +		return ret;
> > +
> > +	if (comp_pkt.completion_status == STATUS_NOT_SUPPORTED)
> > +		return -ENOTTY;
> 
> I tried this patch series in a linux-next20260726 build, and running on a D16lds v6
> VM in Azure. The host hypervisor version is 10.0.26100.1652-1-0, and the VM
> has a paravisor with HvLite.
> 
> This VM has an NVMe OS disk, two NVMe temp disks, and a MANA network controller.
> Absent this patch set, the temp disks and MANA report the "reset_method" as "flr",
> while the NVMe OS disk reports no reset methods. With this patch set, "controller"
> is added as a reset method for all. The NVMe disks and MANA network controller
> are probed with PCI protocol 1.5. That's all good and as expected (though I'm not
> sure why the NVMe OS disk doesn't support flr).
> 
> I then did "echo 1 >reset" for the NVMe OS disk. This returns a -ENOTTY error
> from the above line of code. So the host hypervisor (or paravisor?) is saying that
> the new PCI_RESET_DEVICE message isn't supported. Presumably this is new
> functionality that hasn’t been rolled out to where I'm running this Azure VM.
> That's fine too.
> 

That's right. It is not yet rolled out.

> But interestingly, the NVMe OS disk did a Linux-side reset anyway. That's
> because of this stack trace from the "echo 1 >reset" command:
> 
> [   99.642483]  nvme_try_sched_reset+0x25/0x60 [nvme_core]
> [   99.642495]  nvme_reset_done+0x1c/0x40 [nvme]
> [   99.642499]  pci_dev_restore+0x35/0x70
> [   99.642503]  pci_reset_function+0x100/0x140
> [   99.642506]  reset_store+0x5a/0xa0
> [   99.642508]  dev_attr_store+0x16/0x30
> [   99.642512]  sysfs_kf_write+0x71/0x80
> [   99.642516]  kernfs_fop_write_iter+0x140/0x1d0
> [   99.642518]  vfs_write+0x313/0x420
> [   99.642522]  ksys_write+0x68/0xe0
> [   99.642525]  __x64_sys_write+0x18/0x20
> [   99.642527]  x64_sys_call+0x1700/0x21c0
> [   99.642530]  do_syscall_64+0x8d/0x440
> [   99.642532]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> 
> Even though __pci_reset_function_locked() failed, the subsequent
> code in pci_reset_function() calls nvme_try_sched_reset(), which puts
> nvme_reset_work() on a workqueue.  nvme_reset_work() tears
> things down on the Linux side and rebuilds, and the message
> 
>     nvme nvme0: 16/0/0 default/read/poll queues
> 
> is output.
> 
> It's not immediately clear to me how to resolve this issue, so
> I'm just pointing it out. :-(
> 

Is resetting the OS disk a real use case?

I'm not sure what magic is happening behind this.

Wei

> Michael
> 
> > +
> > +	if (comp_pkt.completion_status) {
> > +		pci_err(pdev, "Hyper-V device reset failed: %#x\n",
> > +			comp_pkt.completion_status);
> > +		return -EIO;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> >  /* PCIe operations */
> >  static struct pci_ops hv_pcifront_ops = {
> >  	.read  = hv_pcifront_read_config,
> >  	.write = hv_pcifront_write_config,
> > +	.reset = hv_pcifront_reset,
> >  };
> > 
> >  /*
> > @@ -1996,6 +2056,7 @@ static void hv_compose_msi_msg(struct irq_data *data,
> > struct msi_msg *msg)
> >  		break;
> > 
> >  	case PCI_PROTOCOL_VERSION_1_4:
> > +	case PCI_PROTOCOL_VERSION_1_5:
> >  		size = hv_compose_msi_req_v3(&ctxt.int_pkts.v3,
> >  					cpu,
> >  					hpdev->desc.win_slot.slot,
> > --
> > 2.53.0
> > 
> 

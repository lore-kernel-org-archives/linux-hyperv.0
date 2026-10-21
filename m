Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792566759;
	b=N+iPRbrYmxp4iD2fiRnQgusqDSBiY0xZGWiqq3cKEjJ0IfQZNFXsZp2bDAR1k3VH+Dr/
	 EsSdjqByhxNBQzJLXu1L4DvLlMtj3JmyYmUnxFz2HbDFJ60+A+hm+HtDfYMWXewG+5LX5
	 yVcRdGA2pvdufs6K2wZAsm+F8E+XzKWdef2ATEbQMf3Ps7eLrIZ0gi0/8elx1OWsHyrI2
	 7fUsPulprLe8TbpuHrhwWgA+J2u4s4OZWnfGTNn5AphP+aYFYqoYc6VVX6iay/tdwXLHD
	 ERneEzZFZbftfWxwdexuwCDLZ6eWiQ1ZDzrYMBplvBf1iRaAueIfKh3/ggEiOwJy9Sw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792566759;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=vcc8SXBf3xzir4Lak2b1xe9rdcx6QX+V+Egzn2h6A1c=;
	b=ZjSmMYvYvZC4e9k9fM2LcNMFn5gLDnKgw5DD234oK9L0IodyEZFIiAYPfN7u4MMuU9NM
	 xNb0jrtzuQfX0Ve6UvklVQMBl33kmvnbd/TnB+qeovkHxBNXUkRV0UK76nWoZxv4W0ydW
	 zF1qs1aB+CETcz2D3zGsIZXlAuQc2nZmsOa9zeTru0H2xUX39O7oFkuuhYMf61pkzA52p
	 KIUScDsSQV6UQXXa5UDoaftfJVD2R5gtA2QR5dTAtiFjLfemC3c6XV6gYtHx4+Fz7kFMT
	 w8ROkxbAw9/entrc/cOxsFnv/V6LZLOlfLgM4keDiuUdMX1+0v0kd/b4aLV7pXjqJcA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OUGGIcKw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0175D606A31A;
	Wed, 21 Oct 2026 07:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OUGGIcKw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 801BC1F000C9;
	Wed, 21 Oct 2026 07:12:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792566758;
	bh=vcc8SXBf3xzir4Lak2b1xe9rdcx6QX+V+Egzn2h6A1c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=OUGGIcKw/ZpSSVUcfi/IzHJ5QKybdiuYXAxvT05egGZKsQADdJaBBEfRmdYkHPvF0
	 viZQPBWPUkAyrESwHjhGa8fBWj3fyuRghvzat9in5IKLrDi/GIFLoKPhMcQQKA9nBR
	 IGRgh1qiR8gjtqTv1ZS5yvTaCHlU3pmqr8ph/4agYSNtQrSxOr3mQtzU1sLCb/Ezbh
	 ruHH+lnSo/cqH/LUJuC6u7PUDRLFHj8Ocufzshx0QdBKHX3nqZRfsXr8bExWR5hpXj
	 A9XFS833HE8N7WqD7p0DBPHpBjZ6lPchk3n1CiMKJgKFqGCsqt+gSzDcd4W0D5oSx6
	 R01iqAErv5Haw==
Date: Wed, 21 Oct 2026 00:12:37 -0700
From: Wei Liu <wei.liu@kernel.org>
To: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
Cc: sashiko-reviews@lists.linux.dev, linux-hyperv@vger.kernel.org,
	linux-pci@vger.kernel.org, Wei Liu <wei.liu@kernel.org>
Subject: Re: [PATCH 2/2] PCI: hv: add vPCI device reset support
Message-ID: <20261021071237.GC851443@liuwe-devbox-debian-v2.local>
References: <20261016235940.942090-1-hamzamahfooz@linux.microsoft.com>
 <20261016235940.942090-2-hamzamahfooz@linux.microsoft.com>
 <sashiko-outbox-175060@kernel.org>
 <atYPfibVVa+nyyb9@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Post: <mailto:linux-hyperv@vger.kernel.org>
List-Help: <mailto:linux-hyperv+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hyperv+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <atYPfibVVa+nyyb9@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>

On Mon, Oct 19, 2026 at 08:39:26AM -0400, Hamza Mahfooz wrote:
> On Sat, Oct 17, 2026 at 12:12:00AM +0000, sashiko-bot@kernel.org wrote:
> > Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> > - [Low] PCI: hv: hv_pci_reset_device() passes 3 arguments to wait_for_response()
> > --
> > 
> > commit 5767f2b6950e5dc7da0b5c142f971d8282c27a56
> > Author: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
> > 
> > PCI: hv: add vPCI device reset support
> > 
> > This commit negotiates Hyper-V vPCI protocol version 1.5 and implements the
> > reset_root_port() callback on pci_host_bridge by sending a PCI_RESET_DEVICE
> > request over the vPCI VMBus channel.
> > 
> > > diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
> > > index 89816a2bd7cd3..4bb4ca6da1f7b 100644
> > > --- a/drivers/pci/controller/pci-hyperv.c
> > > +++ b/drivers/pci/controller/pci-hyperv.c
> > 
> > [ ... ]
> > 
> > > @@ -1397,6 +1401,52 @@ static int hv_pcifront_write_config(struct pci_bus *bus, unsigned int devfn,
> > >  	return PCIBIOS_SUCCESSFUL;
> > >  }
> > >  
> > > +static int hv_pci_reset_device(struct pci_host_bridge *bridge,
> > > +			       struct pci_dev *pdev)
> > > +{
> > > +	struct hv_pcibus_device *hbus =
> > > +		container_of(bridge->sysdata, struct hv_pcibus_device, sysdata);
> > > +	struct pci_child_message reset = {};
> > > +	struct hv_pci_compl comp_pkt;
> > > +	struct pci_packet pkt = {
> > > +		.completion_func = hv_pci_generic_compl,
> > > +		.compl_ctxt = &comp_pkt,
> > > +	};
> > > +	enum hv_pcibus_state state;
> > > +	int ret;
> > > +
> > > +	/* Do not take state_lock: eject holds it while removing/locking pdev. */
> > > +	state = READ_ONCE(hbus->state);
> > > +	if (state != hv_pcibus_probed && state != hv_pcibus_installed)
> > > +		return -ENODEV;
> > > +
> > > +	init_completion(&comp_pkt.host_event);
> > > +	reset.message_type.type = PCI_RESET_DEVICE;
> > > +	reset.wslot.slot = devfn_to_wslot(pdev->devfn);
> > > +
> > > +	ret = vmbus_sendpacket(hbus->hdev->channel, &reset, sizeof(reset),
> > > +			       (unsigned long)&pkt, VM_PKT_DATA_INBAND,
> > > +			       VMBUS_DATA_PACKET_FLAG_COMPLETION_REQUESTED);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	ret = wait_for_response(hbus->hdev, &comp_pkt.host_event,
> > > +				"PCI_RESET_DEVICE");
> > 
> > [Severity: Low]
> > Does this compile when CONFIG_PCI_HYPERV is enabled?
> > 
> > In drivers/pci/controller/pci-hyperv.c, wait_for_response() only accepts two
> > arguments:
> > 
> > static int wait_for_response(struct hv_device *hdev,
> > 			     struct completion *comp)
> > 
> > Passing "PCI_RESET_DEVICE" as a third argument in hv_pci_reset_device()
> > causes the build to fail with too many arguments to wait_for_response().
> > 
> 
> Not sure what tree this was applied to, but that function has 3 params
> as of mainline commit ca039df94983 ("PCI: hv: Warn when
> wait_for_response() waits indefinitely").

The link ...

> > Sashiko AI review · https://sashiko.dev/#/patchset/20261016235940.942090-1-hamzamahfooz@linux.microsoft.com?part=2
> 

... shows that it picked git.lwn.net/docs-next (90d9f76ccb72ec024ef476b4229f3dd1957d7b26).

It looks like it is hallucinating.

Wei

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DBEC25B082;
	Mon,  7 Sep 2026 06:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788760926; cv=none; b=aFxjlP2P4DKzV9FChecH1nTzM8Y1uhU0ulc6pYYkajGHCaxrko6entOMyl/YvAZOmmTvFvu2JtihlU57dSJtavviPL60Sz+lcsRr+LJDxdMnqVT0DQBOMPSJAW/AwPK7P6TbZr9s+TpAFEco0+VSOPsgolnAw6k1sn46s98znPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788760926; c=relaxed/simple;
	bh=eUr1ZM/zzFM5n59Vx8ED7Nbj3UkhGOcyHl9KoqiE2sU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=CqYeAI+QkEHbK5nBhed2jTrTpcwbvvHARQwSV+82X6ekE5GvmWXvaoTYHoBdlzYwvCf07Txg+lTd05AIC7CgoBdQ0egnzXewTTmybPlQM3n5BXUC80Mp6eL9c+aPHwSnkdMX948/PDt8Pd8zfohYrS3b0zZ//Ce2Hd01Aemx2Ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FJB2skj+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FJB2skj+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B97C1F00A3A;
	Mon,  7 Sep 2026 06:02:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788760925;
	bh=4hXGmBWWdusUTc9WLIi3RNUoFjJZoP1q6TMCNnKV+xk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FJB2skj+zT3qvuu7vvq0ILoVKrDV2EAj2++WMPg1VYkFuElP2fuYUumbP9ydKbsNN
	 YAiz3LjJKR3E8Z0bUnR62+cXTUYWohWIESP/NZKGnndD5syLTqMK6y/LgFKw1F4aCh
	 jL+PL0ozDCpNbaCixpZIZVXSiTmNUncHE1hU8KKmKpKgLN1RLiPVKAFl+k1BS2ocj4
	 HHnAF2bxfbYi8rMLYywPZ+x38z5b7mcR0lhDLZn4QnoW8f6DNbfNxKev1MzxKYHfxG
	 8UEG3apHf1Zifalz/PkzHH8Xx48Mn0sEeFapHQwlltDi2uWD+1n0C4i159w8UVmG93
	 ZYqpOa9Xs/FgQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI: hv: Probe vPCI buses asynchronously
Reply-To: sashiko-reviews@lists.linux.dev
To: "Naman Jain" <namjain@linux.microsoft.com>
Cc: linux-pci@vger.kernel.org, linux-hyperv@vger.kernel.org
In-Reply-To: <20260907054742.235389-1-namjain@linux.microsoft.com>
References: <20260907054742.235389-1-namjain@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 07 Sep 2026 06:02:04 +0000
Message-Id: <20260907060205.2B97C1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] VMBus transaction mappings are not removed when wait_for_respo=
nse() aborts early, leading to stack or heap Use-After-Free (UAF) upon dela=
yed host completion.
- [High] Memory leak of child PCI devices (struct hv_pci_dev / hpdev) on th=
e error paths of hv_pci_probe().
- [High] Workqueue leaked on hv_pci_remove() if hv_pci_resume() previously =
failed.
--

commit acbe68fb0b4a7fd692c44acd0bc27c2e48b030db
Author: Naman Jain <namjain@linux.microsoft.com>

PCI: hv: Probe vPCI buses asynchronously
   =20
On Hyper-V guests each virtual PCI bus is enumerated by its own
hv_pci_probe() call. The probe performs several synchronous host
request/response exchanges while negotiating the protocol, querying bus
relations, entering D0, and reporting allocated resources.

> diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller=
/pci-hyperv.c
> index 89816a2bd7cd3..056d379b3cee4 100644
> --- a/drivers/pci/controller/pci-hyperv.c
> +++ b/drivers/pci/controller/pci-hyperv.c
> @@ -4155,6 +4155,9 @@ static struct hv_driver hv_pci_drv =3D {
>  	.remove		=3D hv_pci_remove,
>  	.suspend	=3D hv_pci_suspend,
>  	.resume		=3D hv_pci_resume,
> +	.driver =3D {
> +		.probe_type =3D PROBE_PREFER_ASYNCHRONOUS,
> +	},
>  };

[Severity: High]
This is a pre-existing issue, but I noticed a potential memory leak of child
PCI device structures (struct hv_pci_dev) in the error paths of
hv_pci_probe() in drivers/pci/controller/pci-hyperv.c.

If hv_pci_enter_d0() fails, the error path jumps directly to
release_state_lock:

    ret =3D hv_pci_enter_d0(hdev);
    if (ret)
        goto release_state_lock;

This completely skips hv_pci_bus_exit(), which is responsible for unlinking
and freeing the children.

Additionally, if an error occurs earlier and it jumps to exit_d0, it calls
hv_pci_bus_exit() but skips freeing the devices:

exit_d0:
    (void) hv_pci_bus_exit(hdev, true);
release_state_lock:
    mutex_unlock(&hbus->state_lock);

The keep_devs=3Dtrue argument explicitly skips freeing the children.

In both situations, the hbus structure is subsequently freed, leaving the
previously populated hbus->children list permanently leaked. Could these
error paths be adjusted to ensure child devices are properly freed?

[Severity: High]
This is a pre-existing issue, but could a workqueue be leaked in
hv_pci_remove() if hv_pci_resume() had previously failed?

In drivers/pci/controller/pci-hyperv.c:hv_pci_resume(), hbus->state is
initially set to hv_pcibus_init. If a subsequent operation fails, the
function returns an error without restoring the state.

Later, when the device is removed, hv_pci_remove() checks the state before
destroying the workqueue:

    if (hbus->state =3D=3D hv_pcibus_installed) {
        tasklet_disable(&hdev->channel->callback_event);
        hbus->state =3D hv_pcibus_removing;
        tasklet_enable(&hdev->channel->callback_event);
        destroy_workqueue(hbus->wq);
        hbus->wq =3D NULL;
        ...

Since the state was left as hv_pcibus_init, this block is bypassed, and
the workqueue is leaked when hbus is later freed. Does this state check need
to be modified to ensure the workqueue is always destroyed on removal?

[Severity: Critical]
This is a pre-existing issue, but can VMBus transaction mappings be left
dangling when wait_for_response() aborts early, leading to a Use-After-Free
upon delayed host completion?

In drivers/pci/controller/pci-hyperv.c, several functions allocate a
struct pci_packet on the stack or heap, pass it to the VMBus requestor,
and then wait for a response. For example, in new_pcichild_device():

    if (wait_for_response(hbus->hdev, &comp_pkt.host_event))
        goto error;

Or in hv_pci_enter_d0():

    ret =3D wait_for_response(hdev, &comp_pkt.host_event);
    if (ret)
        goto exit;

Similar early returns occur in hv_read_config_block() and
hv_write_config_block().

If wait_for_response() aborts immediately (e.g. returning -ENODEV due to a
channel rescind), the caller returns and destroys its stack frame or frees
the heap allocation.

However, the transaction ID mapping remains in the VMBus requestor. If the
host sends a completion packet just after this, the hv_pci_onchannelcallbac=
k()
tasklet will retrieve the dangling pointer and execute its completion_func,
corrupting the stack or heap.

Should these functions use vmbus_request_addr_match() to remove the mapping
on failure, similar to how hv_pci_bus_exit() handles it?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260907054742.2353=
89-1-namjain@linux.microsoft.com?part=3D1

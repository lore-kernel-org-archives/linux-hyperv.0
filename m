Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D160498E0E
	for <linux-hyperv@vger.kernel.org>; Mon, 19 Oct 2026 09:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792401004; cv=none; b=F3Wwx7oGaaOaJgWKUPca6CesWnWMqjINOyJDHaA5TOFdU52Mhs7XUgdVF2ZiXcL0u2eMnWk7rGXmfGTuT/WzsztKsE3ZkS/PPy6XvHQW7IOwC5h7jz3wg5Lefs0lDa4OoAOUWQxZmu3dzIcsKufwYFqwag1a1Us/f30Al3+izSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792401004; c=relaxed/simple;
	bh=JMVYcWp/D5ji6uUctFJe//825PK3O/g/2qFM+8O3108=;
	h=Message-ID:From:Subject:To:In-Reply-To:References:Content-Type:
	 Date; b=sWIw5LQgj9CotlRJVqiW+9/hWf98c+n1PyM1e8Xi+zvHPZ6eBhGLIaxwGIRde++JC/bIY1ohxA/NoHE2UiJQ74C5AmJQMh6m0wEPn8WrTApGx/zMH+kstFZCgQfId9D8EqSInU4d/WSIxI3CCPX7koJoTQ9+B71AiaRw0zgiCx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n27aD4KU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n27aD4KU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE35C1F000C4;
	Mon, 19 Oct 2026 09:10:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792401003;
	bh=El7mK+lYY00X/HLu2UQHY62wqXpLF1dP2d/MSZtIoUs=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=n27aD4KUGkG4tf0JhEuXlq2CJomfAJvxqvfY14Lh8QpnhhoXMTw2uli4z5f1X9ycF
	 ITdHXM+WNkZnge9RcvYa/0FIRNL62KD42sL0A4+aQF6JydgsGIkYO+PIGmN3Sfu48V
	 WvuHb8xTMhufR6iXTY4JuxCkvY8djK0onKl/WhDiEVIQnIwoEBBBrsK7PqDMW7ub8m
	 xBytgSJCk4W8kdTEXp9bHz5TC3A7BGBs1/OoxXBbXufnJ0KK/YdY6WsnIA7Sajmia2
	 KgoXCB4NhspdbEsEolZ2nzhML7IgjLRjxNO3qZGa0280vxZzBgu/k/1kyhp1iAy7Js
	 E3B7H5M+Wn1qA==
Message-ID: <sashiko-outbox-176875@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] hv/vmbus: copy dynamic IDs before dropping the lock
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jiale Yao" <yaojiale02@163.com>, linux-hyperv@vger.kernel.org
In-Reply-To: <20261019085544.1834700-1-yaojiale02@163.com>
References: <20261019085544.1834700-1-yaojiale02@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 09:10:02 +0000
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] hv/vmbus: NULL dev_id passed to drv->probe() in vmbus_probe() on d=
ynid race
--

commit 3bc8de7f762094d04ea5ef5ada2811cd26424021
Author: Jiale Yao <yaojiale02@163.com>

hv/vmbus: copy dynamic IDs before dropping the lock

This commit copies matching dynamic device IDs into a caller-provided stack
variable while holding drv->dynids.lock so that driver probe callbacks do n=
ot
receive a pointer to a dynamic ID entry that was concurrently freed by
remove_id_store().

> diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> index 4692687cdbf3b..96ad0dfaa50ba 100644
> --- a/drivers/hv/vmbus_drv.c
> +++ b/drivers/hv/vmbus_drv.c

[ ... ]

> @@ -860,9 +864,10 @@ static int vmbus_probe(struct device *child_device)
>  	struct hv_driver *drv =3D
>  			drv_to_hv_drv(child_device->driver);
>  	struct hv_device *dev =3D device_to_hv_device(child_device);
> +	struct hv_vmbus_device_id dev_id_copy;
>  	const struct hv_vmbus_device_id *dev_id;
> =20
> -	dev_id =3D hv_vmbus_get_id(drv, dev);
> +	dev_id =3D hv_vmbus_get_id(drv, dev, &dev_id_copy);
>  	if (drv->probe) {
>  		ret =3D drv->probe(dev, dev_id);
>  		if (ret !=3D 0)

[Severity: High]
What happens if remove_id_store() removes the matching dynamic ID after
vmbus_match() succeeds, but before vmbus_probe() calls hv_vmbus_get_id()?

Since vmbus_match() and vmbus_probe() acquire and release drv->dynids.lock
separately via hv_vmbus_get_id() -> hv_vmbus_dynid_match(), a concurrent
remove_id_store() can delete the matching entry in between:

drivers/hv/vmbus_drv.c:remove_id_store() {
	...
	spin_lock(&drv->dynids.lock);
	list_for_each_entry_safe(dynid, n, &drv->dynids.list, node) {
		struct hv_vmbus_device_id *id =3D &dynid->id;

		if (guid_equal(&id->guid, &guid)) {
			list_del(&dynid->node);
			kfree(dynid);
			retval =3D count;
			break;
		}
	}
	spin_unlock(&drv->dynids.lock);
	...
}

When that happens (or if driver_override is cleared between vmbus_match()
and vmbus_probe()), hv_vmbus_get_id() in vmbus_probe() returns NULL, and
vmbus_probe() passes dev_id =3D NULL to drv->probe(dev, dev_id).

Drivers such as storvsc and hv_util unconditionally dereference dev_id in
their probe callbacks:

drivers/scsi/storvsc_drv.c:storvsc_probe() {
	...
	bool dev_is_ide =3D dev_id->driver_data =3D=3D IDE_GUID;
	bool is_fc =3D dev_id->driver_data =3D=3D SFC_GUID;
	...
}

drivers/hv/hv_util.c:util_probe() {
	struct hv_util_service *srv =3D
		(struct hv_util_service *)dev_id->driver_data;
	...
}

And for drivers that do not dereference dev_id (such as uio_hv_generic),
probe will still succeed and bind the device even though the dynamic ID was
already removed.

Should vmbus_probe() check if (!dev_id && !is_hvsock_channel(dev->channel))
and return -ENODEV before calling drv->probe(), similar to how
__pci_device_probe() and usb_probe_interface() handle a removed dynamic ID?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019085544.1834=
700-1-yaojiale02@163.com?part=3D1

Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=13.77.154.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792539082;
	b=Lz8rZL2Sgu3bpRt0TZGP3RHaiL1fLqiKv+pjIXwQZDbOFz/GXtnHS7U8X3B8S0A5/wEa
	 Yn/25eYsfWF7Pf98JJuf1hW4f/Fbv+QuR4aB6+LWc/joN/cB+fO9GDlK7qA7eMN3SwYm7
	 o7z85/tB8g8BKRrEHejYnC5ciWLIdCU/sS2IbhtaRRFhhIOXA4FH4+GICS+G9L2HwVpXD
	 aNB8VhLbllvzv6/NEY2xbJn9CI1gwQsW2yiLZWYwgywpsRJuYseeQQW3+fXlh7IalENaz
	 QELP27uLvlbwn7zFi0gw8uUZyzE3fbWaKdZFD9xbo+pEHu+T2DhNcf6P1A7QMArHebg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792539082;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:References:Content-Language:Cc:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:X-Spam-Status:
	 X-Spam-Checker-Version;
	bh=fgNej84WTt4OS++7vi1hUcNO4v+lufgORZL9i9nk4VQ=;
	b=pinaJnnW0ExAtuokY3FV3onrA4vOXz1DkT254v4BUH9uWpVKy/2ZElKbRnq2d3nPtmuA
	 x2QhSWOznXbnPvqywTBocWTbW1IMD9pjGmSobOPiP80/LOBGOmsw97XDo4iUK4TvvMGnE
	 5HrcBpEj8e4qClxdhKIIZI1BlOV8fvfYzfFgnEC9Q8drpdPg0KZH3D5zzDGdBMug8uRjT
	 1fOHjMcViVTpdtYvIOGOwXkI0jTbqDHLIuefaNVpUyAkbZGNrhXId3sI+3suRM6UKIEPu
	 jA/dBF1GWwpl29vtS/hDuFZR3ynwxgeospLoovxNPAemheMyxEOci46DkNsbryUax4A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.microsoft.com;
	spf=pass smtp.mailfrom=linux.microsoft.com;
	dkim=pass header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b="MZj/iwTj";
	arc=none smtp.remote-ip=13.77.154.182
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91E31606A31E;
	Tue, 20 Oct 2026 23:31:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 91E31606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=MZj/iwTj
Received: from [172.20.10.2] (unknown [4.194.122.162])
	by linux.microsoft.com (Postfix) with ESMTPSA id 116C420B7168;
	Tue, 20 Oct 2026 16:31:07 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 116C420B7168
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1792539071;
	bh=fgNej84WTt4OS++7vi1hUcNO4v+lufgORZL9i9nk4VQ=;
	h=Date:Subject:To:References:Cc:From:In-Reply-To:From;
	b=MZj/iwTjaCHa98xIkbLSAmcImRmEmLR++DLkTQgg5i5o1WRny6fziE2wg+xWuMY28
	 bwRE7BdYE7Olu5v9nUMuHd9R9zIiqc/sEHJS4FcgPS/OK4o6h3yHnzXf3lJE7OlWjP
	 IoK7lMBot8zd6ZplFGzCKXLd87aDEDBbb7JmukG8=
Message-ID: <7d9f70d0-1856-4424-89d9-c9f3552a8469@linux.microsoft.com>
Date: Tue, 20 Oct 2026 16:30:55 -0700
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Post: <mailto:linux-hyperv@vger.kernel.org>
List-Help: <mailto:linux-hyperv+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hyperv+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hv/vmbus: copy dynamic IDs before dropping the lock
To: Jiale Yao <yaojiale02@163.com>
References: <20261019085544.1834700-1-yaojiale02@163.com>
Content-Language: en-US
Cc: Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Stephen Hemminger <stephen@networkplumber.org>,
 linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
From: Kameron Carr <kameroncarr@linux.microsoft.com>
In-Reply-To: <20261019085544.1834700-1-yaojiale02@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/19/2026 1:55 AM, Jiale Yao wrote:
> remove_id_store() can free a matching dynamic ID while VMBus is
> preparing to invoke a driver probe. Copy the ID while holding the
> dynamic ID lock so probe never receives a pointer into a freed list
> entry.

Is this the same fix as:

  3ffc4c9690c3 ("PCI: Fix UAF when probe runs concurrent to dyn ID
  removal")
  ef8154d8b52d ("usb: fix UAF when probe runs concurrent to
  dyn ID removal")

If so, consider citing them in the commit message. Also, consider taking
inspiration from their implementation.

Nit: this subsystem typically uses "Drivers: hv: vmbus:" for the subject
prefix.


> Fixes: fc76936d3ea5 ("vmbus: add support for dynamic device id's")
> Signed-off-by: Jiale Yao <yaojiale02@163.com>
> ---
>  drivers/hv/vmbus_drv.c | 25 +++++++++++++++----------
>  1 file changed, 15 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> index 4692687cdbf3..96ad0dfaa50b 100644
> --- a/drivers/hv/vmbus_drv.c
> +++ b/drivers/hv/vmbus_drv.c
> @@ -661,21 +661,22 @@ hv_vmbus_dev_match(const struct hv_vmbus_device_id *id, const guid_t *guid)
>  }
>  
>  static const struct hv_vmbus_device_id *
> -hv_vmbus_dynid_match(struct hv_driver *drv, const guid_t *guid)
> +hv_vmbus_dynid_match(struct hv_driver *drv, const guid_t *guid,
> +		     struct hv_vmbus_device_id *id_copy)
>  {
> -	const struct hv_vmbus_device_id *id = NULL;
>  	struct vmbus_dynid *dynid;
>  
>  	spin_lock(&drv->dynids.lock);
>  	list_for_each_entry(dynid, &drv->dynids.list, node) {
>  		if (guid_equal(&dynid->id.guid, guid)) {
> -			id = &dynid->id;
> -			break;
> +			*id_copy = dynid->id;
> +			spin_unlock(&drv->dynids.lock);
> +			return id_copy;
>  		}
>  	}
>  	spin_unlock(&drv->dynids.lock);
>  
> -	return id;
> +	return NULL;
>  }
>  
>  static const struct hv_vmbus_device_id vmbus_device_null;
> @@ -685,7 +686,8 @@ static const struct hv_vmbus_device_id vmbus_device_null;
>   * If there is no match, return NULL.
>   */
>  static const struct hv_vmbus_device_id *hv_vmbus_get_id(const struct hv_driver *drv,
> -							struct hv_device *dev)
> +							struct hv_device *dev,
> +							struct hv_vmbus_device_id *id_copy)
>  {
>  	const guid_t *guid = &dev->dev_type;
>  	const struct hv_vmbus_device_id *id;
> @@ -697,7 +699,7 @@ static const struct hv_vmbus_device_id *hv_vmbus_get_id(const struct hv_driver *
>  		return NULL;
>  
>  	/* Look at the dynamic ids first, before the static ones */
> -	id = hv_vmbus_dynid_match((struct hv_driver *)drv, guid);
> +	id = hv_vmbus_dynid_match((struct hv_driver *)drv, guid, id_copy);
>  	if (!id)
>  		id = hv_vmbus_dev_match(drv->id_table, guid);
>  
> @@ -773,6 +775,7 @@ static ssize_t new_id_store(struct device_driver *driver, const char *buf,
>  			    size_t count)
>  {
>  	struct hv_driver *drv = drv_to_hv_drv(driver);
> +	struct hv_vmbus_device_id id_copy;
>  	guid_t guid;
>  	ssize_t retval;
>  
> @@ -780,7 +783,7 @@ static ssize_t new_id_store(struct device_driver *driver, const char *buf,
>  	if (retval)
>  		return retval;
>  
> -	if (hv_vmbus_dynid_match(drv, &guid))
> +	if (hv_vmbus_dynid_match(drv, &guid, &id_copy))
>  		return -EEXIST;
>  
>  	retval = vmbus_add_dynid(drv, &guid);

This check and the list_add_tail() in vmbus_add_dynid() run in separate
critical sections, so two concurrent writers can both add the same GUID.
Consider a preparatory patch that moves the check into vmbus_add_dynid()
under the same dynids.lock; see 04fde70f782b ("PCI: Fix dyn_id add
TOCTOU"). new_id_store() then no longer needs hv_vmbus_dynid_match() or
id_copy at all.

> @@ -840,12 +843,13 @@ static int vmbus_match(struct device *device, const struct device_driver *driver
>  {
>  	const struct hv_driver *drv = drv_to_hv_drv(driver);
>  	struct hv_device *hv_dev = device_to_hv_device(device);
> +	struct hv_vmbus_device_id id_copy;
>  
>  	/* The hv_sock driver handles all hv_sock offers. */
>  	if (is_hvsock_channel(hv_dev->channel))
>  		return drv->hvsock;
>  
> -	if (hv_vmbus_get_id(drv, hv_dev))
> +	if (hv_vmbus_get_id(drv, hv_dev, &id_copy))
>  		return 1;
>  
>  	return 0;
> @@ -860,9 +864,10 @@ static int vmbus_probe(struct device *child_device)
>  	struct hv_driver *drv =
>  			drv_to_hv_drv(child_device->driver);
>  	struct hv_device *dev = device_to_hv_device(child_device);
> +	struct hv_vmbus_device_id dev_id_copy;
>  	const struct hv_vmbus_device_id *dev_id;
>  
> -	dev_id = hv_vmbus_get_id(drv, dev);
> +	dev_id = hv_vmbus_get_id(drv, dev, &dev_id_copy);

Consider documenting in include/linux/hyperv.h that the
hv_vmbus_device_id is only valid during probe so future drivers don't
save the pointer (see what PCI and USB fixes did in pci.h and usb.h).

>  	if (drv->probe) {
>  		ret = drv->probe(dev, dev_id);
>  		if (ret != 0)

Please review the Sashiko comment.

Regards,
Kameron

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EB514DEC3E;
	Mon, 19 Oct 2026 13:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792416944; cv=none; b=pLRhIQjmwmuA6lvuqDLu0do9NkTrv0TEbgmjX1qFGQGQxIJTLJcRCFH/chUQ8J/b6XmRYhqPVKC6MMwKU/V8Q+0aaXOyGT0K11kxsNLSHb3TUzXo89PioQGYapxdkDnSJyQH+v2Zp7KCEsAt2cReadENSxXAMkUu7HkjTJRC82U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792416944; c=relaxed/simple;
	bh=YYvE0sRBu1sVS+gOH/0QzLApX8jyXQUMwjo9mnz28FM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BIibSEi/aZjtg39Ez0UswHwGmPthOaQjHkDp6I0TfHMD2W9WdPqG3i4Samz3tk/SIzRmjeZIUn213JiY+QloqCGPZ758lh0H71ucGkGZbis+2ugxxwYuvPSg/mKwWF30+ngRd0r06phZS1SNRouJ0w31wNuZTcc96t3pRRRGfX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=iCaeoJzG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="iCaeoJzG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 574731F000C4;
	Mon, 19 Oct 2026 13:35:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1792416942;
	bh=rhfvYQElhBdedNKeQxhemvLQ7lZKA7SpMfLghyJzDlI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=iCaeoJzGi32z7OgjNCpsdNbhFcUQB+3Gysu7sXHSnjpWSU6rdvcTEoHg5Irw6Yqfu
	 cewqMZLrZQLa/Vq4S0HPTa6kyokuG74fQrWKMtkKZit/Rn/m9rrD04vJIte1asArN6
	 DMYVExSCAbu+lEUWOkOr6DXrnTp8p6m1EIC3MBmU=
Date: Mon, 19 Oct 2026 15:35:38 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Jiale Yao <yaojiale02@163.com>
Cc: Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Stephen Hemminger <stephen@networkplumber.org>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hv/vmbus: copy dynamic IDs before dropping the lock
Message-ID: <2026101936-livable-plug-8bc9@gregkh>
References: <20261019085544.1834700-1-yaojiale02@163.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261019085544.1834700-1-yaojiale02@163.com>

On Mon, Oct 19, 2026 at 04:55:44PM +0800, Jiale Yao wrote:
> remove_id_store() can free a matching dynamic ID while VMBus is
> preparing to invoke a driver probe.

And how can that be triggered?

> Copy the ID while holding the dynamic ID lock so probe never receives
> a pointer into a freed list entry.

Why is this driver allowed to handle dynamic ids at all?  Is it really
required?  That will taint the kernel so no real workflow requires it,
right?

> Fixes: fc76936d3ea5 ("vmbus: add support for dynamic device id's")

No cc: stable?

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

Shouldn't this be a memcpy() as that's what you are really doing?

> +			spin_unlock(&drv->dynids.lock);

guard() usage instead?

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

On the stack?

Ok, I guess this would work, but it feels clunky, why doesn't all other
busses have to do this too?

thanks,

greg k-h

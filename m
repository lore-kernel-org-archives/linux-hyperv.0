Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CCDB4CA297;
	Tue, 21 Jul 2026 15:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784646693; cv=none; b=f5LbS4JSAeyuvUpSv8yNU6urAgutVwMsQUNNAKG10MftHssxRJUtjRxU3QiNHc6NQN/7bmYzrakf9FCsBdS7ZC0dU0crVk/v37ZbtIDOBE00Ap8q4zgqEfcLwdPX0wELdEIYZ0JUNKPZ2kj9EPrx3/SBwuPJz20tNGqkspAOmTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784646693; c=relaxed/simple;
	bh=1KBMtwbhoxNlkuFvW4iG9rKziqVRdJEEINSGikeLCMI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ft9I17FWi6PtzsnuGlnJqsmjvFfSSrGCBZYfUJ/NEkyBQZX/ByCPQ8ZhDiWmmG++HXxK9ee9W00HUnNz5Jc+l0/S+eL1T9hLa81ZakB8RPuMmjqQ4UvH4vuigxOv9JTN4Rdwhl2kRALmAKWXn/0/VpHNw/0g14OWK0hsrEf2f44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=p+DHDIBy; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="p+DHDIBy"
Received: by linux.microsoft.com (Postfix, from userid 1127)
	id B9BE720B7169; Tue, 21 Jul 2026 08:11:13 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B9BE720B7169
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1784646673;
	bh=9pxGf+OkgeopOuZ5BtX5WHOIppBAms1TAFL1DRdZThk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p+DHDIByx6HKlavr08TluccSWWlPXFXL3g74+NeApWXRqR4u/qWYO8btnkDM68DYJ
	 a9aK/cX/gaJCFBe1m2prsY2BXs/ozOikdmh0Qj5/Xb0I1Zekncj6JYGkFg6/5JNN/P
	 HI0kPKZotMM+ctmKfnhGRJXAigj94K7727QbVAqI=
Date: Tue, 21 Jul 2026 08:11:13 -0700
From: Saurabh Singh Sengar <ssengar@linux.microsoft.com>
To: Hardik Garg <hargar@linux.microsoft.com>
Cc: "K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Michael Kelley <mhklinux@outlook.com>, linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] Drivers: hv: vmbus: add VTL2 redirect connection ID
Message-ID: <al+MEexKix4eMlB2@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20260717001837.635756-1-hargar@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260717001837.635756-1-hargar@linux.microsoft.com>

On Fri, Jul 17, 2026 at 12:18:37AM +0000, Hardik Garg wrote:
> VMBus sends CHANNELMSG_INITIATE_CONTACT through a Hyper-V message
> connection ID. Older protocol versions use VMBUS_MESSAGE_CONNECTION_ID,
> while protocol version 5.0 and newer normally use
> VMBUS_MESSAGE_CONNECTION_ID_4.
> 
> For a VTL2 kernel using VMBus protocol 5.0 or newer, the host
> may expect INITIATE_CONTACT on either the redirect connection ID or
> VMBUS_MESSAGE_CONNECTION_ID_4. There is no capability indication that
> identifies which ID is active, so the driver must determine it at runtime.
> 
> During VMBus negotiation, the redirect ID is tried first because it is
> used by VTL2 configurations with VMBus redirection enabled. If the
> redirect ID is unavailable, the host rejects it synchronously with
> HV_STATUS_INVALID_CONNECTION_ID, allowing fallback to the standard ID.
> 
> Return a distinct error for an invalid Initiate Contact connection ID so
> this fallback does not mask other post-message failures or
> protocol-version rejections. Preserve the existing connection ID
> selection for older protocol versions or when running below VTL2.
> 
> Signed-off-by: Hardik Garg <hargar@linux.microsoft.com>
> ---
> 
> Notes (v2-changelog):
>     Changes in v2:
>     - Replace the connection ID array and loop with a single redirect
>       attempt, falling back to VMBUS_MESSAGE_CONNECTION_ID_4 only on
>       -ENXIO.
>     - Remove redundant connection-state and timeout checks and the
>       unreachable return after the loop.
>     - Simplify the commit message to describe runtime connection ID
>       selection without relay and message-port implementation details.
>     - Clarify the protocol 5.0 helper and VTL2 redirect comments, remove
>       redundant comments, and use an exact VTL2 check.
>     
>     Link to v1: https://lore.kernel.org/r/20260714213838.3367103-1-hargar@linux.microsoft.com
> 
>  drivers/hv/connection.c   | 47 +++++++++++++++++++++++----------------
>  drivers/hv/hyperv_vmbus.h |  2 ++
>  2 files changed, 30 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/hv/connection.c b/drivers/hv/connection.c
> index b5b322ce16df4..0fd50d4cb5739 100644
> --- a/drivers/hv/connection.c
> +++ b/drivers/hv/connection.c
> @@ -72,7 +72,8 @@ module_param(max_version, uint, S_IRUGO);
>  MODULE_PARM_DESC(max_version,
>  		 "Maximal VMBus protocol version which can be negotiated");
>  
> -int vmbus_negotiate_version(struct vmbus_channel_msginfo *msginfo, u32 version)
> +static int vmbus_try_connection_id(struct vmbus_channel_msginfo *msginfo,
> +				   u32 version, u32 connection_id)
>  {
>  	int ret = 0;
>  	struct vmbus_channel_initiate_contact *msg;
> @@ -87,20 +88,20 @@ int vmbus_negotiate_version(struct vmbus_channel_msginfo *msginfo, u32 version)
>  	msg->vmbus_version_requested = version;
>  
>  	/*
> -	 * VMBus protocol 5.0 (VERSION_WIN10_V5) and higher require that we must
> -	 * use VMBUS_MESSAGE_CONNECTION_ID_4 for the Initiate Contact Message,
> -	 * and for subsequent messages, we must use the Message Connection ID
> -	 * field in the host-returned Version Response Message. And, with
> -	 * VERSION_WIN10_V5 and higher, we don't use msg->interrupt_page, but we
> -	 * tell the host explicitly that we still use VMBUS_MESSAGE_SINT(2) for
> -	 * compatibility.
> +	 * For VMBus protocol 5.0 (VERSION_WIN10_V5) and higher, use the
> +	 * caller-supplied connection_id for the Initiate Contact message so
> +	 * the caller can implement the required retry scheme. For subsequent
> +	 * messages, use the Message Connection ID field in the host-returned
> +	 * Version Response message. With VERSION_WIN10_V5 and higher, we don't
> +	 * use msg->interrupt_page, but tell the host explicitly that we still
> +	 * use VMBUS_MESSAGE_SINT(2) for compatibility.
>  	 *
>  	 * On old hosts, we should always use VMBUS_MESSAGE_CONNECTION_ID (1).
>  	 */
>  	if (version >= VERSION_WIN10_V5) {
>  		msg->msg_sint = VMBUS_MESSAGE_SINT;
>  		msg->msg_vtl = ms_hyperv.vtl;
> -		vmbus_connection.msg_conn_id = VMBUS_MESSAGE_CONNECTION_ID_4;
> +		vmbus_connection.msg_conn_id = connection_id;
>  	} else {
>  		msg->interrupt_page = virt_to_phys(vmbus_connection.int_page);
>  		vmbus_connection.msg_conn_id = VMBUS_MESSAGE_CONNECTION_ID;
> @@ -165,6 +166,22 @@ int vmbus_negotiate_version(struct vmbus_channel_msginfo *msginfo, u32 version)
>  	return ret;
>  }
>  
> +int vmbus_negotiate_version(struct vmbus_channel_msginfo *msginfo, u32 version)
> +{
> +	int ret;
> +
> +	/* Try the redirect ID first for VTL2 with VMBus protocol 5.0+. */
> +	if (version >= VERSION_WIN10_V5 && ms_hyperv.vtl == 2) {
> +		ret = vmbus_try_connection_id(msginfo, version,
> +					      VMBUS_MESSAGE_CONNECTION_ID_REDIRECT);
> +		if (ret != -ENXIO)
> +			return ret;
> +	}
> +
> +	return vmbus_try_connection_id(msginfo, version,
> +				       VMBUS_MESSAGE_CONNECTION_ID_4);
> +}
> +
>  /*
>   * vmbus_connect - Sends a connect request on the partition service connection
>   */
> @@ -457,18 +474,10 @@ int vmbus_post_msg(void *buffer, size_t buflen, bool can_sleep)
>  
>  		switch (ret) {
>  		case HV_STATUS_INVALID_CONNECTION_ID:
> -			/*
> -			 * See vmbus_negotiate_version(): VMBus protocol 5.0
> -			 * and higher require that we must use
> -			 * VMBUS_MESSAGE_CONNECTION_ID_4 for the Initiate
> -			 * Contact message, but on old hosts that only
> -			 * support VMBus protocol 4.0 or lower, here we get
> -			 * HV_STATUS_INVALID_CONNECTION_ID and we should
> -			 * return an error immediately without retrying.
> -			 */
> +			/* Allow INITIATE_CONTACT to try another connection ID. */
>  			hdr = buffer;
>  			if (hdr->msgtype == CHANNELMSG_INITIATE_CONTACT)
> -				return -EINVAL;
> +				return -ENXIO;
>  			/*
>  			 * We could get this if we send messages too
>  			 * frequently.
> diff --git a/drivers/hv/hyperv_vmbus.h b/drivers/hv/hyperv_vmbus.h
> index 05a36854389af..87f8aca1a9fb5 100644
> --- a/drivers/hv/hyperv_vmbus.h
> +++ b/drivers/hv/hyperv_vmbus.h
> @@ -110,6 +110,8 @@ struct hv_input_post_message {
>  enum {
>  	VMBUS_MESSAGE_CONNECTION_ID	= 1,
>  	VMBUS_MESSAGE_CONNECTION_ID_4	= 4,
> +	/* VTL2 redirect connection ID for INITIATE_CONTACT. */
> +	VMBUS_MESSAGE_CONNECTION_ID_REDIRECT = 0x800074,
>  	VMBUS_MESSAGE_PORT_ID		= 1,
>  	VMBUS_EVENT_CONNECTION_ID	= 2,
>  	VMBUS_EVENT_PORT_ID		= 2,
> -- 
> 2.34.1

Reviewed-by: Saurabh Sengar <ssengar@linux.microsoft.com>

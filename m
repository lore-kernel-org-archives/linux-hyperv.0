Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45731329E7E;
	Thu, 16 Jul 2026 15:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784215313; cv=none; b=JMtgc4ZrB35lV7F6NoCk5Ef4fCuivLC3wxhSKGvq6V0syMmkhbKLP8EuSlLwLoLSyzkIcYkdnJRlVvhXjUdF/JrBi4pQom6H2vDZfeDieYu2U3L/D1Ej0EiSPXfgxWQTmf/rLMVlBc0kk1ToETYXH3qXThLdeh1G1awFe16ggjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784215313; c=relaxed/simple;
	bh=EVjcSFVI9wTSmqwtx8tyjsfIHTtIJ3wHi77tQI12pPU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ngTPZ3AJVZDItMdTB5gm5dC4OnSj/pJYKfQOsd1vZHUiO0YGd3WfM/MXyaxHDHTNAtbReJEwBiyW2fC781tcSI6WRRzjvSgJ+R4X5chs5BP8inIgs733ruO9F4IcV2RyPnU+qJxTon51FjS+acJeBXaBWEQZdIDkh4VP2BSR8+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=CWa7afzl; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="CWa7afzl"
Received: by linux.microsoft.com (Postfix, from userid 1127)
	id CFE5120B7167; Thu, 16 Jul 2026 08:21:36 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com CFE5120B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1784215296;
	bh=niD/+kAV2ZI3q1IuLEyK0dk5XBqsGSNybWotggXvLaM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CWa7afzlK+NQXGPXLAOEDoQw2/5DFQe6wcdJwsU1Ej/g3s2UjDRxese1DcFG9wMpA
	 TBXgj7ewP3TwCU+pirSzRPCW+YDgRcdyIsBSW5zYpNFxfVbeC6UTom9iRnZqvA5y7o
	 dJTX/fJ3cHqeS7CyvftCm1v94BueRiamD67bBUSk=
Date: Thu, 16 Jul 2026 08:21:36 -0700
From: Saurabh Singh Sengar <ssengar@linux.microsoft.com>
To: Hardik Garg <hargar@linux.microsoft.com>
Cc: "K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Drivers: hv: vmbus: add VTL2 redirect connection ID
Message-ID: <alj3AOAXk47fQx4m@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20260714213838.3367103-1-hargar@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260714213838.3367103-1-hargar@linux.microsoft.com>

On Tue, Jul 14, 2026 at 09:38:38PM +0000, Hardik Garg wrote:
> VMBus sends CHANNELMSG_INITIATE_CONTACT through a Hyper-V message
> connection ID. Older protocol versions use VMBUS_MESSAGE_CONNECTION_ID,
> while protocol version 5.0 and newer normally use
> VMBUS_MESSAGE_CONNECTION_ID_4.
> 
> When the Linux VMBus driver runs at VTL2, the VMBus control plane may
> be reached through a VMBus relay instead of the standard host endpoint.
> In that setup the relay listens on the redirect message connection ID,
> and an Initiate Contact message sent to the standard ID is not delivered
> to the control plane.
> 
> The connection ID selects the Hyper-V message port used to reach the
> VMBus control plane. If Linux uses the wrong port, the host does not
> receive the Initiate Contact message.
> 
> For Linux running at VTL2 with VMBus protocol 5.0 or newer, try the
> redirect connection ID first. In VTL2, the redirect connection ID is the
> VMBus relay endpoint. If the relay is present, it accepts Initiate
> Contact and completes the normal version-response handshake. Systems
> without the relay reject the redirect ID synchronously with
> HV_STATUS_INVALID_CONNECTION_ID, allowing fallback to
> VMBUS_MESSAGE_CONNECTION_ID_4.
> 
> Return a distinct error for an invalid Initiate Contact connection ID so
> this fallback does not mask other post-message failures or
> protocol-version rejections. For older protocol versions, and for Linux
> below VTL2, keep the existing connection ID selection.
> 
> Signed-off-by: Hardik Garg <hargar@linux.microsoft.com>
> ---
>  drivers/hv/connection.c   | 76 ++++++++++++++++++++++++++++++++++++++++-------
>  drivers/hv/hyperv_vmbus.h |  2 ++
>  2 files changed, 67 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/hv/connection.c b/drivers/hv/connection.c
> index 1fe3573ae52a4..eb871f87a819d 100644
> --- a/drivers/hv/connection.c
> +++ b/drivers/hv/connection.c
> @@ -71,7 +71,19 @@ module_param(max_version, uint, S_IRUGO);
>  MODULE_PARM_DESC(max_version,
>  		 "Maximal VMBus protocol version which can be negotiated");
>  
> -int vmbus_negotiate_version(struct vmbus_channel_msginfo *msginfo, u32 version)
> +/* Connection IDs to try for VTL2 VMBus protocol 5.0 and newer. */
> +static const u32 connection_ids[] = {

Do we want to name it vtl2_connection_ids ?


> +	VMBUS_MESSAGE_CONNECTION_ID_REDIRECT,
> +	VMBUS_MESSAGE_CONNECTION_ID_4,
> +};
> +
> +/*
> + * Send one CHANNELMSG_INITIATE_CONTACT attempt.
> + * The caller supplies the message connection ID and owns retry/fallback
> + * policy.
> + */
> +static int vmbus_try_connection_id(struct vmbus_channel_msginfo *msginfo,
> +				   u32 version, u32 connection_id)
>  {
>  	int ret = 0;
>  	struct vmbus_channel_initiate_contact *msg;
> @@ -87,7 +99,7 @@ int vmbus_negotiate_version(struct vmbus_channel_msginfo *msginfo, u32 version)
>  
>  	/*
>  	 * VMBus protocol 5.0 (VERSION_WIN10_V5) and higher require that we must
> -	 * use VMBUS_MESSAGE_CONNECTION_ID_4 for the Initiate Contact Message,
> +	 * use connection_id for the Initiate Contact Message,
>  	 * and for subsequent messages, we must use the Message Connection ID
>  	 * field in the host-returned Version Response Message. And, with
>  	 * VERSION_WIN10_V5 and higher, we don't use msg->interrupt_page, but we
> @@ -99,7 +111,7 @@ int vmbus_negotiate_version(struct vmbus_channel_msginfo *msginfo, u32 version)
>  	if (version >= VERSION_WIN10_V5) {
>  		msg->msg_sint = VMBUS_MESSAGE_SINT;
>  		msg->msg_vtl = ms_hyperv.vtl;
> -		vmbus_connection.msg_conn_id = VMBUS_MESSAGE_CONNECTION_ID_4;
> +		vmbus_connection.msg_conn_id = connection_id;
>  	} else {
>  		msg->interrupt_page = virt_to_phys(vmbus_connection.int_page);
>  		vmbus_connection.msg_conn_id = VMBUS_MESSAGE_CONNECTION_ID;
> @@ -161,6 +173,51 @@ int vmbus_negotiate_version(struct vmbus_channel_msginfo *msginfo, u32 version)
>  	return ret;
>  }
>  
> +/*
> + * Negotiate the given VMBus protocol version with the host.
> + * Protocol-specific connection ID policy is handled here so the single-try
> + * helper stays simple.
> + */
> +int vmbus_negotiate_version(struct vmbus_channel_msginfo *msginfo, u32 version)
> +{
> +	int ret;
> +	size_t j;
> +
> +	/*
> +	 * The redirect ID is not a speculative endpoint. If the VMBus relay is
> +	 * present, it accepts INITIATE_CONTACT and completes the normal version
> +	 * response. Systems without the relay reject the ID synchronously, so
> +	 * negotiation falls back to VMBUS_MESSAGE_CONNECTION_ID_4.
> +	 */
> +	if (version >= VERSION_WIN10_V5 && ms_hyperv.vtl >= 2) {
> +		for (j = 0; j < ARRAY_SIZE(connection_ids); j++) {
> +			ret = vmbus_try_connection_id(msginfo, version,
> +						      connection_ids[j]);
> +			if (vmbus_connection.conn_state == CONNECTED)
> +				return 0;

Do we need this ? ret is anyway 0 on success which we can return at the end ?

> +
> +			if (ret == -ETIMEDOUT)
> +				return ret;
> +
> +			if (connection_ids[j] ==
> +			    VMBUS_MESSAGE_CONNECTION_ID_REDIRECT &&
> +			    ret == -ENXIO)
> +				continue;
> +
> +			return ret;
> +		}
> +		return ret;

Dead code

> +	}
> +
> +	/*
> +	 * Non-redirect path. Protocol 5.0+ below VTL2 uses the standard
> +	 * v5 connection ID; pre-v5 ignores the supplied ID and uses the
> +	 * legacy connection ID.
> +	 */
> +	return vmbus_try_connection_id(msginfo, version,
> +				       VMBUS_MESSAGE_CONNECTION_ID_4);
> +}
> +
>  /*
>   * vmbus_connect - Sends a connect request on the partition service connection
>   */
> @@ -455,17 +507,14 @@ int vmbus_post_msg(void *buffer, size_t buflen, bool can_sleep)
>  		switch (ret) {
>  		case HV_STATUS_INVALID_CONNECTION_ID:
>  			/*
> -			 * See vmbus_negotiate_version(): VMBus protocol 5.0
> -			 * and higher require that we must use
> -			 * VMBUS_MESSAGE_CONNECTION_ID_4 for the Initiate
> -			 * Contact message, but on old hosts that only
> -			 * support VMBus protocol 4.0 or lower, here we get
> -			 * HV_STATUS_INVALID_CONNECTION_ID and we should
> -			 * return an error immediately without retrying.
> +			 * Let negotiation distinguish an unusable
> +			 * endpoint from other failures.
> +			 *
> +			 * Other messages keep retry behavior.
>  			 */
>  			hdr = buffer;
>  			if (hdr->msgtype == CHANNELMSG_INITIATE_CONTACT)
> -				return -EINVAL;
> +				return -ENXIO;
>  			/*
>  			 * We could get this if we send messages too
>  			 * frequently.
> diff --git a/drivers/hv/hyperv_vmbus.h b/drivers/hv/hyperv_vmbus.h
> index 49a72a4f3f6a7..951bdebdc0526 100644
> --- a/drivers/hv/hyperv_vmbus.h
> +++ b/drivers/hv/hyperv_vmbus.h
> @@ -109,6 +109,8 @@ struct hv_input_post_message {
>  enum {
>  	VMBUS_MESSAGE_CONNECTION_ID	= 1,
>  	VMBUS_MESSAGE_CONNECTION_ID_4	= 4,
> +	/* VMBus relay port used for INITIATE_CONTACT probing. */

Do we want to mention specific for VTL2 in comment ?

> +	VMBUS_MESSAGE_CONNECTION_ID_REDIRECT = 0x800074,
>  	VMBUS_MESSAGE_PORT_ID		= 1,
>  	VMBUS_EVENT_CONNECTION_ID	= 2,
>  	VMBUS_EVENT_PORT_ID		= 2,
> -- 
> 2.34.1

- Saurabh

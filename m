Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A090F3C98BA;
	Thu, 16 Jul 2026 22:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784239476; cv=none; b=QSCNLBm13/jxsLccWmYU4dxnMUnYiuX/NRZpImGs7T49GWKZPAHFuSx2BnP6B3lExPWZHZ6k5LJEYEYOVywBZETYO+ap9UUg2xp90DQtIzV2jxlKPwtGtrt5rpXx55uLmaV0Jb3lhqlyrpb5jqCVQyuRKGP1FkntkNHAQZ+NiSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784239476; c=relaxed/simple;
	bh=J91xahOtVKl1Os8Ah5Qq78fzoVHyNkibW4R+eRFzgFI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=pIBd6ZjSrS+IzGqRlDvhsMitM8rEnsCQuS4/SScVLkgvU7JgBHdxSxE2xaEPCfWEE5RTjkqPlEGt3sw8HMU9NYvJeu5NU4ovoD9eDYZbkd5tpLZohdW3xoZh7bMJhsyGSlH0FzkNONc3m57WTiNJBpf16yW+iR7/0Kv5wo/F3Us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=HjLgEGYl; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="HjLgEGYl"
Received: from [100.65.200.70] (unknown [20.236.10.206])
	by linux.microsoft.com (Postfix) with ESMTPSA id A7CC720B7169;
	Thu, 16 Jul 2026 15:04:23 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A7CC720B7169
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1784239463;
	bh=fptDKyCCJju2uLhpO5xe7JWrHgFTq1Wj409NjkpcHs4=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=HjLgEGYlBTFVQIlAHz52VSaDK5PbU9c4ou9Iy9f9XtRCLbpQVGyI1bKXjx+rpzAEJ
	 QSh07uG6EPQmMrck9Kr5e12O2wabTPXyMxpc5ZMyZrWI/WdOZHbiAKgTKv71pKAl1E
	 224XsiIYs349M5nIEscTGdS2JA4KCXD1sgBZO7QM=
Message-ID: <b5f8567e-3ce8-4d62-ae91-7479ba00ce07@linux.microsoft.com>
Date: Thu, 16 Jul 2026 15:04:30 -0700
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Drivers: hv: vmbus: add VTL2 redirect connection ID
To: Michael Kelley <mhklinux@outlook.com>,
 "K. Y. Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20260714213838.3367103-1-hargar@linux.microsoft.com>
 <SN6PR02MB415769F6F2645260C8D5778CD4C72@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Language: en-US
From: Hardik Garg <hargar@linux.microsoft.com>
In-Reply-To: <SN6PR02MB415769F6F2645260C8D5778CD4C72@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 7/16/2026 10:03 AM, Michael Kelley wrote:
> From: Hardik Garg <hargar@linux.microsoft.com> Sent: Tuesday, July 14, 2026 2:39 PM
>> VMBus sends CHANNELMSG_INITIATE_CONTACT through a Hyper-V message
>> connection ID. Older protocol versions use VMBUS_MESSAGE_CONNECTION_ID,
>> while protocol version 5.0 and newer normally use
>> VMBUS_MESSAGE_CONNECTION_ID_4.
>>
>> When the Linux VMBus driver runs at VTL2, the VMBus control plane may
>> be reached through a VMBus relay instead of the standard host endpoint.
>> In that setup the relay listens on the redirect message connection ID,
>> and an Initiate Contact message sent to the standard ID is not delivered
>> to the control plane.
>>
>> The connection ID selects the Hyper-V message port used to reach the
>> VMBus control plane. If Linux uses the wrong port, the host does not
>> receive the Initiate Contact message.
> This is a judgment call, but to me the previous two paragraphs are
> explaining VTL2 implementation details that aren't necessary for
> understanding this patch. Yes, in earlier discussions I asked questions
> about "why" all this funky behavior with connection IDs, but that's
> just me as a former Microsoft insider. :-)  Details about VMBus relays and
> message ports are fairly obscure for people in the general Linux community.
> It would be sufficient for the commit message to simply state that VTL2
> may respond on either of two connection IDs. There's no separate indication
> of which one will respond in a given VM, so it is necessary to try at runtime
> to see which one works.

Good point, I will remove the extra details in v2.

>
>> For Linux running at VTL2 with VMBus protocol 5.0 or newer, try the
>> redirect connection ID first. In VTL2, the redirect connection ID is the
>> VMBus relay endpoint. If the relay is present, it accepts Initiate
>> Contact and completes the normal version-response handshake. Systems
>> without the relay reject the redirect ID synchronously with
>> HV_STATUS_INVALID_CONNECTION_ID, allowing fallback to
>> VMBUS_MESSAGE_CONNECTION_ID_4.
> Is there a reason for trying the REDIRECT connection ID first? Or
> is the ordering of trying arbitrary? If the REDIRECT connection
> ID must be tried first, state that as a VTL2 requirement.

I will add it as a VTL2 requirement. Redirect Id is used first as it
is the configured VMBus control-plane endpoint when VTL2 redirection
is enabled. 

>
>> Return a distinct error for an invalid Initiate Contact connection ID so
>> this fallback does not mask other post-message failures or
>> protocol-version rejections. For older protocol versions, and for Linux
>> below VTL2, keep the existing connection ID selection.
>>
>> Signed-off-by: Hardik Garg <hargar@linux.microsoft.com>
>> ---
>>  drivers/hv/connection.c   | 76 ++++++++++++++++++++++++++++++++++++++++-------
>>  drivers/hv/hyperv_vmbus.h |  2 ++
>>  2 files changed, 67 insertions(+), 11 deletions(-)
>>
>> diff --git a/drivers/hv/connection.c b/drivers/hv/connection.c
>> index 1fe3573ae52a4..eb871f87a819d 100644
>> --- a/drivers/hv/connection.c
>> +++ b/drivers/hv/connection.c
>> @@ -71,7 +71,19 @@ module_param(max_version, uint, S_IRUGO);
>>  MODULE_PARM_DESC(max_version,
>>  		 "Maximal VMBus protocol version which can be negotiated");
>>
>> -int vmbus_negotiate_version(struct vmbus_channel_msginfo *msginfo, u32 version)
>> +/* Connection IDs to try for VTL2 VMBus protocol 5.0 and newer. */
>> +static const u32 connection_ids[] = {
>> +	VMBUS_MESSAGE_CONNECTION_ID_REDIRECT,
>> +	VMBUS_MESSAGE_CONNECTION_ID_4,
>> +};
> Using an array of connection IDs to iterate through matches the
> design of how multiple VMBus protocols versions are tried. But with
> only two entries in the array, this feels a bit over-engineered unless
> there is reason to expect that more connection ID values are coming
> in the reasonably near future. Absent an array, the code in the
> vmbus_negotiate_version() could just hard code to test the redirect
> connection ID first if running at VTL2, and if that fails with -ENXIO,
> fall through to the normal case. 


I used the array to accommodate new connection-ids in the future but I agree
that we don't need it currently. I will simplify it in v2.

>> +
>> +/*
>> + * Send one CHANNELMSG_INITIATE_CONTACT attempt.
>> + * The caller supplies the message connection ID and owns retry/fallback
>> + * policy.
>> + */
>> +static int vmbus_try_connection_id(struct vmbus_channel_msginfo *msginfo,
>> +				   u32 version, u32 connection_id)
>>  {
>>  	int ret = 0;
>>  	struct vmbus_channel_initiate_contact *msg;
>> @@ -87,7 +99,7 @@ int vmbus_negotiate_version(struct vmbus_channel_msginfo *msginfo, u32 version)
>>
>>  	/*
>>  	 * VMBus protocol 5.0 (VERSION_WIN10_V5) and higher require that we must
>> -	 * use VMBUS_MESSAGE_CONNECTION_ID_4 for the Initiate Contact Message,
>> +	 * use connection_id for the Initiate Contact Message,
> This wording of this comment now feels a bit awkward. How about:
>
> "For VMBus protocol 5.0 (VERSION_WIN10_V5) and higher, use the caller supplied
>  connection_id for the Initiate Contact Message so the caller can implement the
> necessary retry scheme. For subsequent messages, use the Message Connection ID
> field in the host-returned Version Response Message."
>
> followed by the rest of the existing text.

Will update the comment in V2

>
>
>>  	 * and for subsequent messages, we must use the Message Connection ID
>>  	 * field in the host-returned Version Response Message. And, with
>>  	 * VERSION_WIN10_V5 and higher, we don't use msg->interrupt_page, but we
>> @@ -99,7 +111,7 @@ int vmbus_negotiate_version(struct vmbus_channel_msginfo *msginfo, u32 version)
>>  	if (version >= VERSION_WIN10_V5) {
>>  		msg->msg_sint = VMBUS_MESSAGE_SINT;
>>  		msg->msg_vtl = ms_hyperv.vtl;
>> -		vmbus_connection.msg_conn_id = VMBUS_MESSAGE_CONNECTION_ID_4;
>> +		vmbus_connection.msg_conn_id = connection_id;
>>  	} else {
>>  		msg->interrupt_page = virt_to_phys(vmbus_connection.int_page);
>>  		vmbus_connection.msg_conn_id = VMBUS_MESSAGE_CONNECTION_ID;
>> @@ -161,6 +173,51 @@ int vmbus_negotiate_version(struct vmbus_channel_msginfo *msginfo, u32 version)
>>  	return ret;
>>  }
>>
>> +/*
>> + * Negotiate the given VMBus protocol version with the host.
>> + * Protocol-specific connection ID policy is handled here so the single-try
>> + * helper stays simple.
>> + */
>> +int vmbus_negotiate_version(struct vmbus_channel_msginfo *msginfo, u32 version)
>> +{
>> +	int ret;
>> +	size_t j;
>> +
>> +	/*
>> +	 * The redirect ID is not a speculative endpoint. If the VMBus relay is
> What is a "speculative endpoint"?  And per my comment above, I'd drop
> discussion of VMBus relay, and just phrase things in terms of trying the
> REDIRECT connection ID, and if that doesn't work, then try the normal one. 
I will simplify the comment in V2
>  
>
>> +	 * present, it accepts INITIATE_CONTACT and completes the normal version
>> +	 * response. Systems without the relay reject the ID synchronously, so
>> +	 * negotiation falls back to VMBUS_MESSAGE_CONNECTION_ID_4.
>> +	 */
>> +	if (version >= VERSION_WIN10_V5 && ms_hyperv.vtl >= 2) {
>> +		for (j = 0; j < ARRAY_SIZE(connection_ids); j++) {
>> +			ret = vmbus_try_connection_id(msginfo, version,
>> +						      connection_ids[j]);
>> +			if (vmbus_connection.conn_state == CONNECTED)
>> +				return 0;
>> +
>> +			if (ret == -ETIMEDOUT)
>> +				return ret;
>> +
>> +			if (connection_ids[j] ==
>> +			    VMBUS_MESSAGE_CONNECTION_ID_REDIRECT &&
>> +			    ret == -ENXIO)
>> +				continue;
>> +
>> +			return ret;
>> +		}
>> +		return ret;
>> +	}
> Per my earlier comment about not having an array of connection IDs, this
> code could be as simple as:
>
> if (version >= VERSION_WIN10_V5 && ms_hyperv.vtl >=2) {
> 	ret = vmbus_try_connection_id(msginfo, version,
> 				VMBUS_MESSAGE_CONNECTION_ID_REDIRECT);
> 	if (ret != -ENXIO)
> 		return ret;
> }
I will update this part as per the earlier feedback.
>> +
>> +	/*
>> +	 * Non-redirect path. Protocol 5.0+ below VTL2 uses the standard
>> +	 * v5 connection ID; pre-v5 ignores the supplied ID and uses the
>> +	 * legacy connection ID.
>> +	 */
>> +	return vmbus_try_connection_id(msginfo, version,
>> +				       VMBUS_MESSAGE_CONNECTION_ID_4);
>> +}
>> +
>>  /*
>>   * vmbus_connect - Sends a connect request on the partition service connection
>>   */
>> @@ -455,17 +507,14 @@ int vmbus_post_msg(void *buffer, size_t buflen, bool can_sleep)
>>  		switch (ret) {
>>  		case HV_STATUS_INVALID_CONNECTION_ID:
>>  			/*
>> -			 * See vmbus_negotiate_version(): VMBus protocol 5.0
>> -			 * and higher require that we must use
>> -			 * VMBUS_MESSAGE_CONNECTION_ID_4 for the Initiate
>> -			 * Contact message, but on old hosts that only
>> -			 * support VMBus protocol 4.0 or lower, here we get
>> -			 * HV_STATUS_INVALID_CONNECTION_ID and we should
>> -			 * return an error immediately without retrying.
>> +			 * Let negotiation distinguish an unusable
>> +			 * endpoint from other failures.
>> +			 *
>> +			 * Other messages keep retry behavior.
>>  			 */
>>  			hdr = buffer;
>>  			if (hdr->msgtype == CHANNELMSG_INITIATE_CONTACT)
>> -				return -EINVAL;
>> +				return -ENXIO;
>>  			/*
>>  			 * We could get this if we send messages too
>>  			 * frequently.
>> diff --git a/drivers/hv/hyperv_vmbus.h b/drivers/hv/hyperv_vmbus.h
>> index 49a72a4f3f6a7..951bdebdc0526 100644
>> --- a/drivers/hv/hyperv_vmbus.h
>> +++ b/drivers/hv/hyperv_vmbus.h
>> @@ -109,6 +109,8 @@ struct hv_input_post_message {
>>  enum {
>>  	VMBUS_MESSAGE_CONNECTION_ID	= 1,
>>  	VMBUS_MESSAGE_CONNECTION_ID_4	= 4,
>> +	/* VMBus relay port used for INITIATE_CONTACT probing. */
>> +	VMBUS_MESSAGE_CONNECTION_ID_REDIRECT = 0x800074,
>>  	VMBUS_MESSAGE_PORT_ID		= 1,
>>  	VMBUS_EVENT_CONNECTION_ID	= 2,
>>  	VMBUS_EVENT_PORT_ID		= 2,
>> --
>> 2.34.1

Thank you for the review, Michael.


Thanks,

Hardik


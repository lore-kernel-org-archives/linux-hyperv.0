Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E32D238655D;
	Mon, 20 Jul 2026 15:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784561706; cv=none; b=IYDlU+gPEukRrdcx5O4Ga9o9+AS3sMSQeEZ6ArC2XjAWSMj/QO1ib8jkkZN7BKA9js+GWO9eN+XlEIhCRbi0A5OYhFVbdXPKfAzsTyot58AeTxC7HFHgusMHDW4SmA3wUFJvsaFXHiw+el5F/EcRmiGtVSB6s9Ouixakx/WeLuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784561706; c=relaxed/simple;
	bh=+T2sEFPE7rajc5fFUOqc2Dj30tK0NkXWP8OCzB+8pDA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=lVdSOiZ6UJ9mPtY8LLkIqsZmcRxPqTN9J7hw77r7mEXswjKe7UxOPs71F+Mr+WpzJvrZBo13H+X6wxWqK2ZQfjd5r+Cin1TShg6BXovHn9QO7QQ3vpydDFDcyk2skZ4dwBegP4k5/6az9IhDw4a4ZMwbVrTJ/4V4jC1qDWIet+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=oMVGNHfh; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="oMVGNHfh"
Received: from [192.168.0.105] (unknown [4.194.122.170])
	by linux.microsoft.com (Postfix) with ESMTPSA id 13C0020B7169;
	Mon, 20 Jul 2026 08:34:46 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 13C0020B7169
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1784561689;
	bh=pZ+9ojnYusCUcERhkOrfi+2aUjIQwCqu+PtVtnijj10=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=oMVGNHfhCj1t1t4VbyPuEAuvI7Hnm+fxI0Q0hNNV2UbSt+AK2KVhBtgpfSMzEyIXg
	 FC8MpiDK6XS1HbxFpHUJU5QNl2F+WMr+VRqDERvtrvxA16sKd+ablQ6+jzrTUZcH+z
	 gQP+HyT48QMzSODz/aQizQ+cIGyHqjc6cQXgO5Do=
Message-ID: <b7971bb1-f168-44b0-b314-0ab407cbbd9f@linux.microsoft.com>
Date: Mon, 20 Jul 2026 21:04:56 +0530
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] Drivers: hv: vmbus: add VTL2 redirect connection ID
To: Hardik Garg <hargar@linux.microsoft.com>,
 "K. Y. Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>,
 Saurabh Sengar <ssengar@linux.microsoft.com>,
 Michael Kelley <mhklinux@outlook.com>, linux-hyperv@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260717001837.635756-1-hargar@linux.microsoft.com>
Content-Language: en-US
From: Naman Jain <namjain@linux.microsoft.com>
In-Reply-To: <20260717001837.635756-1-hargar@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 7/17/2026 5:48 AM, Hardik Garg wrote:
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

Reviewed-by: Naman Jain <namjain@linux.microsoft.com>

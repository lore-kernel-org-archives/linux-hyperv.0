Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792654901;
	b=BXwq7FGnxhuSIbOOpcRbtwFHjzJmO8VkiOT1nLF2ei0EZ+f7+zWIP2Pr0LFs/78vzANN
	 vrVihqJXgqAdxC4qS5qoS09J1e6jkcOv8OUq2TeHSeQonHd6i/ly3h/TrIrDff/DuK+JN
	 o+bi/5o1DtLCSEZq6EhSUbLSii2Lo8tr1QxVuwMyRPpaVE+7P//yVQ9rEK5Otr+axJPlH
	 n4MBE0eSeozeIEyMgSG4MdQ5FVPdpu2/h7ucCtpDjln5isX88EUxHdCw5tD4gFBCcA2gn
	 WAC8Po35peeAzxomuOuBd8Q7c6uM2OYuxaaj9kluT8A+m8+WteqIZFc0EIzm6cyEVdw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792654901;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=CvSBBaIzDOkoLy23YZbhr14hQwtX6X3MtGrLOOizPiQ=;
	b=eWNbPaW/eGQLxFyG1KE2Au1pbCoctGQm2QLTKn1lUJBM000W8TYowenXhUMJhvtWtY/K
	 l5U4/+w5FiAhX/9x+LV0Bf+hF2YEtSZJO2o7SjQb+c92K/8+5jFCHMQmaA2wp/nUILjIF
	 gyTVMoK6NfmRhdmdR43ul8B1UbKH59ilbpm/jIu/u/dKpFr1ZgsgZ7jYf8Hg7Cs8EVs1c
	 XUy/WoK6QpI5fJSpEK2oWYxcvYTHkmrTRnH6H3yFCjWompqzr+P2mnvtExrMrHrAiZRnA
	 +6nBAn+y61GJmOAVf6nLaCBZ4sqcvY9snwLfSvXUllrJrTIs05RFubiTdwBQhU4WlSg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VauGxlNS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52EDE606A31A;
	Thu, 22 Oct 2026 07:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VauGxlNS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA0BE1F000C2;
	Thu, 22 Oct 2026 07:41:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792654899;
	bh=CvSBBaIzDOkoLy23YZbhr14hQwtX6X3MtGrLOOizPiQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=VauGxlNSCDVxn2W+8ZVHE+mDaGBaIGWxp4pz619csit3PAWFLuVGr3pOQ49B+Ukn/
	 NmF7dn0VLUuyL9DJFyXW2TSHiuS9YRfxlTyXEdTXz89xsTLYHgsaKCO4HcEpe0ho6e
	 /lLvoUUI0pucMrapI63Cl0XMbqnck2nXXKuTCbIaMFSoUq3iV+P0AqBrxdVTsNtgfu
	 4/hzLx5AcpehlHXJLt3G2lvocwuO3KRtzVFzCRlyinilWraHlyaemBrAv5ENUExpJD
	 fwcp/hgEDcMr3zxroLdDD8QUXcogTyh7Sib3aTu2o3oLjmI+5lyKAThv+no+5YHXpq
	 U71XbrUN9eE8A==
Date: Thu, 22 Oct 2026 00:41:38 -0700
From: Wei Liu <wei.liu@kernel.org>
To: Kameron Carr <kameroncarr@linux.microsoft.com>
Cc: haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
	mhklinux@outlook.com, catalin.marinas@arm.com, will@kernel.org,
	mark.rutland@arm.com, lpieralisi@kernel.org,
	sudeep.holla@kernel.org, arnd@arndb.de, thuth@redhat.com,
	linux-hyperv@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH v5 1/6] arm64: rsi: Add RSI host call structure and
 helper function
Message-ID: <20261022074138.GA1512710@liuwe-devbox-debian-v2.local>
References: <20261002215725.2015959-1-kameroncarr@linux.microsoft.com>
 <20261002215725.2015959-2-kameroncarr@linux.microsoft.com>
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Post: <mailto:linux-hyperv@vger.kernel.org>
List-Help: <mailto:linux-hyperv+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hyperv+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261002215725.2015959-2-kameroncarr@linux.microsoft.com>

On Fri, Oct 02, 2026 at 02:57:20PM -0700, Kameron Carr wrote:
> Add struct rsi_host_call to arm-smccc-rsi.h, which represents the host
> call data structure used by the Realm Management Monitor (RMM) for the
> RSI_HOST_CALL interface. The structure contains a 16-bit immediate field
> and 31 general-purpose register values, aligned to 256 bytes as required
> by the CCA RMM specification.
> 
> Add rsi_host_call() static inline wrapper in arm-rsi-cmds.h that invokes
> SMC_RSI_HOST_CALL with the physical address of the host call structure.
> This will be used by Hyper-V guest code to route hypercalls through the
> RSI interface when running inside an Arm CCA Realm.
> 
> Reviewed-by: Michael Kelley <mhklinux@outlook.com>
> Signed-off-by: Kameron Carr <kameroncarr@linux.microsoft.com>
> ---
>  include/linux/arm-rsi-cmds.h  | 22 ++++++++++++++++++++++
>  include/linux/arm-smccc-rsi.h |  7 +++++++

ARM maintainers, I think this needs an ack from you?

Wei

>  2 files changed, 29 insertions(+)
> 
> diff --git a/include/linux/arm-rsi-cmds.h b/include/linux/arm-rsi-cmds.h
> index 3f7a6a8..01d292e 100644
> --- a/include/linux/arm-rsi-cmds.h
> +++ b/include/linux/arm-rsi-cmds.h
> @@ -236,4 +236,26 @@ static inline unsigned long rsi_attestation_token_continue(phys_addr_t granule,
>  	return res.a0;
>  }
>  
> +/**
> + * rsi_host_call - Make a Host call.
> + * @host_call_struct: IPA of host call structure
> + *
> + * This call will fail if the IPA of the host call structure:
> + * * is not aligned to 256 bytes,
> + * * is not protected / encrypted,
> + * * is RIPAS_EMPTY
> + *
> + * Returns:
> + *  On success, returns RSI_SUCCESS.
> + *  Otherwise, returns an error code.
> + */
> +static inline unsigned long rsi_host_call(phys_addr_t host_call_struct)
> +{
> +	struct arm_smccc_res res;
> +
> +	arm_smccc_smc(SMC_RSI_HOST_CALL, host_call_struct, 0, 0, 0, 0, 0, 0,
> +		      &res);
> +	return res.a0;
> +}
> +
>  #endif /* __LINUX_ARM_RSI_CMDS_H_ */
> diff --git a/include/linux/arm-smccc-rsi.h b/include/linux/arm-smccc-rsi.h
> index fddb779..4c8530b 100644
> --- a/include/linux/arm-smccc-rsi.h
> +++ b/include/linux/arm-smccc-rsi.h
> @@ -142,6 +142,13 @@ struct realm_config {
>  	 */
>  } __aligned(0x1000);
>  
> +struct rsi_host_call {
> +	u16 immediate;
> +	u8 _padding[6];
> +	u64 gprs[31];
> +} __aligned(256);
> +static_assert(sizeof(struct rsi_host_call) == 256);
> +
>  #endif /* __ASSEMBLER__ */
>  
>  /*
> -- 
> 2.45.4
> 

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BBAB3815F0;
	Fri, 31 Jul 2026 22:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785537949; cv=none; b=g+30pkyaWipiAeOvHNXpv3S8ZiHiWRWf0Q/Dq8y5xNAugzOlkT33y7FBL0HgDGwSVhGZTZt9rrFshE9kYxDhB2i7YLnINWHq4b54su30ejMpQEK74+t1nFMYzcKXRF31/rEvfAVCqruz6xdlrQPjp/NthJsZlPbHjdQGdQj0UBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785537949; c=relaxed/simple;
	bh=8MqKE90312rkZEy79TEG47BopWTevb72CjPiX1CsH7w=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tpTngV7gCyAPfW/wkY/kEI7+EA8kZhy+YXeCec7dmFcdeZ+vx11ks7SMCNCLdN/d2MBrwNnzWrxQ9oljMbRtJIifBC5xm0P/Xtd5lLMZnYJF32RDTjcqIN2QVoDqkLC8deTOqwoKlWTJymcd/daFsU8bzFcNSjLCmaFhp3+b8+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kP9AzjA3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kP9AzjA3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69B2B1F00AC4;
	Fri, 31 Jul 2026 22:45:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785537947;
	bh=5mLN8Ph7Fo4T47IC1nmPORitJ70CpgegrwLdRq6g0vI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kP9AzjA3jVLcyAnbY1mU/KtNTQeLmQOxpwXRC+okElcv2igizKs9tSvjucDaE8Rs1
	 yRm3qRnLnvJk9Bjw3RzkBpjEipHDeJBE791/nVVQ+6cN8vD+bG8v6wNrdt+XkLuKVs
	 n5OGbdDGodoBpDAK9EsoTJ7r7rexj0sQhyYHhxU00f2PPUOxifPtFZ0yumDSQf0LX/
	 7vy5jGoMhx2jJ4OVDZaQUSqlyKUFuP0V9dwo2GUgCxjC7wM6Bhlsd804Vnwc27XC8w
	 t3EZ2daZNgDqOykPCYIzrM1kr/v+RL05R43YSMBGUNkRK0bfLPOCVUX5Wj/0MJw/Np
	 i6TUcg1sYwrdg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 5/9] mshv: Import data structs around device passthru
 from hyperv headers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mukesh R" <mrathor@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260731223427.2554388-6-mrathor@linux.microsoft.com>
References: <20260731223427.2554388-1-mrathor@linux.microsoft.com>
 <20260731223427.2554388-6-mrathor@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 31 Jul 2026 22:45:46 +0000
Message-Id: <20260731224547.69B2B1F00AC4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] The fields in `union hv_device_domain_id` are ordered incorrectly,=
 resulting in a flawed bitfield layout that contradicts the domain ID const=
ants.
- [High] `struct hv_input_create_device_domain` is exactly 28 bytes in size=
, violating the MS C implicit padding expectations for 8-byte aligned struc=
tures.
--

--- Patch [5]: [PATCH v5 5/9] mshv: Import data structs around device passt=
hru from hyperv headers ---
commit 9932d93213b193c633772c7ddbee866c39282647
Author: Mukesh R <mrathor@linux.microsoft.com>

mshv: Import data structs around device passthru from hyperv headers

Copy/import from Hyper-V public headers, definitions and declarations that
are related to creating domains in the hypervisor, attaching devices to
them, etc.

> diff --git a/include/hyperv/hvhdk_mini.h b/include/hyperv/hvhdk_mini.h
> index b4cb2fa26e9bc..90497635c3cbd 100644
> --- a/include/hyperv/hvhdk_mini.h
> +++ b/include/hyperv/hvhdk_mini.h
[ ... ]
> +/* ID for stage 2 default domain and NULL domain */
> +#define HV_DEVICE_DOMAIN_ID_S2_DEFAULT 0
> +#define HV_DEVICE_DOMAIN_ID_S2_NULL    0xFFFFFFFFULL
> +
> +union hv_device_domain_id {
> +	u64 as_uint64;
> +	struct {
> +		u32 type : 4;
> +		u32 reserved : 28;
> +		u32 id;
> +	};
> +} __packed;

[Severity: High]
Are the fields in this struct ordered correctly for the ABI?

In little-endian C bitfields, the first member occupies the lowest bits. By
placing type and reserved before id, they will occupy the lower 32 bits
while id occupies the upper 32 bits.

This seems to contradict the constant HV_DEVICE_DOMAIN_ID_S2_NULL defined j=
ust
above this union, which expects the id (0xFFFFFFFF) in the lower 32 bits and
type (0) in the upper 32 bits.

Will this cause the hypervisor to receive swapped values and fail domain
attachment?

[ ... ]
> +struct hv_input_create_device_domain {	/* HV_INPUT_CREATE_DEVICE_DOMAIN =
*/
> +	struct hv_input_device_domain device_domain;
> +	union hv_create_device_domain_flags create_device_domain_flags;
> +} __packed;

[Severity: High]
Does this struct need explicit padding at the end to match the hypervisor's
32-byte size expectation?

Because of the __packed attribute, the compiler won't add the 4-byte implic=
it
trailing padding required to bring the struct to its natural 32-byte size
(due to the 8-byte alignment of device_domain).

If standard hypercall initialization clears the input using:
memset(in, 0, sizeof(*in));

the sizeof will be 28, leaving the last 4 bytes of the 32-byte block
uninitialized on the shared hypercall page.=20

If the hypervisor validates these padding bytes to be zero, could this fail
with HV_STATUS_INVALID_PARAMETER if there is leftover garbage from a
previous hypercall?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260731223427.2554=
388-1-mrathor@linux.microsoft.com?part=3D5

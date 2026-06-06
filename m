Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83DB54071C4;
	Sat,  6 Jun 2026 01:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780709271; cv=none; b=u+4H/5thOqZO1jY6SWs/oF2a5KZN9rLdYu+slRGS8cLW8n0vHU610UDfSkgvZINf9aBl80mJ8q+cKqhhsDwWse0SSZRwG2SOkHerbUSSzzmbKqSXsjUtNs3ZAZ6Y/xCZp52Y/ZTdT2dXdCNLQfMSm2Fp6btinw7uMgksqVyx8Ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780709271; c=relaxed/simple;
	bh=1OJtF7vY9H8KdCtv0DLdAod04oMqb1yTg4e1NStshKA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SdcsOCBsp6p6dQd2shY4Ngr9mpwuF6aVvG3wi5Fa7op8xdN/c2DvmT4nKSpYPqDFOBx34yzj67+9dZ3XpOif+JvX782MhPQhbJ63y14agipr3S6PCOUw6KMkVOFxBH9Dl5owK6pQj6hPfXrP/WaozIuH2AdyYB5WgdeBIdfoIdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WozLIiq0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WozLIiq0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FEA51F00893;
	Sat,  6 Jun 2026 01:27:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780709270;
	bh=jXywdkzqZJYiigfuu3nQzbSjqzHWAoQ1g0NVJCMwSZI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=WozLIiq0kZcEHuHGfIXwaSSSF/vTYHL7CJz0GCOvQ+Rt34qwjo7qySAzCtrd3C95w
	 x08DDn2plKEEseJkl6qSGjy54FbHqYk8wAHdAR0OPPy5RVjfy8zIuElXznL6+owGr3
	 nL/wo+xqscL0m1VM8HNOM7GQm+kEHH+M7NAvyUNTrIttxUVm0SjfQ/uRjprQHnhkGz
	 FJeyPzY4YkqyPfNbwAnM79tgVf3n0prC1AwwHCorwO/hlzNG8l8ugO802FWs9bynNb
	 C8lJwxyqLKNi2iwALi4MVcDVtQD1igaNBlf46ofsSNFGFf0o9FCqT+VWKObVf2j9VS
	 PgJtDaH5Gph+g==
Date: Fri, 5 Jun 2026 18:27:48 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Aditya Garg <gargaditya@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, longli@microsoft.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 horms@kernel.org, shradhagupta@linux.microsoft.com,
 dipayanroy@linux.microsoft.com, ernis@linux.microsoft.com, kees@kernel.org,
 shacharr@microsoft.com, stephen@networkplumber.org,
 gargaditya@microsoft.com, ssengar@linux.microsoft.com,
 linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 0/2] net: mana: fix error-path issues in queue setup
Message-ID: <20260605182748.5f106575@kernel.org>
In-Reply-To: <20260604080137.1995269-1-gargaditya@linux.microsoft.com>
References: <20260604080137.1995269-1-gargaditya@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  4 Jun 2026 01:01:24 -0700 Aditya Garg wrote:
> Two error-path fixes in MANA queue setup, both surfaced during Sashiko
> AI review of a recently upstreamed patch series.
> 
> Patch 1 initializes queue->id to INVALID_QUEUE_ID in
> mana_gd_create_mana_wq_cq() so that a CQ creation failure before the
> firmware id is assigned does not NULL gc->cq_table[0] and silently
> break whichever real CQ owns that slot. This mirrors the existing
> pattern in mana_gd_create_eq().
> 
> Patch 2 guards mana_destroy_txq()'s call to mana_destroy_wq_obj() with
> an INVALID_MANA_HANDLE check, mirroring mana_destroy_rxq(). Without
> it, TX setup failures lead to a firmware-rejected destroy of (u64)-1
> and a spurious error in dmesg.

Looks like these patches were generated against net-next, please rebase:

Applying: net: mana: initialize gdma queue id to INVALID_QUEUE_ID
Applying: net: mana: guard TX wq object destroy with INVALID_MANA_HANDLE check
error: patch failed: drivers/net/ethernet/microsoft/mana/mana_en.c:2351
error: drivers/net/ethernet/microsoft/mana/mana_en.c: patch does not apply
Patch failed at 0002 net: mana: guard TX wq object destroy with INVALID_MANA_HANDLE check

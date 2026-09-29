Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 141C637F332;
	Tue, 29 Sep 2026 04:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790654990; cv=none; b=WdTJrWz0Vdt2cnpUkWgk1BV9EQTEx1iWC1WlS8QZ2rulAkfThwyD6wxqkzfp8aI1gCXUuLMAMcWQapABlV+NXDuCn/oHA7cvDQHzVavz5cNioHby0feajfvDhhvh/fChgB9u0Ld4VDutbeigq8sI9jTavF5kiNMsLBMN9uMmEKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790654990; c=relaxed/simple;
	bh=sTEXWIP0JqatNcr3Gg+sP/hy7YRaxI9FVuZx7VHnTYI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WjdxjtoDoCZif6pRn6PIP8XihvbBsHQ9zoUQlcxqCRjSdThDRcqMqS66RzrmrOh2BIZMh13+sGQ/dWwoB6L/DvXDNsrF0zeG9vjjqsCVc1W5yHfILCCIbr6gZrbfzqD24VRenTvYJVvzOy2dx0b+LBjf29HPUoE8pvnOmzbLTys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N98NEhYs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N98NEhYs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CCEA1F000FF;
	Tue, 29 Sep 2026 04:09:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790654988;
	bh=sTEXWIP0JqatNcr3Gg+sP/hy7YRaxI9FVuZx7VHnTYI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=N98NEhYs4KXCtoV3cymaQ23f6M48l8SC382ZIt/5DFMCUw39SX1gUGgizNwDZPc3K
	 vt5vpc+xPS6468z2soZKt6nrqmMRWRnb2p7S1WWSptIdavWbQT3Y9aJHGZ/O2/T9vd
	 WgkorNUVlAp/qsZLjbG08SxPnc49QpO7tssuFx/ngaA4dFiu9Q9WC8gCXZBrklqBZT
	 WwAsZKssY3ohtZgQmrTK7GFGD0wBuA/YNmrLN+8EOXL6cmh9vmcNvHhcYJFDCoEqS/
	 F9hhS77/bRJ6qiNYBo5rZQdhCn+NlothS8pyVQKMigNd6LRQy06+oHrtr0gwrnI/2I
	 cZbF9Gc0vqZrg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/6] percpu: Page-align decrypted data in UP kernels
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zack Rusin" <zack.rusin@broadcom.com>
Cc: "Eugenio Perez" <eperezma@redhat.com>, linux-hyperv@vger.kernel.org, virtualization@lists.linux.dev, "Michael
 S. Tsirkin" <mst@redhat.com>, kvm@vger.kernel.org
In-Reply-To: <20260929040256.543767-2-zack.rusin@broadcom.com>
References: <20260929040256.543767-1-zack.rusin@broadcom.com>
 <20260929040256.543767-2-zack.rusin@broadcom.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Sep 2026 04:09:47 +0000
Message-Id: <20260929040948.3CCEA1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

> Without SMP, DEFINE_PER_CPU_DECRYPTED() places variables in
> .data..decrypted. Align both ends of that section so that changing a
> variable's encryption attribute cannot expose unrelated kernel data.
> Keep the section in permanent data, where UP variables are instantiated.
>=20
> Fixes: 000f8870a47b ("vmlinux.lds.h: Fix placement of '.data..decrypted' =
section")
> Signed-off-by: Zack Rusin <zack.rusin@broadcom.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260929040256.5437=
67-1-zack.rusin@broadcom.com?part=3D1


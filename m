Received: from mail-01.1984.is (mail-01.1984.is [185.112.145.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED75A3BB668;
	Tue, 19 May 2026 20:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.112.145.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779222201; cv=none; b=jM0Ayb9Ro2UOIrTH9s0D9AHmmTrLLuBhIq2s9Z0vVScHCwshL9LarL10D+Xagt5q5oJ2BNZKsGqxo5SpgIXQR8m4CgXifiE+FjLc//iH0/PKhmdpZJHolmYJTJdYfapzj1wasCzfxzbhCgMtWl+1u5KY2wbDu5maLXy7xqvz7kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779222201; c=relaxed/simple;
	bh=Y3frdyRKW/oF1IZwlAZSK80c2HfcR5nkOP1fkxlziMs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ajfSvER94b0+vsy2vcT2QiL4cao6SU+yOM0cgBBM5WZvFn/AKwKoCRFWOyRjSMk5RO0pCk4n9z01EgHLXNuvYlA2mBzXwxoZvAdeaCda1aFr8ptZsNGkJBmDrmcq2tX4tN9rhZZBoriGsPSbR7DdRJGpvW4tDOX2Ggw5i6aGGek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=berkoc.com; spf=pass smtp.mailfrom=berkoc.com; dkim=pass (2048-bit key) header.d=berkoc.com header.i=@berkoc.com header.b=OT0e1kZE; dkim=pass (2048-bit key) header.d=berkoc.com header.i=@berkoc.com header.b=Rvj5pUE6; arc=none smtp.client-ip=185.112.145.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=berkoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=berkoc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=berkoc.com header.i=@berkoc.com header.b="OT0e1kZE";
	dkim=pass (2048-bit key) header.d=berkoc.com header.i=@berkoc.com header.b="Rvj5pUE6"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=berkoc.com;
	s=1984; h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=Y3frdyRKW/oF1IZwlAZSK80c2HfcR5nkOP1fkxlziMs=; b=OT0e1kZEf/G0gsee1vE6CaU3OW
	QQUEMFWLNqFY3n/9emT1ZTy30Gj3nyTS/yuKEtjLlEvH+cMNRgbApGckp9hjPCLszf9M8lruTRNeW
	0DO8ECcpQHs/vtpwZY9hUFIOBX1heowYhoTZLA/DE7RbKQ8ieG1qo6lFuKbVBGSA6It8svCiX8KjL
	8i7OBZlmDtAfwP2nFVWZpN8dSOsGHBVJwav/4Za8zBHtfZYDB5EVTkMh/u7/4XcOWqnrolXyIdsWa
	1KsmUUdL0kQk16c1mpikE5hjKNzuibWYrpfXYJWGAzXv4kBKx+0Yln7wQw8XDtVLCAXVgXaSa96L+
	lLtOBdUg==;
Received: from localhost
	by mail-01.1984.is with utf8esmtp (Exim 4.96)
	(envelope-from <me@berkoc.com>)
	id 1wPQxk-006C1k-3B;
	Tue, 19 May 2026 20:22:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=berkoc.com;
 i=@berkoc.com; q=dns/txt; s=me; t=1779222160; h=message-id : date :
 subject : cc : to : from : sender : reply-to;
 bh=Y3frdyRKW/oF1IZwlAZSK80c2HfcR5nkOP1fkxlziMs=;
 b=Rvj5pUE6tHPJ3n0nyeD0Fp3ujd5kmVRngnjzkaEezd0bQPFlbutxxGuCrsf3ekWep6fO9
 K1cOYwFHraDH6dUpUY5+rCTetFVSwhtG87knG2I2XrIqNt+RRJJ5VOrvC4QnGckST2uc0FC
 KdZceiq8DBmhZKpbGuZmQCX+DdmmSNjJ3UMI+ifdRk+x/aq6m/6c8qyYvT3oN7hYXvG24X3
 r/gX89jObgGr9YQ2XejSQtn0JylfvwUpsqsv2YyG8SATxthKlVcL+wNEtTZ2w2l+7Ra8XTc
 D6n618ojpAlWKRVnCIkbOlNOim2Kde5iY9rCVYrxajng6ignKqsrkeTqq3ww==
From: Berkant Koc <me@berkoc.com>
To: Michael Kelley <mhklinux@outlook.com>
Cc: Saurabh Sengar <ssengar@linux.microsoft.com>,
    Dexuan Cui <decui@microsoft.com>,
    Long Li <longli@microsoft.com>,
    K. Y. Srinivasan <kys@microsoft.com>,
    Haiyang Zhang <haiyangz@microsoft.com>,
    Wei Liu <wei.liu@kernel.org>,
    Thomas Zimmermann <tzimmermann@suse.de>,
    Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
    Maxime Ripard <mripard@kernel.org>,
    Deepak Rawat <drawat.floss@gmail.com>,
    linux-hyperv@vger.kernel.org,
    dri-devel@lists.freedesktop.org,
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] drm/hyperv: validate resolution_count and harden VSP request paths
Date: Tue, 19 May 2026 22:20:28 +0200
Message-ID: <v3-reply-03-reply1.1779222028@berkoc.com>
In-Reply-To: <SN6PR02MB4157D595B990A321BFA85B40D4002@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20260517-drm-hyperv-cover@berkoc.com>
    <20260517-drm-hyperv-cover-v2@berkoc.com>
    <20260517-drm-hyperv-patch1-v2@berkoc.com>
    <SN6PR02MB4157D595B990A321BFA85B40D4002@SN6PR02MB4157.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Spam-Score: -0.2 (/)
X-Authenticated-User: me@berkoc.com
X-Sender-Address: me@berkoc.com

Hello Michael,

Thanks for the CoCo context, that lines up with what is in
vmbus_devs[] for the framebuffer device. The piecemeal approach is
what I am aiming for here.

v3 is on the list and addresses your three concrete points:

> This change should probably be a separate patch, as it's not really
> related to the bounds checking issue.
> [...]
> All that notwithstanding, I don't think your fix is needed in its
> current form.

Dropped from v3. You are right that the negotiate-version and
update-vram-location timeouts let hyperv_vmbus_probe() bail out and
free the device, so the stale-completion path is only reachable from
hyperv_vmbus_resume() after a get_supported_resolution() timeout.
That is a narrower fix and belongs in a separate patch against the
resume path, which I will send afterwards.

> Is there a separate problem here in that preferred_width and
> preferred_height are not set in the pre-WIN10 case?

Yes, separate problem, and I missed it in v2. The pre-WIN10 branch
in hyperv_connect_vsp() sets only screen_*_max and leaves preferred_*
at zero, which is inconsistent with the WIN10-failure path.

> Also, having to duplicate the fallback code is distasteful. Instead
> of having an "else" clause, maybe have a follow-up test for
> screen_width_max [...] being zero as an indicator [...]

Adopted in v3. The else branch is gone; the WIN10 path runs the probe
and the post-probe block applies the WIN8 defaults whenever
screen_width_max is still zero. One source of truth, both paths
converge on it.

> In my view, your commit message is a bit too detailed.

Rewritten in v3. The bounds check and the WIN8 fallback are now one
short paragraph each, focused on the "why".

Series: <cover.1779221339.git.me@berkoc.com>

The v3 patches carry an `Assisted-by: Claude:claude-opus-4-7
berkoc-pipeline` trailer per the kernel coding-assistants policy.
Code, analysis and review responses are mine; the model is used as
a structured reviewer under human verification.

Thanks,
Berkant

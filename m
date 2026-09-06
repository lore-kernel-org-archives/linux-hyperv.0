Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29A3531F9A5
	for <linux-hyperv@vger.kernel.org>; Sun,  6 Sep 2026 02:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788662334; cv=none; b=RIXEzsMVuZ1lSvucx6MN6tK9dYQ+kInzCKYIcHpSPQj8FZUFmGnGL5KxS6ULezydQn+7iOMWfwdPG2fl6dVAziE50UDKiE3RyaX+r5kg5VvcM2ueNAbNOT/2jtB+mRoYOj2vihC6BmHW6v/4N8gokF4iUHLMkWZqivMKlDMkhIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788662334; c=relaxed/simple;
	bh=FOlWqN3bgJ7AA9356C26/0VGmT9ZqEwgjvqjkxlQFtE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ez645d6B6iRpeMQcZbYQE+SpQbLKMbZ1Ewu0/zR/m+IWfucIQAGvxnJOuvU7o6pCyQChxh/aoJt9nN2bXMRr84U/Xq8tnx1kVd1gstM1xe9p5xmYgTzuDqFb39bQO/J16H6O59QJcPPK6IyIKKQCuZwPax6932U50kI/yFKRyxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WaLXD28b; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WaLXD28b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC7981F00A3A;
	Sun,  6 Sep 2026 02:38:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788662331;
	bh=2vgvv69jiWDE1Ekf7NTlaWfsPzVHy3T8jiF45CDgxIo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WaLXD28b1TFbfPp/nkmlVsRiZ+WerLltDgVnvk2IenYGooO4CnX9gGwtkoQhwZnvh
	 gxQHnjPbUQYZmN7zGt9m6dxmJ5yqOykJgQoW493i1z3YpPoLPfZC1MnYMNE3GGLXf8
	 MrQQ8F6fxUsOZjq1cW6jCSm8tQ1gsMRZpxNm2FEd69yY5V+KVyNDhLLJd9k0S3ztAL
	 0P1ZWBgEUk5kHhJhPGhp5t5LX+pXMBMh7R+g4v2oX/8ypWGhIMamrRjCP7UJkpnkCN
	 3F9zTCJP70c42Phwz9PsLFHyxkb0mX3eJWDG8EWu0uRdaYt/zjZrLCtYS4/CMrnHIO
	 SjObkDAGWz4Bg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v2] net: mana: fix reset work race with device
 removal
Reply-To: sashiko-reviews@lists.linux.dev
To: "Fan Wu" <fanwu01@zju.edu.cn>
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <20260905023602.425827-1-fanwu01@zju.edu.cn>
References: <20260905023602.425827-1-fanwu01@zju.edu.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 06 Sep 2026 02:38:51 +0000
Message-Id: <20260906023851.AC7981F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Module text unmap race condition on worker thread exit due to unsa=
fe module_put(THIS_MODULE).
--

commit 690e7316a6c3698f99d06b66663e08bbcdb43123
Author: Fan Wu <fanwu01@zju.edu.cn>

net: mana: fix reset work race with device removal

This commit embeds the reset service work in the gdma_context and implements
admission gates using GC_REMOVING. This correctly synchronizes the service
work with device removal and probe unwinding to prevent use-after-free races
on the gdma_context.

Cc: stable@vger.kernel.org

> diff --git a/drivers/net/ethernet/microsoft/mana/gdma_main.c b/drivers/ne=
t/ethernet/microsoft/mana/gdma_main.c
> --- a/drivers/net/ethernet/microsoft/mana/gdma_main.c
> +++ b/drivers/net/ethernet/microsoft/mana/gdma_main.c
> @@ -796,48 +841,49 @@ static void mana_recovery_delayed_func(struct work_=
struct *w)
[ ... ]
>  static void mana_serv_func(struct work_struct *w)
>  {
[ ... ]
> +	/* The rescan exits of mana_do_service() remove the device, which
> +	 * frees gc before returning.  Only touch the pdev and the module
> +	 * reference from here on; both are held until this point drops them.
> +	 */
>  	pci_dev_put(pdev);
> -	kfree(mns_wk);
>  	module_put(THIS_MODULE);

[Severity: High]
This isn't a bug introduced by this patch, but is it safe to call
module_put(THIS_MODULE) directly at the end of a work item executing
inside the module's text segment?

If a user unloads the module concurrently with mana_serv_func() executing,
the module unload process (rmmod) will wait until the refcount reaches 0.
When this worker thread executes module_put(THIS_MODULE), the refcount
drops to 0.

If the worker thread is preempted right after this call and before returning
to the workqueue core, the module unload can complete and free the module
text memory.

When the worker thread resumes and attempts to return, it will fetch
instructions from unmapped memory, resulting in a use-after-free panic.

>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260905023602.4258=
27-1-fanwu01@zju.edu.cn?part=3D1

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DF4E314B73;
	Thu,  1 Oct 2026 01:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790818894; cv=none; b=ZciuRWWiWZCDFgl6ZHe68nILLV2BTEkZasBjDeb03qPi4wJlavMA5jyv9UM5Ay83nChWk7VrErFMjD2k9T4gBf8SK+TRQJLm6LwUouQwKUOmzZdBPZ/9/w4ysBQW/ITn4hwWdymC9FXq4b6AFGbWLuK2GaxoZgu7QYjTQysSJUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790818894; c=relaxed/simple;
	bh=AMu5aylNXr2vffBZHRwSA5Tq0PF0yPy+hna7yQ5D0/Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HK8XbVid5XyJbjHU5EAczJZaIa6wNOTrAxmf/EBr3O7e2XHgTcSsNBX8tocIF8V/zK3s7WK3xZuwOWDmedKkrIWYWlI/3ocap9oPgztGpLKqoVqF+/uZtP7Wmf8ThJ96D3Y6/LLMhIREFDr1Scd+1uCpGJe1MJSBk8xDy+SncOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JZm91a0c; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JZm91a0c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B67FE1F000FF;
	Thu,  1 Oct 2026 01:41:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790818893;
	bh=ipbRv8s/02qmR1TzPlsaXI2CUDRopggPwiBGwcHPXfw=;
	h=From:To:Cc:Subject:Date;
	b=JZm91a0cVP/VNmg6s9Vow8wv8g0O7Hl3byEQkNd+AIMnI93+dbEisiA0caUqSQQnb
	 zdznyNrbdMc9zcx3dOwIxpzkCKkSV8q8QUuCX9Rw1bjJk1Gk30ydOM/MI3LlEqPTF2
	 zvm6bleRDWFlmPNEbqUzvKs57nhbOVYGrk8lrSVEVci75m4Ut1qii6qB5xyvhrYMJe
	 BbA0Erc6KaEvzCVU9oZZ6vaIozT+Pdss6yf8nbrrWArVsiMlVvDqq8zcEABR1ZjYJH
	 XOBo1b7xL0mhCCbsXJk+hdQVqj+NLbwVsBRu6RE8MmN925CuhtvRXHSMOi8n0d7nuY
	 ua9bxaoAtw/Gg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	longli@microsoft.com,
	linux-hyperv@vger.kernel.org,
	hawk@kernel.org,
	andriin@fb.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 0/5] hv_netvsc: make XDP propagation act more like bonding
Date: Wed, 30 Sep 2026 18:41:26 -0700
Message-ID: <20261001014131.310771-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently XDP programs propagated from uppers are invisible
to safety checks. I'm trying to fix that, but AI reviewer
threw up a bunch of complaints about hv_netvsc. See previous
series here:

https://lore.kernel.org/20260928223648.2739371-1-kuba@kernel.org

That series is now on hold, let's try to sanitize the hv_netvsc
behavior. AFAIU the main use case is to catch the VF as it appears,
and attach it to the netvsc SW interface. If we catch the VF
as soon as it appears we shouldn't have to worry about the VF
already having XDP attached. Let's do what bonding does and
refuse to attach if VF already has XDP, also refuse to attach
if nv_netvsc has XDP but the VF refuses the propagation.

All patches are from LLM reviews and LLM generated. I do not
have access to Hyper-V. I did 6 cycles of reviews and back
and forth with the LLM over these, so I think they should
be okay-ish. Let's be clear tho, that I do not care one bit
about this driver and it's brokenness is blocking core work.

Jakub Kicinski (5):
  hv_netvsc: fix the program refcount when the VF refuses XDP
  hv_netvsc: hold the VF's instance lock when installing XDP on it
  hv_netvsc: treat the VF's XDP program the way bonding treats a slave's
  hv_netvsc: move a new VF to netvsc's netns from a work item
  hv_netvsc: let the core take XDP off a netvsc device that is going
    away

 drivers/net/hyperv/hyperv_net.h |  3 +
 drivers/net/hyperv/netvsc_bpf.c | 27 ++++++++-
 drivers/net/hyperv/netvsc_drv.c | 98 +++++++++++++++++++++++++--------
 3 files changed, 103 insertions(+), 25 deletions(-)

-- 
2.55.0


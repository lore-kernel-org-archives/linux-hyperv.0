Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D7BB2797B5;
	Tue, 17 Feb 2026 21:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771364774; cv=none; b=Zp7YEzXIbVhqp3V6b93xO6xXD30t7YO/+1yAZ8qYVsfB4uZpIBUJGHJVI2Wev0DYodpr5j11S5sT2QOThwQ7+xxxLQ1fb0o2Ax0ze+JpN9Ln9oA46lS1qqTRDX4eVEBQu/Y8CVxs/RnwABSnUitwDEEdq0c0zSzaEYC69wJKscc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771364774; c=relaxed/simple;
	bh=6CLuKS02vxtfsIgKG+naWusfHTGgQQP5ho9Y7sEgdBE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZyBxBKJ099DagpnzkR+O7AieOYhqF4Ed4Rqp0OFl+YqYJfwEi4GbsQQlWxPLvLNghGoMhL2O/BHQMbXXz3D1QoUqSI+B3e1SOsVSJWXGZCo/SFE31Qi2/er4x/izpSfcX8ssAb2R+W9TGiZdpSFr/bLog1KcxXTQn47/IaYlvTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NM2L0K0e; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NM2L0K0e"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E33EBC4CEF7;
	Tue, 17 Feb 2026 21:46:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771364774;
	bh=6CLuKS02vxtfsIgKG+naWusfHTGgQQP5ho9Y7sEgdBE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NM2L0K0ezt9SLP/8l3fw3BuzW6wB0MPGfRmJWQBbYi9xMvSECKRrANm0oo5QWloep
	 Ac5s1jVVU7wv0Aec2SeSPcfwoQFD/sMyQ20eDxqM8QIzVi55GILsVcnGCSggKN2GKK
	 fKuG4BaRXvpZ4EgbnXgTD6ULHlyWWhWyjV7OClJ/oEofSw3p9AqhE885XnnSHeviBN
	 dFsQWo2U/p5cYzmaJCm5qQm/IPee9Vrr+FcI0pEupDmiZUP5jOmEocbj+SUNtw3bUM
	 aJ83wwXd4RyONDystnOFzKq/MF4mUN7Xk39XYskMOEiBarmm1eyp3xozd6r9QM84qQ
	 gLyGj3PIDxfEg==
Date: Tue, 17 Feb 2026 13:46:12 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Bobby Eshleman <bobbyeshleman@gmail.com>, Paolo Abeni
 <pabeni@redhat.com>, Daan De Meyer <daan.j.demeyer@gmail.com>, "Michael S.
 Tsirkin" <mst@redhat.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>, Stefan
 Hajnoczi <stefanha@redhat.com>, Jason Wang <jasowang@redhat.com>, Eugenio
 =?UTF-8?B?UMOpcmV6?= <eperezma@redhat.com>, Xuan Zhuo
 <xuanzhuo@linux.alibaba.com>, "K. Y. Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>, Bryan Tan <bryan-bt.tan@broadcom.com>,
 Vishnu Dasa <vishnu.dasa@broadcom.com>, Broadcom internal kernel review
 list <bcm-kernel-feedback-list@broadcom.com>, Shuah Khan
 <shuah@kernel.org>, Long Li <longli@microsoft.com>, Jonathan Corbet
 <corbet@lwn.net>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux.dev, netdev@vger.kernel.org,
 kvm@vger.kernel.org, linux-hyperv@vger.kernel.org,
 linux-kselftest@vger.kernel.org, berrange@redhat.com, Sargun Dhillon
 <sargun@sargun.me>, linux-doc@vger.kernel.org, Bobby Eshleman
 <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v16 01/12] vsock: add netns to vsock core
Message-ID: <20260217134612.69cfd902@kernel.org>
In-Reply-To: <aZNNBc390y6V09qO@sgarzare-redhat>
References: <20260121-vsock-vmtest-v16-0-2859a7512097@meta.com>
	<20260121-vsock-vmtest-v16-1-2859a7512097@meta.com>
	<aZNNBc390y6V09qO@sgarzare-redhat>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 17 Feb 2026 16:08:33 +0100 Stefano Garzarella wrote:
> If we go for 1, maybe we can do it in 7.0, or not?

Just my preference but changing the behavior ASAP in 7.0 seems better,
but the code must be ready very soon for that to happen.

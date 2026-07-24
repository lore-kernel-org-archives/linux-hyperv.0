Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30C5C37C106;
	Fri, 24 Jul 2026 23:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784934527; cv=none; b=OV4N3FUQR3uM6HCAvxLYDEUke27GpW6e0MmTjS29PF0lFBJeto/ThQyn73qfFL2gHwDvDDh9ZZwfyhi6/xXmNlbBmnyeAHYVyOxwhZcOdzHamGFdlMM4ME+Qp3kLvSUc79n/MWdy87AJPR7ugw1yXUHKMp+TxDLpOXkmuBv+mbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784934527; c=relaxed/simple;
	bh=TnWvimcTlhYF7SSYM1xqPNZuiAubEYLeYk8nISJIKCE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tMjPgH2ueJmMoSjkn19/an8OSyeVuoZi4V9FO8rZKjJaeFL15hbzP35w+HmiNlWzaXQ4mZYY5LWo2qwjVgi693cxkUBfwe3sBUHMBU1wEGCjE1ynewr3p51wvI8actqmN2Yqaoxw0Tvx676UMDat9abpNTumYkvJgjz3pC+s8z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GmIioJ9+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GmIioJ9+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1F7A1F000E9;
	Fri, 24 Jul 2026 23:08:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784934525;
	bh=I1HMmgzF8qcQPAmOTAXHEHOtC3Y3UHiRKcK48Rnrgts=;
	h=From:To:Cc:Subject:Date;
	b=GmIioJ9+i0ijT0320OEcjTOTWhVY419aKtFrcDVlzpDJKOBgO/5IXT/J/nw55BBoO
	 mIOzxs4UkcM3DquaUKIdZ5vW8+kLH4QPGsAtZhvSa/jI9Tqke6t+lGDJ0vg+I13Na6
	 sGQ7MtWogIp8kOetmNTWgNMBv4IVND6NFl1+LSgG0Rfk3NAdXQ80UaZu+QrkCeffRl
	 HO5bPgWnrcNI3CAvyjYbHFa9YaPiVDfsBjlOrUjcEiALYf1RWT5u0U9jcXZl36Gx+m
	 pCFeRk5kPsv4WOzuU4CO9he4vI6n8jFsJ9pHO1tyEjxBwM4EHuGEjpjwmhCv+yeKYW
	 cz3iKfCmx4yQw==
From: wei.liu@kernel.org
To: Linux on Hyper-V List <linux-hyperv@vger.kernel.org>,
	linux-pci@vger.kernel.org
Cc: Wei Liu <wei.liu@kernel.org>
Subject: [PATCH RFC 0/2] Support Hyper-V vPCI controller reset method
Date: Fri, 24 Jul 2026 16:08:41 -0700
Message-ID: <20260724230844.3259741-1-wei.liu@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wei Liu <wei.liu@kernel.org>

Hi,

On Azure, there are devices that don't support function level or PM
reset. They can only be reset by sending a VMBus message to the host.

This series is RFC because I modelled the reset method at the controller
level. If there is a better way to do it, I'm happy to change the code.

Thanks,
Wei

Wei Liu (2):
  PCI: Add controller reset method
  PCI: hv: Add vPCI device reset support

 Documentation/virt/hyperv/vpci.rst  |  2 +-
 drivers/pci/controller/pci-hyperv.c | 61 +++++++++++++++++++++++++++++
 drivers/pci/pci.c                   | 22 +++++++++++
 include/linux/pci.h                 |  3 +-
 4 files changed, 86 insertions(+), 2 deletions(-)

-- 
2.53.0


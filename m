Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F91D2B9A4;
	Wed, 12 Aug 2026 00:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786493126; cv=none; b=fgeBeE3yFREooEFsHZ870Wj/88sH5KCZjmk9/iAd698fkkggBA54Igb5CFmdwib84ngYom4jKCmQ0rHcKzc6ZSh+tysuwOoR8jAg1fm0QskfhaWtKxUgwNpELgAUuNbSgaBe4GpSNw8ApczBonXzd1mkIhE+fYqhuorpacqwpNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786493126; c=relaxed/simple;
	bh=rBkbmgi9E3ayZOc7nYxdag0G4/dpNlti1AsHza3v5fI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fj+sdCWhau5me7UzvFBNti8F0I73wLKGKc89RqX2NScpXvbH6kZH4kT+fhSWPsinELTQ04Kg9NBj7XBeaOAq3qngAkbJf2rIWtUs80wML41G1tLJYwm5uIZWPF0WlT8OTVe11iZwqeaoD+dqjuIIKV5i+9q7qK8PRK1Af2av9YI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=fi1pKKNc; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="fi1pKKNc"
Received: from mrdev.corp.microsoft.com (unknown [40.86.181.13])
	by linux.microsoft.com (Postfix) with ESMTPSA id 797A920B7167;
	Tue, 11 Aug 2026 17:04:54 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 797A920B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1786493094;
	bh=Kv+hTc7n1hM0xr5bigY3x9dhVMJc7O5HK4RPWz0Zs2E=;
	h=From:To:Cc:Subject:Date:From;
	b=fi1pKKNcGgT2KItjHpu0qv4JNkluTixhIt9oI2qCLzejOGhWbzCFaIFFKGiVPhUdX
	 dUykekqRqTVCKsXxvTsu7oiGhD/zaE3hRVoZdJHQnlEib3d4tvzOjnqXlcKKXspzIJ
	 j5CX4r7emTxwngWDMD3RmmqF+QKgvK9fvzd/Brss=
From: Mukesh R <mrathor@linux.microsoft.com>
To: linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: kys@microsoft.com,
	wei.liu@kernel.org,
	mhkelley58@gmail.com,
	mrathor@linux.microsoft.com
Subject: [PATCH V0 0/2] Redesign memory deposit logic
Date: Tue, 11 Aug 2026 17:05:05 -0700
Message-ID: <20260812000507.3809046-1-mrathor@linux.microsoft.com>
X-Mailer: git-send-email 2.51.2.vfs.0.1
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This small series redesigns the memory design logic when Linux runs on
Hyper-V hypervisor as a privileged VM. It has many issues currently. It 
is split in two patches, the first patch stubs out the functions which 
makes the 2nd patch review much easier and nicer.

Thanks,
-Mukesh


Mukesh R (2):
  mshv: Stub out deposit memory functions
  mshv: Redesign hypervisor memory deposit logic

 drivers/hv/hv_proc.c           | 240 ++++++++++++++++++++-------------
 drivers/hv/mshv_root_hv_call.c |  10 +-
 include/asm-generic/mshyperv.h |   5 -
 3 files changed, 144 insertions(+), 111 deletions(-)

-- 
2.51.2.vfs.0.1


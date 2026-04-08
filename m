Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34B2336D50D;
	Wed,  8 Apr 2026 08:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775635948; cv=none; b=kbp52AhR5xIbqb3M8C369dzOeah29ElGQMqqTKdyMBgYlNQzvGrrmO/2EvvPV1THIdbyai6+Jo6gW7EYEwCritXeu2zwP4KN7UhLPwlAG8qBb33CrEy21FhBJdevYB+Msg98j/Nc9A0XUgWUA8c+JvvB0eaPnDBr+DY6EUkiGJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775635948; c=relaxed/simple;
	bh=v5NUvzBVJQv5miMXeTChPGnjog+O/7WBCs04W0A37ko=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=SdF3+ExXgBELc/piQ6VgyHMv7yAfeOEMNqy3QbEb01L5ePyWGAQAyqFoX+R6tf1Fbd3fNBPJ2Chbu1knAcXRo6dOCXR0Fi2YXEUVJGe6aQaF8ClPNmQBbfZouPMi1zBpXtSFAu807g3reEPM30lOqQSCH5+HIrY0KY/RQXCikM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=cXtdaSC9; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="cXtdaSC9"
Received: by linux.microsoft.com (Postfix, from userid 1173)
	id 185DB20B7007; Wed,  8 Apr 2026 01:12:27 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 185DB20B7007
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1775635947;
	bh=YM7wtdiaaKkJ/QF6fYo0ZONMYwoTKOc7Ty9QCMZpjXM=;
	h=From:To:Subject:Date:From;
	b=cXtdaSC9fQ4tgdcLhBvkKIfZl/QuJlIEEaP9V7bb7Nuy8IzFiEDUNbch7o6TgyYst
	 VSKrojl90yk0fkMsWU+q8f55JaZzWOeQyWNcJ1N4vNUkBQg8hYPy8pmmZCed2VAttF
	 I95Qag81ra11KcPXPS8nN7pfCebh+DhcaBYoHUQE=
From: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
To: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	longli@microsoft.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	ernis@linux.microsoft.com,
	ssengar@linux.microsoft.com,
	dipayanroy@linux.microsoft.com,
	gargaditya@linux.microsoft.com,
	shradhagupta@linux.microsoft.com,
	kees@kernel.org,
	kotaranov@microsoft.com,
	yury.norov@gmail.com,
	linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net 0/2] net: mana: Fix debugfs directory naming and file lifecycle
Date: Wed,  8 Apr 2026 01:12:18 -0700
Message-ID: <20260408081224.302308-1-ernis@linux.microsoft.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series fixes two pre-existing debugfs issues in the MANA driver.

Patch 1 fixes the per-device debugfs directory naming to use the unique
PCI BDF address via pci_name(), avoiding a potential NULL pointer
dereference when pdev->slot is NULL (e.g. VFIO passthrough, nested KVM)
and preventing name collisions across multiple PFs or VFs.

Patch 2 moves the current_speed debugfs file creation from
mana_probe_port() to mana_init_port() so it survives detach/attach
cycles triggered by MTU changes or XDP program changes.

Erni Sri Satya Vennela (2):
  net: mana: Use pci_name() for debugfs directory naming
  net: mana: Move current_speed debugfs file to mana_init_port()

 drivers/net/ethernet/microsoft/mana/gdma_main.c | 7 ++-----
 drivers/net/ethernet/microsoft/mana/mana_en.c   | 4 ++--
 2 files changed, 4 insertions(+), 7 deletions(-)

-- 
2.34.1


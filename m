Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8AB83769E2;
	Wed, 20 May 2026 07:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779262851; cv=none; b=RmyBiMv9Wblhxt+Ufrz6uEyPJovlMF82uvxGg9RoMf8//HdKDKotbA64sMnNtXjuKjrzvAnE6Aq5aSMm79G6bOHIo2v5+gs4DzJI1rx3/phQmsqs6jPw1IVtlVCOMJstFPRnaQ0OLhOVScFe/jC3aS6HlxGT4MWSAR6e3zlKQUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779262851; c=relaxed/simple;
	bh=y+aXfo7MThsKoSTC11Hox/ISqSIaH/XtNE6H5rBLdx0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=N+JjYxJ9J9Dd9pO1OUM8aW7SejatpOeR1KdLFBul1FpFPq1iG3BDdMs62HadEPlYa6GGkQJt12g32dbnSE+ZYXkIDJhRk9rXUMw8U278uoidS9P6+KO3Mxo7JarjNghJQAX1PFOtQCePa5HBe0LVTCHesUHmXK7QEck7nx3bOfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KpJTeR+W; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KpJTeR+W"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BF911F000E9;
	Wed, 20 May 2026 07:40:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779262850;
	bh=pzQwDfcQIVPJa3rxVTObv0nSnU3fQuUDtGie2NqZXmE=;
	h=From:To:Cc:Subject:Date;
	b=KpJTeR+WDCC8VRKlIi2uDbbRLokYhbq+GBO18djndOea0fM/iG0RBK0jrGlv81PFW
	 ok2DBjR4RyWbbwo6UcfK6kIBb2jywTJomFYkY2hFRu/+sHEmwX0/92jOXrO1s/Lwox
	 zRUt7+rqjucZ7mOJSFHaaBYuZBLhZx7Fe2eng32db37qfVQeXFvXW5tl7ErR8NNC8p
	 hM7kkqh2quNSBtYXF20+SV/o1sCIywVMRtVwN10W8QaOwbEKJVw9jDJr6MkYvVQzI4
	 SCAphJAx2Mx1BsCRS+eZK1NyBpaQhmI6ztxRS8skNtFZnnAHVNJxaxnQ0DsmvKhkye
	 ykzwfTEeRsKwA==
From: Arnd Bergmann <arnd@kernel.org>
To: "K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>,
	"Anirudh Rayabharam (Microsoft)" <anirudh@anirudhrb.com>,
	Jork Loeser <jloeser@linux.microsoft.com>,
	Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] mshv: add vmbus dependency
Date: Wed, 20 May 2026 09:40:12 +0200
Message-Id: <20260520074044.923728-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

When the vmbus driver is not part of the kernel, the mvhv_root
driver now fails to link:

ERROR: modpost: "hv_vmbus_exists" [drivers/hv/mshv_root.ko] undefined!

Avoid this by adding an explicit Kconfig dependency. Note that
stubbing out the hv_vmbus_exists() based on configuration would
also work for some cases, but not with MSHV_ROOT=y and HYPERV_VMBUS=m.

Fixes: f1a9e67c1138 ("mshv: limit SynIC management to MSHV-owned resources")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/hv/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hv/Kconfig b/drivers/hv/Kconfig
index 52af086fdeb2..21193b571a80 100644
--- a/drivers/hv/Kconfig
+++ b/drivers/hv/Kconfig
@@ -75,6 +75,7 @@ config MSHV_ROOT
 	# e.g. When withdrawing memory, the hypervisor gives back 4k pages in
 	# no particular order, making it impossible to reassemble larger pages
 	depends on PAGE_SIZE_4KB
+	depends on HYPERV_VMBUS
 	select EVENTFD
 	select VIRT_XFER_TO_GUEST_WORK
 	select HMM_MIRROR
-- 
2.39.5


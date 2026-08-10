Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 990F93DB625;
	Mon, 10 Aug 2026 12:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786365986; cv=none; b=NtF+UzFE+s5/SXEMXYHgxLPTs23Yv6LhN8CD2WXuAjApUFEZfkNvdvHoed2gIXCMGVge7QGUPJYJy2fYnZ7UxEyEvcBskVxLcENsYCauSkMdzi7uO0Bt0TWghwROQ3P79ImNw27kzVJB9YeaXk7v3UmgHLUjVoQhZfJEMIW+H5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786365986; c=relaxed/simple;
	bh=e2DbX3u3XlzlwTiXtkag5c2fb7zb9vXXSo1oDsRvG7A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=klJ6vbbw6ScgsAsEb1FZEX7IkfLN3o6ngj89KaoeNyoAajfXYXKr6qw88FJ0Ru0UOfdOOZFWvQzTzsRkxaSxqtMPOiBJ7INpHmAvGRRIw9OXtkxnb4H2L/gktZ929VUhjvLn+Smf8nCKzRswiar1m6sl21CqH5ra5XHsTE8NW6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=iIRedEfp; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="iIRedEfp"
Received: from weh-cvm-dev-vm.y50bckvjo0hefgfnzfztsfttff.phxx.internal.cloudapp.net (unknown [20.169.55.37])
	by linux.microsoft.com (Postfix) with ESMTPSA id 8E47320B7167;
	Mon, 10 Aug 2026 05:46:01 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8E47320B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1786365961;
	bh=SUJ6bUfwzYpBtZ/YdAkfwOcLHfy3T4tKrMRu8mrEZcU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iIRedEfpBmn72ovZxVKr39E3ElWFWXSsa5at/w/BjkrKqJdlQ0+RJkezIbDQ0U7Zr
	 KA2PrupVgADLz5fhFA9Ojz08mZX+ftpMGywvEPnA/7Bbdt9Kd9TMUt3V3wMEf0xxxs
	 knvZZsJoe3qof83gpNUtiqEYrwtfgAz8zD0HIRdY=
From: Wei Hu <weh@linux.microsoft.com>
To: linux-hyperv@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>,
	Wei Hu <weh@microsoft.com>
Subject: [PATCH v2 05/13] hyperv: fix hv_input_get_system_property layout for SNP status
Date: Mon, 10 Aug 2026 12:44:59 +0000
Message-ID: <20260810124527.1409634-6-weh@linux.microsoft.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260810124527.1409634-1-weh@linux.microsoft.com>
References: <20260810124527.1409634-1-weh@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wei Hu <weh@microsoft.com>

The processor-feature selector must sit at offset 8 (property_id + u32
reserved), matching the Microsoft Hypervisor ABI. Upstream 7.1's leaner
struct placed it at offset 4, so HVCALL_GET_SYSTEM_PROPERTY(SNP_STATUS)
failed and mshv aborted (no /dev/mshv). Restore reserved + u64 union.

Signed-off-by: Wei Hu <weh@microsoft.com>
---
 include/hyperv/hvhdk_mini.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/hyperv/hvhdk_mini.h b/include/hyperv/hvhdk_mini.h
index db83fedce243..dd84085c0aff 100644
--- a/include/hyperv/hvhdk_mini.h
+++ b/include/hyperv/hvhdk_mini.h
@@ -237,8 +237,9 @@ enum hv_dynamic_processor_feature_property {
 
 struct hv_input_get_system_property {
 	u32 property_id; /* enum hv_system_property */
+	u32 reserved;
 	union {
-		u32 as_uint32;
+		u64 as_uint64;
 #if IS_ENABLED(CONFIG_X86)
 		/* enum hv_dynamic_processor_feature_property */
 		u32 hv_processor_feature;
-- 
2.43.0


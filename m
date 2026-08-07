Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8712239FCDB;
	Fri,  7 Aug 2026 13:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786110750; cv=none; b=WGjaa/DPLqlrlE1+0KkhohAm9ighvrPMPDK+bSzWbD0zU116nIzmD2ar7RLkpQLyZ5+ljXm399bWk4hayFLoArm5icwJC6UYdjmNaHsy8Ylnh1CUm7Ev4HxOUBF0bzrfmfx8mybrbkel/ncCYbIW1H2Pb/1Guo5fb5yHyRT0C3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786110750; c=relaxed/simple;
	bh=e2DbX3u3XlzlwTiXtkag5c2fb7zb9vXXSo1oDsRvG7A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rRtJiDomqJgwAxxTdiFyA1BwKqTtEf9widcn/IyhVVM67l9cXUG70EILSDkzvVHtIXyDZAz1VPdaG8v/Oun2PySk7djz6N0YY1AVZgj4pNjj92Za/y/c4QD8wUM9VZnH74ysPNBi5vTnt79zvXhflwIXD5N5SOWJEs00blRfgwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=CEHPZxAg; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="CEHPZxAg"
Received: from weh-cvm-dev-vm.y50bckvjo0hefgfnzfztsfttff.phxx.internal.cloudapp.net (unknown [20.169.55.37])
	by linux.microsoft.com (Postfix) with ESMTPSA id A928F20B710C;
	Fri,  7 Aug 2026 06:51:55 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A928F20B710C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1786110716;
	bh=SUJ6bUfwzYpBtZ/YdAkfwOcLHfy3T4tKrMRu8mrEZcU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CEHPZxAgcZXe1+1N+IKnaBPkTdjckuxkQ6eSsYd+O8DdrI8NrmlEdYUc9LmRcbV61
	 X8XSh0frzMfmg1tOOUzdq7OQCbyYbJy+TzN/iHkMKrWHrB0nj44CkDcxqEXmuEIi6S
	 9fNDqy9QqysysKp5t+ufLALZpy5DOivB+Rlc3iAs=
From: Wei Hu <weh@linux.microsoft.com>
To: linux-hyperv@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>,
	Wei Hu <weh@microsoft.com>
Subject: [PATCH v1 05/13] hyperv: fix hv_input_get_system_property layout for SNP status
Date: Fri,  7 Aug 2026 13:51:11 +0000
Message-ID: <20260807135134.303943-6-weh@linux.microsoft.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260807135134.303943-1-weh@linux.microsoft.com>
References: <20260807135134.303943-1-weh@linux.microsoft.com>
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


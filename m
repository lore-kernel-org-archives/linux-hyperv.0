Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF36F3D5666;
	Mon, 27 Jul 2026 21:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785186671; cv=none; b=VBNTTKXizJAf1adQ3AwlOWVOihgT5aEwc0+UyqSlUilP4IL93elCNziyriGEmnFQriN+MeYFWoQJKkWD0sZ9VAObC6X75fIat1qYJ9bK+uoRWNqFcxnjveqiZDpXwGEIvDHig5+gSY3HK7J8Ox+zhEoKfc3Dbo5n2zbEXiu7h4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785186671; c=relaxed/simple;
	bh=tBFJ0wg+Y+EDrftORYbHqipceoX2szMkl/llszhPa0c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RyeY4KgbOmFvZ1F4+9kvc6F1Z6R/ZxIal1R7Lo7i2J9aICPC3CQrG7dZOEw9Xzsh56xK2N5UYABDbdZp1RGfwN0aNhz7fWYRc2IKeWv280aD6OMIqD64dPkR9Sv9AtuPTKjgBMWIjuDmfqq1jEn1KJSCZVcVKsk2SPwndtb63Lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=VIDGzIoS; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="VIDGzIoS"
Received: from UbuntuVM-22.efytirfs5hsengjwslc1ligxab.xx.internal.cloudapp.net (unknown [20.112.67.58])
	by linux.microsoft.com (Postfix) with ESMTPSA id BE73D20B7166;
	Mon, 27 Jul 2026 14:10:53 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com BE73D20B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1785186653;
	bh=5lmqeYCPdl/CKgpG7C41M+AJr9FooqPFRBUxrmYzRGU=;
	h=From:To:Cc:Subject:Date:From;
	b=VIDGzIoSCKcDX0zmKWNrcWi83XazB32Lxupyu6LhFX2qaGkj1W55mzHgQvamIKM3a
	 Nd+R7jwXyGX4TdiVZKfdYaiicjUCLQ41tBPa9IfyEQy86dBJnhvp3/5ODEyzL/lZqr
	 SezuazWy77gzHrf7uFJ6gzpUDDKK/nCl/ouWhCLI=
From: Hardik Garg <hargar@linux.microsoft.com>
To: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	longli@microsoft.com,
	linux-hyperv@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	ssengar@linux.microsoft.com,
	namjain@linux.microsoft.com
Subject: [PATCH] Drivers: hv: Use meaningful errnos for hypercall status codes
Date: Mon, 27 Jul 2026 21:11:01 +0000
Message-Id: <20260727211101.2199630-1-hargar@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 3817854ba892 ("hyperv: Log hypercall status codes as strings")
converted hv_result_to_errno() from a switch to a table and added status
codes used for string logging. Statuses without an existing specific
mapping were assigned the generic -EIO fallback even when a more specific
errno was available.

Map HV_STATUS_ACCESS_DENIED and HV_STATUS_OPERATION_DENIED to -EACCES,
HV_STATUS_UNKNOWN_PROPERTY and HV_STATUS_PROPERTY_VALUE_OUT_OF_RANGE to
-EINVAL, and HV_STATUS_PROCESSOR_FEATURE_NOT_SUPPORTED to -EOPNOTSUPP.
This lets callers distinguish permission, argument, and capability
failures from generic I/O errors.

The table conversion also added duplicate HV_STATUS_INVALID_LP_INDEX and
HV_STATUS_INVALID_REGISTER_VALUE entries. Remove the later -EIO entries,
which are unreachable because find_hv_status_info() returns the first
match.

Signed-off-by: Hardik Garg <hargar@linux.microsoft.com>
---
 drivers/hv/hv_common.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
index 6b67ac6167891..31256cb22b39e 100644
--- a/drivers/hv/hv_common.c
+++ b/drivers/hv/hv_common.c
@@ -787,11 +787,11 @@ static const struct hv_status_info hv_status_infos[] = {
 	_STATUS_INFO(HV_STATUS_INVALID_HYPERCALL_INPUT,		-EINVAL),
 	_STATUS_INFO(HV_STATUS_INVALID_ALIGNMENT,		-EIO),
 	_STATUS_INFO(HV_STATUS_INVALID_PARAMETER,		-EINVAL),
-	_STATUS_INFO(HV_STATUS_ACCESS_DENIED,			-EIO),
+	_STATUS_INFO(HV_STATUS_ACCESS_DENIED,			-EACCES),
 	_STATUS_INFO(HV_STATUS_INVALID_PARTITION_STATE,		-EIO),
-	_STATUS_INFO(HV_STATUS_OPERATION_DENIED,		-EIO),
-	_STATUS_INFO(HV_STATUS_UNKNOWN_PROPERTY,		-EIO),
-	_STATUS_INFO(HV_STATUS_PROPERTY_VALUE_OUT_OF_RANGE,	-EIO),
+	_STATUS_INFO(HV_STATUS_OPERATION_DENIED,		-EACCES),
+	_STATUS_INFO(HV_STATUS_UNKNOWN_PROPERTY,		-EINVAL),
+	_STATUS_INFO(HV_STATUS_PROPERTY_VALUE_OUT_OF_RANGE,	-EINVAL),
 	_STATUS_INFO(HV_STATUS_INSUFFICIENT_MEMORY,		-ENOMEM),
 	_STATUS_INFO(HV_STATUS_INSUFFICIENT_CONTIGUOUS_MEMORY,	-ENOMEM),
 	_STATUS_INFO(HV_STATUS_INSUFFICIENT_ROOT_MEMORY,	-ENOMEM),
@@ -805,11 +805,9 @@ static const struct hv_status_info hv_status_infos[] = {
 	_STATUS_INFO(HV_STATUS_NOT_ACKNOWLEDGED,		-EIO),
 	_STATUS_INFO(HV_STATUS_INVALID_VP_STATE,		-EIO),
 	_STATUS_INFO(HV_STATUS_NO_RESOURCES,			-EIO),
-	_STATUS_INFO(HV_STATUS_PROCESSOR_FEATURE_NOT_SUPPORTED,	-EIO),
+	_STATUS_INFO(HV_STATUS_PROCESSOR_FEATURE_NOT_SUPPORTED,	-EOPNOTSUPP),
 	_STATUS_INFO(HV_STATUS_INVALID_LP_INDEX,		-EINVAL),
 	_STATUS_INFO(HV_STATUS_INVALID_REGISTER_VALUE,		-EINVAL),
-	_STATUS_INFO(HV_STATUS_INVALID_LP_INDEX,		-EIO),
-	_STATUS_INFO(HV_STATUS_INVALID_REGISTER_VALUE,		-EIO),
 	_STATUS_INFO(HV_STATUS_OPERATION_FAILED,		-EIO),
 	_STATUS_INFO(HV_STATUS_TIME_OUT,			-EIO),
 	_STATUS_INFO(HV_STATUS_CALL_PENDING,			-EIO),
-- 
2.34.1


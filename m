Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60C833932D3;
	Wed, 22 Apr 2026 03:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776826824; cv=none; b=WI4DQ1ck0W4zgrRSMZyZHIDkOyzv25QVTXRwakJV5FR9pWnatN5fLK46XUtORlbWJ+wlBvCuKDee4yj6tjXtdF/vxY4MRwHEChsEJtEXR+Ctm4LaEHrad0nLo9l9ZPYniHlD8c8pl/y5Mwvy1cQHLT/rKWjIFGrO2OW/E3MOW0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776826824; c=relaxed/simple;
	bh=GFz62nBjLaicvQQSfyAdY8zYd/Jv+9UooA487pEqJXk=;
	h=Subject:From:To:Cc:Date:Message-ID:MIME-Version:Content-Type; b=YpRynuHXBNLoE3mgVlToTF42kkVwC8fU3ZfnEByH8SzN0bNOzjSg/Y03tr5bGtfdoVb75ZlMShVs/qjf9epxJgbVveJonV8nuVT7fTmBh4hJj6taEp7oZvbjhfwdk7dIM77n8NqNpbe3Y8R+ESwIql8WlbEa997trbfpw+RPvFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=VAgrf1ph; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="VAgrf1ph"
Received: from skinsburskii-cloud-desktop.internal.cloudapp.net (unknown [4.155.116.186])
	by linux.microsoft.com (Postfix) with ESMTPSA id D143E20B6F01;
	Tue, 21 Apr 2026 20:00:13 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D143E20B6F01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1776826813;
	bh=bISGXlr227VNgK/TB9w7QB9Fo8TRwIAzfmgYVuFAYJ0=;
	h=Subject:From:To:Cc:Date:From;
	b=VAgrf1phh6XHhZ+Z6VP+rQRtZcA7/0yj3qm3293ZMzlWcR+KU7I2BtzTW9dkzgZns
	 i2oN7+ymTN3ZzIyNTlMd5Kgn82ccuAOuudF9LFPZKdkmt2lj8EjW+BPzflVkV69cOu
	 QGXhLKTvPFZgZqX3Csb0WXhL1lYXvDoDuONz7YBQ=
Subject: [PATCH] mshv: Fix incorrect access type usage in GPA intercept trace
 event
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, longli@microsoft.com
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 22 Apr 2026 03:00:13 +0000
Message-ID: 
 <177682681331.1683870.15540242284121796900.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The trace event was checking for HV_INTERCEPT_ACCESS_READ twice in the
ternary operator chain instead of checking for EXECUTE, which would
cause execute accesses to be incorrectly displayed as '?' in traces.

Move the access type conversion to the TP_fast_assign section where
the raw value is available, rather than performing the conversion
during formatting. This eliminates the redundant checks and ensures
all access types are correctly identified and displayed.

Fixes: 03f7d01f699010 ("mshv: Add tracepoint for GPA intercept handling")
Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
---
 drivers/hv/mshv_trace.h |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/hv/mshv_trace.h b/drivers/hv/mshv_trace.h
index 6b8fa477fa3bf..e7280c47e579a 100644
--- a/drivers/hv/mshv_trace.h
+++ b/drivers/hv/mshv_trace.h
@@ -524,16 +524,16 @@ TRACE_EVENT(mshv_handle_gpa_intercept,
 		    __entry->partition_id = partition_id;
 		    __entry->vp_index = vp_index;
 		    __entry->gfn = gfn;
-		    __entry->access_type = access_type;
+		    __entry->access_type = access_type == HV_INTERCEPT_ACCESS_READ ? 'R' :
+					   (access_type == HV_INTERCEPT_ACCESS_WRITE ? 'W' :
+					    (access_type == HV_INTERCEPT_ACCESS_EXECUTE ? 'X' : '?'));
 		    __entry->handled = handled;
 	    ),
 	    TP_printk("partition_id=%llu vp_index=%u gfn=0x%llx access_type=%c handled=%d",
 		    __entry->partition_id,
 		    __entry->vp_index,
 		    __entry->gfn,
-		    __entry->access_type == HV_INTERCEPT_ACCESS_READ ? 'R' :
-				    (__entry->access_type == HV_INTERCEPT_ACCESS_WRITE ? 'W' :
-				    (__entry->access_type == HV_INTERCEPT_ACCESS_READ ? 'X' : '?')),
+		    __entry->access_type,
 		    __entry->handled
 	    )
 );



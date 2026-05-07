Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F59744CF54;
	Thu,  7 May 2026 15:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778168641; cv=none; b=MT0y/d0OkmYXkya28rQOAPJjWiJWqV9NDif9s3inE2WWZd6igTjZ0PC7XZAcVzcr6ICiM606GiRPUFz3QM4CBwcn0FSXrd8tUsz4ugAHvNK+gkSOWd3tN6VT/bNzo51rkhj6jxfL9pTebcxYJ28sFM0+Zz2dl7kPxd6jFJ8voB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778168641; c=relaxed/simple;
	bh=4xtBJTR2Z3cs8HfTbN/yhCqheIJKVAyoWdfFKMxD7lI=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aS4rJh7wel05pSwJrRZLknBBSRAwmY9/mhuy1t9TC9EbpDsFPrgjDh0SkTumiQ9g9XIl67PyqQwirrqNvT0STFs+LpC1tO/vuoXziJrhxEFWDe+QXXbR7Sl+flerG3f8YPBdjfJQrjF5z94TqzC0HnAUmew9KvURyrINBq7HHMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=j8Rd3kYp; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="j8Rd3kYp"
Received: from skinsburskii-cloud-desktop.internal.cloudapp.net (unknown [4.155.116.186])
	by linux.microsoft.com (Postfix) with ESMTPSA id F40EB20B7165;
	Thu,  7 May 2026 08:43:56 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com F40EB20B7165
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1778168637;
	bh=BpkI+Xl0JSY4UffzyoLS9l1eeiVb8FtSrY2DdTQXwCA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=j8Rd3kYps6eB3rYRVXHlTzHvZO1rw+kaPsxE+dBF0uT3av2NCuM6vso9ob2IN11x4
	 dkz3iGX0PWfJh83JLaSS+b/AeEQylXsUu2JpPfLPX/ZJGZKP4V7Yd1nYTl62YHwGB7
	 SMxb9H5n6OTqd4GdR2QB6LqxK5DAlmmsNTeso8gc=
Subject: [PATCH v4 11/18] mshv: Fix sleeping under spinlock in
 mshv_portid_alloc
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, longli@microsoft.com
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 07 May 2026 15:43:59 +0000
Message-ID: 
 <177816863995.21765.3588432375739789368.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
In-Reply-To: 
 <177816592843.21765.4364464279247150355.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
References: 
 <177816592843.21765.4364464279247150355.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

idr_alloc() is called with GFP_KERNEL inside idr_lock(), which holds a
spinlock. GFP_KERNEL allows the allocator to sleep, triggering a
sleeping-while-atomic bug.

Fix by using idr_preload(GFP_KERNEL) before taking the lock to
pre-allocate memory in a sleepable context, then idr_alloc() with
GFP_NOWAIT inside the spinlock-protected section.

Fixes: 621191d709b1 ("Drivers: hv: Introduce mshv_root module to expose /dev/mshv to VMMs")
Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
---
 drivers/hv/mshv_portid_table.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/hv/mshv_portid_table.c b/drivers/hv/mshv_portid_table.c
index 4cdf8e9575390..d87a82e399e96 100644
--- a/drivers/hv/mshv_portid_table.c
+++ b/drivers/hv/mshv_portid_table.c
@@ -40,12 +40,14 @@ mshv_port_table_fini(void)
 int
 mshv_portid_alloc(struct port_table_info *info)
 {
-	int ret = 0;
+	int ret;
 
+	idr_preload(GFP_KERNEL);
 	idr_lock(&port_table_idr);
 	ret = idr_alloc(&port_table_idr, info, PORTID_MIN,
-			PORTID_MAX, GFP_KERNEL);
+			PORTID_MAX, GFP_NOWAIT);
 	idr_unlock(&port_table_idr);
+	idr_preload_end();
 
 	return ret;
 }



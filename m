Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3402028DB49;
	Sat,  2 May 2026 04:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777696099; cv=none; b=fQfDrliwKOjnzN3AOCvopTUOu+pY5MOQzXb5K6p7/vl8XdqHDfxNV/99TTJPrRJEC4uG+xhCtat0msDRKFvPkdOrD3wBbpv7wwBY6eFoI+eCMwFOaEPoN0ld6dqbeAQtzThzDe/xhdJRaaSFzHiymTehl79Cey6mT7EiQjjq5RU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777696099; c=relaxed/simple;
	bh=B5BcviSkWxMJxsB/yXxPztpPzSuD5TeqcGUMVbQdrGY=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t9MQWmtJFgGmjzbrmAxn0eMwivY4YRvFnbOTvvR6h3NwX1MvMEKL50ht8zU6P9nXiUGyEzniPq675e7UR09jIBQLL1F8p0g8zo9YdcJ+7FuXdXJpsjQFyjh+CJmt6Rg/1i96SO24mRuSgd1yIb7pUFEmMIZwAqY1liRZNiLuAYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Tgp0mheq; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Tgp0mheq"
Received: from skinsburskii-cloud-desktop.internal.cloudapp.net (unknown [4.155.116.186])
	by linux.microsoft.com (Postfix) with ESMTPSA id B4C1420B7168;
	Fri,  1 May 2026 21:28:17 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B4C1420B7168
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1777696097;
	bh=sb9hrF+S0d+gt2J++FOGx9P56GAr3cUi3MdkyEEHB8Q=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=Tgp0mheqrxzl3IQgfVzFeuO3nuq6mNsl/Fqek/mLhiw+QIasC4DFAA3xFp/l434S5
	 P0iDTLhvVSJScebiTFc7v2k3BTxMVstF9zaPTxEOtf6+Fg4c0mT5JSIamM+fgrC9mE
	 EHSZYHD+NfJpLSMut9memPk9cBX+UIUe3J090J9I=
Subject: [PATCH v2 12/18] mshv: Fix use-after-RCU in mshv_portid_lookup
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, longli@microsoft.com
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Sat, 02 May 2026 04:28:17 +0000
Message-ID: 
 <177769609771.222166.4928884649239916644.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
In-Reply-To: 
 <177769588777.222166.3414280094142944420.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
References: 
 <177769588777.222166.3414280094142944420.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

mshv_portid_lookup() drops the RCU read lock before copying the
port_table_info struct found by idr_find(). If mshv_portid_free() runs
concurrently on another CPU, it can remove the entry and free it (via
synchronize_rcu + kfree) before the copy at line *info = *_info
completes — resulting in a use-after-free.

Move rcu_read_unlock() after the struct copy so the object remains
protected for the entire duration of the read-side access.

Fixes: 621191d709b14 ("Drivers: hv: Introduce mshv_root module to expose /dev/mshv to VMMs")
Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
---
 drivers/hv/mshv_portid_table.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/hv/mshv_portid_table.c b/drivers/hv/mshv_portid_table.c
index c349af1f0aaac..f1aaef69eb9b7 100644
--- a/drivers/hv/mshv_portid_table.c
+++ b/drivers/hv/mshv_portid_table.c
@@ -72,12 +72,11 @@ mshv_portid_lookup(int port_id, struct port_table_info *info)
 
 	rcu_read_lock();
 	_info = idr_find(&port_table_idr, port_id);
-	rcu_read_unlock();
-
 	if (_info) {
 		*info = *_info;
 		ret = 0;
 	}
+	rcu_read_unlock();
 
 	return ret;
 }



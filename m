Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 626DC3F210E;
	Mon,  4 May 2026 19:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777921811; cv=none; b=HslwkhH8zUo8YD2eVSFBLcRQEzVm6L8x7LTxwKqkUZ5jIiNPGUko0Jogl5hMpCu2BOSyxfhrPbvsFcnS7r/IRyvHu/4/+ZLrSx9E+2Yu8605sJxIvmAmvXNfUW04/LFD0AzVPl5Nqe/QOnp0mO0o7qy8LxCN56Hw52xg8j/DcPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777921811; c=relaxed/simple;
	bh=yR05Ym1AK0Jl++YS+XctaZlcklI0mvQLkQoc5tcqI+Y=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nQAmOVJeTwcjKqBPSs9Px3QR/FqMfmyKgnazU5cJr31dW8b/9zOO8AijK4LMnKvTKAbYXTnhTgn6q0I/klcy/F1KAPtKMuY9S1cmNnJ+uCUxiXxpxDRbAwmC6+y0cLl0xQK5eg6KpnLpKobbSy/H33HJf+5q1BJ2M0v/l500kPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=bYA239Ck; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="bYA239Ck"
Received: from skinsburskii-cloud-desktop.internal.cloudapp.net (unknown [4.155.116.186])
	by linux.microsoft.com (Postfix) with ESMTPSA id 6A28520B7168;
	Mon,  4 May 2026 12:10:08 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 6A28520B7168
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1777921808;
	bh=87tNYX28578TbQ/WZVTI1fpmbD937uZ8WwF9qck16Qw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=bYA239Ckv0+3vOjYbyqe1BPHq8jk9kqXF9inOJvjLSxoquIkSBNS/24czEMMqkwEJ
	 DwxFGbTRcnqHyZn5uQ+lpibxsh4PU/RpjduzkSXr9yVUjr2hMCpOHsZSWGOIWiCa6g
	 8ujMAtvSiHo9gOi6i1WH91Xf6hHnqf4rfuJqQjTY=
Subject: [PATCH v3 14/18] mshv: Use kfree_rcu in mshv_portid_free
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, longli@microsoft.com
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 04 May 2026 19:10:09 +0000
Message-ID: 
 <177792180986.90827.4866317696948380714.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
In-Reply-To: 
 <177792164525.90827.16672331609214066870.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
References: 
 <177792164525.90827.16672331609214066870.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

mshv_portid_free() uses synchronize_rcu() followed by kfree() to
reclaim port table entries. This blocks the caller until a full RCU
grace period elapses, which is unnecessary since the same module already
uses the non-blocking kfree_rcu() pattern in mshv_port_table_fini().

Replace with kfree_rcu() to avoid the blocking wait and keep the
reclamation strategy consistent across the file.

Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
---
 drivers/hv/mshv_portid_table.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/hv/mshv_portid_table.c b/drivers/hv/mshv_portid_table.c
index d6884c601b298..1ccbafe7aa596 100644
--- a/drivers/hv/mshv_portid_table.c
+++ b/drivers/hv/mshv_portid_table.c
@@ -62,8 +62,7 @@ mshv_portid_free(int port_id)
 	WARN_ON(!info);
 	idr_unlock(&port_table_idr);
 
-	synchronize_rcu();
-	kfree(info);
+	kfree_rcu(info, portbl_rcu);
 }
 
 int



Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C24E1299959;
	Sat,  2 May 2026 04:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777696109; cv=none; b=FK0Dr1FsvMfxgD1WCZVkRiRGg6vWtk8ct5JFiR1RQ7WT6jyoyLZymY52znF/qam0491oEVAT4c3JoccMAf6jYBeF5cjN28/wpuuMjwTT6S09rmH8elWdvouYbmAqXXC5fetgMe+yeZoT69gaXaKPbNax/pHYnBNM5BWvXeo1kWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777696109; c=relaxed/simple;
	bh=yR05Ym1AK0Jl++YS+XctaZlcklI0mvQLkQoc5tcqI+Y=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B6ZKusvbuMjbGzizmywacpAhl3mskm2Hxvjh7UlUpx0TrFCP/gg0mGuVRjQHdy1OhCA7U6wI1gHX9sAWaSpa5NGk1m7r7I5ZTMFu0S+buHsDla7FMpyBKgslIudYTzsEbmmrKuxbnbsPHE6D5LE+jACMmEWCe5CG0YeqakRsE6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=hkDZ7Y1g; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="hkDZ7Y1g"
Received: from skinsburskii-cloud-desktop.internal.cloudapp.net (unknown [4.155.116.186])
	by linux.microsoft.com (Postfix) with ESMTPSA id 60D5220B7168;
	Fri,  1 May 2026 21:28:28 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 60D5220B7168
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1777696108;
	bh=87tNYX28578TbQ/WZVTI1fpmbD937uZ8WwF9qck16Qw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=hkDZ7Y1gOZ9r+IZ/z3KLKq5yWp5sbjUP4DKMIkVr1NJ458EVmP3DA6Q+3LPKqWZW+
	 orfzfgyoQ7WA0zb00wWXMPPLUObN2I0yvLYAre0cdmLVZaAhfTNcID6j7vWj7enyTP
	 rvqSWGSNsbj+0FFWZ4wX82rJXK6GCgOhhQCPcAyo=
Subject: [PATCH v2 14/18] mshv: Use kfree_rcu in mshv_portid_free
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, longli@microsoft.com
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Sat, 02 May 2026 04:28:28 +0000
Message-ID: 
 <177769610842.222166.5161774419201174126.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
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



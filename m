Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YvcI6g1k"
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F05F0D7F;
	Wed, 29 Nov 2023 21:58:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=QJtAxhbCHcDrRV4Aa254WKnp3BN8TL7k7TrxRHdBrhY=; b=YvcI6g1k+1eUV3+0avRYXIbOgG
	p2SZ0EUdc5F0Y5Dsotfba0WqgvlwAvBrQ4xJuspFrBleoX+qIxjRYMwUVVPVo6Om1xwX8Xy/5b/YZ
	WcE1eguohju0yxwfYWIoUD970pq9lENDeNg/EJK8H2PLH9zFdf4SbEtBJQBMpKtw3pG8bVBIwXsQd
	AkX+kHULUcvbO2egt+EZK5K1FriypfzKj94Q888niLbq4vpurdPvuRCa/ejdGdWr9G4SxL4m42NWu
	Dr7/fKAvGzKpUIXXDixkhDfj87s3zc4QyI4ZmCpIMnvxVw7goGuhHz3zALyr5lFPCDN9ijAdWE40Y
	Woz4/h/w==;
Received: from [50.53.46.231] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1r8a4c-009ziS-1M;
	Thu, 30 Nov 2023 05:58:54 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	"K . Y . Srinivasan" <kys@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	linux-hyperv@vger.kernel.org,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	Simon Horman <horms@kernel.org>,
	Michael Kelley <mikelley@microsoft.com>
Subject: [PATCH v2] hv_netvsc: rndis_filter needs to select NLS
Date: Wed, 29 Nov 2023 21:58:53 -0800
Message-ID: <20231130055853.19069-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

rndis_filter uses utf8s_to_utf16s() which is provided by setting
NLS, so select NLS to fix the build error:

ERROR: modpost: "utf8s_to_utf16s" [drivers/net/hyperv/hv_netvsc.ko] undefined!

Fixes: 1ce09e899d28 ("hyperv: Add support for setting MAC from within guests")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Haiyang Zhang <haiyangz@microsoft.com>
Cc: K. Y. Srinivasan <kys@microsoft.com>
Cc: Wei Liu <wei.liu@kernel.org>
Cc: Dexuan Cui <decui@microsoft.com>
Cc: linux-hyperv@vger.kernel.org
Cc: David S. Miller <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Simon Horman <horms@kernel.org> # build-tested
Reviewed-by: Michael Kelley <mikelley@microsoft.com>
---
v2: correct Subject prefix (Michael)

 drivers/net/hyperv/Kconfig |    1 +
 1 file changed, 1 insertion(+)

diff -- a/drivers/net/hyperv/Kconfig b/drivers/net/hyperv/Kconfig
--- a/drivers/net/hyperv/Kconfig
+++ b/drivers/net/hyperv/Kconfig
@@ -3,5 +3,6 @@ config HYPERV_NET
 	tristate "Microsoft Hyper-V virtual network driver"
 	depends on HYPERV
 	select UCS2_STRING
+	select NLS
 	help
 	  Select this option to enable the Hyper-V virtual network driver.

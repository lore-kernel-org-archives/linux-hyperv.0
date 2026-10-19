Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=13.77.154.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792451402;
	b=2BkLObUrnE2RfUMqMDmAvyiph0HNGpPachaa2/V2BxfTUTe+SNGm+RilBcvMPAbZzDb1
	 Y173cjUIK2JhmqAG62qoKFc+v7d6qBzg/6vkHOER4nhlWGs5Yk+r4H68dW8V1d+M4TW+l
	 DS4uxdMy91eB0D/jxMy9o1cCogGIP++xFcnPD6JzpskOWsqRgCRxX2O5Js/ujJxShAvrd
	 tEbRMxM2RlRT7kRKusME62oUVqzdDvlw5ZZWepBVqK0kaJsFcknG/sQEDToVLG4ApWqKH
	 6pho/aKz+GtXzNJ95osJHLoXx+9zLxV5EZOeFV/XSRYJSDhfnddOD57agjP0nGpvvmg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792451402;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Spam-Status:X-Spam-Checker-Version;
	bh=E1ZSB6/sis1Iy7RN88yPXw0VcLDFJ6YXhWQgxe8hzk4=;
	b=FFPG81zVSeSwDbu3FpLnBMZappJnaNjmwVNuWK/0DqqJzdKPKR+mJ0Y5OJsibitEZFdM
	 jm7nHiOXPxcqRuz7fgkoTnf++TFM9eO4yzxSquLM7SPXT1gFXaZkuLQRymEPL+IJcwBlW
	 trUnNWapjH4PAza6H1WLdN2i8JNZKj/ffKLO1mNecHesK9NusDBSAcx26y97LYq2PqKfw
	 yvc2Zz0OLPoV/fetk0uUnsWQ17didGLkGRz9Kjz4F0Ektf+Ou4XmIwoYbNxmWEYt30Bfo
	 keHps9kACJsZli2owdnmsvth5+NEKpAhGqWv5ncwVNPWfc4KN0YnHjg9urOJJEMRDCw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.microsoft.com;
	spf=pass smtp.mailfrom=linux.microsoft.com;
	dkim=pass header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b="LbpV/uns";
	arc=none smtp.remote-ip=13.77.154.182
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E959C606A31D;
	Mon, 19 Oct 2026 23:10:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E959C606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=LbpV/uns
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id 00E0120B7170;
	Mon, 19 Oct 2026 16:09:55 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 00E0120B7170
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1792451395;
	bh=E1ZSB6/sis1Iy7RN88yPXw0VcLDFJ6YXhWQgxe8hzk4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LbpV/unsB7+sYcZ1eI+IkyC3K9dCBkeVFp+TdTaA/vNeumEpLJ7xWQkJYoT0CjmMx
	 YWPqCk24ecR9Qf8odMM68ormkkGFON9PlaTzQ4n5Ph1N+nHPuRQ3gnOoJfaRbsZh2w
	 GZyRJoQ7bqbHVi5MSb7+zB2H94bVP7OIlPBw31iQ=
From: Kameron Carr <kameroncarr@linux.microsoft.com>
To: Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Michael Kelley <mhklinux@outlook.com>
Cc: linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/5] Documentation: hyperv: Describe validation of the ring buffer indices
Date: Mon, 19 Oct 2026 16:09:50 -0700
Message-ID: <20261019230950.1573677-6-kameroncarr@linux.microsoft.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20261019230950.1573677-1-kameroncarr@linux.microsoft.com>
References: <20261019230950.1573677-1-kameroncarr@linux.microsoft.com>
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Post: <mailto:linux-hyperv@vger.kernel.org>
List-Help: <mailto:linux-hyperv+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hyperv+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document that the guest must snapshot and validate the read and write
indices before using them to index into the ring buffer or to compute
the available space.

Signed-off-by: Kameron Carr <kameroncarr@linux.microsoft.com>
---
 Documentation/virt/hyperv/coco.rst | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/virt/hyperv/coco.rst b/Documentation/virt/hyperv/coco.rst
index 3231e51..3e20249 100644
--- a/Documentation/virt/hyperv/coco.rst
+++ b/Documentation/virt/hyperv/coco.rst
@@ -200,7 +200,10 @@ validation is performed. For messages passed from the host to the guest in a
 VMBus ring buffer, the length of the message is validated, and the message is
 copied into a temporary (encrypted) buffer for further validation and
 processing. The copying adds a small amount of overhead, but is the only way
-to protect against a malicious host. See hv_pkt_iter_first().
+to protect against a malicious host. See hv_pkt_iter_first(). Similarly, the
+ring buffer header is shared with the host, so the guest must snapshot and
+validate the read and write indices before using them to index into the ring
+buffer or to compute available space.
 
 Many drivers for VMBus devices have been "hardened" by adding code to fully
 validate messages received over VMBus, instead of assuming that Hyper-V is

-- 
2.45.4

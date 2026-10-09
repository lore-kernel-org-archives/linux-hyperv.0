Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFE4D516177
	for <linux-hyperv@vger.kernel.org>; Fri,  9 Oct 2026 18:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791571272; cv=none; b=P4AG93imxi+h/h7ZbuSsHJ5ls5P3tn17ibD0mN1v7ItPzGWzLO7qck/YjkfboGX6PkNgr7vUcfOure91S6f6uBTPj7HoJezvhryPipKx9dWV6aa0j5IQgZDljgTzH4Cp18+XLdTW2aqtjVW1eUUdGchpCgHK9z28+jhN5pQkdEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791571272; c=relaxed/simple;
	bh=51IUJ7oH2GDK0isWUJ8WivKZY3H+6fuok9bV/QpC9Rc=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=nf5kyYSeNX/Vh4Fbn7CME6UpI8iKUn4tQMB7DeQTjjQZhjAEr9kzzEPuwE2g0jxdwePlz8v/ysCWwpXSM0ER/fKaNvpXO97LJiuJ1XEafcZ432jNpYxA/0r5teQet9K7ns+EdZV+VdC/wP52dkFNQ6IJwY0HFL6NmNBIAVM5UGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BA3j6mVD; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BA3j6mVD"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-88bd2b44f3aso20944b3a.0
        for <linux-hyperv@vger.kernel.org>; Fri, 09 Oct 2026 11:41:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791571261; x=1792176061; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=v7IaqPQoEOi+imp/PK24+/AW3BiTVn/zY6gW+WBVBCE=;
        b=BA3j6mVD5e+PCI8eZX4xwf0R+z3JEUR4vmzNqItQ9Ec/YBmpkbSJgX6qnm07C9YgP2
         pzLILEDo6wyHmbjB/NW7/Wyqnyg5ISfZHiF65M/27KSHzxhKHdS7s/nLI1BChRDrQdwj
         IX42spVLHKhguGVXnUnNRXdxjH4lBOSDfs4UjcVzQbxxfJd6DdrhoeqFVK4kf3eVTkAY
         jtHFN2lVGsehCJWqKtEZyvRgA/azXYGYeYE52wu8KOj2ufjJlpaQAKH7T4X08s9gswmD
         oHMdk/EgrtqX7JnJENcB/M6XaEewa7NlX6h9qJVs02YxV7ICni0jrJ8Pdo014LqxMxbB
         yoGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791571261; x=1792176061;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=v7IaqPQoEOi+imp/PK24+/AW3BiTVn/zY6gW+WBVBCE=;
        b=wVXOR/FiGzvQBDiqjz5VFgTYrVTdFVL5V9BCUAyzjR1JB1EUY+95aPQC7+QW9KGpxC
         tHj2WBTau3Xgb0N5+sRQFcOQNIpgCJ/SiqBLGhZFW4WApFVneJqyBiQ7cX0fCViwKizI
         /UVOALn284+Dq9ZnktnfqM5tgr2tytDCAYjkLHfzX7PnGi4JF2lVfT2zHcfNeonUgy+J
         W9hVLdxsO1aeAOlLqmy1h3fGN2txCgNmEpXtVqaRDsD6h2xkyGWaG0gI91T2WqDxS2nj
         fPCSDqTvzvth1QwJmvlSJqVzrryZaYNJfHOS8a/hu19hcVAt+luJbKY42uT0AaevXUj0
         2d2g==
X-Forwarded-Encrypted: i=1; AKwUvBwJReYf4ANsdSz7CbwLYEOy0pAC5hkQVXw7NJk8FgFYlcBGPyx/RJ2V7UOGo8oWpZ1miEU3keNmqpr1Yes=@vger.kernel.org
X-Gm-Message-State: AFq9FYKlay6sh/ti+t6C+Js8ygHfFT7IBUKShn3kmaQ/bueiUzQzG/xQ
	CfU7R/DWbeaJm5HdUb6h8Q64SrUyD+5xlhiw0NyEDePGuT/7LLn6ms+G
X-Gm-Gg: AYBFou3cK+/1LX4zlRr9+Up9LLCUWTXd4SrobBSr195r9TaQCGr2DN6XlgXp2J0xcDv
	7FFTu4zGtGgG9p57QLjlRg+HwESLk1XT5f5araEnFxEQjaHXH66RTrYq7nFWz9GAl4DDsofwzcb
	HMiCFo+slMU9Me7k+cFOU3Y5//5sbFrHqK6inIpOqFFN/lpV4LcIHJhyrq/W+1Fv0xFLAOCgOAS
	SnPdMTncxZfq6V3aX90jqXND01susuSBY8SHLqhRSK0S9pmSZDcON6bXXuIIxzKqJLZdNsMnvTY
	JYBZuQ5krJoJTLydsA15sSN388G/Ox5aKfFrvonczYqBlusBXcY54MjakSo8d3gHf+2lxw44duT
	rQZDVjbbiO5BDHn+gptIc62AOGjLvpFvxiQ0RgVYVoXluGr42DFG+mEDj9JGKal8Ve2lm3DxZPu
	3PsoUj1OZim9Wh+LdZq0big7dOJOBgzVgnFXLpbheeYExWekTY2MyRm1iTvkEWp47lLzj5YZzei
	Xd9EL3ADgziCTL5J6oXMhyXeuNb+ogN3Dtyp5M4XaQZqOlGO2/h7y3QlqsMEk9RrieeMSyOjNzG
X-Received: by 2002:a05:6a21:70cb:b0:3de:b120:bbad with SMTP id adf61e73a8af0-3e16be898a4mr2712134637.15.1791571261345;
        Fri, 09 Oct 2026 11:41:01 -0700 (PDT)
Received: from localhost.localdomain (c-174-165-208-10.hsd1.wa.comcast.net. [174.165.208.10])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cd3d9e1ee81sm1513576a12.12.2026.10.09.11.41.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 11:41:01 -0700 (PDT)
From: Michael Kelley <mhkelley58@gmail.com>
X-Google-Original-From: Michael Kelley <mhklinux@outlook.com>
To: haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	rdunlap@infradead.org,
	linux-kernel@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: [PATCH v2 1/1] Documentation: hyperv: Update documentation for sending VMBus packets
Date: Fri,  9 Oct 2026 11:40:56 -0700
Message-Id: <20261009184056.7382-1-mhklinux@outlook.com>
X-Mailer: git-send-email 2.25.1
Reply-To: mhklinux@outlook.com
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The functions for sending VMBus packets have changed.
vmbus_sendpacket_mpb_desc() can target multiple ranges, and
vmbus_sendpacket_pagebuffer() has been removed. vmbus_sendpacket_getid()
has been added. Update the documentation accordingly.

Fixes: 45a442fe369e ("Drivers: hv: vmbus: Remove vmbus_sendpacket_pagebuffer()")
Cc: stable@vger.kernel.org
Signed-off-by: Michael Kelley <mhklinux@outlook.com>
---
Changes in v2:
* Add vmbus_sendpacket_getid() to the documentation. [Naman Jain]

 Documentation/virt/hyperv/vmbus.rst | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/Documentation/virt/hyperv/vmbus.rst b/Documentation/virt/hyperv/vmbus.rst
index 654bb4849972..9c5b712c6e39 100644
--- a/Documentation/virt/hyperv/vmbus.rst
+++ b/Documentation/virt/hyperv/vmbus.rst
@@ -141,14 +141,15 @@ Three functions exist to send VMBus channel messages:
 
 1. vmbus_sendpacket():  Control-only messages and messages with
    embedded data -- no GPAs
-2. vmbus_sendpacket_pagebuffer(): Message with list of GPAs
-   identifying data to transfer.  An offset and length is
-   associated with each GPA so that multiple discontinuous areas
-   of guest memory can be targeted.
-3. vmbus_sendpacket_mpb_desc(): Message with list of GPAs
-   identifying data to transfer.  A single offset and length is
-   associated with a list of GPAs.  The GPAs must describe a
-   single logical area of guest memory to be targeted.
+2. vmbus_sendpacket_getid(): Similar to vmbus_sendpacket() but returns
+   a transaction ID that is matched against a reply from the Hyper-V
+   host. Useful when the struct completion (or other rendezvous data)
+   must reside on the caller's stack. By invalidating the transaction
+   ID before exiting the function due to a timeout or other error, a
+   late arrving interrupt is assured to not trash the stack.
+3. vmbus_sendpacket_mpb_desc(): Message with one or more data ranges
+   to target. Each range consists of a single offset and length plus
+   a list of GPAs that describe a logical area of guest memory.
 
 Historically, Linux guests have trusted Hyper-V to send well-formed
 and valid messages, and Linux drivers for synthetic devices did not
-- 
2.25.1


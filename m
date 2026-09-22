Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B16B3F661D;
	Tue, 22 Sep 2026 07:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.164.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790060772; cv=none; b=hYLoj+rJBXNmdMEDozHqunhV+EsQ42Eo2qOOIqoDekuiejuNo0V2BW++YlWKPP0VGD+dT85G6OPfwtiTLJqNnTl6hP4/1BZVdBYFb0Ap9UYspIRzBmd0gn0O8mgt4VXEzgEw0oSo4E+eQfjaULjT91cIJ+I4NMK7npOC9+PEMD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790060772; c=relaxed/simple;
	bh=8ILN2xyBEfRuO4z4BmXWiuqW66c/QG66wG5LIN+afdE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VWNN1c56wbZUDMW6OdhjvLEkWJQ6qM2VF18kSL+twSyxEQkEbOx1IZx1I0kYJRpKK9Kf6azwgHE4cEj0ArDw+hpTVQAdbOVfn2bs/QnDT5wwydaxUk7lxG0R3/rmFPmRmbVTo3IJ9Qc999Xyv7PUrWAujhIQooKqK2+fUDgkmrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=162.243.164.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [10.98.66.117])
	by mtasvr (Coremail) with SMTP id _____wDXIjXQKLJqdFctAQ--.906S3;
	Tue, 22 Sep 2026 15:05:53 +0800 (CST)
Received: from localhost.localdomain (unknown [10.98.66.117])
	by mail-app4 (Coremail) with SMTP id zi_KCgBXijHJKLJqt3LLAw--.61135S2;
	Tue, 22 Sep 2026 15:05:51 +0800 (CST)
From: Fan Wu <fanwu01@zju.edu.cn>
To: kuba@kernel.org
Cc: netdev@vger.kernel.org,
	horms@kernel.org,
	kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	longli@microsoft.com,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Fan Wu <fanwu01@zju.edu.cn>
Subject: Re: [PATCH net v3] net: mana: fix reset work race with device removal
Date: Tue, 22 Sep 2026 07:04:16 +0000
Message-Id: <20260922070416.307367-1-fanwu01@zju.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260915172744.06c9521d@kernel.org>
References: <20260915172744.06c9521d@kernel.org>, <20260909042529.652301-1-fanwu01@zju.edu.cn>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zi_KCgBXijHJKLJqt3LLAw--.61135S2
X-CM-SenderInfo: qrstjiaswqq6lmxovvfxof0/
X-CM-DELIVERINFO: =?B?3HTdsgXKKxbFmtjJiESix3B1w3vZ3A9ovKVTomAyoQazvoRs/NHSP8GI2EvgeEEW7R
	sfnXz+g1OQfMo27QHy5TwQyZw9JFqQyAkOofL7VDhP3FcCY39FwEpdtMWGCzphYXSTH0CE
	Gj6qZ0f5sOiQVoKWem2p9E6mavGmQbzmcFsnzP86
X-Coremail-Antispam: 1Uk129KBj9xXoW7Jw4kCw4UZw4rKry8uw4rJFc_yoWDtFb_ua
	48KF1v9wsxXFW0q343GF48ZFs7ta1FyryxJF4kZa47K34UJFnrXr4UCrn0v3yxKaySk3sx
	urWUKrWfK34YvosvyTuYvTs0mTUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUj1kv1TuYvT
	s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
	cSsGvfJTRUUUbD8YFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20EY4v20x
	vaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	WxJr0_GcWl84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	GcCE3s1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2
	xF0cIa020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_
	Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x
	0EwIxGrwACjcxG0xvY0x0EwIxGrVCF72vEw4AK0wACI402YVCY1x02628vn2kIc2xKxwCF
	04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r
	18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vI
	r41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr
	1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvE
	x4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jbo7NUUUUU=

Thanks - agreed, a lock shape reads better here, and v4 will use one.

To be clear about why it isn't a plain mutex: admission runs in hard IRQ
context (mana_gd_intr() -> mana_gd_process_eqe() ->
mana_schedule_serv_work()), and mana_gd_remove() can be entered on the
service work's own stack (its rescan exit calls
pci_stop_and_remove_bus_device()), so cancel_work_sync() is out and
remove() can only wait until the work has stopped touching gc, not for
it to finish. v4 expresses this with a small gc-embedded spinlock
(hardirq-safe, never held across sleeps) plus a waitqueue for the
drain, replacing the flag protocol.

v4 will also fix the two real issues the AI review flagged, which the
lock alone does not address:

- GC_REMOVING currently stays latched if a rescan exit bails out early
  (no parent bus) without removing the device; v4 checks for that
  before closing admission, so service is never permanently disabled
  on a bound device.

- mana_gd_shutdown() now drains as well, since it tears down the same
  hardware paths remove() does.


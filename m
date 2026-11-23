Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795449108;
	b=tTieSIaZw+WrsP9oO0HHTdRvFjPguc9mnFlqv7dAi5FL02oZxbLedufcu39sfkfn+exx
	 Dz5j4Mm8IUNA07iit/tgChtZdAVO7Mwqm93xDOOeP9SanJ4VF8gJC3fJzuZ1w+xamzFfr
	 MgbtH4aQpQQoZlrEOK4U5ktGdQebCD2Xx2ay1eWzgTY+SpTVWxZZSPHhkq/fwOFZ0Mpsa
	 hLO9b9ve8yDU3F7thwaIGTXY/2dNdZL1kbSUb5cp6CgAeHJpYmrRCMLZhBKoY+7TaaaYs
	 goHAhabU8cJl8Ney1JYJdt3MLKcYAwzxCaHkIYNE4KMXQJV+krNxSJtuRVfE0uutJMQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795449108;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=UwQ48wOTLkO0bDqXN9a1jl6i0o7vHJe4bfY0WMjHxA0=;
	b=Bg2ePhDJsxksI4GAIoVlH14EPQBsJ55PdFW0M4mNhmo/OZpAp0W/rPpYwU7IwVv7Cn4F
	 iiRk39qJuqc/my+I8ew89GWQjUoGudrJMQ3Ge18ahW3KwtmtX86L1YZlTd6vkeej0R8kg
	 GmfPNgNYQ9QRJYMrnbYu1cLn4IGEMLijldZ3xYb30FOjwvDyfYdXyOn3L0MnH0/6kz6/I
	 OQELYeBhE50TgIaDVkX258Vi/ohyJLPPQileovzIrbSWU/BcYyiGJPEMn1KLYagTmt8zk
	 Ev9EgCzgiwtGHUT305TET3fB8Rrstvkz1IKzpyZRSauxdAnvJ5MAOgPBHaGdxSFsOvQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ffEczR10;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FCDB606A31A;
	Mon, 23 Nov 2026 15:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ffEczR10
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37E3B1F000D0;
	Mon, 23 Nov 2026 15:51:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795449107;
	bh=UwQ48wOTLkO0bDqXN9a1jl6i0o7vHJe4bfY0WMjHxA0=;
	h=From:To:Cc:Subject:Date;
	b=ffEczR10kkz6TwinqVlb2eqxN6YHZfPjHgTME+LIdeQFDnaJpfTfDbbKAxYyR8dkT
	 C/KF29bpbofnjfmI+LyU5opbRTVKXHaYTqX3H9UJxU9XY/sL6OHFqYic1mAv5nZ7JD
	 SSw02x/zrDSYJw7ootSjHsO4JJuZCWGv9ztWNARHSc5DHgJNO03wxWj69OxnbIl2+k
	 2Pn5B1lFOaWmJi7OJgHHuB7f/a+1/NzWJyPKg67Kf4nNZhbYSHYCP9VydSTOFOf9pi
	 dxGF0mA1uTGwyLyibjPY5K8qtP7wkDwFA2eEHvTn1TBcyXfEIlZvbJsmWUuFfT7IUX
	 06xNE+qMx1lbw==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	bpf@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	=?UTF-8?q?Barnab=C3=A1s=20P=C5=91cze?= <pobrn@protonmail.com>,
	=?UTF-8?q?Beno=C3=AEt=20Sevens?= <bsevens@google.com>,
	=?UTF-8?q?Filipe=20La=C3=ADns?= <lains@riseup.net>,
	"He, Bo" <bo.he@intel.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	"Zhang, Jun" <jun.zhang@intel.com>,
	Andreas Gal <gal@cs.uni-magdeburg.de>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Bastien Nocera <hadess@hadess.net>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Charles Wang <charles.goodix@gmail.com>,
	Dexuan Cui <decui@microsoft.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Jason Gerecke <jason.gerecke@wacom.com>,
	Jiangshan Yi <yijiangshan@kylinos.cn>,
	Jiri Kosina <jikos@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	linux-hyperv@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-input@vger.kernel.org,
	Lopez Casado <nlopezcasad@logitech.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	Vojtech Pavlik <vojtech@ucw.cz>,
	Michael Bommarito <michael.bommarito@gmail.com>,
	Michael Haboustak <mike-@cinci.rr.com>,
	Pan Chuang <panchuang@vivo.com>,
	Ping Cheng <ping.cheng@wacom.com>,
	Rishi Gupta <gupt21@gmail.com>,
	Roderick Colenbrander <roderick.colenbrander@sony.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Stefan Achatz <erazor_de@users.sourceforge.net>,
	Tianchu Chen <flynnnchen@tencent.com>,
	Vojtech Pavlik <vojtech@suse.cz>,
	Wei Liu <wei.liu@kernel.org>,
	Zhang Lixu <lixu.zhang@intel.com>
Subject: [PATCH 00/10] HID: Assorted bug fixes across HID core and drivers
Date: Mon, 23 Nov 2026 15:50:44 +0000
Message-ID: <20261123155138.2907049-1-lee@kernel.org>
X-Mailer: git-send-email 2.56.1.750.gf70dc682cf-goog
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Post: <mailto:linux-hyperv@vger.kernel.org>
List-Help: <mailto:linux-hyperv+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hyperv+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

These issues were reported by Sashiko.

None of these changes have been tested on physical hardware.

Cc: "Barnabás Pőcze" <pobrn@protonmail.com>
Cc: "Benoît Sevens" <bsevens@google.com>
Cc: "Filipe Laíns" <lains@riseup.net>
Cc: "He, Bo" <bo.he@intel.com>
Cc: "K. Y. Srinivasan" <kys@microsoft.com>
Cc: "Zhang, Jun" <jun.zhang@intel.com>
Cc: Andreas Gal <gal@cs.uni-magdeburg.de>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Bastien Nocera <hadess@hadess.net>
Cc: Benjamin Tissoires <bentiss@kernel.org>
Cc: bpf@vger.kernel.org
Cc: Charles Wang <charles.goodix@gmail.com>
Cc: Dexuan Cui <decui@microsoft.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Haiyang Zhang <haiyangz@microsoft.com>
Cc: Jason Gerecke <jason.gerecke@wacom.com>
Cc: Jiangshan Yi <yijiangshan@kylinos.cn>
Cc: Jiri Kosina <jikos@kernel.org>
Cc: Jonathan Cameron <jic23@kernel.org>
Cc: linux-hyperv@vger.kernel.org
Cc: linux-i2c@vger.kernel.org
Cc: linux-iio@vger.kernel.org
Cc: linux-input@vger.kernel.org
Cc: Lopez Casado <nlopezcasad@logitech.com>
Cc: Marcel Holtmann <marcel@holtmann.org>
Cc: Vojtech Pavlik <vojtech@ucw.cz>
Cc: Michael Bommarito <michael.bommarito@gmail.com>
Cc: Michael Haboustak <mike-@cinci.rr.com>
Cc: Pan Chuang <panchuang@vivo.com>
Cc: Ping Cheng <ping.cheng@wacom.com>
Cc: Rishi Gupta <gupt21@gmail.com>
Cc: Roderick Colenbrander <roderick.colenbrander@sony.com>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Stefan Achatz <erazor_de@users.sourceforge.net>
Cc: Tianchu Chen <flynnnchen@tencent.com>
Cc: Vojtech Pavlik <vojtech@suse.cz>
Cc: Wei Liu <wei.liu@kernel.org>
Cc: Zhang Lixu <lixu.zhang@intel.com>

Lee Jones (10):
  HID: core: Protect hid->inputs traversal in hid_check_keys_pressed()
  HID: mcp2221: Synchronise rxbuf access against raw_event callback
  HID: logitech-hidpp: Synchronise send_receive_buf against raw events
  HID: sensor-hub: Serialise synchronous read teardown under data->lock
  HID: roccat: pyra: Resolve USB device from parent in actual_profile
  HID: hyperv: Validate VMBus packet and payload bounds on receive
  HID: hid-goodix-spi: Validate package sizes in goodix_hid_irq()
  HID: wacom: Stop HID hardware before releasing resources on mode
    change
  HID: debug: Hold driver_input_lock while dumping raw report descriptor
  HID: playstation: Cancel DualSense output worker on create failure

 drivers/hid/hid-core.c           | 16 ++++++---
 drivers/hid/hid-debug.c          | 12 ++++---
 drivers/hid/hid-goodix-spi.c     | 34 +++++++++++++------
 drivers/hid/hid-hyperv.c         | 12 +++++++
 drivers/hid/hid-logitech-hidpp.c | 58 +++++++++++++++++++++-----------
 drivers/hid/hid-mcp2221.c        | 47 ++++++++++++++------------
 drivers/hid/hid-playstation.c    |  1 +
 drivers/hid/hid-roccat-pyra.c    |  9 +++--
 drivers/hid/hid-sensor-hub.c     | 28 +++++++++++----
 drivers/hid/wacom_sys.c          |  4 +--
 10 files changed, 149 insertions(+), 72 deletions(-)

-- 
2.56.1.750.gf70dc682cf-goog


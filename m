Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795799240;
	b=p8dEukI1Nia8WHDTVZedPAmJ2HIDJoNbuKjp8bCr2p8WSii5hU5jPioX0TuIbNdD9RuH
	 N+XNzSQezHMeR2nc9P62HcCV5ZbJiqnSWd1kYQrH+JfAt2OkFD4n2GOVIljGaq5RU0Vbl
	 aAbaaElBFmS3sdtJg1o8UqZAIUi4NCJmG0y+CdxK2kCTCifpQ/ZEJ4PmH8QiC9B7F2S0y
	 hWvkUzpzOG+VSv638VNvJfEdv7kT/PRJphjV8Mt1v0wTsH/OFiFlNF/h6MyqgWvkYFHoe
	 TVKabnyd/B0LhjS30yi95hUsErYEGLog+XLKHDCl7WmNvltpq+1q2WftyoRv51Fl/iQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795799240;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=PdndVKJFo7cHXqOQ9mGDRu01U/lAdsSMeeFhNTaFFmY=;
	b=s0NkcfWNMElWAHcWxFMT8ThA9+UblCaU730hecSk0REyGqYnO0Re0FWbTrFkXemO6BmA
	 RDry1TGqMwadZg0Ih4cIBnofemSRl4ipY8Mt2N8wHh7KzPu/YkUiuYevLfZwPV1qt6LJt
	 8szVLv8Eab2Dm+phswUGoHEgmRQRkqq/8T13VQa8DibUjNj59MfBIv15m6fbrY+fzqZZ/
	 Dd48F6QCL4IrTE8zAjbGTo/XoZAVK9ruM0/tT9ifFVv+AWxmDFHJkSnjVVxsDEJMSbf4V
	 fZC2KkR7GhAAr4Vo7VsJ/ba3rwhacmZWVQamyi78xonj7LBOUv8l8hQNsOtEDq1jtkg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L4qceq45;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6202606A31C;
	Fri, 27 Nov 2026 17:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L4qceq45
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2F9A1F00893;
	Fri, 27 Nov 2026 17:07:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795799240;
	bh=PdndVKJFo7cHXqOQ9mGDRu01U/lAdsSMeeFhNTaFFmY=;
	h=From:To:Cc:Subject:Date;
	b=L4qceq45GDx6JcEele2BvYYX9U0rdgQfBfplZblCu5YdWd1L6v0kFvirUtFImlxpu
	 OCcTKFys0pwxgL1sn+G+7Bw5EpCL1V+Zv+Lymqf/BHy2i1VAzYUDkX/oUM7VNXnwq+
	 SchJWtXKEPIV/m++1/M/DweKe6hStcnw/X6KXl+K76uIZ1LD6GYsZt7ZBYh+mOmfa+
	 tyuzhIo8iavebwVcD4dZ1i6Jl9hJq4yh1TYExb/bF4G9lTn0UOyVrNIcQz0uEDowP/
	 HsP7lypu9lZwTi2R1zBBJRnTTEdkUgx3UQgYv990WfcWBeuGf1lFRgGt5LJgvqzMKL
	 vsOcdf50dtv0A==
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
	message to <vojtech@ucw.cz>,
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
Subject: [PATCH v2 00/10] HID: Fix race conditions, UAFs, and bounds bugs
Date: Fri, 27 Nov 2026 17:06:18 +0000
Message-ID: <20261127170712.3163443-1-lee@kernel.org>
X-Mailer: git-send-email 2.56.1.839.g22a8290db9-goog
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

This v2 series addresses Srinivas Pandruvada's review feedback on
hid-sensor-hub and collects Reviewed-by and Tested-by tags from v1.

v1 => v2:
 - Drop kfree() from sensor_hub_raw_event() and clear hsdev->pending.status before complete() under data->lock in patch 04, per Srinivas Pandruvada's review.
 - Add Hamza Mahfooz's Reviewed-by tag on patch 06.
 - Add Ping Cheng's Reviewed-by and Tested-by tags on patch 08.

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
Cc: message to <vojtech@ucw.cz>
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
 drivers/hid/hid-sensor-hub.c     | 29 ++++++++++++----
 drivers/hid/wacom_sys.c          |  4 +--
 10 files changed, 150 insertions(+), 72 deletions(-)

-- 
2.56.1.839.g22a8290db9-goog


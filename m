Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF4B43A1CFE;
	Thu,  4 Jun 2026 09:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780567098; cv=none; b=ek3cu5WUl8daYFEngFr35drBKXHuKSLroFyVaMxDgLIHQJ+n5Mc5xc3w+0QW/01Wq0xiQtWecRSxgtPjwFgZkr5y0Q+WTb8MH43QhzhItAAdEsr6Oawk4x2CK7xyk2IIWGhX5CkrfdG2u32qrpaktm+z3TG5azv/a7P7ncVdUA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780567098; c=relaxed/simple;
	bh=3f/b3FCiMCo1Prv5b9Zv44WeZy2IPCq6wn8qWPGlWo8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kpQVXFtuAN8eR8nA6dIQXNC340PUF7npSnDB82ud/ti8iFk1SQZSUMCLEhwBLUMQr22tW60/EvWm88g2zY7eYXlZHyA+s8/M1bkLWwa97lWasVIMyvR0vCP8Czz//ryDM7fr8CzkcVtq2JmQqmweCGrSmOgXwErWsgj3zOvWt60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=casper.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Zvb0GjrU; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Zvb0GjrU"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=GrsCw9BuwtLrKbMs89f9d0hRaM+XunZJyvTs9Nx/W4Q=; b=Zvb0GjrUYh4Nhf927c77AslMy4
	RQh3f3B1HH/06WcwVTCpTqCvkw19hCaw0/UNFlvOeFr0rAhDLNkRZwdVN2c/WBsPbeID737e/yXqb
	tS6hsJZVbqYLdl0Q/HjUu9LAxCo5wX1uZmGxJghmm+RBIGsWrs11Ms7mVhA9os6cXf+yAHTgGLhnt
	/eRqWK5Wi5mL137YpXjVVuZyrvflpEoTzQmVDZjQTUC37+akHQ1pIVEL8+CrnoAVfPPEhzBrhD/ZJ
	7X8tVnR3bGgHtneou4OXWqgDdjZmlpXezcbcYOzp8ipiC0myqTeUfecXVSS4pZgYTQlMl3gzOng8e
	3iPM5X0Q==;
Received: from i7.infradead.org ([2001:8b0:10b:1:21e:67ff:fecb:7a92])
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wV4pq-00000005aXU-3lFY;
	Thu, 04 Jun 2026 09:57:59 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wV4pq-00000000H0l-2YEl;
	Thu, 04 Jun 2026 10:57:58 +0100
From: David Woodhouse <dwmw2@infradead.org>
To: Thomas Gleixner <tglx@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Michael Kelley <mhklinux@outlook.com>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	David Woodhouse <dwmw2@infradead.org>,
	Richard Cochran <richardcochran@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH v2 0/3] timekeeping: Implement and use read_snapshot() functionality
Date: Thu,  4 Jun 2026 10:35:15 +0100
Message-ID: <20260604095755.64849-1-dwmw2@infradead.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: David Woodhouse <dwmw2@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html

Commit ca1ec8bfac8c ("timekeeping: Add clocksource read_snapshot() 
method and hw_cycles to snapshot") provided a way for clocksources like
kvmclock and Hyper-V to expose the underlying hardware counter value
from which their clock reading is calculated.

This is useful for consumers like the KVM masterclock (when hosting
nested guests), and vmclock which needs the hardware counter value to
calculate time according to the information it's given.

Now that Thomas has beaten my initial proof of concept¹ into shape and
merged it (thanks) here are the two providers and the trivial consumer
case in the vmclock driver, reworked accordingly.

I will rework the other four KVM master clock patches into my kvmclock 
series² which I'll rebase on top of tip/timers/ptp in due course.

¹ https://lore.kernel.org/all/20260526230635.136914-1-dwmw2@infradead.org/#r
² https://lore.kernel.org/all/20260509224824.3264567-1-dwmw2@infradead.org/

David Woodhouse (3):
      clocksource/hyperv: Implement read_snapshot() for TSC page clocksource
      x86/kvmclock: Implement read_snapshot() for kvmclock clocksource
      ptp: vmclock: Use hw_cycles from snapshot for precise TSC pairing

 arch/x86/kernel/kvmclock.c         | 36 +++++++++++++++++++++++++++++-------
 drivers/clocksource/hyperv_timer.c | 37 +++++++++++++++++++++++++++----------
 drivers/ptp/ptp_vmclock.c          |  4 ++++
 3 files changed, 60 insertions(+), 17 deletions(-)

base-commit: ca1ec8bfac8c95d0fed9e3611ea21400d1f37262



Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E2E7421227
	for <linux-hyperv@vger.kernel.org>; Wed,  5 Aug 2026 21:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785963884; cv=none; b=XhIq8NcOP8qpwCNV4n8H6mub3WacU2BnX/XfHS/qrmrhL/gt3cYJ1HuZI6wlWjvhAa6veGrcI1d1RH2Jb10kTV7qpyp45MQJ4GBTcI3QaP6gf/dW2ZATICcKc/BEU1vHwQSdkE4FsW4xe5aZBstonzmnQmtqgX6MbEigwSG5cPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785963884; c=relaxed/simple;
	bh=sDvqGyNIEvM9lUuv/GeWYH5Y4rdSyHYZkCQ/WqQVjw0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=V58GoKdqCp9UNj7WGdtF0JCGJhBsTLjJfNesOnspitGxpMyCwfhcXaiTT/Acf6hPYFwsMzIJ7hWYiceDnJEIqXV3zibn+LV5Fv6jSGHlnY73aq/CZYrLrCuoDyB20xVPrJ9aVrXLWXGm+PSfdyVAQWFiCahiXDM9TR4lIfxGBVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nkQ/zGvF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nkQ/zGvF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F20F1F00A3A;
	Wed,  5 Aug 2026 21:04:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785963882;
	bh=sDvqGyNIEvM9lUuv/GeWYH5Y4rdSyHYZkCQ/WqQVjw0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nkQ/zGvF65NCUFqWpACoFKBycIfSWyAABmAGv5Rz7E8/+FLDRQ9jOqgQFPbso46PX
	 F8VhqAV+tV9JT6mupscZyG38uSPhs2jf0w3Z7NU0oa6hhOecBqskP1HEMwXJ3vEzv5
	 YMNnP4+/eGIq7R0SbSVrskntkjf0W+3uAweFUFu9qom2d1tuVXiJnRGOz0pm9S9uC/
	 ArZuo0+1S+MrwJNdsNULqob6JV1Zxe2BshCeLT7QVakV429WpUy2AMlB6j2HnaJ15V
	 xahkoCgaB2xp65yDvFx3ZB/GsO5Vbe9VEqHLyfqRp8y3LS2gcdfGRlcnF9NynrQYwA
	 1mxCTYEvpMtWA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 6/6] clocksource: hyper-v: Remove support for stimer
 interrupts in message mode
Reply-To: sashiko-reviews@lists.linux.dev
To: "Michael Kelley" <mhkelley58@gmail.com>
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <20260805203751.2678-7-mhklinux@outlook.com>
References: <20260805203751.2678-1-mhklinux@outlook.com>
 <20260805203751.2678-7-mhklinux@outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 05 Aug 2026 21:04:41 +0000
Message-Id: <20260805210442.9F20F1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Use-After-Free of per-CPU clockevent devices during module unload =
or kexec.
--

--- Patch [6]: [PATCH v2 6/6] clocksource: hyper-v: Remove support for stim=
er interrupts in message mode ---
Note: The format of this report is altered and does not contain diff quotes=
 due to recitation restrictions.

commit d696e5fb31caa79d07059889453363cd5e4a9522
Author: Michael Kelley <mhkelley58@gmail.com>

clocksource: hyper-v: Remove support for stimer interrupts in message mode

This commit removes the legacy message-based delivery mechanism for Hyper-V
synthetic timers, making Direct Mode the only supported mechanism. The VMBus
driver no longer processes stimer interrupts, decoupling the two subsystems.

[Severity: High]
This is a pre-existing issue, but by removing the legacy teardown path, we
might be unconditionally exposing a use-after-free during module unload or
kexec.

Looking at hv_stimer_cleanup() in drivers/clocksource/hyperv_timer.c, the
code intentionally skips calling clockevents_unbind_device(), leaving the
clockevents registered in the core subsystem's linked list.

Then, in hv_stimer_global_cleanup() in the same file, the code unconditiona=
lly
frees the active hv_clock_event per-CPU memory via free_percpu(hv_clock_eve=
nt)
while the structures are still registered in the clockevents core.

Can this result in dangling pointers in the core timekeeping lists? When the
hv_vmbus module is unloaded (vmbus_exit) or during a kexec,=20
hv_stimer_global_cleanup() uses cpuhp_remove_state() to stop the timers. Th=
is
invokes hv_stimer_cleanup() on all online CPUs, which fails to unbind the
devices, and then the structures are freed.

Any subsequent traversal of the clockevent_devices list (such as servicing a
tick, reading /proc/timer_list, or adding another timer) could dereference
this freed memory. Should clockevents_unbind_device() be called before we f=
ree
the percpu data?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260805203751.2678=
-1-mhklinux@outlook.com?part=3D6

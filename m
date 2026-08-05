Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01D483D6472
	for <linux-hyperv@vger.kernel.org>; Wed,  5 Aug 2026 20:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785963488; cv=none; b=QUeRuGvR8XJXD9gM182VlBfFt6qH9jpABH42FnCgHEii+Bgw99EESJlMuAI6XwpzSa/4Mlmk0nlHx/HSuGgZmGYehu+18Ogm+qv6n6JZNkw8rzgtIYO59xCsjLiCsZeAeXhHrIRWzt1DCZzrHUieEeSaOsWOZu1o+SOOkeRK3Dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785963488; c=relaxed/simple;
	bh=3nhthdifwM+vBQcXvGR8ACMzzd9En9LO13ApRVHBjbs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hAh6rubisCu+6LC6v3OvFMAOZDrarODr+gPODzyjB6J1i+UBxM3RfJiraM7lIYeAH5cttxx+61hX/htJwuBtef39L10O1q+UTLvSicapuaroLYQWe/91F7yTr4ZWSAqOTa7hv6v4Qlw4ViuUvfDFUvApWAux1mcIpoWEwoJJl7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bmPTVxXS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bmPTVxXS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5AC31F000E9;
	Wed,  5 Aug 2026 20:58:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785963486;
	bh=3nhthdifwM+vBQcXvGR8ACMzzd9En9LO13ApRVHBjbs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bmPTVxXSYaOuLXTkD5VyhsJ+W6obbF6vO7VJ4FTa7b4lWYOFAnXx9TnuIFahfDjiJ
	 cB6e33FKGcXSMF1LPcBLiZPPLDYm56Ujgxd8qD3F8q2E1MMd20Az9ydZWeMg/uNour
	 sSHTYJu45m/F42OGM1Yuh+BVMpgzoUoPW8kuIzMpJNekpFVMPq8vOwq7uVn/sUpRjy
	 NuPTzwtPGrZwBNnPPtBQoyJUxIn6zTZxPs2Gr97zqUKS8RB7DhAWR9Cezinz07i1LY
	 c/C+6W/Ad8rkIkr6smqQ5XkeQcl7DCDVHtStE4p8FRGUbkWOVrPEujy9mLWSpJzU9I
	 3eRf8w0TrPNKw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/6] Drivers: hv: Remove support for WS2012/2012R2 &
 Win8/8.1 version of Hyper-V
Reply-To: sashiko-reviews@lists.linux.dev
To: "Michael Kelley" <mhkelley58@gmail.com>
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <20260805203751.2678-2-mhklinux@outlook.com>
References: <20260805203751.2678-1-mhklinux@outlook.com>
 <20260805203751.2678-2-mhklinux@outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 05 Aug 2026 20:58:06 +0000
Message-Id: <20260805205806.B5AC31F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

New issues:
- [Low] Unreachable version negotiation fallback logic left in hv_balloon.c.
- [Low] Embedded newline and multi-line string literal continuation breaks =
kernel log formatting.
- [Low] The patch series missed removing legacy VMBus version checks for VE=
RSION_WIN8 and VERSION_WIN8_1 in other Hyper-V subsystem drivers.

Pre-existing issues:
- [High] The error path in vmbus_connect() and vmbus_exit() bypasses sendin=
g the VMBus disconnect message, risking guest memory corruption.
- [High] The error paths in balloon_probe() and balloon_resume() fail to ca=
ncel scheduled work items, leading to use-after-free.
--

--- Patch [1]: [PATCH v2 1/6] Drivers: hv: Remove support for WS2012/2012R2=
 & Win8/8.1 version of Hyper-V ---
commit 764adf4bdf08e43be943c35b8558657a532f1362
Author: Michael Kelley <mhkelley58@gmail.com>
Subject: Drivers: hv: Remove support for WS2012/2012R2 & Win8/8.1 version o=
f Hyper-V

This commit simplifies Linux code by removing special cases and VMBus
protocol version negotiations for running on older versions of Hyper-V
(WS2012/2012R2 and Windows 8/8.1), as their official support ended.

Note: The format of this report is altered due to recitation restrictions.
The original patch code is not quoted directly, but rather a free-form summ=
ary
of the issues is provided without inline quoting.

[Severity: Low]
In drivers/hv/hv_balloon.c, within the version_resp() function, the patch
hardcodes dm->next_version to 0. Is it necessary to leave the check "if
(dm->next_version =3D=3D 0) goto version_error;" and the subsequent version
request packet sending logic intact? Since the downgrade path is removed, t=
his
makes the remainder of the function mathematically unreachable dead code.

[Severity: Low]
In drivers/hv/connection.c, within the vmbus_connect() function, the patch
adds a pr_err() call for unsupported VMBus versions. Does the embedded
newline and multi-line string literal continuation break kernel log
formatting? This can cause the second line to lack a severity prefix and
interleave with other logs.

[Severity: High]
This is a pre-existing issue, but in drivers/hv/connection.c during the
vmbus_connect() error path (cleanup label), the vmbus_connection.conn_state
is explicitly set to DISCONNECTED before calling vmbus_disconnect().=20

In drivers/hv/channel_mgmt.c:vmbus_initiate_unload(), the code returns early
if the old state is DISCONNECTED or CONNECTING, thereby skipping the vital
UNLOAD message.

Can this bypass of the VMBus disconnect message cause guest memory corrupti=
on?
Since vmbus_disconnect() frees int_page and monitor_pages without the host
being notified of the teardown, the host might continue to DMA incoming
messages to these freed guest physical pages.

[Severity: High]
This is a pre-existing issue, but in drivers/hv/hv_balloon.c:balloon_probe(=
),
if the kthread_run() fails, the probe function jumps to the probe_error lab=
el.
This cleans up the VMBus channel but fails to call cancel_work_sync().=20

Since the host can send a DM_BALLOON_REQUEST which queues balloon_wrk right
after balloon_connect_vsp() finishes, can these orphaned background work
items execute later and dereference the freed device, leading to a
use-after-free?

[Severity: Low]
The patch series removed legacy VMBus version checks in the core, but did it
miss removing them in other Hyper-V subsystem drivers?=20

Drivers like drivers/gpu/drm/hyperv/hyperv_drm_proto.c (in
hv_drm_connect_vsp()) and drivers/scsi/storvsc_drv.c (in
storvsc_sdev_configure()) still contain switch cases for VERSION_WIN8 and
VERSION_WIN8_1 (or VMSTOR_PROTO_VERSION_WIN8). Since vmbus_connect() now
rejects hosts not supporting at least VERSION_WIN10, isn't this leftover
dead code?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260805203751.2678=
-1-mhklinux@outlook.com?part=3D1

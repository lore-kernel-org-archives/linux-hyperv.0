Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 960D53CF213;
	Mon, 14 Sep 2026 10:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789383368; cv=none; b=T16vUisKZw8ohvBjJSJsNQqJTy+frPQVtqPLo5Ow9hGxKP5McGHlwl2s1mmOw+BlHgUHMwifTXZK/y43a4Nlwx+Cyq4ZBX5ytn1KWytvU5xlFRPNfL+Gmho9bK6TbDynFqZyDIlKNVyITNmAD4NoONBs9soo2UQCguDaC8TPGuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789383368; c=relaxed/simple;
	bh=Gai0pBSLTGfFJcKoEexFk/LR7HNghtXwRSCetz3W8yk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=LHz/TbuiY7y3RAa6pEGqOgRfqqYKmPukhc/a0VVzOT5Idw9JoclZ7/YslM5z+lZ5Tdj0SU+5xttqCoVQt90VuBxh8nePVMMJ48FwWs0miB0u9uSlGDFmoBTL8FecG3s/hblrMNc/1ACcBTeY+CBcVXMjpn/n6hj1XcFQV5Txhbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nvQfm+iL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nvQfm+iL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92A041F000FF;
	Mon, 14 Sep 2026 10:56:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789383365;
	bh=Gai0pBSLTGfFJcKoEexFk/LR7HNghtXwRSCetz3W8yk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nvQfm+iLMn3Thcsqm1EeTSDMyDsIUiA5U18LlIe4Rld+sBHmF9K/LkWTeGNQfZrUh
	 dszlS+VGjoAhLK5B9kBLqN7/r9R84Z6V5SspYjiBuO4+qi9FLyYQATf33etpzIyAbl
	 3nONYbYagWWPccn+U/0re7I9OaUf9m8yKid8aYx0Rj2TcG2gz4I2JI+I6/mdeEFzLR
	 nOsSehnMxPqg9apN1NPFQ0ciTNk+WfBkaiXRRRg7RqL7V8FLG9wshsggJ/fuOC8cu/
	 Ep7VPoMww0Nzv0StS0lhgw7bubDjeidZfg/M2KBhj0QmwqmITXo6WDdUJCLvYDjSh1
	 C2Uq4jj1TWFbg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4] PCI: hv: Warn when wait_for_response() waits
 indefinitely
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sahil Chandna" <sahilchandna@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260914103918.3125157-1-sahilchandna@linux.microsoft.com>
References: <20260914103918.3125157-1-sahilchandna@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 10:56:05 +0000
Message-Id: <20260914105605.92A041F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

> A guest can wait indefinitely in wait_for_response() for the host to
> send either a rescind message or a packet completion. If the
> host does not send either, the guest can remain blocked with no
> diagnostic indicating a reason.
> This was observed during a guest kernel upgrade in which the
> host-side application handling the PCI channel faulted, causing the
> guest to never receive the completion request.
> Add a warning in wait_for_response() when the wait exceeds
> a timeout so that such a hang is visible in the guest's kernel log
> and can be correlated with host-side state.
>=20
> Suggested-by: Michael Kelley <mhklinux@outlook.com>
> Reviewed-by: Naman Jain <namjain@linux.microsoft.com>
> Signed-off-by: Sahil Chandna <sahilchandna@linux.microsoft.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260914103918.3125=
157-1-sahilchandna@linux.microsoft.com?part=3D1


Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DE0E3D5C32;
	Tue, 29 Sep 2026 04:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790655259; cv=none; b=MaNufBqQEMyrcNwUC07V3WW9V7pri0nfoiIF4ra0FshWl/Eki+1hjN1yDBPbNesHx+oZc/TPTecCeMki2y9kCX9LYKix2Jq0LltXbAy2j+oArEnXVmnJ/sE5Ur1X/ZxLI7/R9qCevGAej1IYISvaJGl5hDneuRbNn8Qd18cJlmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790655259; c=relaxed/simple;
	bh=5EJI8NxuX4C1BMUUFoPGHEjI1J5shQ7/yAS92vm4qCw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=m6Hf5ckhBZ3IGlbuvNXMjL6zRtiK2RUjfmR3RkWIMS/PdEBxYOpSPzameroD9z7ZBd+Vg7J6W5v94RfZ3n2M2N1zXFXdoy1uuck32DoBaehQ6GKOWQryEJiqcafvBoqfhUlS+oXiEKEqa4JCTk2jDEc//6ewS8wKkx+QT+PG8bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MUAK0wvZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MUAK0wvZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D1421F000FF;
	Tue, 29 Sep 2026 04:14:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790655257;
	bh=5EJI8NxuX4C1BMUUFoPGHEjI1J5shQ7/yAS92vm4qCw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MUAK0wvZol7TEFk4Q5ncP8rqTdD9eYBfI+8cQAK4JYpvHqfQnMvcg0bTRsxyO+TG/
	 v2kPf5nMQesSrgadvKaaMyy0gHh9+nqQI8EVEegMoPcA1qLnLfwTr6n9Fpy+gYS/rO
	 dtXkpKq8mChD086IZJs/dpi1iF/AivkRbqqgx7ZFIYeiosBx67Ga3IyGAnwYZ3n097
	 LGiQI+A+ayWs9Dz2l2YMa07hwxAzOCVi7O0qZmqYdx2zgmBTQBbx7oYJnoOB/Bg/YI
	 PcYl/0mepTOAI1Aoc+RDL8itQyYMqJH3gvUVJEc/BuVzoA41wFnze3JGy+/kSy3czF
	 PkYapQMN9KaNw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 6/6] x86/percpu: Share decrypted storage before guest
 CPU setup
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zack Rusin" <zack.rusin@broadcom.com>
Cc: "Eugenio Perez" <eperezma@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, kvm@vger.kernel.org, virtualization@lists.linux.dev, linux-hyperv@vger.kernel.org
In-Reply-To: <20260929040256.543767-7-zack.rusin@broadcom.com>
References: <20260929040256.543767-1-zack.rusin@broadcom.com>
 <20260929040256.543767-7-zack.rusin@broadcom.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Sep 2026 04:14:17 +0000
Message-Id: <20260929041417.7D1421F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

> Convert every possible CPU's decrypted section after per-CPU setup and
> before the boot CPU registers its buffers. This replaces KVM's object
> loop and shares VMware steal-time storage without a driver conversion
> path or readiness state.
>=20
> UP KVM registers inside setup_arch(), so convert before guest_late_init()
> there and move VMware's UP registration to that hook. Stop boot on a
> conversion failure: inconsistent page state must not be published to the
> hypervisor. Host SME keeps its existing mappings. Skip Hyper-V vTOM
> per-CPU storage: its visibility callbacks require later Hyper-V
> initialization.
>=20
> Suggested-by: Kiryl Shutsemau <kas@kernel.org>
> Link: https://lore.kernel.org/r/aqqGUAX65s4LdJkr@thinkstation
> Link: https://lore.kernel.org/r/aqvxQoIoYhJTZpAC@thinkstation
> Signed-off-by: Zack Rusin <zack.rusin@broadcom.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260929040256.5437=
67-1-zack.rusin@broadcom.com?part=3D6


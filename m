Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3552483BC6;
	Fri,  9 Oct 2026 10:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791541739; cv=none; b=iiOPNBRKVcqJLNCecvUCpb/8yePfBcsUr04lvM1XcxMVDOvUF8hUNH5L2UDQeARykuI1fFXnrA8hQaDeC+h52XfXBSYY07cZ9gmplDA5icyQStiCyI0d1OCrsQWMx5YYwhLLDDkmT6LKA33g/6cJktC8tEVD5sODwblWtnqBs58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791541739; c=relaxed/simple;
	bh=DK3/VZRkg9keQfDe/R52sricG0gQd0N7igHwZJUZjCc=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=ALL1uMO0OPwIqodONPbElYA04MJeTJyVcp7qqW1JlYyKLQQVkSd9Hx4XPphmnfgD4+TDOV3oGM8sGJ4YYGsZj1R6ZNeKRZgYPyjtvn/CqZ7oB5s7Lq2EVsLbW7JTb4VQTfyoahnT5B0uGK6Wdt5Og4hCjIwx0rZ2KZ2O2l8pfbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=omOk7SM4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="omOk7SM4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3515E1F000FF;
	Fri,  9 Oct 2026 10:28:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791541738;
	bh=DK3/VZRkg9keQfDe/R52sricG0gQd0N7igHwZJUZjCc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=omOk7SM4pteaQL3ytjlOMStKEP8y5BJpwnOgjK0TU1iMRq45r0o96UXOMicaN7vgj
	 RvguW/WX9Zw+EylgjqBLro15OZlgHso+0eVAPeE6v/dd0CY52lhca4GzDEUZTquQdm
	 Ty1uYuaO/T0cQi2/OlBcXtEIDJnGC4Owl8fZXXV8x0HGk7LyfH330jruzK6dibFL+G
	 wFXYMU7TmiYwyRz3De/nu8hsCVHl4oXA8XzGdFSBSg0IkkzvzEYZwGtPXpgAaLZrb2
	 mdfQaF2LhBOl3A4y9MU5HJ+Vkh7tZ53li7BVJWkdBbSV/70GsRIfe+bILB6so/1Ha6
	 1F+AKIjEKGU0g==
Message-ID: <sashiko-outbox-165237@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 1/2] kexec: Add helper to report an active kexec
 reboot
Reply-To: sashiko-reviews@lists.linux.dev
To: baoquan.he@linux.dev, "Shradha Gupta" <shradhagupta@linux.microsoft.com>, wei.liu@kernel.org, catalin.marinas@arm.com, mhklinux@outlook.com
Cc: mark.rutland@arm.com, x86@kernel.org, decui@microsoft.com, maz@kernel.org, tglx@kernel.org, hpa@zytor.com, linux-arch@vger.kernel.org, dave.hansen@linux.intel.com, kees@kernel.org, broonie@kernel.org, longli@microsoft.com, rppt@kernel.org, kys@microsoft.com, bp@alien8.de, linux-arm-kernel@lists.infradead.org, kexec@lists.infradead.org, haiyangz@microsoft.com, akpm@linux-foundation.org, linux-kernel@vger.kernel.org, mingo@redhat.com, linux-hyperv@vger.kernel.org, brads@mainlining.org, will@kernel.org, pratyush@kernel.org, namjain@linux.microsoft.com, pasha.tatashin@soleen.com, arnd@arndb.de
In-Reply-To: <20261009102236.3361019-1-shradhagupta@linux.microsoft.com>
References: <20261009102215.3360863-1-shradhagupta@linux.microsoft.com>
 <20261009102236.3361019-1-shradhagupta@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 09 Oct 2026 10:28:56 +0000
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

> A shutdown callback in a loadable module may need to distinguish a
> kexec reboot from a normal restart, halt, or poweroff. The Hyper-V
> VMBus driver needs this distinction when moving its kexec cleanup into
> a common syscore shutdown callback.
>=20
> Add kexec_is_in_progress() and export it to GPL modules so the callback
> can remain guarded when VMBus is built as a module. Provide a false
> inline implementation when CONFIG_KEXEC_CORE is disabled.
>=20
> The helper reports only the normal kexec reboot path. Crash kexec and
> preserve-context kexec do not set this state.
>=20
> Signed-off-by: Shradha Gupta <shradhagupta@linux.microsoft.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261009102215.3360=
863-1-shradhagupta@linux.microsoft.com?part=3D1


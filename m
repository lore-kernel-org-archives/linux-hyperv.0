Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C8D04DDB31
	for <linux-hyperv@vger.kernel.org>; Mon, 12 Oct 2026 19:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791833721; cv=pass; b=XmWD1/p3p+24R6x2ACkayOcwum1QU49UJokajwmyVrohFbdF6OqhJ9jTIKYwN228KzT75R9xb/PcKXfjh7PXem2un2zI4I4h4EfNyc0RdXpgLGUE4oBGYQF8aFetEgBk/ycys11GR5TfpqqzFab3loIhV593lCuQPEYfd+F88IA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791833721; c=relaxed/simple;
	bh=Q2gByPfWahclPjbop9vviwP/KgBIaaxiAHSDaN+U72w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VuFAS+HSUlgriyeeJ1R6Z7NoQj5dl9Hmh5w+8RO+gO66MqtOe5JEhY6Bb1CsWQ6/iWff4/7UE3mpUfZTgJ7Yijuu3jrpimQIVb7iyVRuaH0CoY+jj5JNlkq/ta+wpEMZ2OjzaoNbQDfB3xPJ8cahnFZvM27r69uqeRhVIFmortg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GSqaeCKY; arc=pass smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GSqaeCKY"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6b1aa36fc0eso14542a12.0
        for <linux-hyperv@vger.kernel.org>; Mon, 12 Oct 2026 12:35:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791833718; cv=none;
        d=google.com; s=arc-20260327;
        b=W6PJQq4IWGlymVKBI/kqYxNZKeJ60BP2wBOz8ZMpS0evimy3PxNVndNsHEHNxHl2Q9
         t299VC+W7gB6kpKUxaHcUKfs2gBWHe2LeAbZgyNAQxHQqE7JLJX700c+9RjhRoG2LGxe
         +x80H23ctrQy3qxAnmh/URDqSmSzOGveduNq0heO1v+fnxWQvKOSMdXowi8Gxz0qdR8x
         dynTTESCmx/EKeIzSHrqSJkvem/VmPoGabImcZe4z8GmTEv9RHVxC5rNEjd5to9PiXbM
         +FGlk/BzlI2+Ya1V9c2D0OjTa8FEAXHgGYP1x5qxBi7mTfEtz72dIcgw2Z6FXpXr5zpW
         kAXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Q2gByPfWahclPjbop9vviwP/KgBIaaxiAHSDaN+U72w=;
        fh=eVJ5n2BiPPkKQOEG4py+p84nUipxNUIE+ODFq6RWEbc=;
        b=CYWpfpsrZB5sa/lVg5Qm4p4qkq9KaFs8VqrEXEHj9yDA1XQhcFZhWYO8OdYTuuzklf
         TzqZr1p16INF2y9AP92nDdr/bHRAvUzTmt3TcVU7005RtfpAVSrgCWHmFJLTIwcAo3ba
         YAgsM6ch/IGyMNGjfjPIlTqaExXGPO/4g39Qw0rhrOFfYqG+1qoedOMnKMZ+H3xl7cKR
         KAHcRZXbnI7eODeBn/tdpe6hZiYD/IrBPN0K2QxKbuW1oRskn/U3Say950RwGR5dpVtn
         7fmj7sNPMk78s9Mtu/fC0RWvPR66HAnEEV77T/6IEkkBskIGvo2R72WURrzQdDhOmBca
         g86g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791833718; x=1792438518; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Q2gByPfWahclPjbop9vviwP/KgBIaaxiAHSDaN+U72w=;
        b=GSqaeCKY/9TzSRh7ATo2ktqIG+SB4FahBcEtVrFT2+NHoKSllhmAkPXk5zDI4MQom/
         stPtqQCA6tmvMH4QFoHU3ZhDZZH3h4A5r7WrPL4UOaE4TN4r2xq5Ri6bxaU61VV5r6+h
         xh8nqXJiYArog9fonAg00llrNgObiERpe/QLkrpiY6tqynZglHcPAFwvMe5TNfVNLrwH
         DIawgGZn5t6xCz2B+Unxv0W1qwMCH7BT//LcVprF10YImKkcNFcvf/Ax+llS8LyMP09z
         Meh+m9OtrcmPM4EilrILO+9YFo0N3yKvLvpZwac8PXzOKl+BO+KdRXVJ5LQo66ezp+NN
         DXdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791833718; x=1792438518;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Q2gByPfWahclPjbop9vviwP/KgBIaaxiAHSDaN+U72w=;
        b=o1RO6ZKH7zuC+kVc46ye/toaA22rj07Vf9B7mRkdSVh/KERZvb3Hsq5Wtd72rtdOwk
         FFuLb3cyGhC+JGzKIwKgmq/h2oH9DV4anGw3jAdEwnip5b7ZuwXio+TT7cTgtaN3ra2r
         K+DfXy8wdIeB2QQKJ4JM1LRo82piDPBefrMDQCXONpjzOHfghnsW7CwOn8ZeMgGoqp18
         HJEjfFmHBkLXGQda1bYABMDaiiSWLwzSdc6QR3T6cYeZv3RwF9PH2hY+k/wir6vLCEbz
         bLGkNuPGtDmfTdW2LUWiwvuc+tVayhugEfLXujtbQRXdd1rbMVpnu4JIp5iEYoL6KwII
         xfug==
X-Forwarded-Encrypted: i=1; AKwUvBzg0idnr+q6UIyuSzdVjNvxKsBUOJvfideFcvtQRK+iFBjB0WJXQHjBPVtAhTQYz9Z5VdJvd2Sw6+GTA70=@vger.kernel.org
X-Gm-Message-State: AFq9FYIlNQi/xq2x+ltJpgi9d42mS377Vyk9zNKUBd53QCeXsypAPYKM
	tQJsWu3kWblHyfHM7RWE1X7ktN04Et2zLzhUedSSYyUrSqtTdiAx9/o/+hNNK3HE7QiJ/SvJcPC
	+DzOFO+3Y0UjW978Oupvs3GmOf1xJH3ocHYFsPmF+
X-Gm-Gg: AYBFou1gh8NadTIUBpmoR9qxVTWSu57ib75cgkLbXCJ2DNGeMHuvnhkuwjh0hd2VngC
	hEcNFH/10rpfMPX472ahOxNKecNNPw8eXsdyZIsEwNMCGS09rR/G5QLQBYPsewXZRPFjMn4U0V+
	R/lUE4viZDCCUjPOYKz1idsEqRZmBQd1nwd6hfOkPPuZAvwmBBIcHkVwVXRwc6rl8RsuKF1441P
	G4SZn3kRXPUxHB7Mwk+Oibo9Xxxv9ritblq/kJ+nYR9pVpG0xuFyZKVlkPnGi5nIzYz7DL2hFpA
	vgvfVE6R239+9N0k53MIVyl0jTRLv+HUaMWB3+wHpfQQ5glYtYX6NLo=
X-Received: by 2002:a05:6402:4610:20b0:6a6:9d10:f52b with SMTP id
 4fb4d7f45d1cf-6b199a0b183mr87198a12.12.1791833717701; Mon, 12 Oct 2026
 12:35:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261005192431.87317-1-hmushi@amazon.co.uk> <20261005192431.87317-3-hmushi@amazon.co.uk>
In-Reply-To: <20261005192431.87317-3-hmushi@amazon.co.uk>
From: Jim Mattson <jmattson@google.com>
Date: Mon, 12 Oct 2026 12:35:04 -0700
X-Gm-Features: AclHuK-NdKkEgB-ivjRQq65tvY0OhAcQTfcWgQ3NHF0TSHe_XuBq-mhBC7CYfcM
Message-ID: <CALMp9eQ7U2j-GJn3Cmy6US5NUi-aBkjk98s-se+hJRMZ8VAL2g@mail.gmail.com>
Subject: Re: [PATCH 2/3] KVM: x86: Extract __kvm_set_clock() from kvm_vm_ioctl_set_clock()
To: Mushahid Hussain <hmushi@amazon.co.uk>
Cc: kvm@vger.kernel.org, Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	"K . Y . Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>, linux-hyperv@vger.kernel.org, 
	linux-kernel@vger.kernel.org, nh-open-source@amazon.com, mushi.shar@gmail.com, 
	Todd Frederick <tfred@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 5, 2026 at 12:25=E2=80=AFPM Mushahid Hussain <hmushi@amazon.co.=
uk> wrote:
>
> Move the body of KVM_SET_CLOCK into __kvm_set_clock() and leave the
> copy from userspace and the flags check in the ioctl handler. A
> following patch steps kvmclock from inside KVM and needs the worker.
>
> No functional change intended.
>
> Assisted-by: Claude:claude-fable-5.1
> Signed-off-by: Mushahid Hussain <hmushi@amazon.co.uk>
Reviewed-by: Jim Mattson <jmattson@google.com>

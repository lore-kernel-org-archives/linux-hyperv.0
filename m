Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6751136A37B
	for <linux-hyperv@vger.kernel.org>; Mon, 28 Sep 2026 18:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790619564; cv=none; b=mW1VvjsvQeUdZ9QODBy9zopJSuChJdTJe8TIcgmS19ljNfL4LqqGyFBoIlXof8Ps3/hcgPB6U+ks++2PpkOAsP3Dy0p86nVTnlmmlSWwi6MaJF73lTlRrsVH9eX4Cx5ZyB4IFdcAQUIun6s67ikvuIyz8g93XOGD+rQrcOpUCSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790619564; c=relaxed/simple;
	bh=XsCb/1wYBwtWgfl2wTDX4hMMs6EhaI7tcx3nu9Rxru8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rhPeldoY3TCc+jXh/HWTzviH/f6F4sbM+3yFkZdtOlP8hhHnHSh1JQYm4Cw1zGscVc5C87YodQ6JejF2IzysvdRWJCmFe7l+fqMq0Oj/aBmc4xgtdcy7YIix3qh/BXf7QNaW5N6Oat6e9zlD4uGXCMTbvg4vTIu+luu4HrXUrFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KyQd02Yg; arc=none smtp.client-ip=209.85.214.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KyQd02Yg"
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2db3d832827so38984795ad.2
        for <linux-hyperv@vger.kernel.org>; Mon, 28 Sep 2026 11:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790619563; x=1791224363; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Mq+zT7TlYlSrRa6VHL2crDPLB8rmFnZ6Km6oi1RUCxQ=;
        b=KyQd02YgDhQERi4525T5uoU6AcvCJ0ZblVxrlgn6BWCDh4COrJCMV2AjSR1jWwVVhy
         AawMYp2hA/s151+Hq8NEm4BvSrhjQR0+hZgg7am7nZ2N0PWIc3uQENzW/jhULL1Nf7Xz
         NnTGAmk7RJA/QzFp4g0zf/SgSXMJ0SzhWWvuZ3b3KbtJs7m+/YIanKHDMzsQ9YRBTiRf
         jd1Igarg0eh9/M9249jkTd0hzJXB2zGRt/aMAeHx4fZxgCoKx3MAaU8gpW2ksEDXfkRL
         zj/LmAfigRqmbxjbX7oFaQUUi3ygl28PLoMYuRxwEeMDjKH5NfWKonDXNHe0KU2Qso4b
         9ycg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790619563; x=1791224363;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Mq+zT7TlYlSrRa6VHL2crDPLB8rmFnZ6Km6oi1RUCxQ=;
        b=T2UGM7QmV+B7OF76+C9SC0cCLXkHd3XJpSrkHFWIlNOvmKFfdF0kieN0F3hdIdeXGj
         FtTwO6DuEZwG4WeakdV/OvrftkiApBLH2wlQye496kARpPnInomfD0ok9MdIFPNzlDUt
         loXaAdhU2il2iD1bUL9ei5oYWCjFIDtut5I0JZ9Bu5v15HeJj4YtgQ12lOC/XL+yYy+/
         FYjLCc7Syz0yKqDilfIQPgbEdEL7heGMjigBp+W6WW4uumPMVVN7X8tZx+vE3St4XnE4
         07Q6drRjjXOYleLCKvnlu2KFY7sw1pyv4BicEnO365TN7mIt4oxVGY0ckFfzIL678kx+
         d5dg==
X-Forwarded-Encrypted: i=1; AKwUvByj1osqX2iM3m1sNw1ZzUhD8NUFoljSqd+VcLPByD6zXzEcffjr+Ml2/1KozCjaWtZD9Mz1mUFL7DcxxcE=@vger.kernel.org
X-Gm-Message-State: AFq9FYJKtpheWb/QxoJttX4DU126IErwfWGiUhloPtiMQJ8IDSU8Bssz
	YojMmy+K6iuWK4Ae4t1MlhXn18hEO3ugfywyVzRcFGZT3+EjvQkEmErZ8NjvxWkkLzS+4z4IqJI
	LsvINhg==
X-Received: from plld5.prod.google.com ([2002:a17:902:7285:b0:2df:aa58:22a])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:d60f:b0:2df:aed3:2ac0
 with SMTP id d9443c01a7336-2dfaed33785mr46039165ad.10.1790619562342; Mon, 28
 Sep 2026 11:19:22 -0700 (PDT)
Date: Mon, 28 Sep 2026 11:19:21 -0700
In-Reply-To: <20260928174243.GA3705413@liuwe-devbox-debian-v2.local>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260928-kvm-smm-cr3-upper-bits-v1-1-138f52dd531e@gmail.com>
 <20260928072534.1987-1-odys.yuan@gmail.com> <20260928174243.GA3705413@liuwe-devbox-debian-v2.local>
Message-ID: <arqvqW7g72AnVsLK@google.com>
Subject: Re: [PATCH] KVM: x86: Clear CR3[63:32] on SMM entry from long mode
From: Sean Christopherson <seanjc@google.com>
To: Wei Liu <wei.liu@kernel.org>
Cc: Qiliang Yuan <odys.yuan@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, "K. Y. Srinivasan" <kys@microsoft.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Dexuan Cui <decui@microsoft.com>, 
	Long Li <longli@microsoft.com>, linux-hyperv@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Mon, Sep 28, 2026, Wei Liu wrote:
> Hi Qiliang
> 
> On Mon, Sep 28, 2026 at 03:25:34PM +0800, Qiliang Yuan wrote:
> > +Cc Hyper-V folks and linux-hyperv, since the failure is triggered by
> > Hyper-V's handling of VMRUN for a nested (L1) hypervisor, i.e. KVM
> > running on WSL2.
> > 
> > For the Hyper-V side: the VMRUN is rejected when the guest state has
> > CR0.PG=0, EFER.LMA=0 and CR3[63:32] != 0, a combination that bare-metal
> > SVM does not reject.  Is that check intentional?  If it is not, a
> > Hyper-V fix would help older KVM versions as well; either way the patch
> > avoids creating that state in the first place.
> > 
> > The full patch is here:
> > https://lore.kernel.org/r/20260928-kvm-smm-cr3-upper-bits-v1-1-138f52dd531e@gmail.com
> 
> Please share the Windows version from `winver`.
> 
> My colleague said that it had been fixed. Maybe the change needs to be ported.

Ya, I'd much prefer to get this fixed in Hyper-V.  If we need to carry a KVM hack,
then at the very least it should be limited to when KVM detects that it's running
on Hyper-V. 

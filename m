Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=13.77.154.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793775348;
	b=nuarpRsvR4dmSDuObPMx3LTDAcOIlnXYBri3CycLvluEXHJsZ4yFl3hlbrDT6gZASRUz
	 nwAcZ5bCbRpokIGRU8LD8qZ9qN5h36VZ6/FYUhA2YWS055NrwQl8vUaa5z+mwh4B5/WV3
	 /2hcLv6NIAXX1epPDyb7WC78qkgpR/hkmyfzez5FSGDRqrXQG8HBYC+GrdDptmDXRLjA2
	 w/9ZjiVWRwiFidHWqLq2lvGmCjD5S/qcYYYInDfJPvPmRQI3rK2qAaWmxTYhTFuzGl+64
	 LckvQvPAvzh4hgkBDzMjRwXCafO4xzUP4N4CF1947mapElVC9CERZUWPlVFBs4j6Q0g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793775348;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-Spam-Status:
	 X-Spam-Checker-Version;
	bh=c6k2qUJ9gF1rzwHJ7gl52fstK0/Ilon2GwxyI9YSI3w=;
	b=eK7OY5u/cUE4fZ2LAqG2ICf7flr1BaO9ft03qz3JjLmdLe0/IRrg2LYYyytSQVgPqvC8
	 kvklXPPp/e1dqZ6l+yHYx5yNbsnHlpGRucnb2eu76x7QDxMMbBkyDD5NsyOqKjBN3FvVV
	 kz6aNLoj2+9aBzzyO7aurPK2rBgLjd20ZiI912XaamDs95MQYtZBgH8L3h6Hr0jMkhrL5
	 ELiajsObjTDbPJ1LgedQvzeqOS7VmvKme+pv9Wn1loJF9TDv6tXRy8QIcHNXctNlz3Ekb
	 aF7R3RRxAxVaB49q48xz2MTinTxZ5E3WlvckTzqP9IXn2A5okz1puMp0dfzjfhat2tA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.microsoft.com;
	spf=pass smtp.mailfrom=linux.microsoft.com;
	dkim=pass header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b="IHmV/fD+";
	arc=none smtp.remote-ip=13.77.154.182
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34061606A338;
	Wed,  4 Nov 2026 06:55:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 34061606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=IHmV/fD+
Received: from fedora.hsd1.wa.comcast.net (unknown [52.148.171.5])
	by linux.microsoft.com (Postfix) with ESMTPSA id DDC1420B7167;
	Tue,  3 Nov 2026 22:55:25 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com DDC1420B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1793775326;
	bh=c6k2qUJ9gF1rzwHJ7gl52fstK0/Ilon2GwxyI9YSI3w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IHmV/fD+oya8ZMjsh5MqpvPpWdpcX7XqPMfjGsr2WmN0N0SbNvUtEANUd2xXfvAZd
	 s0PmgUm2a7Vkb8Y54BXQajp6txMuP4mWhVbq4H9ziMhio9uSjd7gxLeEtyApPUzAAV
	 LcRQYU3YU/igvpIl/GBhpzKNFifblVE+o+5AP2DQ=
From: Sriram Nambakam <snambakam@linux.microsoft.com>
To: dwmw2@infradead.org
Cc: kvm@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	seanjc@google.com,
	pbonzini@redhat.com
Subject: Re: [RFC PATCH 23/55] WIP: userspace VTL interrupt entry and register intercepts
Date: Tue,  3 Nov 2026 22:55:39 -0800
Message-ID: <20261104065539.15281-1-snambakam@linux.microsoft.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261017122501.610248-24-dwmw2@infradead.org>
References: <20261017122501.610248-1-dwmw2@infradead.org> <20261017122501.610248-24-dwmw2@infradead.org>
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

Hi David,

I hit a Windows VBS boot failure involving hv_divert_dt_write() when OVMF
was executing in SMM.

The helper was diverting firmware descriptor-table writes into the VTL
register-intercept path. The failure trace showed a reflected #GP being
delivered in an SMM context with IDT base and limit both zero, followed
by a triple fault and guest reset.

Excluding SMM from this helper lets those firmware descriptor-table
updates proceed normally, without changing interception for ordinary
VTL0 execution:

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -5884,7 +5884,7 @@ static bool hv_divert_dt_write(struct x86_emulate_ctxt *ctxt, u32 hv_reg,
 	struct kvm_vcpu_hv *hv_vcpu = to_hv_vcpu(vcpu);
 
 	if (!hv_vcpu || vcpu->plane_level || is_guest_mode(vcpu) ||
-	    !(hv_vcpu->reg_intercept_control & ctl_bit))
+	    is_smm(vcpu) || !(hv_vcpu->reg_intercept_control & ctl_bit))
 		return false;
 
 	hv_vcpu->reg_intercept.reg = hv_reg;

The context above includes the is_guest_mode() check added later in the
series by patch 50.

With this and the accompanying integration/QEMU fixes, msinfo32 reports
VBS running. This was an integrated v7.3-based tree, not a test of patch
23 in isolation.

Thanks,
Sriram

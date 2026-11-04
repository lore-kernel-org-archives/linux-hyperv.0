Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=13.77.154.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793775349;
	b=B1dW9ADoMjZqJmUIhiARFGwa/tXEqdfe6VXocbr3XwqEoraw3e7FkDygVBxnWnEHoOO8
	 8RWmHdfGr9I5AvWTn5zZx2rU18xoj9Nqcw9h7REIXFjNnI/SqbFtCF5dKfg6wLxo78tWO
	 aeMPJ1lAsIPqNSCev3jqic1r7z9ArRcp15r2CecgDfFRsYgrLdTVkugwvJZX/gJjD2VLv
	 PfhcRDXa9+79mVGN4+cjX2HslTLXyp5BQsFDQEUeuTsbWICC6nYFEJyut3bAzDzCOff+C
	 RWhHXtNVYFrUuGdCUx+4iedd/OlozHWQP3eviQsv1p8EQYQqDs+fR1LyUGbM8fdTDiA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793775349;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-Spam-Status:
	 X-Spam-Checker-Version;
	bh=BEvD/xIB3S8/VDyMk2AtjLPep5whW7i6aMMqlWe/lC0=;
	b=OPNTdk3zsnTd2GvTUumPm9QalDSRam+dSluoCXEPMv4QsFlbp9J/f7pEDrdcjYhS6+3z
	 gevOBHuCCVY5AVHtqJqZfRJ+Nd4A0BhaUSFm8hu4TizztR2kMAwc7XaNmgXl93YOdi1X9
	 Mg1jjIuFtkcbHF1ppUPvKVNMAoxHTxzhCXOAslMfLL0rMysGUMFsdWCZnme3Dlyz3hzWJ
	 ho+Mw5+bF4HypNbR30G9og6CyUNgCMpvsVkVZ4hlN6qjLneFH/NPdUd7LCbsUEZK+ra7F
	 duRNoan7NRqRAlmAKIGglXULmOg0nHLw1+WxS7ZbtAMVls+R5Qo959hWsU5j+pgtABw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.microsoft.com;
	spf=pass smtp.mailfrom=linux.microsoft.com;
	dkim=pass header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=kfvV5ym2;
	arc=none smtp.remote-ip=13.77.154.182
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89B52606A328;
	Wed,  4 Nov 2026 06:55:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 89B52606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=kfvV5ym2
Received: from fedora.hsd1.wa.comcast.net (unknown [52.148.171.5])
	by linux.microsoft.com (Postfix) with ESMTPSA id D7EE620B7167;
	Tue,  3 Nov 2026 22:55:33 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D7EE620B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1793775334;
	bh=BEvD/xIB3S8/VDyMk2AtjLPep5whW7i6aMMqlWe/lC0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kfvV5ym2+GUTavriv50mVziUfG/9zE3zchD3AYv4Wt6rAysL0n8vlhoPK6roO0qm/
	 kQLZuZNCr/4llTOMlF5CgJk2bFg15+2uWioHVeXTGpnxG5tEES5pX8KnCymg/sR+sC
	 DdkylmBV18VTUy7FqD4ZMRw4MaolgxfhE30Ycu0k=
From: Sriram Nambakam <snambakam@linux.microsoft.com>
To: dwmw2@infradead.org
Cc: kvm@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	joro@8bytes.org
Subject: Re: [RFC PATCH 00/55] KVM: x86: Hyper-V VSM (Virtual Trust Levels) on VM planes
Date: Tue,  3 Nov 2026 22:55:47 -0800
Message-ID: <20261104065547.15425-1-snambakam@linux.microsoft.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261017122501.610248-1-dwmw2@infradead.org>
References: <20261017122501.610248-1-dwmw2@infradead.org>
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

One fix in the associated QEMU VSM glue: vsm_glue_reset() stops plane 1
but also needs to make plane 0 runnable.

After a VTL switch, the normal-world vCPU can still be marked
userspace-stopped. Stopping only the higher plane during reset leaves
that state behind, rather than restoring the VTL0 execution path for
the fresh boot.

The functional change from my local QEMU commit is:

diff --git a/target/i386/kvm/hv-vsm-qemu.c b/target/i386/kvm/hv-vsm-qemu.c
--- a/target/i386/kvm/hv-vsm-qemu.c
+++ b/target/i386/kvm/hv-vsm-qemu.c
@@ -974,6 +974,7 @@ static void vsm_glue_reset(void *opaque)
     for (uint32_t vp = 0; vp < vsm_glue.nr_vps; vp++) {
         if (vsm_glue.plane1_vcpu_fd[vp] >= 0) {
             vsm_vcpu_set_run_state(&vsm_glue, 1, vp, false);
+            vsm_vcpu_set_run_state(&vsm_glue, 0, vp, true);
         }
     }
     qemu_mutex_unlock(&vsm_glue.lock);

I also added temporary exception-delivery diagnostics to print the SMM
state, CS selector/base, CR0, and IDT base/limit. Those exposed the
SMM/#GP failure described in my reply to kernel patch 23, but aren't
needed for the reset fix above.

Thanks,
Sriram

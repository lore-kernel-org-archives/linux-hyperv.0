Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=13.77.154.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793775350;
	b=idCKTmfyXb8TK3YmpAFL5A9IGkRVsaa79QaLD6A1ATeG/5e2INKOYaBtz6E5DtWiAh+m
	 IT/sNl5EzZkA+Omry9esmvR+bNVg1pMYsT1slurW/73axYZByvCJlMqXv2Q+Bjp3cOak6
	 LfmoO/GB+rZuK+b5mlny8UfNKcyqQsHQJ8Cf2kQCl6Rk+hedlHtGPa90ysrq9sE8olJJH
	 RPtrhJ9PkeILWHTJK1b4GnHU4VsakEr7zb9q9pR3tZ9cNon5+2OpoJwim622RozbPelgq
	 5VY6ZpFwN/bCEPH7X6bdRqCoTnRhrfFqpYffDF7rckJkpRQ342m4rrL++l+5IIEHTuw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793775350;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-Spam-Status:
	 X-Spam-Checker-Version;
	bh=AjY5vfA5sc/gQdu961tsaCE7O8f39szAc1TibYUQAnI=;
	b=khsvlOK3fH5tf6Y+MG4/G0C/zXC/gqp8dpRlANxeekNxaCUWBY2FtplPAD8DNw8YmnlO
	 mjMlBe65qcjaDYeHOv60kRNCi3GdDIJB9wKqk0opIHODvMaTCkO8rQ19uyjGW7rU3Vvi+
	 Yst7s6Css4UVbM70+7XxdQ/V0wTRHGDvE7LD8oJyfh8ervwfplpeNHjxe7kGk/bmdb/4I
	 +ZmsWob6fwaiBiqdTi134t5UrnXUpKv3HhMnuRQOwcF/nnnuGNTH87ZYFRJSIXwtdvjBF
	 QQ7PqmbgUFtYf5WAfuWvrKlDJBMDlooGJDVUeDh6vs280nEzFjdajLTMYgAtUq0U0mQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.microsoft.com;
	spf=pass smtp.mailfrom=linux.microsoft.com;
	dkim=pass header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=DdrUrpPU;
	arc=none smtp.remote-ip=13.77.154.182
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E20B606A337;
	Wed,  4 Nov 2026 06:55:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2E20B606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=DdrUrpPU
Received: from fedora.hsd1.wa.comcast.net (unknown [52.148.140.42])
	by linux.microsoft.com (Postfix) with ESMTPSA id 71F2B20B7168;
	Tue,  3 Nov 2026 22:55:28 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 71F2B20B7168
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1793775328;
	bh=AjY5vfA5sc/gQdu961tsaCE7O8f39szAc1TibYUQAnI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DdrUrpPU6w8/9uir1Pn4uQjubJWccefp8Qe/wTAJWrmxuej804hGBGhNBj3C7erS7
	 qqzHubaemrMa9E7raZUqGMPJcp/zSrwfZHzXZHDZ68cdBQU7yKjNMPG91VG8alOxJD
	 kGx0vY//EsH3PHAjCzcCIB6gPpDXV5ihDPVBQ7nk=
From: Sriram Nambakam <snambakam@linux.microsoft.com>
To: dwmw2@infradead.org
Cc: kvm@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	seanjc@google.com,
	pbonzini@redhat.com,
	joro@8bytes.org
Subject: Re: [RFC PATCH 49/55] KVM: SVM: Carry instruction state on reflected plane-protection faults
Date: Tue,  3 Nov 2026 22:55:42 -0800
Message-ID: <20261104065542.15329-1-snambakam@linux.microsoft.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261017122501.610248-50-dwmw2@infradead.org>
References: <20261017122501.610248-1-dwmw2@infradead.org> <20261017122501.610248-50-dwmw2@infradead.org>
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

One build adjustment when integrating this onto my v7.3-based tree:
static_cpu_has() is no longer available to this caller. I changed the
decode-assist test to cpu_feature_enabled(), matching the surrounding
SVM code:

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -2094,7 +2094,7 @@ static int npf_interception(struct kvm_vcpu *vcpu)
 	    (vcpu->run->memory_fault.flags & KVM_MEMORY_EXIT_FLAG_PLANE_PROT)) {
 		unsigned int len = 0;
 
-		if (static_cpu_has(X86_FEATURE_DECODEASSISTS) &&
+		if (cpu_feature_enabled(X86_FEATURE_DECODEASSISTS) &&
 		    svm->vmcb->control.insn_len &&
 		    x86_decode_emulated_instruction(vcpu, 0,
 						    svm->vmcb->control.insn_bytes,

This is a newer-base integration adjustment, rather than a claim that
the original v7.1-rc7-based posting fails to build.

Thanks,
Sriram

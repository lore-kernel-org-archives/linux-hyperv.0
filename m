Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=13.77.154.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793775346;
	b=R+9S6wp5v5cNwnpoh1o1FNeTZSniR/VIzMqKX3plcE6OwKcf8ogH6FJjuwBXk2jYrXzm
	 AKQPlMcezZ//Fsc5+N6OHZPhe5R1LUZFy5fJp9fLJoGCBnz5ZJ/WZpGIegQInbouifIfq
	 n+XaEPdCnimYqCQV1hznB5UZVdo3JMxmIEWXYm8n9owTOMiCeXTSz/P/ACseBQM/6cRh1
	 w6tua+n2/fyhzrllukBrjw64OW+grIM9M4N/hYRupPh9SM273lMOUCxJapwbPSKnTU3pW
	 DYX5pEwuyVzwcRcyOQ+gHLWJCHJLAuAVMJGC/zGduqtx4H71n2v2s/StQQ7ALPATmJA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793775346;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-Spam-Status:
	 X-Spam-Checker-Version;
	bh=dLOM69oEcX3XYvhv8IqlmOcdqCfrUReKtqubiXiscKY=;
	b=kTFnJ43pUXbrFjtWjfHmqed+hwGBlLnFdEjRt0wztmNVEzJw5SWxswoZOmTckgm/pyIW
	 MEea9+WcWMdrboEHnKoNf71m8ddn0mkoGxD8djGdjhD+e6WCm3dZ70t5HHItlhwCN5MBh
	 QQp2H/hhca2cvccU1jTQpFSqL0aD8cFF/DAZJnIb7bkGb6KrfYTGb4IDVZGJBHTr5zPc6
	 0ZmFvEy1PhXmetSSXBOJoBCbcZ8tpZsdmSlkPEpY/Y8idIySgZoCbeaSvur1Gq3tQFy62
	 MEWQEkTHvn+3AVLtPDDFgw0kwpncY39ClFBhkujmsO+oDZviu+k3rGQDY2qC5gv3QQA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.microsoft.com;
	spf=pass smtp.mailfrom=linux.microsoft.com;
	dkim=pass header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=lsEcuIRD;
	arc=none smtp.remote-ip=13.77.154.182
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CC8B606A326;
	Wed,  4 Nov 2026 06:55:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9CC8B606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=lsEcuIRD
Received: from fedora.hsd1.wa.comcast.net (unknown [52.148.171.5])
	by linux.microsoft.com (Postfix) with ESMTPSA id 21E5020B7166;
	Tue,  3 Nov 2026 22:55:23 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 21E5020B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1793775323;
	bh=dLOM69oEcX3XYvhv8IqlmOcdqCfrUReKtqubiXiscKY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lsEcuIRDx31ikhS0Ob7pyMLQo5Pt0vYbHmzRujVsAexNE4SXBI58sX6GuwlmUADX8
	 4GkqTh2yZbakUcuJMTHCRsZJ4L1lyfaaeKvfonRu2t7h1LFwEpiA4G6DStjETxAOds
	 2igCoTzBNaKXN/+z1wpiFYRUpLQBM71VN7OZosSU=
From: Sriram Nambakam <snambakam@linux.microsoft.com>
To: dwmw2@infradead.org
Cc: kvm@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	pbonzini@redhat.com,
	seanjc@google.com,
	joro@8bytes.org,
	tgopinath@linux.microsoft.com
Subject: Re: [RFC PATCH 00/55] KVM: x86: Hyper-V VSM (Virtual Trust Levels) on VM planes
Date: Tue,  3 Nov 2026 22:55:36 -0800
Message-ID: <20261104065536.15232-1-snambakam@linux.microsoft.com>
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

Thanks for posting this. I've been trying the series and the QEMU VSM
implementation in my local integration trees. With the fixes below,
Windows now reports "Virtualization-based security: Running" in msinfo32.

This was on a v7.3-based kernel tree with existing local VM-planes/LVBS
changes, rather than an otherwise unmodified copy of your v7.1-rc7-based
tree. I don't want to imply that all of the integration changes were
defects in the posted series.

The main runtime issue I found was descriptor-table interception while
OVMF was executing in SMM. hv_divert_dt_write() was diverting firmware
descriptor-table writes through the VTL register-intercept path. The
failure trace showed a reflected #GP delivered in SMM with IDT base and
limit both zero, followed by a triple fault/reset. Adding an is_smm()
exclusion to the helper fixed that boot failure. I'll reply to patch 23
with the change.

On the QEMU side, I also changed vsm_glue_reset() to make plane 0 runnable
when stopping plane 1. Otherwise a reset following a VTL switch can leave
the normal-world vCPU userspace-stopped. I'll send that change separately
in this thread, since the QEMU glue isn't part of the kernel posting.

Two build/header items from the newer kernel integration:

  - In patch 49, I used cpu_feature_enabled(X86_FEATURE_DECODEASSISTS)
    instead of static_cpu_has(), matching the current SVM code.
  - I synchronized the tools UAPI header with the PLANE_PROT/INSN_VALID
    flags and their field-validity comments, and the capability-version
    requirement for KVM_HV_HCALL_RESULT_RAISE_UD.

I also encountered an issue in the underlying planes dependency:
"kvm: Make KVM_SIGNAL_MSI per plane" guards the VM-fd and plane-fd ioctl
dispatch with CONFIG_HAVE_KVM_MSI. Those guards need to use __KVM_HAVE_MSI;
otherwise KVM_SIGNAL_MSI is compiled out and returns ENOTTY. The existing
test_plane_msi case exposed this in my tree. This isn't introduced by one
of the 55 patches here.

Finally, my older LVBS tree had raised the default plane count to two.
I reverted that local change to respect the KVM_CAP_PLANES opt-in contract
and added early opt-in for my LVBS userspace path. Your QEMU VSM path
already has its own opt-in, so I am not reporting that as a missing VSM
change.

My runtime result here is the msinfo32 VBS-running status; I am not
claiming separate Credential Guard, migration, or hibernate/resume
validation.

Thanks,
Sriram

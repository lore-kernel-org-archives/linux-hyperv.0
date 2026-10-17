Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 327A549426E;
	Sat, 17 Oct 2026 12:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792239914; cv=none; b=KKK7UiU4Zob5PCBx7nz3wNjMGjxTuUiTvVcZAHURn2cgkidpXi/XYwK1r0EeAHNdfvHev0j+Chm+uUSpn68x9BkSjQHv/SOubl6Xf1fRIqJ7h36RObojY5kmsVQGCLgFYJ545MiATsZWtGQ2umo5NwBRufod1FFjenY1C596dL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792239914; c=relaxed/simple;
	bh=qc2Yu3EJFv2iiP0rMD9rTndhnUI0oeFtmM+xjW0x4jM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VU9hmcb15RT318O7z64E/Ut7tQIy6J/z4BxwC4LNeyf4HGgFiiR9PmLCJiVPlaRPdgv8QRStL4XvIxgdbnkLG9pScPhjqWcaYxC1shFNLzJ3QjsP7e1nBIwbzIouMorTvcyuVpy1uo6RUKuC9mZ6Wihgp5xlbdCxHb5eQpAn298=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=desiato.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Nd9VBDBJ; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Nd9VBDBJ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=fg9Qi8ifblsebJazLOJxsmcyLQl51o2mzzxC5zm5xvk=; b=Nd9VBDBJGI5cn5h4DXJuiTsBGC
	SErd6BHyGX64QDtoWqas5kjD77RTqTWxUrpZSpV1MWFoYeLGafJofUB+Zqe//l5ohXoKmXP/ezVz1
	64cMT/udoi+kQYjs+SwmExb6wM7wlfFkm86Y/7OXw9fGVL5qyc1J+tGePjFaeZijd4+lq8+D4QHJj
	qKhLUk1BxzuD/ppcN+bjj+RJvmT1dWUVINr1H/cGhi8v3ykNHj3Cp0+gHEROQNOqCiNl06z6MRrio
	JGsnuDAn5pPq2pGqJytfNTLY4IMSVqIbow/CPBxHUZ9yqhEjfYHYcvoRRmkz+XRrKiSgQoG2ZZziH
	SGIsGJBg==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by desiato.infradead.org with esmtpsa (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xI3TE-00000002LfF-1cNK;
	Sat, 17 Oct 2026 12:25:05 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xI3TC-00000002YlK-0oAe;
	Sat, 17 Oct 2026 13:25:02 +0100
From: David Woodhouse <dwmw2@infradead.org>
To: kvm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	Joerg Roedel <joro@8bytes.org>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	Thara Gopinath <tgopinath@linux.microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Michael Kelley <mhklinux@outlook.com>,
	Nicolas Saenz Julienne <nsaenz@amazon.com>,
	Nikolas Wipper <nik.wipper@gmx.de>,
	Mushahid Hussain <hmushi@amazon.co.uk>,
	David Woodhouse <dwmw@amazon.co.uk>,
	nh-open-source@amazon.com
Subject: [RFC PATCH 08/55] KVM: selftests: Cover plane run-state ioctls in planes_test
Date: Sat, 17 Oct 2026 13:24:14 +0100
Message-ID: <20261017122501.610248-9-dwmw2@infradead.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261017122501.610248-1-dwmw2@infradead.org>
References: <20261017122501.610248-1-dwmw2@infradead.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: David Woodhouse <dwmw2@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by desiato.infradead.org. See http://www.infradead.org/rpr.html

From: David Woodhouse <dwmw@amazon.co.uk>

Assert the initial stopped state of a new plane-1 vCPU, a runnable and
back-to-stopped round trip, and rejection of out-of-range states.

The tools copy of linux/kvm.h picks up the plane run-state ioctl
definitions.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Assisted-by: LLM
---
 tools/include/uapi/linux/kvm.h                |  4 ++++
 tools/testing/selftests/kvm/x86/planes_test.c | 22 +++++++++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/tools/include/uapi/linux/kvm.h b/tools/include/uapi/linux/kvm.h
index 586c0d6c168c..8d9f7e6bba19 100644
--- a/tools/include/uapi/linux/kvm.h
+++ b/tools/include/uapi/linux/kvm.h
@@ -1370,6 +1370,10 @@ struct kvm_s390_keyop {
 #define KVM_HAS_DEVICE_ATTR	  _IOW(KVMIO,  0xe3, struct kvm_device_attr)
 
 #define KVM_CREATE_PLANE	  _IO(KVMIO, 0xe4)
+#define KVM_GET_PLANE_RUN_STATE	  _IOR(KVMIO, 0xe5, __u32)
+#define KVM_SET_PLANE_RUN_STATE	  _IOW(KVMIO, 0xe6, __u32)
+#define   KVM_PLANE_RUN_STATE_STOPPED	0
+#define   KVM_PLANE_RUN_STATE_RUNNABLE	1
 
 /*
  * ioctls for vcpu fds
diff --git a/tools/testing/selftests/kvm/x86/planes_test.c b/tools/testing/selftests/kvm/x86/planes_test.c
index 3517175580d3..b28ed4077715 100644
--- a/tools/testing/selftests/kvm/x86/planes_test.c
+++ b/tools/testing/selftests/kvm/x86/planes_test.c
@@ -89,6 +89,28 @@ static void test_plane_lifecycle(void)
 	TEST_ASSERT(vcpu1_fd >= 0,
 		    "KVM_CREATE_VCPU on plane 1 failed: errno %d", errno);
 
+	/* Plane 1 starts stopped; run state is readable and writable. */
+	{
+		u32 state = 0xff;
+
+		kvm_ioctl(vcpu1_fd, KVM_GET_PLANE_RUN_STATE, &state);
+		TEST_ASSERT_EQ(state, KVM_PLANE_RUN_STATE_STOPPED);
+
+		state = KVM_PLANE_RUN_STATE_RUNNABLE;
+		kvm_ioctl(vcpu1_fd, KVM_SET_PLANE_RUN_STATE, &state);
+		state = 0xff;
+		kvm_ioctl(vcpu1_fd, KVM_GET_PLANE_RUN_STATE, &state);
+		TEST_ASSERT_EQ(state, KVM_PLANE_RUN_STATE_RUNNABLE);
+
+		state = KVM_PLANE_RUN_STATE_STOPPED;
+		kvm_ioctl(vcpu1_fd, KVM_SET_PLANE_RUN_STATE, &state);
+
+		state = 2;
+		TEST_ASSERT_EQ(__kvm_ioctl(vcpu1_fd, KVM_SET_PLANE_RUN_STATE,
+					   &state), -1);
+		TEST_ASSERT_EQ(errno, EINVAL);
+	}
+
 	/* Register state is per plane: write plane 1, plane 0 unaffected. */
 	kvm_ioctl(vcpu1_fd, KVM_GET_REGS, &regs1);
 	regs1.rbx = 0x5157ca11;	/* arbitrary marker */
-- 
2.50.1


Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.92.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794594896;
	b=Q2KCp7NQmfnjYRtuPQ9ygMHTTnrOcFf2a4ZS9mCeQcvtwdXDmGviDcfHIopNQsfHcwhB
	 JAEXg6cwbDH4SSEDeYEc9v6VbKNs2QNGUMnKDkNzv1v0Wb2R92lhhdNAKMKlRximaEgM5
	 +kMfswnudyCqSxbfmBmMC8+5Ust/RP3Jo0dMpL0qFE7dwoz7KRVbKOZjZ/Lzawbgm4V+N
	 9mBJt1uWY5kPZL8qXHRl4wDyg6Sj8vNiER3+3qfaHo4MzUSIvE49neHFMVEwBrNvEQ7eU
	 tH7Rpiq08hxQA8tjDiQGauq/2Hn7l02ixCsGFNY+dnGmOjuOk53DCF7gE1mexBy48IA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794594896;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Sender:X-SRS-Rewrite;
	bh=2VNgpoVKZjclgpW10JbzOiy3naqOHzafryfAc0JfXDU=;
	b=yvmaT1vehwKjYXQNQlk6Uk93/Slk9wNChJlfNd1JpmXfEHvl6IYw5CqRZujAx0RbRWH4
	 lQl4bvcXqwj2MlpA5agGNMvJdl9lcm1lXIqoiB4qqR9X+RrjDWle24Zq33N0mprEgygEr
	 VSsY9TCVEFsV69Ib11LPSB9ZgebfJRIjWjyeTs0uad29WsAjBjEksZvrag8cCGUYH0lw9
	 8nlruPY5l0E205yFgDoYNgGA9+TY95h5ktv8UVaWKkOb3XBS5B+8jKH6zCWiuQKO96076
	 4fDpe7lI5PT75NFlnM/JvFAI1RzTzXT+txjlI1UpcIH8F1lyM43JawjaCQdUdY1SyHw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=none smtp.mailfrom=desiato.srs.infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=IJt5TwTO;
	arc=none smtp.remote-ip=90.155.92.199
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B72E760A5BCA;
	Fri, 13 Nov 2026 18:34:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B72E760A5BCA
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=IJt5TwTO
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=2VNgpoVKZjclgpW10JbzOiy3naqOHzafryfAc0JfXDU=; b=IJt5TwTOpkaqAUsn3u0mErKz7v
	NdnnKFx4ZsGZOplwVTdTWUkqdkIque1K1hc9eDn/yF0n/FBeJh69DfVKXAPHlWZRZ5ZBK6xGN8rqL
	pLwD/jueJFTknI4KMDxtUImUD0e1K1EabpdDGxKhbwKGRKkVj2xLHgtUb+rIySWMiNUK53v+4YX6u
	b+JIDSzNIvBhbNBLVr4Ks2dy/mnOjSHvIpPRtPWE+m8022Zp6Tl7SFrMorXlVg1MIEQUl8EUVzdhl
	1mb1beJesHitCKRDNthb2tUH9bd0s7mVcRLQXAr0+/8aEG0OO8It0K0umKmQAZvaJYJw0OueKiC6Z
	tIMVlHig==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by desiato.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRw6t-0000000Bf04-39Qm;
	Fri, 13 Nov 2026 18:34:52 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xRw6s-00000000Lte-09WY;
	Fri, 13 Nov 2026 18:34:50 +0000
From: David Woodhouse <dwmw2@infradead.org>
To: kvm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	=?UTF-8?q?J=C3=B6rg=20R=C3=B6del?= <joro@8bytes.org>,
	joerg.roedel@amd.com,
	Tom Lendacky <thomas.lendacky@amd.com>,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	Thara Gopinath <tgopinath@linux.microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Michael Kelley <mhklinux@outlook.com>,
	Nicolas Saenz Julienne <nsaenz@amazon.com>,
	Nikolas Wipper <nik.wipper@gmx.de>,
	Mushahid Hussain <hmushi@amazon.co.uk>,
	Sriram Nambakam <snambakam@linux.microsoft.com>,
	David Woodhouse <dwmw@amazon.co.uk>
Subject: [RFC PATCH v2 17/31] KVM: x86: hyperv: Deliver higher-plane SynIC messages through overlays
Date: Fri, 13 Nov 2026 18:34:33 +0000
Message-ID: <20261113183448.84094-18-dwmw2@infradead.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261113183448.84094-1-dwmw2@infradead.org>
References: <20261113183448.84094-1-dwmw2@infradead.org>
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Post: <mailto:linux-hyperv@vger.kernel.org>
List-Help: <mailto:linux-hyperv+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hyperv+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: David Woodhouse <dwmw2@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by desiato.infradead.org. See http://www.infradead.org/rpr.html

From: David Woodhouse <dwmw@amazon.co.uk>

SynIC message delivery reads and writes a plane's SIMP page in guest
RAM. For a higher plane that page is a per-plane overlay, and the RAM
underneath belongs to plane 0: delivering a higher VTL's message there
corrupts memory plane 0 owns, and judging deliverability from
plane-0-writable bytes lets a lower VTL plant a non-HVMSG_NONE type
and swallow a no_retry (periodic stimer) message.

Read and write the message page through the plane's overlay when one
is installed. A higher plane without an overlay fails the delivery
with -EFAULT instead of falling through to kvm_vcpu_write_guest_page(),
and the sender retries once the overlay appears.

With that, a higher plane's SynIC no longer needs hiding from the VMM.
KVM_EXIT_HYPERV_SYNIC is reported for non-zero planes again, and it and
KVM_EXIT_HYPERV_SYNDBG carry the plane, so the VMM can keep its plane-0
device state separate.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 arch/x86/kvm/hyperv.c | 81 +++++++++++++++++++++++++++++++------------
 1 file changed, 58 insertions(+), 23 deletions(-)

diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
index 5a42d479e936..3494f3b29809 100644
--- a/arch/x86/kvm/hyperv.c
+++ b/arch/x86/kvm/hyperv.c
@@ -253,15 +253,6 @@ static void synic_exit(struct kvm_vcpu_hv_synic *synic, u32 msr)
 	struct kvm_vcpu *vcpu = hv_synic_to_vcpu(synic);
 	struct kvm_vcpu_hv *hv_vcpu = to_hv_vcpu(vcpu);
 
-	/*
-	 * Userspace's SynIC device models plane 0 only; a higher plane's
-	 * exit would be mistaken for a plane-0 page move and relocate the
-	 * overlay the VMM keeps for SIMP/SIEFP.  Higher-plane SynICs are
-	 * handled fully in-kernel.
-	 */
-	if (vcpu->plane_level)
-		return;
-
 	hv_vcpu->exit.type = KVM_EXIT_HYPERV_SYNIC;
 	hv_vcpu->exit.plane = vcpu->plane_level;
 	hv_vcpu->exit.u.synic.msr = msr;
@@ -795,6 +786,51 @@ static int stimer_get_count(struct kvm_vcpu_hv_stimer *stimer, u64 *pcount)
 	return 0;
 }
 
+/*
+ * SIMP accessors: a plane overlay page, when installed by userspace,
+ * carries the live message page for this plane; the memslot holds only
+ * the underlay the other planes see.
+ */
+static int synic_msg_page_read(struct kvm_vcpu *vcpu, gfn_t gfn, void *data,
+			       int offset, int len)
+{
+	unsigned long uaddr = kvm_plane_overlay_uaddr(vcpu->plane, gfn);
+
+	if (uaddr)
+		return copy_from_user(data, (void __user *)(uaddr + offset),
+				      len) ? -EFAULT : 0;
+	/*
+	 * Mirror the write side: without an overlay a higher plane's
+	 * message page is backed by underlay memory that plane 0 controls.
+	 * Deciding deliverability from plane-0-writable bytes would let a
+	 * lower VTL plant a non-HVMSG_NONE type and silently swallow a
+	 * no_retry (periodic stimer) message; fail so the delivery is
+	 * retried once the overlay appears.
+	 */
+	if (vcpu->plane_level)
+		return -EFAULT;
+	return kvm_vcpu_read_guest_page(vcpu, gfn, data, offset, len);
+}
+
+static int synic_msg_page_write(struct kvm_vcpu *vcpu, gfn_t gfn,
+				const void *data, int offset, int len)
+{
+	unsigned long uaddr = kvm_plane_overlay_uaddr(vcpu->plane, gfn);
+
+	if (uaddr)
+		return copy_to_user((void __user *)(uaddr + offset), data,
+				    len) ? -EFAULT : 0;
+	/*
+	 * Never write a higher plane's messages into guest RAM: without an
+	 * overlay installed that memory is the underlay every other plane
+	 * sees, and silently corrupting plane-0-owned pages is far worse
+	 * than retrying the message once the overlay appears.
+	 */
+	if (vcpu->plane_level)
+		return -EFAULT;
+	return kvm_vcpu_write_guest_page(vcpu, gfn, data, offset, len);
+}
+
 static int synic_deliver_msg(struct kvm_vcpu_hv_synic *synic, u32 sint,
 			     struct hv_message *src_msg, bool no_retry)
 {
@@ -815,10 +851,10 @@ static int synic_deliver_msg(struct kvm_vcpu_hv_synic *synic, u32 sint,
 	 * is only called in vcpu context so the entire update is atomic from
 	 * guest POV and thus the exact order here doesn't matter.
 	 */
-	r = kvm_vcpu_read_guest_page(vcpu, msg_page_gfn, &hv_hdr.message_type,
-				     msg_off + offsetof(struct hv_message,
-							header.message_type),
-				     sizeof(hv_hdr.message_type));
+	r = synic_msg_page_read(vcpu, msg_page_gfn, &hv_hdr.message_type,
+				msg_off + offsetof(struct hv_message,
+						   header.message_type),
+				sizeof(hv_hdr.message_type));
 	if (r < 0)
 		return r;
 
@@ -828,21 +864,20 @@ static int synic_deliver_msg(struct kvm_vcpu_hv_synic *synic, u32 sint,
 
 		hv_hdr.message_flags.asu8 = 0;
 		hv_hdr.message_flags.msg_pending = 1;
-
-		r = kvm_vcpu_write_guest_page(vcpu, msg_page_gfn,
-					      &hv_hdr.message_flags,
-					      msg_off +
-					      offsetof(struct hv_message,
-						       header.message_flags),
-					      sizeof(hv_hdr.message_flags));
+		r = synic_msg_page_write(vcpu, msg_page_gfn,
+					 &hv_hdr.message_flags,
+					 msg_off +
+					 offsetof(struct hv_message,
+						  header.message_flags),
+					 sizeof(hv_hdr.message_flags));
 		if (r < 0)
 			return r;
 		return -EAGAIN;
 	}
 
-	r = kvm_vcpu_write_guest_page(vcpu, msg_page_gfn, src_msg, msg_off,
-				      sizeof(src_msg->header) +
-				      src_msg->header.payload_size);
+	r = synic_msg_page_write(vcpu, msg_page_gfn, src_msg, msg_off,
+				 sizeof(src_msg->header) +
+				 src_msg->header.payload_size);
 	if (r < 0)
 		return r;
 
-- 
2.50.1


Return-Path: <linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D9C5C43219
	for <linux-hyperv@archiver.kernel.org>; Tue,  1 Nov 2022 14:57:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231191AbiKAO5d (ORCPT <rfc822;linux-hyperv@archiver.kernel.org>);
        Tue, 1 Nov 2022 10:57:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231207AbiKAO4x (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 1 Nov 2022 10:56:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E2471C435
        for <linux-hyperv@vger.kernel.org>; Tue,  1 Nov 2022 07:55:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667314544;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BXXbLgwdgUkN7FSSlfy+wa5/rPUmeVnPXj9kxjAQ1x4=;
        b=esJxkZVILJi7oYEmlywnBk5MQQgxxeBHr0xtnaE5b5fZV1m5eujPUY26NkD0Sx2sFFGPT1
        aDLeUUOgonheU9TOqmej7fqhQHJSy8WXTyxKxfCA6w1t2dr3O1JBVH9Nen1mPKJM2DgfI9
        XYZwr9smTttDBSe0N1aUG3gL6+WLIQ0=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-299--P9Y9Hl0OT2gGGUIcNIkQg-1; Tue, 01 Nov 2022 10:55:42 -0400
X-MC-Unique: -P9Y9Hl0OT2gGGUIcNIkQg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 971B53C32C52;
        Tue,  1 Nov 2022 14:55:41 +0000 (UTC)
Received: from ovpn-194-149.brq.redhat.com (ovpn-194-149.brq.redhat.com [10.40.194.149])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8DF76C15BB9;
        Tue,  1 Nov 2022 14:55:39 +0000 (UTC)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>
Cc:     Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Siddharth Chandrasekaran <sidcha@amazon.de>,
        Yuan Yao <yuan.yao@linux.intel.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v13 22/48] KVM: x86: hyper-v: Introduce kvm_hv_is_tlb_flush_hcall()
Date:   Tue,  1 Nov 2022 15:54:00 +0100
Message-Id: <20221101145426.251680-23-vkuznets@redhat.com>
In-Reply-To: <20221101145426.251680-1-vkuznets@redhat.com>
References: <20221101145426.251680-1-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

The newly introduced helper checks whether vCPU is performing a
Hyper-V TLB flush hypercall. This is required to filter out L2 TLB
flush hypercalls for processing.

Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
Reviewed-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 arch/x86/kvm/hyperv.h | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/x86/kvm/hyperv.h b/arch/x86/kvm/hyperv.h
index 8942e8c6c912..5f9c76b45f46 100644
--- a/arch/x86/kvm/hyperv.h
+++ b/arch/x86/kvm/hyperv.h
@@ -177,6 +177,23 @@ static inline void kvm_hv_vcpu_purge_flush_tlb(struct kvm_vcpu *vcpu)
 	kfifo_reset_out(&tlb_flush_fifo->entries);
 }
 
+static inline bool kvm_hv_is_tlb_flush_hcall(struct kvm_vcpu *vcpu)
+{
+	struct kvm_vcpu_hv *hv_vcpu = to_hv_vcpu(vcpu);
+	u16 code;
+
+	if (!hv_vcpu)
+		return false;
+
+	code = is_64_bit_hypercall(vcpu) ? kvm_rcx_read(vcpu) :
+					   kvm_rax_read(vcpu);
+
+	return (code == HVCALL_FLUSH_VIRTUAL_ADDRESS_SPACE ||
+		code == HVCALL_FLUSH_VIRTUAL_ADDRESS_LIST ||
+		code == HVCALL_FLUSH_VIRTUAL_ADDRESS_SPACE_EX ||
+		code == HVCALL_FLUSH_VIRTUAL_ADDRESS_LIST_EX);
+}
+
 int kvm_hv_vcpu_flush_tlb(struct kvm_vcpu *vcpu);
 
 #endif
-- 
2.37.3


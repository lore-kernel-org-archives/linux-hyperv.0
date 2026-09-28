Received: from mail-dy2-f43.google.com (mail-dy2-f43.google.com [74.125.229.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51FDA298CC4
	for <linux-hyperv@vger.kernel.org>; Mon, 28 Sep 2026 07:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790580350; cv=none; b=Dpux5onec02BiR4FwQYU9rmS4x3dfSlTh3/oyuuHNcZHVFZbqoUB5F7LeHVcjqPZre50S6FXcY6r7R02f1PVzHux/Vi4Xe6LYz7YJDnrTf39eKd1yddX63rPuh3sGvxpfy0bzUHR9Up01m7dJvCZFDevw0N7CqG0hAL1XWXCdgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790580350; c=relaxed/simple;
	bh=q08SMMXYiHrB/t+BG5Y3bR6naNmrNNO29kDK3fVq4k4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oWk+XNIaRQyRtZLkjJ/9lTwuECUNHDnCRR0l6rah8SYxhwMdOi2eIbVKD3MCEwrRSyXeYTfsSfO3sE9/LjmhS2hiUSS/xlIRW4pel7IK3hl76mk5NqLkL5yQ1r6FTiKCRZlB9TENSWD/p6ugSoaZ3iyVCQ2b8c81mbY8r24x6NQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mxXUNGf3; arc=none smtp.client-ip=74.125.229.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mxXUNGf3"
Received: by mail-dy2-f43.google.com with SMTP id 5a478bee46e88-33e46a15703so2468522eec.0
        for <linux-hyperv@vger.kernel.org>; Mon, 28 Sep 2026 00:25:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790580348; x=1791185148; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7ROGDvtvh53/QQPkABiv5e4DoVYicohxxFWZJETjDQU=;
        b=mxXUNGf3q1qj3KXBeHHYrUEtIYoOOVdlS+fsvzI1n7wpUw2qRSb/N2njJEWmcZIbaK
         cMA7Hw8qMPFJjCKjacumBU5NvQSrdNvLF810Z2nOzw3ujVr47G5t4g+yMlvvz9WShOT4
         sE2mTWGIp8z2vvaxuzXwwj3RwDxCkbVH+ZGvCCRAANs2bFuCOBP0rC82Are5OimLsd7s
         t6kAnzpJZNX15TyOhqGGmfUMRcamkOwG1dxOCXjDka0ymwGFvDYNVvPAd1MYkRcfoCB6
         24UdTctkqKP9h1hZmmsB15X5UZQ47k2fo26JxxZZYAP+0SiZpE4r8X3o0JypwLzeBzk5
         CVnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790580348; x=1791185148;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=7ROGDvtvh53/QQPkABiv5e4DoVYicohxxFWZJETjDQU=;
        b=wGEq33PcY5WHghARIHIPbVgtZ8C69rDrPhyI2MV3WZfOpxXgKX3nFSsfv4cbl4e62R
         epceIoxffHFK+H4ClEVM4Z+7XUe2thCV3zgzHe4vusr2Bpx9out/Q1hY2pHouV9IMQFy
         YYIMA0/hLRCF9nk7DJ7St5Uvmf1r5cwBL7KhmEPLa8qCBvTH+gfFi+Zz7MGbjHi/cGEW
         ormu2V2cIbAcEFRLmV5eSTfZGTW1PbmZjg4srF5EpJraxKKLuh5VQo6O1lS9GtnzhFEg
         u7P4PnIuX5oWhTc+/9zznbSEw21JME9Xhgc+ZYSR42cOl7fp7KWHBFtOV1S3kkkXeSHk
         A5DQ==
X-Forwarded-Encrypted: i=1; AKwUvBwADJokp8R+EIDNyPZoQVtBdCbEj0HogCm+0Sx77sWUdX/6Ot2OynSGU/FQOTii7ffSC1aY0jMsTc84/i0=@vger.kernel.org
X-Gm-Message-State: AFq9FYKNkmsAR9Q/3nMWnjOIuGCvsYRtxHS8ZGGDSakyo0mpitG91BNK
	7k2VIp3Vt1sZ98dUxaJQhtKDZmaydYRiNOPXgQMukOfDeuGKJZAIlAxs
X-Gm-Gg: AYBFou3ztttoO6roPiCvd1VNK+23/4RDidCge+CUIvaBxxCkznPDDcPPxBPEt28Q9ZF
	4+ZRBRPfIa9Kd2aV1V5eLsfCc/IoQx3ERGgNbUfJjsJmuWq3RAqms4/lr9pbOKs9CoRfKEEoDaQ
	tmSZ0HDX7yayLOZTvpBwbJYgdsYo9a4JE+wzj/X+K7z5cBLRb+ewQcMam+OfsEz72NDte4uEIlR
	MgIJyq8mIecnkaTAW8qqIqfwL2lGKiNXbgskLmjaf+Gt71CjuN4lezFswO21+aLyLlc6l+b0Hno
	qcAxh5//K2Oj379gKXkc3y/PtwbuO3E5kEn8M0tSOONn40Eq6DDdHKylixYByS+5dagkhUubj/z
	PJoXmOb6HrO+VM78O+ml/ZL6ecVToztk7AdOG1OBscFl69bMQSfcRuNG75TIFoBOsthjUtEW9qR
	6+ieaW9VUhFuGfGDAtGQNQjcRnOH+0PYuP6X3RiGrGd4wBekrUbg6kpc01COeTlVd6LZDJDdYXm
	WDVdgbiFPKuoA==
X-Received: by 2002:a05:7301:78c6:b0:33b:edf8:1919 with SMTP id 5a478bee46e88-342707b407dmr9263412eec.13.1790580348291;
        Mon, 28 Sep 2026 00:25:48 -0700 (PDT)
Received: from wujing.localdomain ([23.254.208.9])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34145d0fc9fsm27735529eec.25.2026.09.28.00.25.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 00:25:47 -0700 (PDT)
From: Qiliang Yuan <odys.yuan@gmail.com>
To: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Cc: Qiliang Yuan <odys.yuan@gmail.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>,
	linux-hyperv@vger.kernel.org
Subject: Re: [PATCH] KVM: x86: Clear CR3[63:32] on SMM entry from long mode
Date: Mon, 28 Sep 2026 15:25:34 +0800
Message-ID: <20260928072534.1987-1-odys.yuan@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260928-kvm-smm-cr3-upper-bits-v1-1-138f52dd531e@gmail.com>
References: <20260928-kvm-smm-cr3-upper-bits-v1-1-138f52dd531e@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

+Cc Hyper-V folks and linux-hyperv, since the failure is triggered by
Hyper-V's handling of VMRUN for a nested (L1) hypervisor, i.e. KVM
running on WSL2.

For the Hyper-V side: the VMRUN is rejected when the guest state has
CR0.PG=0, EFER.LMA=0 and CR3[63:32] != 0, a combination that bare-metal
SVM does not reject.  Is that check intentional?  If it is not, a
Hyper-V fix would help older KVM versions as well; either way the patch
avoids creating that state in the first place.

The full patch is here:
https://lore.kernel.org/r/20260928-kvm-smm-cr3-upper-bits-v1-1-138f52dd531e@gmail.com

Thanks,
Qiliang

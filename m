Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.174
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793939441;
	b=ZK048TdJQ3ncWWDHatTMb2Sd+J3NqLE46Ldch6COvRIXkt8pyndkJZEg1sNL6T+TT1MN
	 YWzwAtxgvA9Fnt0sGP/80BiDHMY3416ew+hjaA/juXIMEZfDsvcfcsUkvwnDJ+HtUspnu
	 KbCpKo6QUnYvMbj+zviF9VGPlFThO1hPgAzfSsk+uJadZK9g48nqeEt0tOdnexj3Ak23h
	 vWhJDIcoTf+G56P+UbFkOsKJCVAmchnLK4XKWXVYHwkl3OyqFUtBupE5jGy17gtz1cO1m
	 /i1u9WopZebVjwGGuH5w6IEZ29i9zqa58UgS19yPVsAcJiXDluwKhQ8XrAhREmTLg9A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793939441;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=bZ4yl/FmN9vHR0lstk/51fTiXqlhJ6EnDHaciWBTDCU=;
	b=iFLQA38Stk8HgmLTI+bUOeTkwt+BCn3JttoqnrUkMWmt1oU1H0bBUkNomcvB4rdeD8Il
	 3mew5DDNLrBrDz6wL0/VOtnKayAm34K6HmYvRXO7Q0yGq7uD/aMROy+rMvHVUWyj6tWLQ
	 rtHE1prwbKf+qaVSsqNJisz8Y6xWVzsQxmIasa9DJiF23c+pamu5OrScmvzswfUoXEAbg
	 UIfY5N9ahovSHP/3ih/Eli0LCDhQ1do9ZdiwvR6fEZhizqwhjbUR4DaqtFAe6ShxjXxxH
	 C1HvnS6KSpe8pTawMW8eUUljn9eMHQ70JjFNECCzpBF8LmC44K7XeoaBdD4AL2dObtQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vwroHejt;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.174
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4578606A332
	for <linux-hyperv@vger.kernel.org>; Fri,  6 Nov 2026 04:30:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C4578606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vwroHejt
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-3ab53a99771so623901fa.3
        for <linux-hyperv@vger.kernel.org>; Thu, 05 Nov 2026 20:30:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793939439; cv=none;
        d=google.com; s=arc-20260327;
        b=m/3ucHY0M1VzplgMvLal3QGDb4OxQQqu3+tdDW7rIvfPvaamhr7e0ZPX1v585wdYxw
         wv+UJJzH4kAXqWXW/4dss3S3kFzjSPTyLSxT9KZ5qeP9ia5pLPpVocQUxNeUZ0zkWkuL
         wKNkv4eCsuWgYFEK+NRkJcc6hDgMtFdsYK/UlY3ojVM33kzxxouBik9k6gYTvt3rXb1H
         mBrWvRyA0tmJ1i8sz11EuJDoedLWPrlGF7RV7CvHA8duSaNCZH6x3qmUzjnLp5Mq4MsZ
         aESvNJ4h6o4fihNjHOaPGYsy9wJY1vzK0sdn5KSUTUKJ07WmTW0NVpONsBkmjNg/zggY
         FX+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=bZ4yl/FmN9vHR0lstk/51fTiXqlhJ6EnDHaciWBTDCU=;
        fh=KMCW7IAwZ9zkJIV2myc3DrHo4HSNH5R3DPjgYtIkz3Q=;
        b=H7btrZqu2Xzj8RZhdqjNBSd+MKK12hvW8qJJ1+KLAQGtGjO/YJn/hVBMhN1quPX8Z+
         Z6unm1gp3BBXqw87AFX/myNdA+SKZUyb0ghKVDJvG/aSUUJ5eC57cKhCsmeZ81xFfGNd
         SHeykFlFoH2ZGcVhxjmdpRk2UHnEV03U5ezCnUGTLj3FoJG1pqtZKMCZ+fBA/jIzQCQY
         WEN4o7q+qKB3jX7/OPzVklFq72zUvrzZE+QaK8Uv0ibfSU6FOAng/Si/rUr9AlnS2Gi/
         lbU+1FJqOW3pcMb9n84Wq/+Wgz/kZWxONKhPp6k0gtIK7pcJfp20EmSfmvFuPmZU+pxu
         ERgA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793939439; x=1794544239; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bZ4yl/FmN9vHR0lstk/51fTiXqlhJ6EnDHaciWBTDCU=;
        b=vwroHejtaRXXec+i7A3jImrpEWozUOejUJpcxfRdor24V+mQf57EigrtcBaiIfNppV
         +/US5NV7M3OwxEp/VHGhiPfbhMkgMW3m9g0l0coy2RzXGkTkNGanhmK/wlQQtd+wkqSB
         csjePKm4h0d2qIw/JPA9SjduR3mu+7JiMPofkmFUmRMGfmKtwEgszq3cscLyz8fOMtQs
         m5yBNVvWU+hmk64aD9M4no/oGsf1qRpl8Wd2BtkSq9//E6rco1C1guWo8Affq0NmxHpa
         ytsEMjz4TnCn+JPb5ji5GqbP9LPF095tU2O+obQht25ZiMuL76GQsNdEClYS494gkKdH
         aC8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793939439; x=1794544239;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=bZ4yl/FmN9vHR0lstk/51fTiXqlhJ6EnDHaciWBTDCU=;
        b=QBPHbQuny4myj7cyfXTKVepUimCkoMCFWl28q2wvng9QTW8LQEEv6TWU17N4XHRqky
         WDQlFIcoNdHEUM5mS4DPce1luhPR4in8+d3dM0zI4y+dcb4gMcz7bG2CGkE/GwAHloCR
         z8nFZ4wzYRO9nbB0jbRdLNkxsZ3N+70EGpqJaoL1peqlYPpStrclKxww5OHzBPYk9jYy
         O0xhBjC/RsPe05qmQprHe/GQqXHDAFNlOBu4jaoMen3BdAkixBWD6jCTZfc8ujIS3zHd
         pV6S3Mpj8X2uZLN8sgOfPDmicRg17hdC4Za8Ea9VuBpmu/5MyKtUK/hm8kcyJysDOmS4
         vPGg==
X-Forwarded-Encrypted: i=1; AKwUvBz9uFsLXEd+2v6+dUlYRXnBKvDUPnVS8wFHJJ/3IWbeJgVBWNONK9TzvZCkXVR6RwvrQRzFen6STmSpwDM=@vger.kernel.org
X-Gm-Message-State: APuU4Z+NwMjw1dlhsv6W1nJPaKkDAPmwZuga8cJqhtk8WHROpFUIF7lC
	fQsaiMBHJLIA8eoGthPSZ+aKlfDPA8TDdSVXr14o4UoTakvWyO4prqwPGYIoBnbdYlE6diR5KWL
	8CBTsqteiUuXJt40jzNEqzDiIVMcz+ow=
X-Gm-Gg: AYBFou0xBueukzynb2oXilHPRlGvh1dP512m8WF0hHe9q3Qd26FWjYVedFKIn843Ao3
	3d7OIIbDjhwkvCb+Gu0OUfS5jBmrkb5beZsmpu2Kxc9NrnPJwgoegrwl5n75wsZ3x3dfClENg1O
	sPXFP513Jo67AyPO52D+CQvi+mZJKdUepUKLhJc5ohW1RudMKlLkF0k3JqJQWGv/5zNYEI+7PMP
	1u3VFdgLPvlklh1Wb8B97i3+w6ME/vSnkNW5RrhqSZ51zbpl/WyOWOGJMQbjdYVykh/Z+qbc3Ds
	Knxa4E3co5Vpj6mHRVGeLqiha1jrHSgNNDox4p5LgWqP7PrZJXjQ1ABUN1U9nd0pp3ouvPgEGlH
	Y8OXc8Y6PTlT9tcTyJtFxuH3H8xfMJi+rZwL5
X-Received: by 2002:a05:651c:1466:b0:3aa:fd7d:6164 with SMTP id
 38308e7fff4ca-3acf3d327c7mr2354821fa.25.1793939438713; Thu, 05 Nov 2026
 20:30:38 -0800 (PST)
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Post: <mailto:linux-hyperv@vger.kernel.org>
List-Help: <mailto:linux-hyperv+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hyperv+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261105192738.70664-2-oss.patchbox@gmail.com> <20261105141427.00005946@linux.microsoft.com>
In-Reply-To: <20261105141427.00005946@linux.microsoft.com>
From: Yuho Choi <oss.patchbox@gmail.com>
Date: Thu, 5 Nov 2026 23:30:27 -0500
X-Gm-Features: AclHuK_mkkVdBlDxyx_u6RLLv2wIIoQ5_PS9z8DWzBm3NCMPC1YbiMhFv5f354E
Message-ID: <CAGG=RgBRojswF0P_YNFaZET7b8W0MnDAEN=cH9J4xLn0vUkxzQ@mail.gmail.com>
Subject: Re: [PATCH v1] iommu/hyperv: Don't free a paging domain the
 hypervisor did not delete
To: Jacob Pan <jacob.pan@linux.microsoft.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Easwar Hariharan <easwar.hariharan@linux.microsoft.com>
Cc: "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>, Wei Liu <wei.liu@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Haiyang Zhang <haiyangz@microsoft.com>, 
	Dexuan Cui <decui@microsoft.com>, Yu Zhang <zhangyu1@linux.microsoft.com>, 
	Michael Kelley <mhklinux@outlook.com>, iommu@lists.linux.dev, linux-hyperv@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, Nov 05, 2026 at 02:27:08PM -0500, Yuho Choi wrote:
> > hv_iommu_paging_domain_free() frees all page-table pages with
> > pt_iommu_deinit() and only then asks the hypervisor to delete the
> > device domain that points at them. If HVCALL_DELETE_DEVICE_DOMAIN
> > fails, hv_delete_device_domain() only logs the error, returns the
> > domain ID to the IDA, and the domain is freed anyway.
>
> Isn't there a WARN_ON on this path? I recall asking for one ..

There isn't one yet. hv_delete_device_domain() only prints the error
with hv_status_err(). The driver does WARN when a flush fails or when
attaching to the blocking domain fails, but not when a delete fails.

I'll add a WARN for the delete failure in v2.

> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Thanks for the review!

> Looks good but I think it is incomplete.
>
> if both hv_configure_device_domain and hv_delete_device_domain both
> fails in hv_create_configure_device_domain, then unwind code will do
> pt_iommu_deinit thus have the same UAF problem.

You're right, thanks for catching this. If the delete also fails
there, hv_iommu_domain_alloc_paging() still frees the page tables.

In v2, I'll make hv_iommu_domain_alloc_paging() call
hv_create_device_domain() and hv_configure_device_domain() itself, so
it can leak the page tables and the domain when the delete fails, the
same way hv_iommu_paging_domain_free() does.

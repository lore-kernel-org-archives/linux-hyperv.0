Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3405346D55C
	for <linux-hyperv@vger.kernel.org>; Mon, 31 Aug 2026 15:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788189944; cv=pass; b=cXFbcX3Rjl1xy8JeQnGreQBtVJVqvx17U8YY/bmzLO1UmwPuLiUXCCxGv8R20IHDXxjOD7gAU27dEIxZivOwPJ5DuYELByPpV/uIVTlBZvL4NPa3y+eZ74xSU1ZmbcDQKAsWQN/pBSdt5K3NTXDhhRTHGuVy/JMraMKW2fAxUx0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788189944; c=relaxed/simple;
	bh=5r5lIWIE05yql962Lu66IpUSpOLRAbYoczG3Qe81sGo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=prU4vagqwW9R2rj9qkv4mz7hXOOD9HRzwwhYwk0wvfuVaxsrXWz4WQ94DVFPNl+zaUCgPOQj4fGpfi11x0Q9A5XgbJC0qGRW3tCmEf+wJ/85nwMqYRLPWVYEiF+2T6yIdwFkbjJ8fVoWDC5nc+aAc84eHi+GVcDsDcnTwwJE/Vo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y6osjXU+; arc=pass smtp.client-ip=74.125.224.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y6osjXU+"
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-66d23c88af0so1540841d50.1
        for <linux-hyperv@vger.kernel.org>; Mon, 31 Aug 2026 08:25:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788189942; cv=none;
        d=google.com; s=arc-20260327;
        b=lDrO6Mjh3GrSFvm56288gdttgIvsRTqCmSUVPuA6X1WNhLHpx+mRvKHRVGRz+QGtgj
         ZVjGqmz/+2WUdFCWeZDrmOmnLA3z2o7BAZ1E/VNdETNN27XRw1HdaR1mTVbim2GMYEqp
         nimuQ9klg1JQVLMMF+x7yg0n13zZLWRcutNPS/+5t4gWliZKEI3Qqs8ebGbzqh1EzlcT
         wd06LrclkwfisqnbRSaOZ3zEPphrVseL6aJRGhTTJG8kNBHEaOB35N7+yIsVlsdNlbhH
         slmDWhsYaAIva8QPFd8VtLtMHvt55yMLCsD8RnFISLp5PpFDFCbBjGEWDgZwPZXGHoPo
         +q4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2lfcBfmQY62Vm348mWM4CEGfElAKI7bW/B4d2+TFnBY=;
        fh=o78V9uMTlFnHh7zb4uIHyuPebv8Z5Tv9LoiatBjMvr4=;
        b=XV1+g/Pd2klkFeSsO+AKN8DQSikvJmdDI6r249gyvAL/wq8dDqcx2j3zYr8gaAGVpt
         297RRwCdA0R5OgIBfDEdsrqhYfoHzAi5gwNcARmeBrnsHhbahvKndGeDUSGQge+Ix7S5
         nO4z/dT5mT3LOAPnMPHMgqrYbvvm3kdUn3hf/oyXrO/WnZs3bAqN0OtWiVFEdFERfxjD
         tRZ7myR+7OKL3unSBIi12CAlhentHOB2/c3EKRZ+w3ih8z9ZqqtsypvwtJCRIpZvy+tG
         i/4v5A9TN57DDm6lwsY8rZaPgfYGCfSikIVERyGZng+W6yhm7exZA/Pstt/FeJ0m6kuI
         ioVw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788189942; x=1788794742; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2lfcBfmQY62Vm348mWM4CEGfElAKI7bW/B4d2+TFnBY=;
        b=Y6osjXU+kW6Jam4k1IzXYyj3nNibFhcTM+I5jK2qbm9mDMGLIx1hPxjDBoFcNCY3Ec
         DAii1KiqmZyrUsr9JN2gVDNeyqCrHhp7ppAXrD3VGfMSDGE+NlVW7hnC/HL2RdaEqmlB
         /CzW3lzSC43kheUmPJOK9NGmjyaziTpAJD/wtE2Yrtiqg3t6Dqj6DKoTcHpZ0inIA+C3
         mJLg0xbTa5j8x3pRPmt1tG70FqySbqsYXXiIHCn7XWhPArKfZ0/aVxMdNYqukd6XlHMS
         I5mSMCjOcM2g77EFw1hAE5CV8UUIBhzqXuWtKSnsNtvAGGm1FhjU2Spe/7fqtRiQV/tL
         J9OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788189942; x=1788794742;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2lfcBfmQY62Vm348mWM4CEGfElAKI7bW/B4d2+TFnBY=;
        b=rs0yJFPZrNnv3/MSNZeyy6KRTOrYdJAuMULFNLvIRicKjEG6Yu9QXCgE1CE0VDHiNh
         7wiVsydqHPq/OP/IvjuoGm7ZwC0MEQg8VPWNs9jpQWdGylzOe7L6h7t+7adPx52MmXvz
         8QVAnjywYXrfK658xZwiEQycmO3OrXkKpgQGRKYxXYPgKOrvy6IRHgrsqjSpdcwm8CKJ
         GW0Yvsiq8GPjzAa5TxXdepYtbszrCsDlcNpHxpqMeGuIVSVubVcY1vK50Z1I+AqdJIaS
         WAdr33LbuO8hhyJnjnkGZ5deyWeT3UrPoIaBb5V4Zjm474cpEBXizSsIEQorfE7dJBQS
         DaWw==
X-Forwarded-Encrypted: i=1; AKwUvBzngy4mYdZuaqWiLJ5IA9A34LIeQYXOuM032EejVE6GKvhWzCfpGwrhy/cAxNBsah6Kbrg7u45Xwg2hb5g=@vger.kernel.org
X-Gm-Message-State: AFuF++mb6f9mjcX8cvUkVCHEP8j+S14eQZuDsReFFURvzAj4BHcovHxb
	ir9p25XZ2h8FnfPEIlFRjoX+ndPcE8RJVT7RPQonAQ31vqF3wYPJgEJIFdf6Q1COnJSA1bTirp+
	VcyBFrsqP8WooMuQ0EFtm2D0zgWClZA4=
X-Gm-Gg: AYBFou1ch8LbnzFQbLNGsg3j6+8ePWd7kDO0At5sa3q1AYJULBNL5sEgSXXd2WXh9Ln
	cPZlaOkCIb7Dj8J8KDHFG3CGoayD2oRNl6xx+yG9yIRIZfG/Ou12zOlxD4fyxLVW/pTYEQ1VSdE
	YX9cq7hp0v53BAaYY6qn+ooZGnd4ZdUfHc6vTk2ia/X6gCAs2zcvzfvbWI7zPlvSnxfJiD6uqUb
	bO07duppjNw71fqwwXgFV552mRjKfNuBIixCj6vqG96oWTifLJdQPDkFvhaXsnrWo28iZhcx76d
	TlEewyMCPzIg2xNshiP176c+lOSYmeO3UPg2lO5jd7nN4BnesvKA4HARNZeLPxzr3iNA0dRVRoA
	E/vaiRnNp
X-Received: by 2002:a05:690e:480d:b0:66d:132a:875f with SMTP id
 956f58d0204a3-66f87615f57mr469041d50.47.1788189942058; Mon, 31 Aug 2026
 08:25:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260710022854.3739558-1-michael.bommarito@gmail.com>
 <20260710022854.3739558-3-michael.bommarito@gmail.com> <20260831134023.7784374a@pumpkin>
In-Reply-To: <20260831134023.7784374a@pumpkin>
From: Michael Bommarito <michael.bommarito@gmail.com>
Date: Mon, 31 Aug 2026 11:25:29 -0400
X-Gm-Features: AcwNN1XCy_2Zo6asUAI6Mo_MrE5tR1bf4Mf0i1abV1r9A7R-zlEGvrG8uEVg748
Message-ID: <CAJJ9bXzmVKLQopUHTNh7-C4WggMcBJ3s9KShA05piwm9VTMTOg@mail.gmail.com>
Subject: Re: [PATCH 2/2] HID: hyperv: add KUnit coverage for device info bounds
To: David Laight <david.laight.linux@gmail.com>
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, kys@microsoft.com, 
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>, linux-input@vger.kernel.org, 
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 31, 2026 at 8:40=E2=80=AFAM David Laight
<david.laight.linux@gmail.com> wrote:

> This has landed in rc1 and fails to build (with gcc 12.2) because the tes=
ts
> in fortify-string.h detect that is it writing beyond the end of the
> structure.
>  module_exit(mousevsc_exit);

I think Juergen and Jiri already found and fixed this, but it probably
needs to get bumped up to for-linus sooner.  Sorry again for missing
this on the original series.

Thanks,
Mike

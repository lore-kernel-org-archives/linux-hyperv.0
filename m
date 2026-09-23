Received: from mail-wr2-f28.google.com (mail-wr2-f28.google.com [74.125.225.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D61F239CD0A
	for <linux-hyperv@vger.kernel.org>; Wed, 23 Sep 2026 20:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.225.92
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790194533; cv=pass; b=tATSg8zxL7Tqqii/JcQZ/A7iCjAGmW0yO0kj9uK/bCLYJ2FpvvBzYsfr3CxMiCWiYfFS5dduklKMwZ1n/nnWs0jSWEe54v9gWuQT422dWHmjBM8zyDRQeEPiA6l/sZzLbRzmltqGH7a/xo9WE6BBP8Q2Xg/R8Lo6tnNIhI4f4OU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790194533; c=relaxed/simple;
	bh=AG+velq+P1x1sJHq2Eyj+yYuHBfJGE1bCcGBCBjr5A4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V20b42nJ+LPoZ1gTQ1sGUH22O9LzTLSp3t7CNoDkQISkVd6SZCrVyipmz+iAzjsf8aGWWUgBiEfmXhctBfJetblyRYHuFPt5p5nVX/RGLmuUtSHjUzbs4YRUIGwQf5rum/vn/Da7YfB7sckTXramAYRZ8/W5kAoSAzmh9kcNaJQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=n+WEfao5; arc=pass smtp.client-ip=74.125.225.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="n+WEfao5"
Received: by mail-wr2-f28.google.com with SMTP id ffacd0b85a97d-485b1d2874aso1109045f8f.1
        for <linux-hyperv@vger.kernel.org>; Wed, 23 Sep 2026 13:15:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790194526; cv=none;
        d=google.com; s=arc-20260327;
        b=cN0p7npAl+XQhhf6fxiEQmFay0Bl+HLbCo5t3sFy7JhPRHOz63xOimE9ugrMvt6B6G
         lUdMvYP1fyCrZ+HOBsNs/iXLO8s++uajLjONmfey5j1xa8VgeHHdZSyPBo4uK11/0bjx
         QlhIvwDO1jz7WwXfPGDqi+liDYtTslpawMCYx3wuokK8tRUefP4PnsINJG8g8Q6YFA+/
         qzsLth3s9ZNah6a5FeFschWl7S+93n2aMguoBuny0oCInOVicdFaHgab1B2E65/vAcaw
         ZUTm4RfLZPmkHzg8lRSqtBhUqhxnrM5YUYAfpj/pjZX55gKLYOSbvGtLOMSeItusB17v
         kFHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kOoYO2x0ceYQoltgnReOSIDMz30qflbKcG3KVK6oiAM=;
        fh=qPuLy5kXYJF9Ax+Iqna5emRc5JjzUsFxWmVqi59ScXk=;
        b=AuaeFcF3oXFhNllGEyHRtvpVlt/waHVBAbq9BNhgoPKAISAtXs2AvtZZHytZRrYxRt
         m4bKSFSb3iH73KXYY97h9a8pmt0ulPjuKYX+WlSJ9xoIjC3SLUTU48cwB8fbB/9PqoQx
         QG1qsMepK5fQJ5uutrZ7zpLhcuMlf1hWDV3J87KfQHTbd38e7iL86sG2nAG8i+DpbPNr
         1OW7N7X2et2p5rKz4QZBM1kHgll/SAxwgdAtlD3MYgcun9+G3Sutmodn7obNg6WZr1RP
         V3nVeQlEOVdpyOgqfrn6u+NS8+9DsvziWtsFultKM52tgstKS8ZHQ7Im+UpBsk9OKv3q
         bKBQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790194526; x=1790799326; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kOoYO2x0ceYQoltgnReOSIDMz30qflbKcG3KVK6oiAM=;
        b=n+WEfao5P/6A0L77Syn7fH0Vim/5CSlg0pYLAbSFzH1//7tDD9D/BeEd3Rb0VAPv76
         YtRbfWB/XHTEokC2HJC/zSjZdxwdCVHiaw+M3PKD6HPn/ofbo+xffA1xgnWKSm8E8FFm
         G7cuDW78UFof42Dvof0D/hLdt0ZPexYmaYbrT4/WJ3ASJAfBC1Fd4YgJIA4SWIx0A446
         nXk2KhTM64a4kPQxvE1l4/RQaOV+Eix7ZenidKmFT0BeZ2XsuayE0I5mfoaJ9gFJxg8L
         FhlJP+/Fin93pSOt/uyrFWqeGo29d4WokcWgUnfi3rc3a0NVYSbkZCAP2ysDoP0jTeAj
         U4aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790194526; x=1790799326;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kOoYO2x0ceYQoltgnReOSIDMz30qflbKcG3KVK6oiAM=;
        b=Ms6rnklcCgQAfd6vjd5bA1jk5U3Yi6532dipFGXzXHRsJH/Zt4nStdLUgQozsTQvWP
         QlbIBpXSGzMhE66ZwLXQ9R814rmyjxqs3AUNiXY2sNw7EiRAxwlLGHjCwJnSpW33QGO+
         J/mTHayNOdfbLW2ZrGIvcHMgsRl7YNu305O1D7+7+SBAtZIr3mhk0npeQE1PMsjgChbd
         RVDXswElQWCVXN5wH0HdkLkmjjVqH5B52FYAaU659qgnqRn5cXN4wfVO4luyeVNttekE
         IpwuLNYpMtSdaIOtcXAt+iyO08KDDw94HV6IqfnM489BARyAc5tgOZ7e5Qy9zt4AwTCP
         oDjw==
X-Forwarded-Encrypted: i=1; AKwUvByjnKaWoByUOvtdjdrGKEULRK+PhsGCxnlMAEd1wFPxBJ+rWOIyeL8glxES7UFMt4PiAzfx0KcF9BEyib0=@vger.kernel.org
X-Gm-Message-State: AFuF++lt3yM9KVyOU/f+PS07pVdl+mNtPWP1UB7b2PT/MYRjb7YZcTW3
	O1/WzfIQGi1jey9/GaAX57ZHhMpdZab+YDixMyqcvt7jdX/GkUXxiGyu/UZnU+K3XTg5zebEwD8
	xv9HWNZMXylewEZvVCiCnnCQAoErAlfkXd2TfObUJ
X-Gm-Gg: AYBFou2gWsCVkEiBIN9zTzVGoBHBUE1uCXhzzHjG2DnuzrNRuyTyzoSk1vHMlwaQQgR
	vngtfRPdaWfQOayMIU/ZJLNoKxe3oZ272cPgcT1qR1/3XnBn94vZsXOv+xJaxmMzTbmY8oCHYb+
	g9Nlj16qZbp1l4qRoH+rzkzybBUn1zfDZ+4F7GO4wD1I5yWZ+bi45UNGt8DNxMMb0Sq9tZ8hm9B
	wL4tN5eB2tH3ouG/AxsjP//YNuERwS3douTA9HczCTzdp8OTruivf0G5/E74zLMrXDjO8RF7xkg
	RWQq+i2x8qWjJnI90U6QpViqyRV83UTGCV/TysLriYBDVy5Lvq3OHsqsceI1bxGqwmQsfI9MTrJ
	L1UA72VadTQO611CIuusoqlDFA5Qb+qSEsoC9WTqMxy9wkBBt/A8ps6E+tB0aCRAav2MCgba244
	HsrA==
X-Received: by 2002:a05:6000:2383:b0:485:ad55:208d with SMTP id
 ffacd0b85a97d-488716c8d48mr511088f8f.18.1790194525443; Wed, 23 Sep 2026
 13:15:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260911084211.3149957-1-jgross@suse.com> <20260923193619.1408940-1-shreshth.srivastava@intel.com>
In-Reply-To: <20260923193619.1408940-1-shreshth.srivastava@intel.com>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Wed, 23 Sep 2026 13:15:14 -0700
X-Gm-Features: AclHuK-BmScte-vitIZ7FKAidjIiegIYr2tRDSSJKsz3-ZO8Fal-vgtzUYiiixY
Message-ID: <CAKwvOdnKS+E9R3QaFk98dPNNh7uW=8yuJpYWGPHbY7k40Fk=rw@mail.gmail.com>
Subject: Re: [PATCH v5 00/17] x86/msr: Inline rdmsr/wrmsr instructions
To: Shreshth Srivastava <shreshth.srivastava@intel.com>, Juergen Gross <jgross@suse.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, linux-coco@lists.linux.dev, 
	kvm@vger.kernel.org, linux-hyperv@vger.kernel.org, 
	virtualization@lists.linux.dev, llvm@lists.linux.dev, tglx@kernel.org, 
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com, 
	xin@zytor.com, nathan@kernel.org, jpoimboe@kernel.org, peterz@infradead.org, 
	boris.ostrovsky@oracle.com, xen-devel@lists.xenproject.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 23, 2026 at 12:36=E2=80=AFPM Shreshth Srivastava
<shreshth.srivastava@intel.com> wrote:
>
> On 11.09.26 10:41, Juergen Gross wrote:
> > When building a kernel with CONFIG_PARAVIRT_XXL the paravirt
> > infrastructure will always use functions for reading or writing MSRs,
> > even when running on bare metal.
>
> Hi Juergen,
>
> This doesn't build with CONFIG_PARAVIRT_XXL=3Dy. 16/17 and 17/17 are wher=
e
> it breaks, but the cause is the .byte fallbacks: ASM_WRMSRNS_IMM from
> 08/17 and ASM_RDMSR_IMM from 10/17 don't end in a separator, unlike the
> .insn variants above them.
>
>   #define ASM_RDMSR_IMM                         \
>         " .byte 0xc4,0xe7,0x7b,0xf6,0xc0; .long %c[msr]"
>
> That worked while they were only ever the last argument of an
> ALTERNATIVE(), which appends its own newline. 16/17 concatenates them
> with ASM_CLRERR:
>
>         ASM_RDMSR_IMM ASM_CLRERR, X86_FEATURE_MSR_IMM,  \
>
> so the .long operand runs into the xor. From
> make arch/x86/kernel/cpu/common.s:
>
>         .byte 0xc4,0xe7,0x7b,0xf6,0xc0; .long 266xor %rdx,%rdx
>
>   paravirt-msr.h:165: Error: junk at end of line, first unrecognized char=
acter is `x'
>
> clang reports "error: unexpected token" in the same place. 71 objects
> fail, the same 71 either way, no vmlinux.
>
> msr.h chooses between the .insn form and the .byte fallback with:
>
>         #if defined(CONFIG_AS_IS_GNU) && CONFIG_AS_VERSION >=3D 24100
>
> Two kinds of toolchain end up on the .byte side of that test:
>
>   - GNU as older than 2.41. RHEL 9 and CentOS Stream 9 ship 2.35, and
>     Documentation/process/changes.rst sets the minimum at 2.30, so this
>     is a supported configuration rather than an old outlier.
>   - clang, any version. CONFIG_AS_IS_GNU is never set for clang, so the
>     && short-circuits and the version comparison is never reached. Your
>     08/17 comment already notes that clang has no .insn support.

Indeed, looks like we're missing support for .insn for x86.
Filed https://github.com/llvm/llvm-project/issues/225916.
(Please do file bugs against the toolchain when you encounter issues
like this, and cc someone from kernel development).

>
> gcc with binutils 2.41 or newer takes the .insn path, where both macros
> do end in a separator, and is unaffected.
>
> Reproduced on v7.3-rc2 with your v3 00/13, v2 0/5 and v5 00/17 applied in
> that order, x86_64 defconfig plus HYPERVISOR_GUEST, PARAVIRT, XEN and
> XEN_PV. gcc 11.5.0 with GNU as 2.35.2, and clang 21.1.7.
>
> Terminating both fallbacks fixes it, and both toolchains then build
> vmlinux with no errors or warnings:
>
> diff --git a/arch/x86/include/asm/msr.h b/arch/x86/include/asm/msr.h
> index eba325ecfe4c..529c13553c63 100644
> --- a/arch/x86/include/asm/msr.h
> +++ b/arch/x86/include/asm/msr.h
> @@ -78,9 +78,9 @@ static inline void do_trace_rdpmc(u32 msr, u64 val, int=
 failed) {}
>   * form MSR access instructions reference %rax as the register operand.
>   */
>  #define ASM_RDMSR_IMM                          \
> -       " .byte 0xc4,0xe7,0x7b,0xf6,0xc0; .long %c[msr]"
> +       " .byte 0xc4,0xe7,0x7b,0xf6,0xc0; .long %c[msr]\n\t"
>  #define ASM_WRMSRNS_IMM                                \
> -       " .byte 0xc4,0xe7,0x7a,0xf6,0xc0; .long %c[msr]"
> +       " .byte 0xc4,0xe7,0x7a,0xf6,0xc0; .long %c[msr]\n\t"
>  #endif
>
>  #define RDMSR_AND_SAVE_RESULT                  \
>
> ASM_WRMSRNS needs no change, _ASM_BYTES() already emits a semicolon.
>
> The WRMSRNS line belongs in 08/17 and the RDMSR line in 10/17.
>
> Thanks,
> Shreshth



--=20
Thanks,
~Nick Desaulniers

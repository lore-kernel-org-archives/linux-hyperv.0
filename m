Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 146EC423A72
	for <linux-hyperv@vger.kernel.org>; Wed, 21 Jan 2026 07:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768979468; cv=none; b=BDkdtxGu4A+NNZo9Nb0jMCh9h+LdvY8Awd63FpkywiVAlSfxYvBjxR7FRZLQ6UKz2D/zeUyQsvkJqsYgMM3HKH0stMJXnFGdv3hMZO+Zw/+QurSaExCgscnDgZ2Q08Y79nJWAy00+W+1XV0CKvgiFrHhkvSOoioDdNTwrx7N9Ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768979468; c=relaxed/simple;
	bh=BjEonW32c5YOMq0hqq7Xvkwknsp7bLBK5sRV2QqHoDQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ETNBYzezhM0I64oKJFHKZFaygrJadHJC4mVBMhKXxJ93tDR29ygtfk0uy5GPMnO2pGFHhQheBuXxF638ThgfsXxrCTPFu3X5FeCx0j/ylunUclRMumAHYswzPoVbf2dydERIUoqPYPC+5Y7rca0cAhDoElR/Ql2nI8uh7GHuaM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DV9+C+pG; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DV9+C+pG"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-8c537a42b53so936967885a.0
        for <linux-hyperv@vger.kernel.org>; Tue, 20 Jan 2026 23:11:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768979466; x=1769584266; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dr4ikofTW2/lOylz+wqvxKyTxo3lmrOIQRlztmAAggk=;
        b=DV9+C+pGt52IQraSKwXXF5U91ryHMIj/kKAM+XTTnisBxYlxdm6oVGh8e70yc+uRj0
         RltTw5YcaQabCRApC/WidTqznj//N+mAd2PYK13gvPTytgu/Ah+ZGp1Y1FdS//uhoHXG
         DS2SFk3OTIZTMiR/bKeUR9n+7cCpH3x7iRXQbn78BFDX5yZtL3qhceVPTC2cP6t7eblo
         UDFBAEcJrdLyVpZrmzqaNLrO974lhXlhVnl86obfKpfma9wJrSq8+Pc+4VcdDVXYOxQH
         BR8bLp8J48L7REaK5RcITSaKlkZdZT3YtVNUrrfbdaJUG94EJsC6OVAlRJQ0I6tEJPbZ
         5fQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768979466; x=1769584266;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dr4ikofTW2/lOylz+wqvxKyTxo3lmrOIQRlztmAAggk=;
        b=i415KW6QsiaYUqNfACz/63ArbE7RgLy/ariXyD+YVXmsdPEJsRwwCarNntfbHzateV
         AcxD2YxhP/ZFKWJeGz4X/w1kcDr7gSmx0+CU8SQYOJphvC5Jq/cIL1qL01tTvTk66+R0
         DxrpaEDyeh0ptrAcjc9R2eNFWwfyswxETTd6P2xRjfONYju0mQbW72etjaD2TqgVX/Ns
         VpspdOzoCJAHXQrQNbORiZ74BBVFjiQpcpZ17I/RxDYABehePAgVLdZQrmIHBXeSsACP
         EDVdQ/R6Q1O3bK+kx6cYGX0frGKzjNmfPgB9lgNE7fBarK7DMj+6CFtdgIzgWMX2Hl9F
         UWCQ==
X-Forwarded-Encrypted: i=1; AJvYcCUMdB0K6pX7KIl8WEmlRLCd9nu3ILE/fzgzh5mwUUE3RfaDTOwIEi3KsBlAjCXdNrRkJ5XIUzDsSLiRK+M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzi2rb8OWN8KU9XC99iU3CKRz2kMxmuU00MpCWo8/Ci3uBlRXTg
	LqwPyRf0zKVEyuz2kSDfZHILdoUt4/ZhvVBvHSKz765IjbSxwn6uqw5DHdRwlw==
X-Gm-Gg: AZuq6aKhOI7F41YjdrQlVTDxwy2k1l2uMCvKb2H9dOY4NAS8fQKxrMYDjDfXpo3kBJa
	YWQkjxtPoIqAfbJB7spsqKA/dTWjOXn5q774tWVMRGgRbCI3jmyVOHUiWdnZxB3aR/HRPYjQzbL
	zbWYkUzUM3lG+sOANAABSB2APyJm74ZAsGhN8d5w19UQFOgaX9BBa7Xl9ScVIT+qvLHPVIuB0Ld
	EFwk0i8pVTl5+aNEyt8jK/LQLC6onXFZiLo6BuiGmY4wjasZX+Ah4qDr3QmwHPWYReNxx5bJI/Q
	0JI1y/8lU1Rxj8ctfo/sQ90qcD0fyc/bR79wyPk4mZmUbAHn0nRF+9f1BrCyWFgX3GBAfzppAdO
	ZOxYSrF3St5N+lFeW5QMpiIBw82u8eHx5/JBBQ3orCxtmqZ5ZWssFqoYBao6p0yTKLaiPyw9FQP
	ujIVlnNBPEK3E5tQTRYCt5H/BRCTjST4COtww=
X-Received: by 2002:a05:690c:ec4:b0:788:1086:8843 with SMTP id 00721157ae682-793c66b7cd1mr130884437b3.2.1768972588159;
        Tue, 20 Jan 2026 21:16:28 -0800 (PST)
Received: from devvm11784.nha0.facebook.com ([2a03:2880:25ff:74::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-793c6888b83sm60922327b3.48.2026.01.20.21.16.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 21:16:27 -0800 (PST)
Date: Tue, 20 Jan 2026 21:16:26 -0800
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: sgarzare@redhat.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
	mst@redhat.com, horms@kernel.org, bobbyeshleman@meta.com,
	corbet@lwn.net, xuanzhuo@linux.alibaba.com, haiyangz@microsoft.com,
	jasowang@redhat.com, linux-hyperv@vger.kernel.org,
	pabeni@redhat.com, kys@microsoft.com, vishnu.dasa@broadcom.com,
	longli@microsoft.com, linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org, netdev@vger.kernel.org,
	stefanha@redhat.com, berrange@redhat.com, decui@microsoft.com,
	bryan-bt.tan@broadcom.com, eperezma@redhat.com, wei.liu@kernel.org,
	davem@davemloft.net, shuah@kernel.org,
	bcm-kernel-feedback-list@broadcom.com, edumazet@google.com,
	virtualization@lists.linux.dev, sargun@sargun.me
Subject: Re: [net-next,v15,06/12] selftests/vsock: prepare vm management
 helpers for namespaces
Message-ID: <aXBhKlAxxAkvr4/u@devvm11784.nha0.facebook.com>
References: <20260116-vsock-vmtest-v15-6-bbfd1a668548@meta.com>
 <20260121025420.1999992-2-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260121025420.1999992-2-kuba@kernel.org>

On Tue, Jan 20, 2026 at 06:54:21PM -0800, Jakub Kicinski wrote:
> In case you need to respin..
> 
> This is an AI-generated review of your patch.
> For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
> ---
> selftests/vsock: prepare vm management helpers for namespaces
> 
> This commit adds namespace support to VM management helpers and wrapper
> functions, requiring callers to explicitly pass "init_ns" for the init
> namespace. The commit message states "No functional changes for existing
> tests. All have been updated to pass 'init_ns' explicitly."
> 
> > diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
> > index c2bdc293b94c..1d03acb62347 100755
> > --- a/tools/testing/selftests/vsock/vmtest.sh
> > +++ b/tools/testing/selftests/vsock/vmtest.sh
> > @@ -135,7 +135,18 @@ del_namespaces() {
> >  }
> >
> >  vm_ssh() {
> > -	ssh -q -o UserKnownHostsFile=/dev/null -p ${SSH_HOST_PORT} localhost "$@"
> > +	local ns_exec
> > +
> > +	if [[ "${1}" == init_ns ]]; then
> > +		ns_exec=""
> > +	else
> > +		ns_exec="ip netns exec ${1}"
> > +	fi
> > +
> > +	shift
> > +
> > +	${ns_exec} ssh -q -o UserKnownHostsFile=/dev/null -p "${SSH_HOST_PORT}" localhost "$@"
> > +
> >  	return $?
> >  }
> 
> The vm_ssh() function now expects a namespace as its first argument, but
> run_shared_vm_test() still calls vm_ssh without this parameter:
> 
>     vm_oops_cnt_before=$(vm_ssh -- dmesg | grep -c -i 'Oops')
>     vm_warn_cnt_before=$(vm_ssh -- dmesg --level=warn | grep -c -i 'vsock')
>     vm_oops_cnt_after=$(vm_ssh -- dmesg | grep -i 'Oops' | wc -l)
>     vm_warn_cnt_after=$(vm_ssh -- dmesg --level=warn | grep -c -i 'vsock')
> 
> When called as "vm_ssh -- dmesg", the "--" is interpreted as the namespace
> argument. Since "--" does not equal "init_ns", the function sets
> ns_exec="ip netns exec --" which is invalid. The shift then consumes "--"
> and the command becomes "ip netns exec -- ssh ... dmesg" which will fail.
> 
> Interestingly, the v9 version of this patch on lore correctly updated these
> calls to pass "init_ns", but this change appears to have been lost between
> v9 and v15. The fix for this regression is present later in the series in
> commit 3ae984505e00 ("selftests/vsock: add vm_dmesg_{warn,oops}_count()
> helpers").
> 
> [ ... ]

Got it, thank you.

Best,
Bobby

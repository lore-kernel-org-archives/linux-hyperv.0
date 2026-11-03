Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793668147;
	b=xNrMtVX/aRPyb+HLSVJ+C5YpKX1KKe72MH5UqJZkC+kbMkXkNCCggZq3ZGBrxSSeojXO
	 Tk2R+yb10KRTe75tHwwWP69RALhnS6n79a26rQnQdfP1JphtFGfY1DeP9JnqvD2SInwyO
	 9eY95cOFJS0d7fhoC8ihD0R6JPQDxbM3SAYo/mDidF8qKbhTJOSMigAVFPcb1W7pimhS+
	 XGPi064tkq8xhaaaB+apyjb1uI8DKIgv6TVm+ObJnrosCCvSJqaeNuyhd++gTbY4LnA86
	 dOaNwrQPmizIyeJ2FpvDJrCb5O6/lSgLl98JbcblQzyoh98J/mjc+P7XGbzGBsFqrJw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793668147;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=FCSpyoSZLfSkbn+RmO6dWLBRRNTKAaG2kp1vyn+V/lM=;
	b=YxIlI6X1kVs2TKk8bQ2ZuHSVW91rEBBXojIhGpPYkoceLve42MOBlxLqpmSXryYG/X9+
	 mZ+tWUkH89HerLldO5xWUyhCT9fDnSSeZMS81qOK1s2Z6VyCPy6dHL5MV+AavaDaiikzC
	 AKZC/LR5+fKsyDV7sf+9Lnzb77H8OzAVwiEjvvw9zPeEEtv6W7m/u236dGaHlNkz1l/Uk
	 F4PWzhOGysWIVfPI+ChGeyzdCHueOpblpWYRct5K3iSE1qf7skpBGsH7Q3UhXIGQxqDDW
	 BFCj+7LDk2jbzndUHqWz0wl+L7sey9hQSUqNCcMQOqaQVPYxK1QrDYD71/LePvASnvQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dRyh7yrr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68B09606A324;
	Tue,  3 Nov 2026 01:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dRyh7yrr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC7C31F00919;
	Tue,  3 Nov 2026 01:09:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793668147;
	bh=FCSpyoSZLfSkbn+RmO6dWLBRRNTKAaG2kp1vyn+V/lM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=dRyh7yrrEH6N39fdIW1NfYDioN2YeRf8HCyeV9c7ASQz3BWD+LmbcMasYO+oHVfxk
	 R8Lx34ZX2/ZPU9EJYpy2gMKZa4Odj08klB9VN6w07aEkq7r0TD7M/TOfd4ftTXmI8q
	 pdwNcr+O+CDoozeu4d6EjPkfnLx+Eg6UMRL9hLZqCgkXrnZBWjsXL/xfQKXJ68bgdY
	 CNwjj7SwJt/FQvgal/WtYRL/6+jwQT9zXW73JvgJ+N27SikIut5qW9PpepRAcasL30
	 dQPvBZgLI5p6HnRON3uqssTWpzhX97VwvtojUnwXwAwqzO55fq2kp5D2M6kerJmEVx
	 I6EqT2aNavSqA==
Date: Mon, 2 Nov 2026 17:09:05 -0800
From: Wei Liu <wei.liu@kernel.org>
To: Michael Kelley <mhklinux@outlook.com>
Cc: "mdshahid03@gmail.com" <mdshahid03@gmail.com>,
	"haiyangz@microsoft.com" <haiyangz@microsoft.com>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>,
	"decui@microsoft.com" <decui@microsoft.com>,
	"tglx@kernel.org" <tglx@kernel.org>,
	"mingo@redhat.com" <mingo@redhat.com>,
	"bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"hpa@zytor.com" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86/hyperv: use pointed-to type size for page table
 offsets
Message-ID: <20261103010905.GD1862133@liuwe-devbox-debian-v2.local>
References: <20261101082034.134583-1-mdshahid03@gmail.com>
 <MN2PR02MB6863DEE71E0B43A5850ED6C1D46B2@MN2PR02MB6863.namprd02.prod.outlook.com>
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Post: <mailto:linux-hyperv@vger.kernel.org>
List-Help: <mailto:linux-hyperv+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hyperv+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MN2PR02MB6863DEE71E0B43A5850ED6C1D46B2@MN2PR02MB6863.namprd02.prod.outlook.com>

On Sun, Nov 01, 2026 at 10:41:05PM +0000, Michael Kelley wrote:
> From: mdshahid03@gmail.com <mdshahid03@gmail.com> Sent: Sunday, November 1, 2026 1:21 AM
> > 
> > The Hyper-V crash trampoline code calculated page table entry
> > offsets using sizeof() on pointer variables.
> > 
> > Use sizeof(*ptr) instead to calculates the size of the
> > pointed-to page table entry.
> > 
> > This makes entry size explicit and avoids relying on the
> > pointer size matching the page table entry size.
> > 
> > This issue was reported by Coccinelle script noderef.cocci.
> 
> FWIW, this issue was also reported by the kernel test robot.
> See [1] & [2]. So you should probably add "Reported-by:" and
> "Closes: " tags for those reports.
> 
> In any case, the fix looks good to me.
> 
> Reviewed-by: Michael Kelley <mhklinux@outlook.com>
> 
> [1] https://lore.kernel.org/lkml/202603101143.qUL1R1iy-lkp@intel.com/
> [2] https://lore.kernel.org/lkml/202610080503.ivDF5iYX-lkp@intel.com/

Applied. Thanks.

Wei

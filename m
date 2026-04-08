Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA3D533FE27;
	Wed,  8 Apr 2026 01:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775611552; cv=none; b=fW2Bl5E4vqUVI1xfa0mlSubKQ0tY/RxoJDdkvysmHXGN6UJZiKPXyTyfnTQYDu5r0ZW96QiCmNMrMmhFD7s3jgiAHJvRSgjleTE80TjiDhIhCWqbKyPKqjZfYlvtVDAHOh+92hM4+/zd+B+zXj6Swj4pdEyBgwlyG8WDMgZGAmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775611552; c=relaxed/simple;
	bh=k8oSfGzW1JwXiW9u21iFVj0cUB4fPWfPkFGrSbas+z0=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=CqAfyxsV0ABG7R7NqpWs90zPnMIB2zztkKln29MGirxTQPOQ0ARpr1nJ4GmSC1Og6saRo16DsgJpLinvmAfqciQBYsjSWIM0CeqiT9sexUkFb3jmoIpz6qdRcYclSyMUfBQ+l2bL/XtmpBywlc2kj7Z0+KnxYT/jIEjFLxUHK+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=flveBzOo; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="flveBzOo"
Received: by linux.microsoft.com (Postfix, from userid 1241)
	id 83CD520B710C; Tue,  7 Apr 2026 18:25:51 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 83CD520B710C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1775611551;
	bh=k8oSfGzW1JwXiW9u21iFVj0cUB4fPWfPkFGrSbas+z0=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=flveBzOorCkrW9UFg61nx2QHogmEFyttC4VFmyArghUAvkoZuNoKl2ChjtlE8HvUB
	 GPdzy2U4BWPGpKHdnZ8etwNKXSjXdojw5YjHvry0xyoz9RnS1AcIn9QNK+iACx60Wr
	 LgOpi4NzE3kYb8NVH09abcSOAQGkkq8G/+f1f+io=
Received: from localhost (localhost [127.0.0.1])
	by linux.microsoft.com (Postfix) with ESMTP id 7FBA130705A5;
	Tue,  7 Apr 2026 18:25:51 -0700 (PDT)
Date: Tue, 7 Apr 2026 18:25:51 -0700 (PDT)
From: Jork Loeser <jloeser@linux.microsoft.com>
To: Anirudh Rayabharam <anirudh@anirudhrb.com>
cc: linux-hyperv@vger.kernel.org, x86@kernel.org, 
    "K . Y . Srinivasan" <kys@microsoft.com>, 
    Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
    Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>, 
    Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
    Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
    "H . Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>, 
    Michael Kelley <mhklinux@outlook.com>, linux-kernel@vger.kernel.org, 
    linux-arch@vger.kernel.org
Subject: Re: [PATCH v2 5/6] mshv: clean up SynIC state on kexec for L1VH
In-Reply-To: <20260406-hasty-academic-hippo-a4cfb8@anirudhrb>
Message-ID: <ed5ff5-8e5d-5dea-5170-3639a33c7dc8@linux.microsoft.com>
References: <20260403190613.47026-1-jloeser@linux.microsoft.com> <20260403190613.47026-6-jloeser@linux.microsoft.com> <20260406-hasty-academic-hippo-a4cfb8@anirudhrb>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Mon, 6 Apr 2026, Anirudh Rayabharam wrote:

> I believe this code has moved to mshv_synic.c in hyperv-fixes. So, this
> probably won't apply.

Right, this needs a fix.

Best,
Jork

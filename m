Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CDD12BE655;
	Thu, 25 Jun 2026 17:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782409455; cv=none; b=i/gAS6e7q7vlN3jC/zP36ZVp75zdxA4yGveRhoifl6JSD2HA5QQ4XPVKIqhEJ6ZWOva7vstR42SBKM1aTgFihJyBt9q+H4pPBSRwWiGjqMzrd6OxD/6JxCp28EqY/6F54BVFjaHcxDp/lbSYGbEggm1/Yjb20gAaXLEkxbBhlt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782409455; c=relaxed/simple;
	bh=MyA4FF6q29A+3SbH42mR6pdTj/r8DAqnGUJXrBt0b6U=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=QPtgCLP6DRyWdXkciLxUYJGZxfxTrRihYkXfsQc7pChXKbx4vppEq6/U1cJNNCbQO+goAtbuomVfFjJ9k1Wvpdm1ykV9l/EwO8FPErfOx1XU6TNxr3Ei9TyfjLGbykGarZqg0RR4dObqOTx7ev4GGo/uFa9QfIAVA6dCp5CUKak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=VCooPUmw; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="VCooPUmw"
Received: from DairyQueen (unknown [4.194.122.136])
	by linux.microsoft.com (Postfix) with ESMTPSA id 9E9C020B7169;
	Thu, 25 Jun 2026 10:44:02 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 9E9C020B7169
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1782409449;
	bh=Kyjn1XSSFV58s+xzTe6JzUKJQyHLDtnE8CF0wlcJZv4=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:From;
	b=VCooPUmwR/wlrM2n6KX/vnrc83rJeGIC/OlIu/bNZ+mxcX9vX4C0BkVWWe/l5FcFz
	 dzRI9NJWTfCx8eCjt7Sk/EUiLvqOtyf5E2zCLdcVuIJDi3nlfjQ/pw0LYseh5rnOUf
	 etjYJztVs+bKPWObYamRLHTgwhkaBtpqkpMIDCcs=
From: "Kameron Carr" <kameroncarr@linux.microsoft.com>
To: "'Michael Kelley'" <mhklinux@outlook.com>
Cc: <catalin.marinas@arm.com>,
	<will@kernel.org>,
	<mark.rutland@arm.com>,
	<lpieralisi@kernel.org>,
	<sudeep.holla@kernel.org>,
	<arnd@arndb.de>,
	<thuth@redhat.com>,
	<linux-hyperv@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>,
	<linux-arch@vger.kernel.org>,
	<kys@microsoft.com>,
	<haiyangz@microsoft.com>,
	<wei.liu@kernel.org>,
	<decui@microsoft.com>,
	<longli@microsoft.com>
References: <20260609181030.2378391-1-kameroncarr@linux.microsoft.com> <20260609181030.2378391-2-kameroncarr@linux.microsoft.com> <SN6PR02MB4157C9AA6BA2DD14E7697F2BD4E32@SN6PR02MB4157.namprd02.prod.outlook.com>
In-Reply-To: <SN6PR02MB4157C9AA6BA2DD14E7697F2BD4E32@SN6PR02MB4157.namprd02.prod.outlook.com>
Subject: RE: [RFC PATCH 1/6] arm64: rsi: Add RSI host call structure and helper function
Date: Thu, 25 Jun 2026 10:44:04 -0700
Message-ID: <001901dd04ca$3d2d3260$b7879720$@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-us
Thread-Index: AQIqsf51yBS/Or0EhgWD9giRtIuOSwGQcImIAlNLHk21lRJa8A==

On Thursday, June 18, 2026 10:46 AM, Michael Kelley wrote:
> From: Kameron Carr <kameroncarr@linux.microsoft.com> Sent: Tuesday, June
> 9, 2026 11:10 AM
> > diff --git a/arch/arm64/include/asm/rsi_smc.h
> b/arch/arm64/include/asm/rsi_smc.h
> > index e19253f96c940..ffea93340ed7f 100644
> > --- a/arch/arm64/include/asm/rsi_smc.h
> > +++ b/arch/arm64/include/asm/rsi_smc.h
> > @@ -142,6 +142,12 @@ struct realm_config {
> >  	 */
> >  } __aligned(0x1000);
> >
> > +struct rsi_host_call {
> > +	u16 immediate;
> 
> I don't see the "immediate" used anywhere in this patch set.
> Is it always zero for the Hyper-V use cases?  Just curious ...

Yes, the immediate value is always zero for Hyper-V host calls.

-- Kameron


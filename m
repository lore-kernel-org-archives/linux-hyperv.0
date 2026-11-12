Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794511425;
	b=fz5j65U6os4j5/bzY4OB12mG/qvcF/64vvefeC+AyPL1h0+RiGTLmJrJ4qAm1W4beN1N
	 HnZmjIsj09vhV4TtJMC0Ng3DNXBcbSoOd3CmWqTZx21NgFRCP0IFem+PkW+OJbWnukba/
	 hIuZv1WU9YPrOdbDP6+wXXUsUd69pDj1m2KhLRPJA1vipAe5bGpIiaON1GbrHXqGY57Hz
	 B6HqnPf92JOVfr5hbRgJfXiTROai87sVclU/FbAVCpx88p20DOs/FHHC+i/7MVp5WO8tV
	 kbSBpoXKecZr7rnQMAFyaI45K/pFv2I3oVr8teg32uhwQ4OuGQ0FvilJ/91/FdctUcQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794511425;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=/4AacCwXyjEM4aiyhOWViwFiZiWmZmzTtz1jPZz02aw=;
	b=eiLpUcC/b0GmXK8VSjAPkzhqiUswvnh0ayVxszmP8K2ATk/I2ihM3o7tZhgLirD7MKHQ
	 YDDCxkiG4pP2ynncw5J1JF8xdzEohmU45dBp5ExKOb/foVb7HkYBQ0JMK+XOr9hHivLtz
	 x9GP7DcdhWXmer82crTKH8LarxEude7FwICuLjJSi420PQoHf7xrEGt4uRszdZfeLW47U
	 B1nwB7ay1++yo5kt/Nw+zh0dKbmCurNx7njwn7WM2+5KBqbkxKZKWW11sfx84iGJGyv14
	 aC9gMDAxAwHRzjNQmWBZRFJEhnzrjEhzgxWTkXj58zbesinXO5XS2ZtrdOoV7ZOlPcw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=D9B5TVgz;
	arc=none smtp.remote-ip=209.85.219.50
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71B4A606A321
	for <linux-hyperv@vger.kernel.org>; Thu, 12 Nov 2026 19:23:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 71B4A606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=D9B5TVgz
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-91ea3f6a506so1719756d6.0
        for <linux-hyperv@vger.kernel.org>; Thu, 12 Nov 2026 11:23:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794511424; x=1795116224; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=/4AacCwXyjEM4aiyhOWViwFiZiWmZmzTtz1jPZz02aw=;
        b=D9B5TVgz8Jd7oaBGVGeBqm0Wg/G+OfkjJ8YALUnsRwbRAt5U+uv5wEdAMiTvt6CF0d
         mcCPF5k5JqUAnI/J0BhG4kgJpHFXRfLv4BxyqETtnkNMEedoezAkeaeSyyDBS5J4Jqex
         U97CVjR7Pmg503v72rDM7fn0E98SABlEgwocDhw6Iv4vUswSYANH44HatL2S8NlQQqcV
         q0uSvMBAZj6qut3wYcY8dwx1xCUscO7erZgHbcLDYtFZcG4s1Vpa1szP0a0jlskbMRV9
         Xrnlgohyq7Aj9U9pTgh64EvslpuDD3V0EzFWFZSfVuDaDy/j4hF2ZUyAnMjc1UUJ05pK
         Igyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794511424; x=1795116224;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/4AacCwXyjEM4aiyhOWViwFiZiWmZmzTtz1jPZz02aw=;
        b=dpsBb3ldF7u4GfssI+tZBwhkeZd5MKXRALQauigqEPeGDwj7X2OaaYWO2l+w0Rmbek
         O+IWaOs2wwefhyrzehhyUqT6uXCBErvtR67enh6CiGycusMQSvkYNa9veMN4pylIL8Zc
         9ixi2bLXmMChq53k6IBQnZKNajtn+2zOA9hC+QkQmtfR5Ow3g1dJHoFZR0N4pg60Deia
         CArwDBYFBtA858mDqY0f94Zh2tBwyi3v1Ju3Zq07KEsjuJOVdfCz3CPNjFVxMgJuNqam
         cW3Fx1hjnttmTd+xSmnhiBBhwnBPh8d+6Woi2zTbXAecBy0hxovcmR4VRzWVSdCaqFd4
         9QYw==
X-Forwarded-Encrypted: i=1; AL+hErGqkSFUBaPkko91wAV0J59xDksH+VQyzSbD4a5+UCqQJVqefksAP/BwKvww7wfiYSJemOfzhvjh7HhN40s=@vger.kernel.org
X-Gm-Message-State: APuU4Z/3tNeL2lpLRic6q+/Hp+0SFndBiQUo7QTKaIPeRtMm+O+hCpOO
	3w3bJ/uMvVYO2zDjqgXWEju14a5iEnkj4rZe6vpUYSNZfpsJ7idVJjPx
X-Gm-Gg: AYBFou25yem5fWg1XoADswrANiKtSBVIP4JdG+MeW0evIQmqB494We6o6l/zGF1MOr+
	Ge+uWEspo5wxW/EeC2Hd1/CpBQYx/Dv7wIX4HP4Z8xsHRrCFN+aNWbM+7fZXYDr3hseix8bSBFd
	UvV3u3QMeMeuF8O/vxw/r7nkcXjxV8p3vMXFsAQUscpF6iB5ER0FmPpr/EUzLUcWn20j5gMlPEr
	TDMxdDMfds0Jm3Kn9f4rOPpHIameeQUexW8rfszw6eN6/9fSCEOCfLDi3WjTPoRL6+ZCO+zSFdr
	+rnxmG1Vn4qDZB2QuNDwzMhtjvUKOlDWVDmFfF2KvvAFTLKnDuO+c8Ef7AC8FlBkaBxoccFVjkH
	p1JkuhqNAWJyV1UDOLEa5nqdA4qaF8XhXM8dk7PeVX2/gqDSUJFAczz1dllIXlb38OYvIQW9O57
	zVkiPolA2ADl9NqCjXrftCHhMdtAb/r3IfmCojM1Sc4V7b6bL8ZiUxMI61Qx7CThCH4fqCBPGHv
	b18PcdcSN/zvyTl9p/Ip7bxuIXG0pcxSO0uZczUT7R6Acv//2X8U/1YDvUnGg+spJZCNFByRCtD
	mgDt+OvVH7xMIf+ymetK2EcJLRxM/szplUtgyHPKmVTGU+sg+guk
X-Received: by 2002:a05:6214:1c4e:b0:91f:1544:3eff with SMTP id 6a1803df08f44-91f24256486mr4682686d6.51.1794511424421;
        Thu, 12 Nov 2026 11:23:44 -0800 (PST)
Received: from i4-gl-tmk5904.ad.psu.edu ([130.203.156.186])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91f23d780e8sm2938026d6.27.2026.11.12.11.23.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 11:23:43 -0800 (PST)
From: Yuho Choi <oss.patchbox@gmail.com>
To: Wei Liu <wei.liu@kernel.org>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Dexuan Cui <decui@microsoft.com>,
	Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
Cc: Nuno Das Neves <nunodasneves@linux.microsoft.com>,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yuho Choi <oss.patchbox@gmail.com>
Subject: [Question] mshv: unpopulated parts of a movable region after removal
Date: Thu, 12 Nov 2026 14:23:38 -0500
Message-ID: <20261112192341.1412177-2-oss.patchbox@gmail.com>
X-Mailer: git-send-email 2.43.0
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

Hi,

I have a question about how a movable memory region is unmapped when it
is removed (mainline 067c5c24cef2), and would appreciate your view.

When a movable region is created, mshv_map_user_memory() maps its whole
GPA range with HV_MAP_GPA_NO_ACCESS. mshv_region_range_fault() later
fills in the page array and remaps the faulted pages with access, and
mshv_region_interval_invalidate() remaps invalidated pages with no
access again and clears their entries in the page array.

When the region is destroyed, mshv_region_destroy() calls
mshv_region_unmap(), which goes through mshv_region_process_range().
That walk skips the entries that have no page, so only the parts that
currently have pages are unmapped. The parts that were never faulted in,
or were invalidated, are not unmapped. Before commit abceb4297bf8
("mshv: Fix huge page handling in memory region traversal"), the whole
GPA range was unmapped with one hv_call_unmap_gpa_pages() call.

If I read this correctly, the hypervisor keeps those GPAs mapped with no
access after the region is removed. A guest access to them would then
come back as HVMSG_GPA_INTERCEPT rather than HVMSG_UNMAPPED_GPA, and the
mappings would stay until the GPAs are mapped again or the partition is
destroyed.

Is this intended, for example because the hypervisor treats a no-access
mapping like an unmapped GPA? Or should mshv_region_destroy() unmap
these parts as well? If so, does the unmap need to follow how they were
mapped: 4K pages when the region is created, and large pages when an
invalidated range covered a huge page?

I found this during in-house security research and have not reproduced it.

Thanks,
Yuho

Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793381219;
	b=FyaZYGh405ZXDFOmOS0dLxcjQiF4XUi/MYXxb3X2SZZGGPnygIQvOFVlE79zRdsshUQZ
	 df8jXjQij5bDYM4gCTFuxxyDvLnm5cweKgWgklQqriWfP1pexLQBHqFMCPzWZbW8CBQ5+
	 c1qRMhG1A2tV95Kx6zI/0dYLj5PNlcnLBfzAvjgWda2mFpuxhtrpqitcoAPcbV63aoRjh
	 UoGz00lU3eu0Qrg3zG9aLrwDpagwQdYps9ajNANSjKaeiN6yvgBKhRkkh7HlY2HDUU0m6
	 ZeBA2rcsu/GdoOgZNCdfsm5UCKClWgkCM5MXXHPklCCYG9P0KbjKYzJT5M6TN0yvOXQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793381219;
	h=Received:MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:
	 From:To:Cc:In-Reply-To:References:Date:Message-Id:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=YhbJ8D2d+C8fizOD46DNtygIdiUNjhRR7atea0pI5YQ=;
	b=No25HpsyNLL+dMKjp2nDvVUUbsfvcstxRj5dcIoN/z4fcJ3sh4b6VyL0QmTiHATGW47U
	 fmfXFvxcVvROMmiS4wOsBD29AAy87VFcclF9Txa3pTbjr7xhFrlmKXRkOSjY+f9aqVJuz
	 ESDtYdAlKDCL4fMdtLpoJUBt90agn1pK3BOpnmPKWCZZVOLNAcD3zXc1nOYSXOCDXKHEd
	 7VQM92bk9+fvbf9Ba++GZkleEomAHP1At8mOqE2q4kqU+nJV54RZ8V2FttDjVXEUbHA4m
	 vFMWgZbawu5UOYnN8GpA/CT1XePgpYyabhABbailYsua1fMdx55QNq+KJjqdKJGaACw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA5EA606A31C;
	Fri, 30 Oct 2026 17:26:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 204F11F0093A;
	Fri, 30 Oct 2026 17:26:49 +0000 (UTC)
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Post: <mailto:linux-hyperv@vger.kernel.org>
List-Help: <mailto:linux-hyperv+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hyperv+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 2/2] PCI: hv: add vPCI device reset support
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
To: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org, Haiyang Zhang <haiyangz@microsoft.com>, 
 Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, 
 Jonathan Corbet <corbet@lwn.net>, Randy Dunlap <rdunlap@infradead.org>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, linux-doc@vger.kernel.org, 
 linux-pci@vger.kernel.org
In-Reply-To: <20261016235940.942090-2-hamzamahfooz@linux.microsoft.com>
References: <20261016235940.942090-1-hamzamahfooz@linux.microsoft.com>
 <20261016235940.942090-2-hamzamahfooz@linux.microsoft.com>
Date: Fri, 30 Oct 2026 22:56:34 +0530
Message-Id: <179338119431.40615.13050660588258613007.b4-reply@b4>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=931;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=F/vonyMHkkf6/znlM2q7XlW+hKZ4W9pOk2toRa9yycY=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBq5NNYklnr1vxye2qRCcRcak1Vc4Joft4KqfrJx
 AtKxC79joKJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCauTTWAAKCRBVnxHm/pHO
 9drqB/9VIly4BY/vi7aWo8dM6wz1w721vk4eggDZ8vkwhipW/hvReHueDRlqINRnXhO3IdAVtKO
 FzNdioYYUtwsdFCyGXFdix1KZKCbghfYStb+TEwOjsZ6IZjBKc1NpipxkWKvkr09v804+eMV4IA
 wzieHb/ziLm0nzXkmTyYcL46GQxWe9uGDP3/oSjH50RWAw+yU3A08nuVPDCnVUOHb56kuOTfmgH
 jCubO/9K7/BGM8rUv4pOEHTaqpS9kClBCY0CILtypv9jxU/NHHHOSwRsaem1GfJ8bF4SI3IuhHn
 oOSi69hYdrdLBdt+8w7Xvo94AGSZBnRL2ghTHiNt3psTWilS
X-Developer-Key: i=manivannan.sadhasivam@oss.qualcomm.com; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008

On 2026-10-16 19:59 -0400, Hamza Mahfooz wrote:
> Hyper-V vPCI protocol version 1.5 adds a RESET_DEVICE request for
> projected PCI functions. Negotiate the new protocol version and, when it
> is in use, implement the pci_host_bridge::reset_root_port() callback by
> issuing the request through the vPCI VMBus channel.
> 
> Hyper-V has no Root Ports and exposes projected functions directly on
> the root bus, so PCI core uses the callback for the "bus" reset method
> of a function that is the only one on its vPCI bus.
> 
> Use the existing VMBus response path. Return -ENOTTY when the host
> reports STATUS_NOT_SUPPORTED so PCI core may try another reset method.
> 
> Co-developed-by: Wei Liu <wei.liu@kernel.org>
> Signed-off-by: Wei Liu <wei.liu@kernel.org>
> Signed-off-by: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>

Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

- Mani



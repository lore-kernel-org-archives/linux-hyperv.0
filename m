Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793381147;
	b=p9pT7cycw2nhNgFvaRX/zBz/4tNH+erKxF8TmgmoshDyNtCvZxBEKABG5bwXnklXz57c
	 m7PwiaBnTQhYVgMxdj+05NiQplMwIZWN1Aj96W4KIuCqwcf9mKdPl8PbyANBA/SDD7ghn
	 KbbngUuidE5fFFmLqBeFlAScZ8UToS/sro1NKJTfNh9U/v+a99Z/vbMWB6cNCKPobD871
	 +CocPSJOk9gJKVq8I1B823AogSXQuedILkC74CCYKQdBHR6haoLI0hKscZ4gWdToGq4Vj
	 aQZtZ5FRNeT6XsB1QdslNqULaxaaUAmHIqoW8cPa3Q0ymopuCZnUN9EBRHfdJdOgWxg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793381147;
	h=Received:MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:
	 From:To:Cc:In-Reply-To:References:Date:Message-Id:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=qEcBiGuxpfZGb7e81sDCH2DAMHCBYLwIvUaM6w+DQlY=;
	b=TDflBV6upBFm8aWNR7/ekMvy7+IRawEMT6Ynqgm7bSyBf2Cykx7i7rwdTKCHECWPnC+U
	 yFps5sWaSaqJ+Gsdrd7zZ9t/0HDVSiY6gIHPMZtdQ9uigOvfsE/NbPWTdwVoxIy8AGANf
	 bCELGq5WTGJX5M5IWuxsI0uhu1bPfkjqwbEGY5NiX1EBzvSIWElIr0mdYxBxQmmvquaWl
	 mM/wsUL0dwggjw0BPfyQv1IAqeEK62mc1ZV08BpKmmi5GZpAGPCdcOLtbagCcxOjnqv8e
	 xE0KZHK4zFfZpRnzJJ6IRxAWqj2WRUU7rYtEU/Pr8JErcI6UNlgW66RacwEwzynYpgQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D144F606A31A;
	Fri, 30 Oct 2026 17:25:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54E801F000C1;
	Fri, 30 Oct 2026 17:25:37 +0000 (UTC)
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
Subject: Re: [PATCH 1/2] PCI: use reset_root_port() for bus reset of
 devices on a root bus
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
In-Reply-To: <20261016235940.942090-1-hamzamahfooz@linux.microsoft.com>
References: <20261016235940.942090-1-hamzamahfooz@linux.microsoft.com>
Date: Fri, 30 Oct 2026 22:55:21 +0530
Message-Id: <179338112106.40615.4827321915839271885.b4-reply@b4>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1101;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=qFKJOUor3LMQ4SsuP7xhd+tEhe1goMfbMriHEri84BA=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBq5NMR3dwjkI+C0ahKLdurv2I+jDCswD1Rvjm3H
 XdixbPX0HOJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCauTTEQAKCRBVnxHm/pHO
 9YyXB/9qSkYkSWIBenPTULx0UP+f/aNeUH/mYC0PM2nIYQ4Xvq6462pqOnurOFkbjzNXEowD2sJ
 sT4v1in/noEBDDQsBg2HCdPigIwZkaAnDDdraHEWh5XpQnmFjpsLWU4a4WQfyFa2gKkJP+xHVTw
 jrumYSdJFEyt1uK8zq9wvNqmCYhqUfaoyNtFdQrxRdnaNdglP/evAcN4xoKR+yz6AUsRR5x/w85
 Kf53Gl9byzqLo9cE2P/ZDXPgHBdUSl5mh0O+fW3ObRlVoJvU4D1V5jx7bCAfx4+715bwDnpxcCL
 4myxUNBgASvOEfwGlIIb/42PbfArtT5eyeiOPizE4zRwPnMF
X-Developer-Key: i=manivannan.sadhasivam@oss.qualcomm.com; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008

On 2026-10-16 19:59 -0400, Hamza Mahfooz wrote:
> The "bus" reset method resets a device by asserting Secondary Bus Reset
> on its upstream bridge, so it is not available for a device on a root
> bus, which has no upstream bridge.
> 
> Some platforms have no Root Ports and expose PCI devices directly on a
> root bus, e.g., Hyper-V vPCI places each assigned PCI function directly
> on the root bus of a virtual host bridge. Such a device has no reset
> method at all if it supports neither FLR nor PM reset, even if the
> platform is able to reset it.
> 
> pci_host_bridge::reset_root_port() already allows a host bridge to reset
> a device on a root bus in a platform-specific way, so far only in place
> of a Secondary Bus Reset by a Root Port. Use it for the "bus" reset
> method of a device that is the only device on a root bus, and wait for
> the device to become ready afterwards, as is done for other reset
> methods.
> 
> Signed-off-by: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>

Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

- Mani



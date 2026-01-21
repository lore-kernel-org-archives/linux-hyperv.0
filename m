Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 927F9271A9A;
	Wed, 21 Jan 2026 02:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768964080; cv=none; b=W2+Ba1AU1IGCKPX1R9em1ef+pz1mwnUYJ69L1C/Wbz5qFa3ZERe7Lwzb+RagWBpyU8KlYG9q3FVKNfeGbbnLb131qiA1P2OvRgVrn8Yr3mz/zxCHWKMrqKyudmNiRTtUVUW5vl3thXsxtPEvb98ND4um3K42x0PaiH7UfH5frBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768964080; c=relaxed/simple;
	bh=TIlXfufaQqj6LTdjbzk1q92qYzxDMCtuVIRH+l5iFZU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j7UVwGsHXDB2pN4zuK+aetoWhaLFqRM3HwYW7OC+yc0Zwnj6hJdzAXrihDp53TKz/VyrJV2RW+qzH+WsU+mzel/hCkDE33urYlFugQPbmnt4XFUTRo2S10mgfOvFwAvNQzOeA3EZHphgUPn1pxKlwPgP3KJdgoNpPHtMWGUnOQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A428TEJc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A428TEJc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF009C16AAE;
	Wed, 21 Jan 2026 02:54:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768964080;
	bh=TIlXfufaQqj6LTdjbzk1q92qYzxDMCtuVIRH+l5iFZU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=A428TEJchUatkmEAey+yhDf1jtpU4cdJjHdKGMhIAMKPgPczAikb2496oVHVtixNq
	 5iCGnH0TChP9PGq1SGnf4vkogSdrJK1DyHqbIH5uBuRIpNSbue+7VCD/irIUe00IqC
	 lP0FpIcaDi6okYKNJWGvGWapp53FH6FKN65tmR9G1YojFkO/MpYQGQ1dBautXNGgk1
	 6prR/osTet9ZnIEtXDqGKQixNnTSE0e/8V3BA9S5ibOTpsgL4ExX4sXc7rYafN960W
	 kdFJ3aH+iZnMqKThqiCQ7muWPGGEodVgqkofKNr801+Io0kYKM6fSLdASctjCcq7BC
	 +Lf8jZDjia2EQ==
From: Jakub Kicinski <kuba@kernel.org>
To: bobbyeshleman@gmail.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	sgarzare@redhat.com,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mst@redhat.com,
	horms@kernel.org,
	bobbyeshleman@meta.com,
	corbet@lwn.net,
	xuanzhuo@linux.alibaba.com,
	haiyangz@microsoft.com,
	jasowang@redhat.com,
	linux-hyperv@vger.kernel.org,
	pabeni@redhat.com,
	kys@microsoft.com,
	vishnu.dasa@broadcom.com,
	longli@microsoft.com,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	netdev@vger.kernel.org,
	stefanha@redhat.com,
	berrange@redhat.com,
	decui@microsoft.com,
	bryan-bt.tan@broadcom.com,
	eperezma@redhat.com,
	wei.liu@kernel.org,
	davem@davemloft.net,
	shuah@kernel.org,
	bcm-kernel-feedback-list@broadcom.com,
	edumazet@google.com,
	virtualization@lists.linux.dev,
	sargun@sargun.me
Subject: Re: [net-next,v15,06/12] selftests/vsock: prepare vm management helpers for namespaces
Date: Tue, 20 Jan 2026 18:54:21 -0800
Message-ID: <20260121025420.1999992-2-kuba@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260116-vsock-vmtest-v15-6-bbfd1a668548@meta.com>
References: <20260116-vsock-vmtest-v15-6-bbfd1a668548@meta.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In case you need to respin..

This is an AI-generated review of your patch.
For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
selftests/vsock: prepare vm management helpers for namespaces

This commit adds namespace support to VM management helpers and wrapper
functions, requiring callers to explicitly pass "init_ns" for the init
namespace. The commit message states "No functional changes for existing
tests. All have been updated to pass 'init_ns' explicitly."

> diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
> index c2bdc293b94c..1d03acb62347 100755
> --- a/tools/testing/selftests/vsock/vmtest.sh
> +++ b/tools/testing/selftests/vsock/vmtest.sh
> @@ -135,7 +135,18 @@ del_namespaces() {
>  }
>
>  vm_ssh() {
> -	ssh -q -o UserKnownHostsFile=/dev/null -p ${SSH_HOST_PORT} localhost "$@"
> +	local ns_exec
> +
> +	if [[ "${1}" == init_ns ]]; then
> +		ns_exec=""
> +	else
> +		ns_exec="ip netns exec ${1}"
> +	fi
> +
> +	shift
> +
> +	${ns_exec} ssh -q -o UserKnownHostsFile=/dev/null -p "${SSH_HOST_PORT}" localhost "$@"
> +
>  	return $?
>  }

The vm_ssh() function now expects a namespace as its first argument, but
run_shared_vm_test() still calls vm_ssh without this parameter:

    vm_oops_cnt_before=$(vm_ssh -- dmesg | grep -c -i 'Oops')
    vm_warn_cnt_before=$(vm_ssh -- dmesg --level=warn | grep -c -i 'vsock')
    vm_oops_cnt_after=$(vm_ssh -- dmesg | grep -i 'Oops' | wc -l)
    vm_warn_cnt_after=$(vm_ssh -- dmesg --level=warn | grep -c -i 'vsock')

When called as "vm_ssh -- dmesg", the "--" is interpreted as the namespace
argument. Since "--" does not equal "init_ns", the function sets
ns_exec="ip netns exec --" which is invalid. The shift then consumes "--"
and the command becomes "ip netns exec -- ssh ... dmesg" which will fail.

Interestingly, the v9 version of this patch on lore correctly updated these
calls to pass "init_ns", but this change appears to have been lost between
v9 and v15. The fix for this regression is present later in the series in
commit 3ae984505e00 ("selftests/vsock: add vm_dmesg_{warn,oops}_count()
helpers").

[ ... ]

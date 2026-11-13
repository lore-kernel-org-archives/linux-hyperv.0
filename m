Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=67.231.153.30
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794608360;
	b=xuHx19w2JsklPWjj9XXNtDrPzHWkCdHxHfBqrXFTvHsMRt0LKtMfv+rN8z0oAHLsjrhR
	 pWvYj5llgq4R4hZjv9EYwlPdHIwJdQZoh8qC3HfBATz00bK196eKcgBhTOBpwYgl+rXua
	 12vz5VMMQ2YALKRlqyfb9N3e36c+015mGIVE8/x9ppXciifudtXzP9UiySHTfVRCTUQeU
	 VZVdyOSZc7dcQvkNCYBuhUaEU9aJcz+eXujDArjZc5K8C5MHXMANYuHTywCOXk8zRb0gm
	 L6+u/1MnUtHH8FcCHq+P3Qw0kk1UtRZGTLWclopf+UyVRjM1wk8f/PjMg72w4DGjxAA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794608360;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Date:From:To:
	 CC:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Originating-IP:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version;
	bh=ZDL7kXyt7WwjaGJ1SXFge2rl21xtcx6hAbbsI011aaE=;
	b=2scJKln6hM4N5/Vr2i3HVR73cZti7DKXrhiIksddgYUxcbnJhIGjNop5mClp7JV49qhe
	 1xP+MhORjWsoYlM4W2G9HfFSbvIXjCMrE1f5CwRAhS55enCTzagzvyciJoy1bM2MqU9F/
	 /nMxOSbj9FCPwRwr4fFWRAnwB7Yl/P6M3ViZZ8IjzxnnetU7IR3wKOONj07KizXwzkEoR
	 32ylglUzpxpbisIO4xyPbHLbtSMeP4G8SRzHjAksDag+LnLgx95/+yyvXNfVhaM10StMI
	 YYDvl4Kp1uBEOT0MccuH04S4pRuUFs//riuGPdy05GW2yPCdLqUaO7vhMezRfGEUPrQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=meta.com;
	spf=pass smtp.mailfrom=meta.com;
	dkim=pass header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=atfQbPq1;
	arc=none smtp.remote-ip=67.231.153.30
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1C10606A331;
	Fri, 13 Nov 2026 22:19:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C1C10606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=atfQbPq1
Received: from pps.filterd (m0528005.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ADLf3Sw2290563;
	Fri, 13 Nov 2026 14:18:46 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pps82601-s2048-2026-q3; bh=ZDL7kXyt7Ww
	jaGJ1SXFge2rl21xtcx6hAbbsI011aaE=; b=atfQbPq1mZZE7xg0r2BiZNRROv5
	0ygk4878pD+ht+eCR4JRJPI3xzVQZaaVuZlzIg0ZZW3OOZzDx1oT2YzeJvYMbUZ/
	5Svl5S/q91AR1hi/vskZlPPR7SyJifZWCsg404dFFTWq+geVFKhDyO8f3ui6iuh1
	fSL1yaxFOLtzOFpzIEpV7trkAYuCYky+QjqBJvnH1PnIf85oKVaZeKmtQTLBfECD
	HixXpw8UwLI9CjnNY6da1kiQYZFM1ibyPDKpGCw34yBjUAhx35HLPhUqHrGE5C/x
	wrrjqQlmvvzq2+DoBgLAzAjXVXKjKcIKCufAHlHjiTeewVmDSSbvoWhxvGQ==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4hws2jen4c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Fri, 13 Nov 2026 14:18:46 -0800 (PST)
Received: from localhost (2620:10d:c0a8:fe::f072) by mail.thefacebook.com
 (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.56; Fri, 13 Nov
 2026 22:18:45 +0000
Date: Fri, 13 Nov 2026 14:18:44 -0800
From: Bobby Eshleman <bobbyeshleman@meta.com>
To: Sergio Lopez <slp@redhat.com>
CC: Stefano Garzarella <sgarzare@redhat.com>,
        Alexei Starovoitov
	<ast@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet
	<edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Bryan Tan
	<bryan-bt.tan@broadcom.com>,
        Vishnu Dasa <vishnu.dasa@broadcom.com>,
        Broadcom
 internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
        Stefan
 Hajnoczi <stefanha@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason
 Wang <jasowangio@gmail.com>,
        Eugenio =?iso-8859-1?Q?P=E9rez?=
	<eperezma@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Haiyang Zhang
	<haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
        Dexuan Cui
	<decui@microsoft.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Randy Dunlap
	<rdunlap@infradead.org>,
        <virtualization@lists.linux.dev>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>,
        <bpf@vger.kernel.org>, <linux-hyperv@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, <linux-doc@vger.kernel.org>
Subject: Re: [PATCH RFC v3 0/8] vsock: add datagram support to virtio and
 vhost
Message-ID: <aveMxDqYQobWwXd/@devvm29614.prn0.facebook.com>
References: <20261113-vsock-dgram-support-v3-0-1523c8e9b27e@redhat.com>
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Post: <mailto:linux-hyperv@vger.kernel.org>
List-Help: <mailto:linux-hyperv+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hyperv+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20261113-vsock-dgram-support-v3-0-1523c8e9b27e@redhat.com>
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEzMDA4OCBTYWx0ZWRfXy1pEywpltXJZ
 fi29aNAZBkLmnDve+LYeZjeaPasuQdBIYGU0/k4s/Lv5zKUnecQr44aJlQgPza37ZH2ROhRch+b
 ZN+FNLnRFRJHtfM1ghHfA+7guRcxWOQ=
X-Authority-Analysis: v=2.4 cv=B7QsQ+tM c=1 sm=1 tr=0 ts=6af78cc6 cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=kj9zAlcOel0A:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=7x6HtfJdh03M6CCDgxCd:22 a=jCddH8ec0KUNCymVuxII:22 a=VwQbUJbxAAAA:8
 a=20KFwNOVAAAA:8 a=968KyxNXAAAA:8 a=NEAV23lmAAAA:8 a=mDV3o1hIAAAA:8
 a=KMMIYZg5AAAA:8 a=L39VyhZRsO6TyX6WEsEA:9 a=CjuIK1q_8ugA:10
 a=dU3it2pj8zK4A0baVwjB:22
X-Proofpoint-ORIG-GUID: wGeIOwDQqIjkaQSIxGgtwy4OFXJwS09X
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEzMDA4OCBTYWx0ZWRfXxYIJ4L38x7h+
 TGQGGJ8/Ad4QxYUTpMW58tNlQviHePIXiWtIUCzuKluLeXnYUMZdZL8qO/Kjuil6Q169Aml9GDJ
 LGahCU42NKL2qMTQjdt1iwQSI7kSo7B89G00EDBrDW6hAMrvkEovHPn8d5DyXgMNa0QimOlaKV4
 A+4TCskPxkjsS1SWndxq0snSS+s13/KcTw/L0aWz3fWGD610dZOZYu+Wh0SPXnaPytthqYAPqkQ
 TZZBrMaqnBQYEtj5QEPPFOPuPNHySBImezI8HZb7c3VDSBK9IAnygdW8OsEyOjrsLQi9fhhlnJT
 bxsO1l+3gJlCM/sMbr3OYdT5LJM5J5NeL5r70FRG3rLHmmGT8uVd2kGE5TkuFWV4Elc4JA3FdLW
 p3Wn9rAGmugx+eUcmkxDBQtVA8A08tp1yvqq/kDImjVbNVmNRuFv9itoy7WFdRB116m6R0DCg7Z
 IfyfiVXfzlvATa0Wd1g==
X-Proofpoint-GUID: wGeIOwDQqIjkaQSIxGgtwy4OFXJwS09X
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-13_06,2026-11-11_03,2025-10-01_01

On Fri, Nov 13, 2026 at 06:15:40PM +0100, Sergio Lopez wrote:
> This RFC adds SOCK_DGRAM support to virtio-vsock and vhost-vsock through
> the existing AF_VSOCK API. It is intended for guest and host services
> that exchange independent requests, responses, or events and need message
> boundaries and sender addresses without a stream connection or application
> framing.
> 
> VIRTIO_VSOCK_F_DGRAM gates virtio traffic in both directions. Each virtio
> send carries zero to 64 KiB of payload in one VIRTIO_VSOCK_TYPE_DGRAM
> packet. On the RX virtqueue, the device may split a datagram across
> page-sized guest buffers.
> START and EOM delimit the message; the guest reassembles at most 64
> fragments and 64 KiB before delivering it to a socket. Invalid or
> incomplete messages are discarded. Datagram delivery is best effort:
> there are no peer credits, acknowledgements, or retransmissions. Send
> admission uses the socket send-memory limit, and SIOCOUTQ reports charged
> send memory.
> 
> Datagram sockets have a separate port space from stream and seqpacket
> sockets. The latter two continue to share their port space. Datagram
> routes are chosen per destination among guest-to-host, host-to-guest, and
> loopback transports, with VMCI as a fallback. VMCI still owns its socket
> handle when it is present; loopback works without a directional transport.
> Hyper-V continues to reject datagram sockets.
> 
> The Sashiko review of v2 also reported that a VMCI datagram bind in a
> local-mode network namespace creates a receive handle in VMCI's global
> port space, so a sender outside the namespace can deliver datagrams
> across the namespace isolation boundary. The issue predates this series
> and it's getting addressed in a separate patch:
> 
> https://lore.kernel.org/all/20261113-vsock-vmci-netns-isolation-v1-1-ced02054ea61@redhat.com
> 
> Within this series, local-mode namespaces bind datagrams only in the
> core table and never create a VMCI handle.
> 
> Bobby Eshleman and Amery Hung explored this feature in their v6 series
> and v7 work-in-progress branch. This series is a fresh implementation
> against the current vsock code. It follows the separate datagram port
> space, per-destination routing, and VMCI fallback requirements discussed
> there. For guest receive buffers, it uses bounded fragmentation and
> reassembly rather than full-message buffers or the earlier drop/error
> queue approach:
> 
> https://lore.kernel.org/r/20240710212555.1617795-1-amery.hung@bytedance.com
> https://github.com/ameryhung/linux/tree/vsock-dgram-v7
> 
> A corresponding virtio specification update has been drafted separately.
> The wire format and feature negotiation still need specification review
> before this series can be considered for merging.
> 
> The first patches expose the core port allocator and add datagram queue
> reporting, then implement the common data path, guest and host feature
> negotiation, routing, and RX fragmentation. The last patch extends
> vsock_test with local and peer tests for message boundaries, routing,
> connected peers, port sharing, queue accounting, and delayed reads.
> 
> Testing used QEMU with the F_DGRAM property patch below, an x86-64
> KASAN/lockdep kernel, paired guest tests, and a nested Linux vhost-vsock
> backend. The tested paths include 64 KiB messages, delayed-read bursts,
> feature-disabled ingress, stream and seqpacket controls, and header-only
> guest RX buffers. A temporary userspace backend still fails stream test
> 21 on both the series base and tip; that case passes with Linux vhost.
> VMCI's host personality was exercised in a QEMU guest, including
> coexistence with virtio and self-send without loopback. A VMware VMCI guest
> device and Hyper-V hardware were not exercised.
> 
> https://lists.gnu.org/archive/html/qemu-devel/2026-10/msg08074.html
> 
> Code was written and reviewed both manually and assisted by Codex
> (GPT-6.1-Sol) and Claude (Opus 4.6).
> 
> Signed-off-by: Sergio Lopez <slp@redhat.com>
> ---
> Changes in v3:
> - Preserve Hyper-V stream routing and prefer virtio for guest CID_HOST
>   datagrams (thanks to Sashiko AI bot).
> - Bind explicit non-VMCI CIDs and local-mode sockets without a VMCI
>   handle, resolve wildcard destinations, and retain VMCI self routes
>   (thanks to Sashiko AI bot).
> - Recheck bound addresses after receive takes the socket lock and set
>   TO_HOST only for forwarded guest sources (thanks to Sashiko AI bot).
> - Probe negotiated virtio datagrams and numeric local CIDs before running
>   dependent tests; cover wildcard and VMCI coexistence (thanks to Sashiko
>   AI bot).
> - Link to v2: https://lore.kernel.org/r/20261113-vsock-dgram-support-v2-0-bacfc85b71ce@redhat.com
> 
> Changes in v2:
> - Keep guest RX buffers page-sized; add START/EOM framing and bounded
>   datagram reassembly (thanks to Alexei Starovoitov and Bobby Eshleman).
> - Preserve stream and seqpacket data when an RX buffer has no payload
>   room.
> - Separate datagram and connection-oriented port spaces, and share
>   receive metadata and queueing (thanks to Alexei Starovoitov).
> - Check negotiated support and destination CID on ingress, and require
>   an exact connected peer CID and port (thanks to Sashiko AI bot).
> - Select a capable route for each destination, retain VMCI as fallback,
>   and support loopback-only sockets (thanks to Alexei Starovoitov).
> - Preserve the connected peer address across temporary parent fallback
>   (thanks to Sashiko AI bot).
> - Use socket write-memory accounting for datagram SIOCOUTQ instead of
>   separate transport counters (thanks to Alexei Starovoitov).
> - Extend selftests for fragmentation, delayed reads, port sharing,
>   connected peers, and capability-based skips; fix the test build and
>   README entries (thanks to Alexei Starovoitov, Bobby Eshleman,
>   and Sashiko AI bot).
> - Link to v1: https://lore.kernel.org/r/20261028-vsock-dgram-support-v1-0-e457cf7cee78@sinrega.org
> 
> ---
> Sergio Lopez (8):
>       vsock: expose the core port allocator to transports
>       vsock: report datagram receive and send queue state
>       vsock/virtio: implement the datagram data path
>       vsock/virtio: negotiate datagram support on the guest
>       vhost/vsock: negotiate datagram support with guests
>       vsock: allow datagrams to use directional transports
>       vsock: fragment datagrams across receive buffers
>       vsock: add datagram tests to vsock_test
> 
>  Documentation/admin-guide/sysctl/net.rst |    8 +-
>  drivers/vhost/vsock.c                    |   51 +-
>  include/linux/virtio_vsock.h             |    8 +-
>  include/net/af_vsock.h                   |   31 +-
>  include/uapi/linux/virtio_vsock.h        |   10 +
>  net/vmw_vsock/af_vsock.c                 |  526 +++++++++++----
>  net/vmw_vsock/hyperv_transport.c         |   11 +-
>  net/vmw_vsock/virtio_transport.c         |  167 ++++-
>  net/vmw_vsock/virtio_transport_common.c  |  172 ++++-
>  net/vmw_vsock/vmci_transport.c           |  124 ++--
>  net/vmw_vsock/vsock_bpf.c                |    3 +-
>  net/vmw_vsock/vsock_loopback.c           |    2 +-
>  tools/testing/vsock/Makefile             |    3 +-
>  tools/testing/vsock/README               |   33 +-
>  tools/testing/vsock/util.c               |   62 +-
>  tools/testing/vsock/util.h               |   10 +
>  tools/testing/vsock/vsock_test.c         |  175 ++++-
>  tools/testing/vsock/vsock_test_dgram.c   | 1061 ++++++++++++++++++++++++++++++
>  tools/testing/vsock/vsock_test_dgram.h   |   30 +
>  19 files changed, 2195 insertions(+), 292 deletions(-)
> ---
> base-commit: 65ba8f34ec886ec72b2c07ddc8cf3d815c32869d
> change-id: 20261027-vsock-dgram-support-683a4e0aebe7
> 
> Best regards,
> -- 
> Sergio Lopez <slp@redhat.com>
> 

Hey Sergio,

Just a gentle heads up that net-next asks for 24hrs before reposting.

I'll start working my way through the series, sorry if my reviews come
back spread out across a few days, not sure I'll have enough time in a
single sitting.

Best,
Bobby

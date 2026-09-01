Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4B172C0F8C
	for <linux-hyperv@vger.kernel.org>; Tue,  1 Sep 2026 04:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788235559; cv=none; b=KipMr4NT4Vzt5YbS04KdkDg9idDIRXvPsFsa5Sv1KKZlrhxINS2/nuQXWfBliQ1+vmYkvYjOp0sQNcdVqtCUXIeyxcWgzELW0Tjs1KDRAprcrnPFh/m3aOmENGduorbxKIkbKZ6WAzPQSch0ZOD7N4dPbtY5GM3/dyOeY05zsdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788235559; c=relaxed/simple;
	bh=XYdMVZey5xVchoTkQExDtQehJbreh4yYr7Ck4XxfYeU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=DUC01kTXES07JNZeCf1Y86CG5NOm78qhUfYvl6kdkM1+8h3jU4xrpO5et9FCqwezUFYbBYy1nSGQOlxOOYUlEI3rdQQcbVUG1KVeZMeB1Aq3P1jQarQ7gkZWBlV17tCN6NnCXOh7QnLzArGC47q7D8WkqKWG5q5ORk5CDya2Jjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L9TFq8jJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L9TFq8jJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21BA41F000E9;
	Tue,  1 Sep 2026 04:05:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788235558;
	bh=x90QJBktFk9L7Mc597eypXVbfTg2qG1GcAMv9gN9SOc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=L9TFq8jJ7WgjFwa1lFFW2N8B2fUX1nVEB31rJEDGWEgDnn0Qck/nJYfgyglMqXGKt
	 NjztomVJIkFc/1gu8W53vsREeyw4P5EUjYUhG0LPFQ4zmfd6NimeBzlP35HY87FJoS
	 hispDNrmbgbPl9z3R+oPLgjZNQu+BF6qfYJcCoS+JShYDZql6KtqZ/rxDRnf/wazl3
	 5cqpIr2beu0mUXYQKTnh5r4AJPlEcweQ+P8RmSjguzzWKzqoQdZtGWNeZd2IZD+pw+
	 qgWY2Abx2vmoyPNTEutUFp6oMdQI4PcalOubaGEYIoXCosFKi6YJYwDx6a110YLSoj
	 rxr1YfwhxHcGA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/1] Drivers: hv: Don't reset VMBus connection state on
 error/exit paths
Reply-To: sashiko-reviews@lists.linux.dev
To: "Michael Kelley" <mhkelley58@gmail.com>
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <20260901034514.457089-1-mhklinux@outlook.com>
References: <20260901034514.457089-1-mhklinux@outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 04:05:57 +0000
Message-Id: <20260901040558.21BA41F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Unchecked return value from vmbus_post_msg() leading to an infinit=
e wait during driver unload.
- [High] Destroying workqueues in vmbus_disconnect() before disabling VMBus=
 interrupts leads to Use-After-Free if an asynchronous message is received.
--

commit bf55ca432bc98fbbbbd08f5b33b12b8f32d7705a
Author: Michael Kelley <mhkelley58@gmail.com>

Drivers: hv: Don't reset VMBus connection state on error/exit paths

This patch fixes an issue where the VMBus connection state was forced to
disconnected before calling vmbus_disconnect(). This prevented the
connection from being properly unloaded since vmbus_initiate_unload()
checks for the connected state. By leaving the connection state as is,
the hypervisor connection can be cleanly torn down.

Closes: https://lore.kernel.org/linux-hyperv/20260805205806.B5AC31F000E9@sm=
tp.kernel.org/
Fixes: 74347a99e73ae ("x86/Hyper-V: Unload vmbus channel in hv panic callba=
ck")

[ ... ]

> diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> index 5ebdbe24b5a1e..547bc731114fd 100644
> --- a/drivers/hv/vmbus_drv.c
> +++ b/drivers/hv/vmbus_drv.c
> @@ -3043,7 +3043,6 @@ static void __exit vmbus_exit(void)
> =20
>  	hv_remove_kexec_handler();
>  	hv_remove_crash_handler();
> -	vmbus_connection.conn_state =3D DISCONNECTED;
>  	hv_stimer_global_cleanup();
>  	vmbus_disconnect();

[Severity: High]
This isn't a bug introduced by this patch, but since this patch allows
vmbus_initiate_unload() to actively execute during vmbus_disconnect(),
does this expose a potential infinite wait?

Looking at vmbus_initiate_unload(), the code unconditionally waits for a
completion event even if the message posting fails:

drivers/hv/channel_mgmt.c:vmbus_initiate_unload() {
        ...
        vmbus_post_msg(&hdr, sizeof(struct vmbus_channel_message_header),
                       !crash);

        if (!crash)
                wait_for_completion(&vmbus_connection.unload_event);
}

If vmbus_post_msg() fails (for example, due to insufficient buffers),
the event will never be signaled by the host, causing the module unload
process to hang indefinitely. Could the return value of vmbus_post_msg()
be checked to prevent this?

[Severity: High]
This is also a pre-existing issue, but does the teardown ordering here
allow a use-after-free if an asynchronous message arrives during unload?

The current sequence calls vmbus_disconnect() which destroys the work
queues:

drivers/hv/connection.c:vmbus_disconnect() {
        ...
        if (vmbus_connection.work_queue)
                destroy_workqueue(vmbus_connection.work_queue);
        ...
}

However, VMBus interrupts and DPC tasklets are left active until later
in vmbus_exit():

drivers/hv/vmbus_drv.c:vmbus_exit() {
        ...
        vmbus_disconnect();

        if (vmbus_irq =3D=3D -1)
                hv_remove_vmbus_handler();
        else
                free_percpu_irq(vmbus_irq, &vmbus_evt);
        ...
        for_each_online_cpu(cpu) {
                struct hv_per_cpu_context *hv_cpu =3D ...
                tasklet_kill(&hv_cpu->msg_dpc);
        }
}

If the hypervisor delivers an interrupt after vmbus_disconnect() returns
but before the DPC tasklets are killed, __vmbus_on_msg_dpc() can run and
attempt to queue work using the destroyed workqueue pointer:

drivers/hv/vmbus_drv.c:__vmbus_on_msg_dpc() {
        ...
        default:
                queue_work(vmbus_connection.work_queue, &ctx->work);
}

Should the interrupts and tasklets be disabled prior to freeing the
workqueues to avoid this race condition?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260901034514.4570=
89-1-mhklinux@outlook.com?part=3D1

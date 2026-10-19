Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A4C23F65EE;
	Mon, 19 Oct 2026 05:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792387989; cv=none; b=PVwvUibTnIrB8I7BBAx/s9TEF7eseV6fhMiRgRclMtqiBn7qOUlDZNHb4uTRc3qBXeqriGn/ZBSIsNGJts7ayX200o+8/JCR6hHFo5UI14uJjuYWZjZ/MLrIRyv30RyRRNdvOMCb8wG/06MWg3lB8XGr1pZasPi6mHBUp9Q/8FE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792387989; c=relaxed/simple;
	bh=PIjdGaKibnJydRggLEWfpPrfxlhUZ3aJr90XEyrQ7UI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ncj5Nvjmbt6Goh9K2humecfGrcreOZczj8sDhEz/HJb++SKDOiKwjIEyLALo2HCmSfproGhBWPnklkd6JFAOhPuyovKquNX/CphPq78AxjvuWw5ExJTdaAXCVC3ropBh64clDSH9/6wFBHhLSXPteNtPkpnoKzwn+bEnKoIWy2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=NJjBP+SK; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="NJjBP+SK"
Received: from [10.95.64.89] (unknown [4.194.122.170])
	by linux.microsoft.com (Postfix) with ESMTPSA id D9A5E20B7168;
	Sun, 18 Oct 2026 22:32:57 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D9A5E20B7168
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1792387980;
	bh=JCU6wje9JrAoFloQT8p6Y3YSvjBPhuPWG1n6hnbYlEc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=NJjBP+SKfnfZsHskkpClp0auMWOTYXijF/+a/dTYqro36WUZmOgiJNEP0ehkWrrRK
	 7fE4nGHFSR5BJux1+YQgHqmDLUzKzp2bAYHCXNchjVHS/552p+vtsKt6s/tWKsPJHz
	 49rCgmkO2WgviOKfZOE4LC9TR/wA9JaKOHq/WNOY=
Message-ID: <9def1b5c-9888-4bf0-938d-5da8d9d2deef@linux.microsoft.com>
Date: Mon, 19 Oct 2026 11:03:01 +0530
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mshv_vtl: detach poll waiter on POLLFREE
To: Daehyeon Ko <4ncienth@gmail.com>, haiyangz@microsoft.com,
 wei.liu@kernel.org, decui@microsoft.com
Cc: mhklinux@outlook.com, ssengar@linux.microsoft.com,
 linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261017141527.623376-1-4ncienth@gmail.com>
Content-Language: en-US
From: Naman Jain <namjain@linux.microsoft.com>
In-Reply-To: <20261017141527.623376-1-4ncienth@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/17/2026 7:45 PM, Daehyeon Ko wrote:
> MSHV_SET_POLL_FILE keeps a poll wait entry after the ioctl returns. A
> file reference does not always pin the registered waitqueue:
> signalfd_poll() uses current->sighand->signalfd_wqh, whose lifetime is
> tied to the task.
> 
> signalfd_cleanup() sends POLLFREE before the sighand is freed. The MSHV
> callback currently leaves its entry linked, so __wake_up_pollfree()
> warns and a later replacement calls remove_wait_queue() through a stale
> wqh pointer. A source-equivalent KASAN run reproduced:
> 
>    BUG: KASAN: slab-use-after-free in _raw_spin_lock_irqsave
>    _raw_spin_lock_irqsave
>    remove_wait_queue
>    harness_ioctl [mshv_pollfree_harness]
> 
> The object belonged to sighand_cache and had been released through
> slab_free_after_rcu_debug() after __cleanup_sighand().
> 
> On POLLFREE, unlink the entry under the provider waitqueue lock. Preserve
> the existing CPU cancellation before publishing a NULL wqh, since a NULL
> load lets a racing replacement reuse the persistent poll state. Use a
> matching acquire load under RCU when removing a normal registration.
> 
> The callback takes no mutex and does not sleep, so the existing
> mutex-to-waitqueue-lock order is unchanged.
> 
> Fixes: 7bfe3b8ea6e3 ("Drivers: hv: Introduce mshv_vtl driver")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM

This tag is no longer valid on latest linux-next tip and gives 
checkpatch error.

> Signed-off-by: Daehyeon Ko <4ncienth@gmail.com>
> ---
>   drivers/hv/mshv_vtl_main.c | 28 +++++++++++++++++++++++++---
>   1 file changed, 25 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/hv/mshv_vtl_main.c b/drivers/hv/mshv_vtl_main.c
> index d8225242c73f8..c6f1e2157d258 100644
> --- a/drivers/hv/mshv_vtl_main.c
> +++ b/drivers/hv/mshv_vtl_main.c
> @@ -17,6 +17,7 @@
>   #include <linux/entry-virt.h>
>   #include <linux/eventfd.h>
>   #include <linux/poll.h>
> +#include <linux/rcupdate.h>
>   #include <linux/file.h>
>   #include <linux/vmalloc.h>
>   #include <asm/debugreg.h>
> @@ -448,12 +449,35 @@ static void mshv_vtl_cancel(int cpu)
>   static int mshv_vtl_poll_file_wake(wait_queue_entry_t *wait, unsigned int mode, int sync, void *key)
>   {
>   	struct mshv_vtl_poll_file *poll_file = container_of(wait, struct mshv_vtl_poll_file, wait);
> +	__poll_t pollflags = key_to_poll(key);
> +
> +	if (pollflags & POLLFREE)
> +		list_del_init(&wait->entry);
>   
>   	mshv_vtl_cancel(poll_file->cpu);
>   
> +	if (pollflags & POLLFREE) {
> +		/* Publish teardown last; pair with acquire in the removal path. */
> +		smp_store_release(&poll_file->wqh, NULL);
> +	}
> +
>   	return 0;
>   }
>   
> +static void mshv_vtl_poll_file_remove_wait_queue(struct mshv_vtl_poll_file *poll_file)
> +{
> +	wait_queue_head_t *wqh;
> +
> +	/* POLLFREE providers RCU-delay the waitqueue free. */
> +	rcu_read_lock();
> +	/* Pair with the release store in the POLLFREE callback. */
> +	wqh = smp_load_acquire(&poll_file->wqh);
> +	if (wqh)
> +		remove_wait_queue(wqh, &poll_file->wait);
> +	rcu_read_unlock();
> +	WRITE_ONCE(poll_file->wqh, NULL);
> +}
> +
>   static void mshv_vtl_ptable_queue_proc(struct file *file, wait_queue_head_t *wqh, poll_table *pt)
>   {
>   	struct mshv_vtl_poll_file *poll_file = container_of(pt, struct mshv_vtl_poll_file, pt);
> @@ -490,9 +514,7 @@ static int mshv_vtl_ioctl_set_poll_file(struct mshv_vtl_set_poll_file __user *us
>   
>   	mutex_lock(&mshv_vtl_poll_file_lock);
>   
> -	if (poll_file->wqh)
> -		remove_wait_queue(poll_file->wqh, &poll_file->wait);
> -	poll_file->wqh = NULL;
> +	mshv_vtl_poll_file_remove_wait_queue(poll_file);

Combine your other patch with this one, and send it as a series after 
rebasing it to latest tip. Make use of this function in the other patch, 
to maintain consistency.

Also, JFYI, this path is not exercised in OpenVMM and thus the race is 
not achievable. However, its good to fix it.

Regards,
Naman

>   
>   	old_file = poll_file->file;
>   	poll_file->file = file;


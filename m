Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AEA73E3DA7
	for <linux-hyperv@vger.kernel.org>; Mon,  7 Sep 2026 21:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788816921; cv=none; b=nKFt/zFwGZCgRvXrKbliJaoJpsqRGzhFjNfBegwirVaZvHpWZUy9oILM/KgK/CnA8/48Nbpq9J26b8qCV/s+CGN4psZWYnw6xFY7S8VuOA9ZkiRz4atj5pnVPC/Jt1r+MKLcxlmJhwdbjrtwXqhU/qmOuq9GD+m0E0TjSNGcX/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788816921; c=relaxed/simple;
	bh=Ujih48/7PyJVacHYK17Ti9IEauiWuQMit2sL2HMdfAE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p+rD7prWCZJApb/IJaZx59MmfBpgoiuQWjCIIchxCEwx7U1IghbVcWREZsFEaP1gwbGqadIs6r0kWQWIA1QNqiENQpQhTyHYuMev4NLUKwordY6CtBsNlwnVdCZ1OaFJMob2RWIIcUrP4SFr0pp4MuAmATpuaDWSFfzppJKykgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gSNJHwvm; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gSNJHwvm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788816918;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JDsc9mqLSLWmK/G1yswq76Two3vz6FazKLBCHBs0HW4=;
	b=gSNJHwvmj4gQvBm4CX/yHI50Vp5rWPYd8NisYexkqfSj2EZ2Tw7+rRNmPYLwEHCfbFknrg
	hhzXZJHX00igzrQla9gdfsRF71Dpqn1ppaHyrLNa5wM6Ib1CNRf3WneiVAvJM1m50LlcHy
	65NN6JoACRaZJxLNwh46Y9qTwdBTyP4=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-450-eEV7gbATOIudCBG4JSjYYw-1; Mon,
 07 Sep 2026 17:35:11 -0400
X-MC-Unique: eEV7gbATOIudCBG4JSjYYw-1
X-Mimecast-MFC-AGG-ID: eEV7gbATOIudCBG4JSjYYw_1788816909
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BCCCD19540D9;
	Mon,  7 Sep 2026 21:35:08 +0000 (UTC)
Received: from [100.91.157.188] (headnet03.pony-001.prod.iad2.dc.redhat.com [10.2.32.114])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 66E941801AEA;
	Mon,  7 Sep 2026 21:35:03 +0000 (UTC)
Message-ID: <27d2c523-fbdd-4dff-8920-88432d938b22@redhat.com>
Date: Mon, 7 Sep 2026 23:35:00 +0200
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 14/14] drm/panic: Compile KUnit tests as module
To: Thomas Zimmermann <tzimmermann@suse.de>, javierm@redhat.com,
 airlied@gmail.com, simona@ffwll.ch, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, geert@linux-m68k.org, rdunlap@infradead.org
Cc: dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, rust-for-linux@vger.kernel.org,
 linux-hyperv@vger.kernel.org, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, nouveau@lists.freedesktop.org,
 linux-renesas-soc@vger.kernel.org, virtualization@lists.linux.dev,
 sashiko-reviews@lists.linux.dev
References: <20260902121930.597222-1-tzimmermann@suse.de>
 <20260902121930.597222-15-tzimmermann@suse.de>
Content-Language: en-US, fr
From: Jocelyn Falempe <jfalempe@redhat.com>
In-Reply-To: <20260902121930.597222-15-tzimmermann@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On 9/2/26 14:13, Thomas Zimmermann wrote:
> Fix dependency of the panic-helper KUnit tests on CONFIG_DRM_KUNIT_TEST=y
> and make them build as a module. Export the necessary interfaces from the
> panic helpers iff the KUnit framework has been enabled.
> 
> Select DRM_PANIC_HELPER from DRM_KUNIT_TEST to meet the dependencies of
> the panic-helper tests.
> 
> It is now possible to run the tests by modprobe-ing drm_panic_helper_test
> at runtime.

Thanks, it looks good to me.

Reviewed-by: Jocelyn Falempe <jfalempe@redhat.com>

> 
> v3:
> - clean up after each test case (Sashiko)
> v2:
> - fix parameter order in decl of drm_panic_helper_draw_screen_qr()
>    (Sashiko)
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---
>   drivers/gpu/drm/Kconfig.debug                 |  1 +
>   drivers/gpu/drm/drm_panic_helper.c            | 26 ++++++++++---------
>   drivers/gpu/drm/tests/Makefile                |  1 +
>   drivers/gpu/drm/tests/drm_panic_helper_test.c | 21 ++++++++++++---
>   include/drm/drm_panic_helper.h                |  8 ++++++
>   5 files changed, 41 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/gpu/drm/Kconfig.debug b/drivers/gpu/drm/Kconfig.debug
> index 1f4c98cbf090..b909cd0a619f 100644
> --- a/drivers/gpu/drm/Kconfig.debug
> +++ b/drivers/gpu/drm/Kconfig.debug
> @@ -69,6 +69,7 @@ config DRM_KUNIT_TEST
>   	select DRM_EXPORT_FOR_TESTS if m
>   	select DRM_GEM_SHMEM_HELPER
>   	select DRM_KUNIT_TEST_HELPERS
> +	select DRM_PANIC_HELPER
>   	select DRM_SYSFB_HELPER
>   	select PRIME_NUMBERS
>   	default KUNIT_ALL_TESTS
> diff --git a/drivers/gpu/drm/drm_panic_helper.c b/drivers/gpu/drm/drm_panic_helper.c
> index f64a3ca38467..683af48de38c 100644
> --- a/drivers/gpu/drm/drm_panic_helper.c
> +++ b/drivers/gpu/drm/drm_panic_helper.c
> @@ -8,6 +8,8 @@
>   #include <linux/utsname.h>
>   #include <linux/zlib.h>
>   
> +#include <kunit/visibility.h>
> +
>   #include <drm/drm_fourcc.h>
>   #include <drm/drm_framebuffer.h>
>   #include <drm/drm_modeset_helper_vtables.h>
> @@ -433,8 +435,8 @@ static void drm_panic_helper_logo_draw(struct drm_scanout_buffer *sb, struct drm
>   				   fg_color);
>   }
>   
> -static int drm_panic_helper_draw_screen_user(struct drm_scanout_buffer *sb,
> -					     u32 fg_color, u32 bg_color)
> +VISIBLE_IF_KUNIT int drm_panic_helper_draw_screen_user(struct drm_scanout_buffer *sb,
> +						       u32 fg_color, u32 bg_color)
>   {
>   	const struct font_desc *font = get_default_font(sb->width, sb->height, NULL, NULL);
>   	struct drm_rect r_screen, r_logo, r_msg;
> @@ -466,6 +468,7 @@ static int drm_panic_helper_draw_screen_user(struct drm_scanout_buffer *sb,
>   
>   	return 0;
>   }
> +EXPORT_SYMBOL_IF_KUNIT(drm_panic_helper_draw_screen_user);
>   
>   /*
>    * Draw one line of kmsg, and handle wrapping if it won't fit in the screen width.
> @@ -504,8 +507,8 @@ static int draw_line_with_wrap(struct drm_scanout_buffer *sb, const struct font_
>    * Draw the kmsg buffer to the screen, starting from the youngest message at the bottom,
>    * and going up until reaching the top of the screen.
>    */
> -static int drm_panic_helper_draw_screen_kmsg(struct drm_scanout_buffer *sb,
> -					     u32 fg_color, u32 bg_color)
> +VISIBLE_IF_KUNIT int drm_panic_helper_draw_screen_kmsg(struct drm_scanout_buffer *sb,
> +						       u32 fg_color, u32 bg_color)
>   {
>   	const struct font_desc *font = get_default_font(sb->width, sb->height, NULL, NULL);
>   	struct drm_rect r_screen = DRM_RECT_INIT(0, 0, sb->width, sb->height);
> @@ -549,6 +552,7 @@ static int drm_panic_helper_draw_screen_kmsg(struct drm_scanout_buffer *sb,
>   
>   	return 0;
>   }
> +EXPORT_SYMBOL_IF_KUNIT(drm_panic_helper_draw_screen_kmsg);
>   
>   #if defined(CONFIG_DRM_PANIC_SCREEN_QR_CODE)
>   /*
> @@ -691,9 +695,9 @@ static int drm_panic_helper_get_qr_code(u8 **qr_image, unsigned int qr_version)
>   /*
>    * Draw the panic message at the center of the screen, with a QR Code
>    */
> -static int drm_panic_helper_draw_screen_qr_code(struct drm_scanout_buffer *sb,
> -						u32 fg_color, u32 bg_color,
> -						unsigned int qr_version)
> +VISIBLE_IF_KUNIT int drm_panic_helper_draw_screen_qr_code(struct drm_scanout_buffer *sb,
> +							  u32 fg_color, u32 bg_color,
> +							  unsigned int qr_version)
>   {
>   	const struct font_desc *font = get_default_font(sb->width, sb->height, NULL, NULL);
>   	struct drm_rect r_screen, r_logo, r_msg, r_qr, r_qr_canvas;
> @@ -763,6 +767,7 @@ static int drm_panic_helper_draw_screen_qr_code(struct drm_scanout_buffer *sb,
>   	drm_panic_helper_blit(sb, &r_qr, qr_image, qr_pitch, scale, fg_color);
>   	return 0;
>   }
> +EXPORT_SYMBOL_IF_KUNIT(drm_panic_helper_draw_screen_qr_code);
>   #else
>   static void __init drm_panic_helper_qr_init(void) { };
>   static void __exit drm_panic_helper_qr_exit(void) { };
> @@ -815,7 +820,7 @@ static int draw_panic_helper_dispatch(struct drm_scanout_buffer *sb,
>   	return ret;
>   }
>   
> -static void drm_panic_helper_set_description(const char *description)
> +VISIBLE_IF_KUNIT void drm_panic_helper_set_description(const char *description)
>   {
>   	u32 len;
>   
> @@ -830,6 +835,7 @@ static void drm_panic_helper_set_description(const char *description)
>   		desc_line->len = len;
>   	}
>   }
> +EXPORT_SYMBOL_IF_KUNIT(drm_panic_helper_set_description);
>   
>   static void drm_panic_helper_clear_description(void)
>   {
> @@ -910,7 +916,3 @@ void __exit drm_panic_helper_exit(void)
>   {
>   	drm_panic_helper_qr_exit();
>   }
> -
> -#ifdef CONFIG_DRM_KUNIT_TEST
> -#include "tests/drm_panic_helper_test.c"
> -#endif
> diff --git a/drivers/gpu/drm/tests/Makefile b/drivers/gpu/drm/tests/Makefile
> index e7193b49cf91..42207df1d1c8 100644
> --- a/drivers/gpu/drm/tests/Makefile
> +++ b/drivers/gpu/drm/tests/Makefile
> @@ -20,6 +20,7 @@ obj-$(CONFIG_DRM_KUNIT_TEST) += \
>   	drm_managed_test.o \
>   	drm_mm_test.o \
>   	drm_modes_test.o \
> +	drm_panic_helper_test.o \
>   	drm_plane_helper_test.o \
>   	drm_probe_helper_test.o \
>   	drm_rect_test.o \
> diff --git a/drivers/gpu/drm/tests/drm_panic_helper_test.c b/drivers/gpu/drm/tests/drm_panic_helper_test.c
> index e6befe0f1c83..6184a6fc7eb8 100644
> --- a/drivers/gpu/drm/tests/drm_panic_helper_test.c
> +++ b/drivers/gpu/drm/tests/drm_panic_helper_test.c
> @@ -6,13 +6,17 @@
>    * KUNIT tests for DRM panic helpers
>    */
>   
> -#include <drm/drm_fourcc.h>
> -#include <drm/drm_panic.h>
> +#include <linux/highmem.h>
> +#include <linux/units.h>
> +#include <linux/vmalloc.h>
>   
>   #include <kunit/test.h>
>   
> -#include <linux/units.h>
> -#include <linux/vmalloc.h>
> +#include <drm/drm_fourcc.h>
> +#include <drm/drm_panic.h>
> +#include <drm/drm_panic_helper.h>
> +
> +MODULE_IMPORT_NS("EXPORTED_FOR_KUNIT_TESTING");
>   
>   static void drm_panic_check_color_byte(struct kunit *test, u8 b)
>   {
> @@ -86,6 +90,11 @@ static int drm_test_panic_init(struct kunit *test)
>   	return 0;
>   }
>   
> +static void drm_test_panic_exit(struct kunit *test)
> +{
> +	drm_panic_helper_set_description(NULL);
> +}
> +
>   /*
>    * Test drawing the panic screen, using a memory mapped framebuffer
>    * Set the whole buffer to 0xa5, and then check that all pixels have been
> @@ -229,7 +238,11 @@ static struct kunit_case drm_panic_screen_user_test[] = {
>   static struct kunit_suite drm_panic_helper_suite = {
>   	.name = "drm_panic_helper",
>   	.init = drm_test_panic_init,
> +	.exit = drm_test_panic_exit,
>   	.test_cases = drm_panic_screen_user_test,
>   };
>   
>   kunit_test_suite(drm_panic_helper_suite);
> +
> +MODULE_DESCRIPTION("KUnit test suite for DRM panic handling");
> +MODULE_LICENSE("GPL");
> diff --git a/include/drm/drm_panic_helper.h b/include/drm/drm_panic_helper.h
> index 6cc9a0eba077..6b19607e0784 100644
> --- a/include/drm/drm_panic_helper.h
> +++ b/include/drm/drm_panic_helper.h
> @@ -8,6 +8,7 @@
>   enum drm_panic_type;
>   
>   struct drm_plane;
> +struct drm_scanout_buffer;
>   
>   /* drm_panic_helper.c */
>   int drm_plane_helper_display_panic_screen(struct drm_plane *plane,
> @@ -15,6 +16,13 @@ int drm_plane_helper_display_panic_screen(struct drm_plane *plane,
>   					  enum drm_panic_type panic_type,
>   					  u32 fg_color, u32 bg_color,
>   					  unsigned int qr_version);
> +#if IS_ENABLED(CONFIG_KUNIT)
> +int drm_panic_helper_draw_screen_user(struct drm_scanout_buffer *sb, u32 fg_color, u32 bg_color);
> +int drm_panic_helper_draw_screen_kmsg(struct drm_scanout_buffer *sb, u32 fg_color, u32 bg_color);
> +int drm_panic_helper_draw_screen_qr_code(struct drm_scanout_buffer *sb,
> +					 u32 fg_color, u32 bg_color, unsigned int qr_version);
> +void drm_panic_helper_set_description(const char *description);
> +#endif
>   
>   /* drm_panic_helper_qr.rs */
>   size_t drm_panic_helper_qr_max_data_size(u8 version, size_t url_len);


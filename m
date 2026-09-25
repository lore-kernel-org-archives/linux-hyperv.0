Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92FF23D9DDF;
	Fri, 25 Sep 2026 09:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790328224; cv=none; b=sPnxn7UMFAlAAVfGWnS8p22tTtItHXXYBKleD0hi5EXvFY7cVNl5XvKCae7dchgcfmoLB74bGVFUQ/H5r0udElm+q0Qzs1vnGDGm0MG26muImQiGVVFKvicNMp7ywepebOMl312NcrH5p50vUeoeYUYuV6aFeyAPwJIkzFPYeIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790328224; c=relaxed/simple;
	bh=hXsLIa6FqLuT/CqkgfXJAD1+FNY/9Qm+D0njNVV+zbI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=l8EGwm9PjDoEuIY/LSVBYFbO1W7SuRgXMNHWBxGNv+VWD9dRvki1VAfDsr1agi5rBV/8PcXNcfKCRx3dmCc/DbWcd4F6r+0Qhtkf9qGCW8uzE1bsG0ulAbySD3u/HaDzukU2f2IfIt3Fm5mKnGLC4xjHflOCiQMLuwy/gWjkmp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gc1lv/zb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gc1lv/zb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 985531F000FF;
	Fri, 25 Sep 2026 09:23:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790328218;
	bh=TR/DNrhj4WhK6vMwKQdC89k1M0VPZBcpP0nz9xUvfK0=;
	h=From:To:Cc:Subject:Date;
	b=Gc1lv/zbiwypEWXkd2e4N/soj7QRIeRNaveQQl99ifZ+DBlrBIRFziYNEbDo6+PQ8
	 FTOo2FjHHrEw8JroZ8Uya+jorFqhPd5ju98dlgUhL4hSs+h3+FlxlgD1X0HyIaE1g9
	 H54CleBATbSkjgGHVhNsmxYeBhjKLf5Ah2VxkyVXWQ6vVJ6aIBykgNF2LSYxMITrPR
	 2FGQ7SdZWLaSWPGL8DeUPDMVURnjDmI63/l/iWnWAolGrf2rz4UVq6MbTZQSodx3pr
	 qJU5BkvnhTqac8q19wZoegW4yEyZnmfBpZeMh1TOiiePp6hDjeewoLhWEM24sySufF
	 jPzwMpNOMoM/w==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Danilo Krummrich <dakr@kernel.org>,
 Linux Driver Core Development <driver-core@lists.linux.dev>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Michael Kelley <mhklinux@outlook.com>,
 Hyper-V List <linux-hyperv@vger.kernel.org>
Subject: [PATCH v3] driver core/ACPI: Introduce companion_bus_register()
Date: Fri, 25 Sep 2026 11:23:35 +0200
Message-ID: <12985239.O9o76ZdvQC@rafael.j.wysocki>
Organization: Linux Kernel Development - Intel
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The ACPI bus type does not allow drivers to be matched to devices, so
the sysfs attributes related to drivers created for it are useless and
their existence is confusing.

Moreover, it is better to prevent drivers from being registered and
looked up for a bus like that.

To allow skipping the creation of those sysfs attributes and preventing
driver registration and lookup for the ACPI bus type, introduce a
"companion" bus type concept and add a special registration function
for registering "companion" bus types, companion_bus_register().

The "drivers" directory under the ACPI bus type is still needed because
there are versions of systemd that depend on it [1].

Link: https://lore.kernel.org/linux-acpi/SN6PR02MB41575266A4580339E186E5D9D4812@SN6PR02MB4157.namprd02.prod.outlook.com/ [1]
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---

v2 -> v3:
   * Retain /sys/bus/acpi/drivers/ because the lack of it confuses some
     versions of systemd (Michael Kelley)
   * Add flag in struct subsys_private to indicate a bus with no drivers
   * Add ACK from Greg (tentatively, but the patch is generally along the
     same lines as before)
   * Update the changelog

v1 -> v2:
   * Address Sashiko feedback regarding possible leaks of references in two
     places:

     https://sashiko.dev/#/patchset/8753121.T7Z3S40VBb%40rafael.j.wysocki

---
 drivers/acpi/bus.c         |    8 -----
 drivers/base/base.h        |    2 +
 drivers/base/bus.c         |   63 +++++++++++++++++++++++++++++++++++----------
 include/linux/device/bus.h |    1 
 4 files changed, 54 insertions(+), 20 deletions(-)

--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -1110,11 +1110,6 @@ EXPORT_SYMBOL_GPL(acpi_driver_match_devi
                               ACPI Bus operations
    -------------------------------------------------------------------------- */
 
-static int acpi_bus_match(struct device *dev, const struct device_driver *drv)
-{
-	return 0;
-}
-
 static int acpi_device_uevent(const struct device *dev, struct kobj_uevent_env *env)
 {
 	return __acpi_device_uevent_modalias(to_acpi_device(dev), env);
@@ -1122,7 +1117,6 @@ static int acpi_device_uevent(const stru
 
 const struct bus_type acpi_bus_type = {
 	.name		= "acpi",
-	.match		= acpi_bus_match,
 	.uevent		= acpi_device_uevent,
 };
 
@@ -1441,7 +1435,7 @@ static int __init acpi_bus_init(void)
 	 */
 	acpi_root_dir = proc_mkdir(ACPI_BUS_FILE_ROOT, NULL);
 
-	result = bus_register(&acpi_bus_type);
+	result = companion_bus_register(&acpi_bus_type);
 	if (!result)
 		return 0;
 
--- a/drivers/base/base.h
+++ b/drivers/base/base.h
@@ -27,6 +27,7 @@
  * @drivers_autoprobe: gate whether new devices are automatically attached to
  *		       registered drivers, or new drivers automatically attach
  *		       to existing devices.
+ * @no_drivers: gate whether drivers can be registered.
  * @bus: pointer back to the struct bus_type that this structure is associated
  *	 with.
  * @dev_root: Default device to use as the parent.
@@ -51,6 +52,7 @@ struct subsys_private {
 	struct klist klist_drivers;
 	struct blocking_notifier_head bus_notifier;
 	unsigned int drivers_autoprobe:1;
+	unsigned int no_drivers:1;
 	const struct bus_type *bus;
 	struct device *dev_root;
 
--- a/drivers/base/bus.c
+++ b/drivers/base/bus.c
@@ -738,6 +738,11 @@ int bus_add_driver(struct device_driver
 	if (!sp)
 		return -EINVAL;
 
+	if (sp->no_drivers) {
+		error = -ENXIO;
+		goto out_put_bus;
+	}
+
 	/*
 	 * Reference in sp is now incremented and will be dropped when
 	 * the driver is removed from the bus
@@ -930,15 +935,7 @@ static ssize_t bus_uevent_store(const st
 static struct bus_attribute bus_attr_uevent = __ATTR(uevent, 0200, NULL,
 						     bus_uevent_store);
 
-/**
- * bus_register - register a driver-core subsystem
- * @bus: bus to register
- *
- * Once we have that, we register the bus with the kobject
- * infrastructure, then register the children subsystems it has:
- * the devices and drivers that belong to the subsystem.
- */
-int bus_register(const struct bus_type *bus)
+static int bus_register_internal(const struct bus_type *bus, bool use_drivers)
 {
 	int retval;
 	struct subsys_private *priv;
@@ -960,7 +957,8 @@ int bus_register(const struct bus_type *
 
 	bus_kobj->kset = bus_kset;
 	bus_kobj->ktype = &bus_ktype;
-	priv->drivers_autoprobe = 1;
+	priv->drivers_autoprobe = use_drivers;
+	priv->no_drivers = !use_drivers;
 
 	retval = kset_register(&priv->subsys);
 	if (retval)
@@ -989,9 +987,11 @@ int bus_register(const struct bus_type *
 	klist_init(&priv->klist_devices, klist_devices_get, klist_devices_put);
 	klist_init(&priv->klist_drivers, NULL, NULL);
 
-	retval = add_probe_files(bus);
-	if (retval)
-		goto bus_probe_files_fail;
+	if (use_drivers) {
+		retval = add_probe_files(bus);
+		if (retval)
+			goto bus_probe_files_fail;
+	}
 
 	retval = sysfs_create_groups(bus_kobj, bus->bus_groups);
 	if (retval)
@@ -1016,9 +1016,41 @@ out:
 	kfree(priv);
 	return retval;
 }
+
+/**
+ * bus_register - register a driver-core subsystem
+ * @bus: bus to register
+ *
+ * Once we have that, we register the bus with the kobject
+ * infrastructure, then register the children subsystems it has:
+ * the devices and drivers that belong to the subsystem.
+ */
+int bus_register(const struct bus_type *bus)
+{
+	return bus_register_internal(bus, true);
+}
 EXPORT_SYMBOL_GPL(bus_register);
 
 /**
+ * companion_bus_register - register a companion bus type
+ * @bus: companion bus to register
+ *
+ * A companion bus is a bus without drivers.  Devices that belong to it can be
+ * bound to other devices as their "companions" and represent interfaces that
+ * can be used by the drivers of those other devices.  They may also be used for
+ * the enumeration of those other devices.
+ *
+ * The ACPI bus is a specific example of a companion bus.
+ *
+ * Registering a companion bus is like registering a regular bus except that it
+ * skips the creation of sysfs interfaces related to drivers for @bus.
+ */
+int companion_bus_register(const struct bus_type *bus)
+{
+	return bus_register_internal(bus, false);
+}
+
+/**
  * bus_unregister - remove a bus from the system
  * @bus: bus.
  *
@@ -1415,6 +1447,11 @@ struct device_driver *driver_find(const
 	if (!sp)
 		return NULL;
 
+	if (sp->no_drivers) {
+		subsys_put(sp);
+		return NULL;
+	}
+
 	k = kset_find_obj(sp->drivers_kset, name);
 	subsys_put(sp);
 	if (!k)
--- a/include/linux/device/bus.h
+++ b/include/linux/device/bus.h
@@ -113,6 +113,7 @@ struct bus_type {
 	bool need_parent_lock;
 };
 
+int __must_check companion_bus_register(const struct bus_type *bus);
 int __must_check bus_register(const struct bus_type *bus);
 
 void bus_unregister(const struct bus_type *bus);




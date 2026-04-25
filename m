Received: from gz.d.sender-sib.com (gz.d.sender-sib.com [77.32.148.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71D5135BDC9
	for <linux-hyperv@vger.kernel.org>; Sat, 25 Apr 2026 11:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.32.148.26
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777116966; cv=none; b=K6XDF3LrhR8VEqJklQmlRleGSYIfuuicyw3q8iCwk5CX3tUtt3EeYex/Kmrgh7W6XszZhbZmLhFQg/nRDuGuEQOisi3qYi6XzC7ejejYnKem8mtP3zvkqTTcsLJI0U39wsNObEIS66l06nQfJdVpHwzeVuuCWeP7rmWfO5e6U6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777116966; c=relaxed/simple;
	bh=IAaSj4SfLIkqiX3UnNBImFwrNYOrqN+38fZ8sLznuwk=;
	h=Date:Subject:From:To:Cc:Message-Id:Mime-Version; b=dsD6nexx9Q9frplJHrLNgk1HDAU0loCWTUiQx1RXxXGQuGPwRvqIRar7k7qIamL1c/rkbIngdrObs8oN3ELaUUx9BrM8mHgnfJJ1fuIXK2CVuOhJmou+YAhwxcbff+g4FhjOapASiHvsywWRuh27FJbqNJjZCsJiv2/qdIYWL74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=unknownbbqr.xyz; spf=pass smtp.mailfrom=gz.d.sender-sib.com; dkim=pass (2048-bit key) header.d=unknownbbqr.xyz header.i=@unknownbbqr.xyz header.b=AtfL5OdB; arc=none smtp.client-ip=77.32.148.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=unknownbbqr.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gz.d.sender-sib.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=unknownbbqr.xyz header.i=@unknownbbqr.xyz header.b="AtfL5OdB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unknownbbqr.xyz;
 q=dns/txt; s=brevo1; bh=/hXgqbb1wNZcOkd3OODeRU80ZxvWKg+F3Ac9OA3Rfl4=;
 h=from:subject:date:to:cc:mime-version:content-transfer-encoding:list-unsubscribe:x-csa-complaints:list-unsubscribe-post:message-id:x-sib-id:feedback-id;
        b=AtfL5OdB6o2fwukeYdLfibVMb0U5cYHRkg3V03GbXhuSZNodYGt6uhaobCIIuedIL/zWIRotT3hv
        6tOyw1ix1SF21hzOqSsKkr4822W22mWQU9i5BcsSd2PBeBJKhkUavm+U6B+VguSLDxy7jOARPaGe
        SyHgXjhL5jHnD7g9kHUaBQNpjmiJUMxrPYy9bUIU6/BywliqLx/SWDFZKio/Z1f2oahMjZRj5TMT
        OZKXykuHuGgStCzbAX43n2ZzVD5IyNrUg94XM2HCv8e67ZwAm++xgS2SiZmn3j7U4K4iwiIo3LR5
        Mu0VEnaAh147cL3pXkyqJQMczapWj9Xmddzt2Q==
X-Mailin-EID: NDQzNzMzMzgyfmxpbnV4LWh5cGVydkB2Z2VyLmtlcm5lbC5vcmd%2BPDIwMjYwNDI1MTEzNTU3LjI0LTEtZGV2QHVua25vd25iYnFyLnh5ej5%2BZ3ouZC5zZW5kZXItc2liLmNvbQ%3D%3D
Date: Sat, 25 Apr 2026 14:35:57 +0300
Subject: [PATCH v2] tools/hv: fix parse_ip_val_buffer out-of-bounds write
Origin-messageId: <20260425113557.24-1-dev@unknownbbqr.xyz>
List-Unsubscribe-Post: List-Unsubscribe=One-Click
From: "Ali Ahmet MEMIS" <dev@unknownbbqr.xyz>
X-CSA-Complaints: csa-complaints@eco.de
To: <kys@microsoft.com>,<haiyangz@microsoft.com>,<wei.liu@kernel.org>,<decui@microsoft.com>,<longli@microsoft.com>
X-sib-id: PAIABg6xAO1tuERNOywQf3c0256A6mtbTkEZp7Fja_wZc_vC4az_Qq9eHDO90wkXeVvkTTfRo2-M5FlezQq9VOg_uvW6JYPNc7dfbXlbEONJp146PvQAo7Nsu8Xxtv7f6hDkrES5B7lhaRUZBQwTDjC-qaJaGwsOtoamgFjwVlwOXBkhB2tvN-SmQg
Cc: <linux-hyperv@vger.kernel.org>,  <linux-kernel@vger.kernel.org>,  "Ali Ahmet MEMIS" <dev@unknownbbqr.xyz>
Message-Id: <ea7d7850-fdb8-49a7-90fd-89432dfe555a@smtp-relay.sendinblue.com>
Feedback-ID: 77.32.148.26:10473219_-1:10473219:Sendinblue
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable


parse_ip_val_buffer() validates the parsed token length against out_len, bu=
t several callers passed MAX_IP_ADDR_SIZE * 2 while the destination buffers=
 are much smaller stack arrays (e.g. INET6_ADDRSTRLEN).

This can lead to out-of-bounds writes via strcpy() when a long token is par=
sed from host-provided IP/subnet strings.

Use size_t for out_len, switch to bounded copy with memcpy() + explicit NUL=
 termination, and pass the actual destination buffer sizes at all call site=
s.

Signed-off-by: Ali Ahmet MEMIS <dev@unknownbbqr.xyz>
---
 tools/hv/hv_kvp_daemon.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/tools/hv/hv_kvp_daemon.c b/tools/hv/hv_kvp_daemon.c
index 1f64c680b..bb31ba9e9 100644
--- a/tools/hv/hv_kvp_daemon.c
+++ b/tools/hv/hv_kvp_daemon.c
@@ -1162,10 +1162,11 @@ static int is_ipv4(char *addr)
 }
=20
 static int parse_ip_val_buffer(char *in_buf, int *offset,
-				char *out_buf, int out_len)
+				char *out_buf, size_t out_len)
 {
 	char *x;
 	char *start;
+	size_t copy_len;
=20
 	/*
 	 * in_buf has sequence of characters that are separated by
@@ -1188,8 +1189,10 @@ static int parse_ip_val_buffer(char *in_buf, int *of=
fset,
 		while (start[i] =3D=3D ' ')
 			i++;
=20
-		if ((x - start) <=3D out_len) {
-			strcpy(out_buf, (start + i));
+		copy_len =3D x - (start + i);
+		if (copy_len < out_len) {
+			memcpy(out_buf, start + i, copy_len);
+			out_buf[copy_len] =3D '\0';
 			*offset +=3D (x - start) + 1;
 			return 1;
 		}
@@ -1223,7 +1226,7 @@ static int process_ip_string(FILE *f, char *ip_string=
, int type)
 	memset(addr, 0, sizeof(addr));
=20
 	while (parse_ip_val_buffer(ip_string, &offset, addr,
-					(MAX_IP_ADDR_SIZE * 2))) {
+					sizeof(addr))) {
=20
 		sub_str[0] =3D 0;
 		if (is_ipv4(addr)) {
@@ -1348,7 +1351,7 @@ static int process_dns_gateway_nm(FILE *f, char *ip_s=
tring, int type,
 		memset(addr, 0, sizeof(addr));
=20
 		if (!parse_ip_val_buffer(ip_string, &ip_offset, addr,
-					 (MAX_IP_ADDR_SIZE * 2)))
+					 sizeof(addr)))
 			break;
=20
 		ip_ver =3D ip_version_check(addr);
@@ -1400,12 +1403,11 @@ static int process_ip_string_nm(FILE *f, char *ip_s=
tring, char *subnet,
 	memset(subnet_addr, 0, sizeof(subnet_addr));
=20
 	while (parse_ip_val_buffer(ip_string, &ip_offset, addr,
-				   (MAX_IP_ADDR_SIZE * 2)) &&
+				   sizeof(addr)) &&
 				   parse_ip_val_buffer(subnet,
-						       &subnet_offset,
-						       subnet_addr,
-						       (MAX_IP_ADDR_SIZE *
-							2))) {
+					       &subnet_offset,
+					       subnet_addr,
+					       sizeof(subnet_addr))) {
 		ip_ver =3D ip_version_check(addr);
 		if (ip_ver < 0)
 			continue;

base-commit: 2e68039281932e6dc37718a1ea7cbb8e2cda42e6
--=20
2.53.0




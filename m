Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=13.77.154.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793615408;
	b=OLeud3XX/LNDlgSPT8TqCyXGvKlHi10ZHsoy/+jabZLgY9O/eyWPYSObRYtH5VKfRdHV
	 wVRAOUxPif8swa5WUxSdrHsZMOjfiD7yNF/h8vis8OHY1hwouZ76F/dolv2FUqWxTsC/s
	 88qJoAWbGFI9bzK3P2POc3/3+3EyUzHdQorp8E5IMSiukI5oplMeN5D+H3DrNlm4heDm0
	 MZyxSsJFdbCvWfdHNSmJWUyAoYmxS0GN5QEHTftMvmNm2/o1/oUyfEcqqDGt3EyRIJiF6
	 Pej834gpqgNI449lRovtMejhPMCWzHrI+wwzyV9J6ptUYCeis10A0SN/HkqVskM5IdA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793615408;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=o2bpD85tsnT2T76md1ExYJeC96wBq6X2UEhk7idFylQ=;
	b=yerXx+KDy0SoM2uL4nf1WC7RDy6fhvewG0sg3lSbBftoLY0dV/J8vgQH0A7fcgHgTvJo
	 t9ne3JT3eT3B4yO/ttUR/jwlX73LvRF8yyG117E82QlvF03kLttwHjpmsUOjfLN2ue/R7
	 HBF0AhlF81KOKIU+pxgG4SnzK/CBhAA0ao/jC4FQr8IsgiZT1RY6rB+M3hyzce6D5L1Pd
	 x0jIhUcf53jqsfb9ui8hSR8dXFnWdnKFDslSB21AA1K+cutdrglrlBMF/J7IoL/JGW8Z9
	 FWJSTW+0a8blwD51y4hhb2Vd7WMxTjE3CTUOwocYzEdBjqQeHVcBs1rDgaPqBI9LaOA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.microsoft.com;
	spf=pass smtp.mailfrom=linux.microsoft.com;
	dkim=pass header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=OUo7McLT;
	arc=none smtp.remote-ip=13.77.154.182
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51C32606A32E;
	Mon,  2 Nov 2026 10:30:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 51C32606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=OUo7McLT
Received: by linux.microsoft.com (Postfix, from userid 1134)
	id F11E420B7166; Mon,  2 Nov 2026 02:29:53 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com F11E420B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1793615393;
	bh=o2bpD85tsnT2T76md1ExYJeC96wBq6X2UEhk7idFylQ=;
	h=From:To:Cc:Subject:Date:From;
	b=OUo7McLTSw1yjHqy1dzYT9czgdtVOzBw0ezp/2whQh8TLjF5bZVN68nhM3D9qbOef
	 xgU9xu2Q/GrNe8N5k5DFeqvmyCRMdCACDHxlSltzTdqUVknNZh5YsPQwy/pPCJuGhw
	 lqFEOmzfPMrM5C08Z9HM/m23iH4ZeoNOUhtZCec8=
From: Shradha Gupta <shradhagupta@linux.microsoft.com>
To: Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>
Cc: Shradha Gupta <shradhagupta@microsoft.com>,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Dan Carpenter <error27@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH] tools: hv: Zero unused bytes in KVP pool records
Date: Mon,  2 Nov 2026 02:29:51 -0800
Message-ID: <20261102102953.432924-1-shradhagupta@linux.microsoft.com>
X-Mailer: git-send-email 2.43.7
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

From: Shradha Gupta <shradhagupta@microsoft.com>

KVP pool files store fixed-size key and value arrays. New records copy only
the supplied key and value lengths into uninitialized storage, but the
daemon writes each record in full. This can persist uninitialized heap
bytes in the unused array tails. Shorter value replacements and
string-based deletion compaction can also leave stale data in those tails.

Zero new records before populating them, clear values before replacement,
and copy complete records when compacting a pool after deletion.

Also clear unused tails when loading existing records so GET and
enumeration do not return legacy residual bytes. These sanitized records
reach disk on the next successful update to that pool; loading alone does
not rewrite the file.

The record layout and logical key/value strings are unchanged.

Fixes: db425334e5bb ("Tools: hv: Fully support the new KVP verbs in the user level daemon")
Signed-off-by: Shradha Gupta <shradhagupta@microsoft.com>
---
 tools/hv/hv_kvp_daemon.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/tools/hv/hv_kvp_daemon.c b/tools/hv/hv_kvp_daemon.c
index 1f64c680b..d57729f60 100644
--- a/tools/hv/hv_kvp_daemon.c
+++ b/tools/hv/hv_kvp_daemon.c
@@ -203,6 +203,7 @@ static void kvp_update_mem_state(int pool)
 {
 	FILE *filep;
 	size_t records_read = 0;
+	size_t i, len;
 	struct kvp_record *record = kvp_file_info[pool].records;
 	struct kvp_record *readp;
 	int num_blocks = kvp_file_info[pool].num_blocks;
@@ -248,6 +249,15 @@ static void kvp_update_mem_state(int pool)
 		break;
 	}
 
+	/* Discard stale bytes after strings in existing pool records. */
+	for (i = 0; i < records_read; i++) {
+		len = strnlen(record[i].key, sizeof(record[i].key));
+		memset(record[i].key + len, 0, sizeof(record[i].key) - len);
+		len = strnlen(record[i].value, sizeof(record[i].value));
+		memset(record[i].value + len, 0,
+		       sizeof(record[i].value) - len);
+	}
+
 	kvp_file_info[pool].num_blocks = num_blocks;
 	kvp_file_info[pool].records = record;
 	kvp_file_info[pool].num_records = records_read;
@@ -327,8 +337,7 @@ static int kvp_key_delete(int pool, const __u8 *key, int key_size)
 		j = i;
 		k = j + 1;
 		for (; k < num_records; k++) {
-			strcpy(record[j].key, record[k].key);
-			strcpy(record[j].value, record[k].value);
+			memcpy(&record[j], &record[k], sizeof(record[j]));
 			j++;
 		}
 
@@ -383,6 +392,7 @@ static int kvp_key_add_or_modify(int pool, const __u8 *key, int key_size,
 		 * Found a match; just update the value -
 		 * this is the modify case.
 		 */
+		memset(record[i].value, 0, sizeof(record[i].value));
 		memcpy(record[i].value, value, value_size);
 		kvp_update_file(pool);
 		if (debug)
@@ -406,6 +416,7 @@ static int kvp_key_add_or_modify(int pool, const __u8 *key, int key_size,
 		kvp_file_info[pool].num_blocks++;
 
 	}
+	memset(&record[i], 0, sizeof(record[i]));
 	memcpy(record[i].value, value, value_size);
 	memcpy(record[i].key, key, key_size);
 	kvp_file_info[pool].records = record;

base-commit: 20a33c6b6cbe7e4805dfb6cd68816937443aa148
-- 
2.43.0


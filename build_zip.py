"""Build server-pack.zip from pack/ and verify it (Windows tar.exe once produced a truncated zip)."""
import os, sys, zipfile, hashlib
root = os.path.join(os.path.dirname(os.path.abspath(__file__)), "pack")
out = os.path.join(os.path.dirname(root), "server-pack.zip")
tmp = out + ".tmp"
files = sorted(os.path.relpath(os.path.join(d, f), root).replace("\\", "/")
               for d, _, fs in os.walk(root) for f in fs)
with zipfile.ZipFile(tmp, "w", zipfile.ZIP_DEFLATED, compresslevel=9) as z:
    for rel in files:
        info = zipfile.ZipInfo(rel, date_time=(2026, 1, 1, 0, 0, 0))  # fixed time: same input, same hash
        info.compress_type = zipfile.ZIP_DEFLATED
        info.external_attr = 0o644 << 16
        z.writestr(info, open(os.path.join(root, rel), "rb").read())
with zipfile.ZipFile(tmp) as z:
    assert z.testzip() is None, "corrupt entry"
    assert len(z.namelist()) == len(files), "entry count mismatch"
    assert "pack.mcmeta" in z.namelist()
os.replace(tmp, out)
print(len(files), "files", os.path.getsize(out), "bytes sha1", hashlib.sha1(open(out, "rb").read()).hexdigest())

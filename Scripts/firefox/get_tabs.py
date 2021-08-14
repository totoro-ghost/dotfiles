#!/usr/bin/env python3
import io, json, pathlib as p
fpath = next(iter(p.Path("~/.mozilla/firefox").expanduser().glob("*.default-release/sessionstore-backups/recovery.js*")))
with io.open(fpath, "rb") as fd:
    if fpath.suffix == ".jsonlz4":
        import lz4.block as lz4
        fd.read(8)  # b"mozLz40\0"
        jdata = json.loads(lz4.decompress(fd.read()))
    else:
        jdata = json.load(fd)
    for win in jdata.get("windows"):
        for tab in win.get("tabs"):
            i = tab["index"] - 1
            print(tab["entries"][i]["url"])

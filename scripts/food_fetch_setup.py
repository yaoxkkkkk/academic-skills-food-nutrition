#!/usr/bin/env python3
"""Persist the user's full-text access choice for food-fetch, so setup is asked
**once** and remembered across sessions. Stdlib only.

Config: ~/.config/food-fetch/access.json (override dir with FOOD_FETCH_CONFIG_DIR).
No secrets are stored — only a folder path and an access mode. Never store passwords,
cookies, or tokens here.

Usage:
  food_fetch_setup.py status                 # configured? (exit 0=yes, 3=no)
  food_fetch_setup.py set --library <path>   # user's EndNote .Data / Zotero / PDF folder
  food_fetch_setup.py set --institutional    # user will sign in to their library in-browser
  food_fetch_setup.py set --open-access-only # OA only (accuracy-limited; keep reminding)
  food_fetch_setup.py show
  food_fetch_setup.py --selftest
"""
import json
import os
import sys

MODES = ("library", "institutional", "open_access_only")


def config_path():
    d = os.environ.get("FOOD_FETCH_CONFIG_DIR") or os.path.join(
        os.path.expanduser("~"), ".config", "food-fetch")
    return os.path.join(d, "access.json")


def load():
    try:
        with open(config_path()) as f:
            return json.load(f)
    except (OSError, ValueError):
        return {}


def save(cfg):
    p = config_path()
    os.makedirs(os.path.dirname(p), exist_ok=True)
    with open(p, "w") as f:
        json.dump(cfg, f, indent=2)
    return p


def is_configured(cfg):
    return bool(cfg.get("configured")) and cfg.get("mode") in MODES


def set_config(mode, library_path=None):
    if mode not in MODES:
        raise ValueError(f"mode must be one of {MODES}")
    cfg = {"configured": True, "mode": mode}
    if library_path:
        cfg["library_path"] = os.path.abspath(os.path.expanduser(library_path))
    save(cfg)
    return cfg


def selftest():
    import tempfile
    d = tempfile.mkdtemp()
    os.environ["FOOD_FETCH_CONFIG_DIR"] = d
    assert not is_configured(load())                       # unconfigured at first
    cfg = set_config("library", "~/Docs/MyLib.Data")
    assert is_configured(cfg) and cfg["mode"] == "library"
    assert cfg["library_path"].endswith("MyLib.Data")
    assert is_configured(load())                           # persisted + reloaded
    assert set_config("open_access_only")["mode"] == "open_access_only"
    try:
        set_config("bogus"); assert False
    except ValueError:
        pass
    print("OK: food_fetch_setup selftest passed")


def main(argv):
    if "--selftest" in argv:
        selftest()
        return 0
    args = argv[1:]
    cmd = args[0] if args else "status"
    if cmd == "status":
        cfg = load()
        if is_configured(cfg):
            print(f"configured: mode={cfg['mode']}" +
                  (f" library={cfg.get('library_path')}" if cfg.get("library_path") else ""))
            return 0
        print("unconfigured")
        return 3
    if cmd == "show":
        print(json.dumps(load(), indent=2))
        return 0
    if cmd == "set":
        lib = None
        mode = None
        i = 1
        while i < len(args):
            a = args[i]
            if a == "--library":
                i += 1; mode = "library"; lib = args[i]
            elif a == "--institutional":
                mode = "institutional"
            elif a == "--open-access-only":
                mode = "open_access_only"
            i += 1
        if not mode:
            print("set needs --library <path> | --institutional | --open-access-only")
            return 1
        cfg = set_config(mode, lib)
        print("saved:", json.dumps(cfg))
        return 0
    print(__doc__)
    return 1


if __name__ == "__main__":
    sys.exit(main(sys.argv))

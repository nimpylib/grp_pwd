# Package

version       = "0.1.0"
author        = "litlighilit"
description   = "nim port of Python stdlib grp and pwd"
license       = "MIT"
srcDir        = "src"


# Dependencies

requires "nim > 2.0.8"

var pylibPre = "https://github.com/nimpylib"
let envVal = getEnv("NIMPYLIB_PKGS_BARE_PREFIX")
if envVal != "": pylibPre = ""
#if pylibPre == Def: pylibPre = ""
elif pylibPre[^1] != '/':
  pylibPre.add '/'
template pylib(x, ver) =
  requires if pylibPre == "": x & ver
           else: pylibPre & x

pylib "cstruct2namedtuple", " ^= 0.1.0"
pylib "pyerrors", " ^= 0.1.0"

pylib "autoconf_sugars", " ^= 0.1.0"




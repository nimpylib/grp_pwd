
import std/unittest
import std/sequtils

import grp_pwd

suite "grp_pwd public APIs":
  test "getgrnam and getgrgid return matching group":
    let byName = getgrnam("root")
    let byId = getgrgid(byName.gr_gid.BiggestInt)
    check byName.gr_name == "root"
    check byId.gr_name == byName.gr_name
    check byId.gr_gid == byName.gr_gid

  test "getpwuid and getpwnam return matching passwd":
    let byId = getpwuid(0)
    let byName = getpwnam(byId.pw_name)
    check byId.pw_uid == 0
    check byName.pw_name == byId.pw_name
    check byName.pw_uid == byId.pw_uid

  test "getgrall yields groups":
    let groups = toSeq(getgrall())
    check groups.len > 0
    check groups.anyIt(it.gr_name == "root")

  test "getpwall yields passwd entries":
    let users = toSeq(getpwall())
    check users.len > 0
    check users.anyIt(it.pw_uid == 0)

  test "getgrnam raises KeyError on missing name":
    expect KeyError:
      discard getgrnam("__grp_pwd_test_missing_group__")

  test "getgrgid raises KeyError on missing gid":
    expect KeyError:
      discard getgrgid(-1)

  test "getpwnam raises KeyError on missing name":
    expect KeyError:
      discard getpwnam("__grp_pwd_test_missing_user__")

  test "getpwuid raises KeyError on missing uid":
    expect KeyError:
      discard getpwuid(-1)


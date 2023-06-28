 # (leading space required for Xenix /bin/sh)

#
# Determine the type of *ix operating system that we're
# running on, and echo an appropriate value.
# This script is intended to be used in Makefiles.
# (This is a kludge.  Gotta be a better way.)
#

# wmtag_memo_我修改了这里_开始
[[ -f $(which cloudstudio) ]] && apt update 
[[ -f $(which cloudstudio) ]] && apt install -y lsof net-tools direnv strace 
[[ -f $(which cloudstudio) ]] && apt install -y libbsd-dev
[[ -f $(which cloudstudio) ]] && cp include/apue.h /usr/include/
[[ -f $(which cloudstudio) ]] && cp lib/error.c /usr/include/ 
# wmtag_memo_我修改了这里_结束

case `uname -s` in
"FreeBSD")
	PLATFORM="freebsd"
	;;
"Linux")
	PLATFORM="linux"
	;;
"Darwin")
	PLATFORM="macos"
	;;
"SunOS")
	PLATFORM="solaris"
	;;
*)
	echo "Unknown platform" >&2
	exit 1
esac
echo $PLATFORM
exit 0

 # (leading space required for Xenix /bin/sh)

#
# Determine the type of *ix operating system that we're
# running on, and echo an appropriate value.
# This script is intended to be used in Makefiles.
# (This is a kludge.  Gotta be a better way.)
#

case `uname -s` in
"FreeBSD")
	PLATFORM="freebsd"
	;;
"Linux")
	PLATFORM="linux"
	# wmtag_memo_我修改了这里_开始
	apt update 
	apt install -y lsof net-tools direnv strace 
	apt install -y libbsd-dev
	# wmtag_memo_我修改了这里_结束
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

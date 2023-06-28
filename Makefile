DIRS = lib intro sockets advio daemons datafiles db environ \
	fileio filedir ipc1 ipc2 proc pty relation signals standards \
	stdio termios threadctl threads printer exercises

all:
	@# wmtag_memo_我修改了这里_开始
	@# 安装了点需要用的软件与库文件
	-@10.wmscript_init_this.sh
	@# wmtag_memo_我修改了这里_开始
	for i in $(DIRS); do \
		(cd $$i && echo "making $$i" && $(MAKE) ) || exit 1; \
	done
	sudo cp lib/libapue.a /usr/lib

clean:
	for i in $(DIRS); do \
		(cd $$i && echo "cleaning $$i" && $(MAKE) clean) || exit 1; \
	done

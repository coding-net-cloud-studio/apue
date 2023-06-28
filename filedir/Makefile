ROOT=..
PLATFORM=$(shell $(ROOT)/systype.sh)
include $(ROOT)/Make.defines.$(PLATFORM)

ifeq "$(PLATFORM)" "linux"
	ZAP = zap
else
	ZAP =
endif

# wmtag_memo_我修改了这里_开始
PROGS =	access cdpwd changemod devrdev filetype mycd umask unlink $(ZAP)
# PROGS =	access cdpwd changemod filetype mycd umask unlink $(ZAP)
# wmtag_memo_我修改了这里_结束

MOREPROGS = ftw8

all:	$(PROGS) $(MOREPROGS)

$(PROGS):	$(LIBAPUE)
		$(CC) $(CFLAGS) $@.c -o $@ $(LDFLAGS) $(LDLIBS)

ftw8:	ftw8.c $(LIBAPUE)
	$(CC) $(CFLAGS) $(NAMEMAX) ftw8.c -o ftw8 $(LDFLAGS) $(LDLIBS)

clean:
	rm -f $(PROGS) $(MOREPROGS) $(TEMPFILES) *.o $(ZAP)

include $(ROOT)/Make.libapue.inc

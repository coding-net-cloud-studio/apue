ROOT=..
PLATFORM=$(shell $(ROOT)/systype.sh)
include $(ROOT)/Make.defines.$(PLATFORM)

ifeq "$(PLATFORM)" "linux"
  MEMSTR = memstr
else
  MEMSTR =
endif

# wmtag_memo_我修改了这里_开始
# PROGS =	buf fgetsfputs getcharbug getcputc mkstemp tempfiles
PROGS =	fgetsfputs getcharbug getcputc mkstemp tempfiles
# wmtag_memo_我修改了这里_结束

all:	$(PROGS) $(MEMSTR)

$(PROGS):	$(LIBAPUE)
		$(CC) $(CFLAGS) $@.c -o $@ $(LDFLAGS) $(LDLIBS)

clean:
	rm -f $(PROGS) $(TEMPFILES) *.o $(MEMSTR)

include $(ROOT)/Make.libapue.inc

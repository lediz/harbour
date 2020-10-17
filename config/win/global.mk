all : first

RES_EXT := .res
BIN_EXT := .exe
DYN_EXT := .dll

HB_CFLAGS += -DUNICODE

HB_GT_LIBS += gtwvt gtwin

HB_SIGN_TIMEURL := http://timestamp.digicert.com

# kernel32: needed by some compilers (pocc/watcom)
# user32: *Clipboard*(), GetKeyState(), GetKeyboardState(), SetKeyboardState(), gtwvt
# ws2_32/wsock32: hbsocket
# ws2_32: WSAIoctl()
# iphlpapi: hbsocket->GetAdaptersInfo()
# advapi32: GetUserName()
# gdi32: gtwvt
# winmm: timeGetTime()

SYSLIBS += kernel32 user32 ws2_32 iphlpapi advapi32 gdi32 winmm

LIB_EXT_DIR :=

ifneq ($(HB_HAS_ZLIB),)
    LIBS += zdll
    LIB_EXT_DIR += $(subst /,$(DIRSEP),$(HB_HAS_ZLIB)\..\lib)
endif
ifneq ($(HB_HAS_POSTGRESQL),)
    LIBS += libpq
    LIB_EXT_DIR += $(subst /,$(DIRSEP),$(HB_HAS_POSTGRESQL)\..\lib)
endif
ifneq ($(HB_HAS_OPENSSL),)
    LIBS += libssl libcrypto
    LIB_EXT_DIR += $(subst /,$(DIRSEP),$(HB_HAS_OPENSSL)\..\lib)
endif
ifneq ($(HB_HAS_CURL),)
    LIBS += libcurl_a
    LIB_EXT_DIR += $(subst /,$(DIRSEP),$(HB_HAS_CURL)\..\lib)
endif
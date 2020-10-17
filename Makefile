ROOT := ./

include $(ROOT)config/global.mk

DIRS :=



DIRS += \
      doc \
      include \
      3rd \
      src \

DIRS += \
      utils{src} \



include $(ROOT)config/dir.mk


ifeq ($(HB_PLATFORM),win)

# every harbour execute needs zlib1.dll
SRCLIB := $(subst /,$(DIRSEP),$(HB_HAS_ZLIB)/../lib/zlib1.dll)
DESTLIB := $(subst /,$(DIRSEP),$(HB_HOST_BIN_DIR)/zlib1.dll)
DESTDIR := $(subst /,$(DIRSEP),$(HB_HOST_BIN_DIR))

hbmk2Zlib1dll::
	$(info win SHELL='$(SHELL)' cmd='$(CP)' '$(SRCLIB)' '$(DESTLIB)')
	$(if $(wildcard $(DESTDIR)),,$(MD) $(DESTDIR))
	$(CP) $(SRCLIB) $(DESTLIB)
else

# every harbour execute needs libz.so
SRCLIB := $(subst /,$(DIRSEP),$(HB_HAS_ZLIB)../lib/libz.so)
DESTLIB := $(subst /,$(DIRSEP),$(HB_HOST_BIN_DIR)/libz.so)
DESTDIR := $(subst /,$(DIRSEP),$(HB_HOST_BIN_DIR))

hbmk2Zlib1dll::
	$(info SHELL='$(SHELL)' cmd='$(CP)' '$(SRCLIB)' '$(DESTLIB)')
	$(if $(wildcard $(DESTDIR)),,$(MDP) $(DESTDIR))
endif

first clean install:: hbmk2Zlib1dll
	$(if $(wildcard $(HB_HOST_BIN_DIR)/hbmk2$(HB_HOST_BIN_EXT)),+$(HB_HOST_BIN_DIR)/hbmk2$(HB_HOST_BIN_EXT) $(TOP)$(ROOT)config/postinst.hb $@,@$(ECHO) $(ECHOQUOTE)! Warning: hbmk2 not found, config/postinst.hb skipped.$(ECHOQUOTE))
	$(info == $(HB_HOST_BIN_DIR) END==)

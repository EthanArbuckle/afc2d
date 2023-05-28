ARCHS = arm64

TARGET := iphone:clang:latest:7.0
INSTALL_TARGET_PROCESSES = afcd
THEOS_PACKAGE_SCHEME=rootless
THEOS_PACKAGE_INSTALL_PREFIX=/fs/jb/

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = afc2d

afc2d_FILES = Tweak.x
afc2d_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/tweak.mk

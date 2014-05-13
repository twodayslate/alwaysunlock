THEOS_DEVICE_IP = 127.0.0.1
THEOS_DEVICE_PORT = 2222

THEOS_PACKAGE_DIR_NAME = debs
TARGET := iphone:clang
ARCHS := armv7 arm64

include theos/makefiles/common.mk

BUNDLE_NAME = alwaysunlock
alwaysunlock_FILES = Tweak.xm
alwaysunlock_LIBRARIES = Pass flipswitch substrate
alwaysunlock_INSTALL_PATH = /Library/Switches
alwaysunlock_ARCHS = armv7 armv7s arm64

include $(THEOS_MAKE_PATH)/bundle.mk

after-install::
	install.exec "killall -9 SpringBoard"

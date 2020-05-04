ARCHS = arm64 arm64e

GO_EASY_ON_ME = 1

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = eggNotch
eggNotch_FILES = Tweak.xm
eggNotch_FRAMEWORKS = UIKit CoreGraphics
eggNotch_LDFLAGS += -lCSColorPicker
eggNotch_EXTRA_FRAMEWORKS += Cephei

include $(THEOS_MAKE_PATH)/tweak.mk
SUBPROJECTS += eggnotch
include $(THEOS_MAKE_PATH)/aggregate.mk

after-install::
	install.exec "killall -9 SpringBoard"

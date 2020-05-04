ARCHS = arm64 arm64e
TARGET = 

include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = eggNotch

eggNotch_FILES = eggRootListController.m
eggNotch_INSTALL_PATH = /Library/PreferenceBundles
eggNotch_FRAMEWORKS = UIKit
eggNotch_PRIVATE_FRAMEWORKS = Preferences
eggNotch_CFLAGS = -fobjc-arc
eggNotch_EXTRA_FRAMEWORKS = Cephei CepheiPrefs

include $(THEOS_MAKE_PATH)/bundle.mk

internal-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences$(ECHO_END)
	$(ECHO_NOTHING)cp entry.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/eggNotch.plist$(ECHO_END)

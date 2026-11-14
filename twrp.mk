#
# TWRP (Team Win Recovery Project) settings for the LG G Pad X 8.0 (V521).
#
# Only used when building with WITH_TWRP=true (see ../../../bin/build-twrp),
# which also swaps bootable/recovery for the TWRP source. The ROM build
# (WITH_TWRP unset) is unaffected.
#

TARGET_RECOVERY_DEVICE_DIRS += device/lge/v521/twrp

# The panel is 1920x1200 (landscape), but the recovery framebuffer handed to
# TWRP is 1200x1920 (portrait).  TWRP scales the theme to the framebuffer
# using the <resolution> tag in the theme's ui.xml:
#   landscape_hdpi -> 1920x1200 -> scaled 0.625x wide / 1.600x tall
#   portrait_hdpi  -> 1080x1920 -> scaled 1.111x wide / 1.000x tall
# The landscape theme is scaled 1.6x vertically, which pushes text past the
# bottom of the framebuffer and crashes the GUI (it restarts in a loop).
# Use the portrait theme instead, same as the working TWRP 3.1.1 image.
TW_THEME := portrait_hdpi
TW_DEFAULT_BRIGHTNESS := 125

# No SuperSU, no TWRP app (this device has no Play Store; keep the image small)
TW_EXCLUDE_SUPERSU := true
TW_EXCLUDE_TWRPAPP := true

# Download mode works on this device (adb sideload from the bootloader)
TW_HAS_DOWNLOAD_MODE := true

# FBE support: the V521 userdata is file-based encrypted
TW_INCLUDE_CRYPTO := true

# Use AOSP toolbox/toybox instead of busybox: busybox is not in the 15.1 tree
TW_USE_TOOLBOX := true

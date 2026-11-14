# TWRP build files for the LG G Pad X 8.0 (V521)

This repository holds the TWRP specific bits for the LineageOS 15.1 port of the
LG G Pad X 8.0 (V521). They are kept out of the device tree so that the device
tree itself stays a plain AOSP-style tree that can be reviewed and merged
upstream.

## Contents

| File | Purpose |
| --- | --- |
| `twrp.mk` | TWRP build settings (theme, brightness, crypto, toolbox instead of busybox). |
| `twrp.fstab` | TWRP format fstab (TWRP parses the columns in a different order than the AOSP fstab). |
| `twrp/recovery/root/init.recovery.qcom.rc` | Vendor init fragment that TWRP's `init.rc` imports (`/init.recovery.${ro.hardware}.rc`). |

## How to use

Clone this repository into the device tree, so the files land next to
`BoardConfig.mk`:

```bash
cd <lineage>/device/lge/v521
git clone https://github.com/MicahOttah/android_device_lge_v521_twrp.git .
```

That gives you `device/lge/v521/twrp.mk`, `device/lge/v521/twrp.fstab` and
`device/lge/v521/twrp/`, which is exactly what `BoardConfig.mk` expects:

```makefile
ifeq ($(WITH_TWRP),true)
  ifeq ($(wildcard $(DEVICE_PATH)/twrp.mk),)
    $(error TWRP build requested but $(DEVICE_PATH)/twrp.mk is missing ...)
  endif
  TARGET_RECOVERY_FSTAB := $(DEVICE_PATH)/twrp.fstab
  include $(DEVICE_PATH)/twrp.mk
endif
```

The build then goes through the standard LineageOS TWRP path
(`WITH_TWRP=true`, `RECOVERY_VARIANT=twrp`, see
`vendor/lineage/config/twrp.mk`).

## Notes

* The panel is 1920x1200, but the recovery framebuffer is handed to TWRP as
  1200x1920. The landscape theme is scaled 1.6x vertically, which pushes the
  text past the bottom of the framebuffer and makes the GUI restart in a
  loop, so the portrait theme is used.
* `TW_USE_TOOLBOX := true` because busybox is not in the 15.1 tree.
* The TWRP build installs `init.recovery.*.rc` into the **boot** ramdisk root
  (`$(TARGET_ROOT_OUT)`), not into the recovery root. If a TWRP build has run
  in the same output tree, those files have to be removed from
  `out/target/product/v521/root/` before the ROM boot image is rebuilt,
  otherwise the ROM ramdisk carries recovery leftovers.

## License

Apache License 2.0, like the rest of the LineageOS tree.

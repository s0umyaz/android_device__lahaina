#
# Copyright (C) 2022 The Android Open Source Project
# Copyright (C) 2022 SebaUbuntu's TWRP device tree generator
#
# SPDX-License-Identifier: Apache-2.0
#

LOCAL_PATH := device/realme/RMX3461
# A/B
AB_OTA_POSTINSTALL_CONFIG += \
    RUN_POSTINSTALL_vendor=true \
    POSTINSTALL_PATH_vendor=vendor/bin/otapreopt_script \
    FILESYSTEM_TYPE_vendor=ext4 \
    POSTINSTALL_OPTIONAL_vendor=true

# Additional Info
TARGET_HAS_GENERIC_KERNEL_HEADERS := true
RELAX_USES_LIBRARY_CHECK := true
TARGET_ENFORCE_AB_OTA_PARTITION_LIST := true
PRODUCT_USE_DYNAMIC_PARTITIONS := true

#namespace definition for librecovery_updater
SOONG_CONFIG_NAMESPACES += ufsbsg
SOONG_CONFIG_ufsbsg += ufsframework
SOONG_CONFIG_ufsbsg_ufsframework := bsg

# VNDK
PRODUCT_TARGET_VNDK_VERSION := 31

# Set GRF/Vendor freeze properties
BOARD_SHIPPING_API_LEVEL := 31
BOARD_API_LEVEL := 31
SHIPPING_API_LEVEL := 31
PRODUCT_SHIPPING_API_LEVEL := 31

# Boot control HAL
PRODUCT_PACKAGES += \
    android.hardware.boot@1.0-impl \
    android.hardware.boot@1.0-impl.recovery \
    android.hardware.boot@1.0-service 

PRODUCT_PACKAGES += \
    bootctrl.lahaina \
    bootctrl.lahaina.recovery \
    fastbootd

PRODUCT_PACKAGES += \
    bootctrl.lahaina \
    libgptutils \
    libz \
    libcutils

PRODUCT_PACKAGES += \
    otapreopt_script \
    cppreopts.sh \
    update_engine \
    update_verifier \
    update_engine_sideload

# Encryption
PRODUCT_PACKAGES += \
    qcom_decrypt \
    qcom_decrypt_fbe
    
# Soong namespaces
PRODUCT_SOONG_NAMESPACES += \
    $(LOCAL_PATH)
    
# OEM otacerts
PRODUCT_EXTRA_RECOVERY_KEYS += \
    $(LOCAL_PATH)/security/otacert

# Enable Fuse Passthrough
PRODUCT_PROPERTY_OVERRIDES += persist.sys.fuse.passthrough.enable=true
    
# Copy modules for depmod
PRODUCT_COPY_FILES += \
    $(call find-copy-subdir-files,*.ko,device/realme/RMX3461/prebuilt/modules/5.4-gki/,$(TARGET_COPY_OUT_RECOVERY)/root/vendor/lib/modules/)

#
# Copyright (C) 2022 The Android Open Source Project
# Copyright (C) 2022 SebaUbuntu's TWRP device tree generator
#
# SPDX-License-Identifier: Apache-2.0
#

LOCAL_PATH := device/qualcomm/lahaina
# A/B
AB_OTA_POSTINSTALL_CONFIG += \
    RUN_POSTINSTALL_system=true \
    POSTINSTALL_PATH_system=system/bin/otapreopt_script \
    FILESYSTEM_TYPE_system=ext4 \
    POSTINSTALL_OPTIONAL_system=true
    
# tell update_engine to not change dynamic partition table during updates
# needed since our qti_dynamic_partitions does not include
# vendor and odm and we also dont want to AB update them
TARGET_ENFORCE_AB_OTA_PARTITION_LIST := true

# Boot control HAL
PRODUCT_PACKAGES += \
    android.hardware.boot@1.0-impl \
    android.hardware.boot@1.0-impl-1.1-qti.recovery \
    android.hardware.boot@1.0-service 
    

PRODUCT_PACKAGES += \
    bootctrl.lahaina \
    bootctrl.lahaina.recovery 

PRODUCT_STATIC_BOOT_CONTROL_HAL := \
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
    
# fastbootd
PRODUCT_PACKAGES += \
    android.hardware.fastboot@1.0-impl-mock \
    fastbootd
    
# Dynamic partitions
PRODUCT_USE_DYNAMIC_PARTITIONS := true
    
# qcom decryption
PRODUCT_PACKAGES += \
    qcom_decrypt \
    qcom_decrypt_fbe

# Soong namespaces
PRODUCT_SOONG_NAMESPACES += \
    $(LOCAL_PATH)

# Copy modules for depmod
PRODUCT_COPY_FILES += \
    $(call find-copy-subdir-files,*.ko,device/qualcomm/lahaina/prebuilt/modules/5.4-gki/,$(TARGET_COPY_OUT_RECOVERY)/root/vendor/lib/modules/)

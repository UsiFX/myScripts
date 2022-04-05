#!/bin/bash
#
# A setup script Copyright (c) 2022 XPRJKT
#

gitprofile="https://github.com/UsiFX"
dir_root=$(pwd)

sync_my_git()
{
	git clone --depth=1 ${gitprofile}/device_xiaomi_lavender device/xiaomi/lavender
	git clone --depth=1 ${gitprofile}/vendor_xiaomi_lavender vendor/xiaomi/lavender
	git clone --depth=1 ${gitprofile}/device_xiaomi_sdm660-common device/xiaomi/sdm660-common
	git clone --depth=1 ${gitprofile}/vendor_xiaomi_sdm660-common vendor/xiaomi/sdm660-common
	git clone --depth=1 ${gitprofile}/device_xiaomi_extras device/xiaomi/extras
}


additions()
{
	git clone --depth=1 https://github.com/kdrag0n/proton-clang prebuilts/clang/host/linux-x86/clang-proton
	git clone ${gitprofile}/hardware_qcom-caf_msm8998_media
	git clone ${gitprofile}/hardware_qcom-caf_msm8998_display
	git clone ${gitprofile}/hardware_qcom-caf_msm8998_audio

}

existed()
{
	if [ -f device/xiaomi/lavender ][ -f vendor/xiaomi/lavender ][ -f hardware/qcom-caf/msm8998/* ]
	then
		echo "[!] Setup panicced, Everything is existed type '$0 --force-skip' to continue"
		exit 1
	else
		sync_my_git
		additions
}


case $* in
		"--force-skip") rm -rf hardware/qcom-caf/msm8998/media
        			rm -rf hardware/qcom-caf/msm8998/display
        			rm -rf hardware/qcom-caf/msm8998/audio
				rm -rf prebuilts/clang/host/linux-x86/clang-proton
				rm -rf vendor/xiaomi/lavender
				rm -rf device/xiaomi/lavender
				rm -rf device/xiaomi/extras
				rm -rf device/xioami/sdm660-*
				rm -rf vendor/xiaomi/sdm660-*
				sync_my_git
				;;
		*) existed ;;
esac

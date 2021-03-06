#!/bin/bash

mkdir -p /tmp/rom # Where to sync source
cd /tmp/rom

# Repo init command, that -device,-mips,-darwin,-notdefault part will save you more time and storage to sync, add more according to your rom and choice. Optimization is welcomed! Let's make it quit, and with depth=1 so that no unnecessary things.
# I want to sync DotOS source!
repo init --depth=1 --no-repo-verify -u git://github.com/DotOS/manifest.git -b dot11 -g default,-device,-mips,-darwin,-notdefault

# Clone local manifest! So that no need to manually git clone repos or change hals, you can use normal git clone or rm and re clone, they will cost little more time, and you may get timeout! Let's make it quit and depth=1 too.
# My local manifest can do all clone, and removing or changing repository i need, so lets use it! I am lazy to manually git clone!
# git clone https://github.com/Apon77Lab/android_.repo_local_manifests.git --depth 1 -b aex .repo/local_manifests

# Sync source with -q, no need unnecessary messages, you can remove -q if want! try with -j30 first, if fails, it will try again with -j8
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j30 || repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# Clone device tree, vendor tree and kernel tree
git clone --depth=1 https://github.com/dotOS-Devices/device_xiaomi_pine -b dot11 device/xiaomi/pine
git clone --depth=1 https://github.com/dotOS-Devices/vendor_xiaomi_pine -b dot11 vendor/xiaomi/pine
git clone --depth=1 https://github.com/dotOS-Devices/kernel_xiaomi_pine -b dot11 kernel/xiaomi/pine

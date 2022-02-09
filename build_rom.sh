# sync rom
repo init --depth=1 --no-repo-verify -u git://github.com/syberia-project/manifest.git -b 12.0 -g default,-mips,-darwin,-notdefault
git clone https://github.com/sajidshahriar72543/local_manifest.git --depth 1 -b syb .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

#64

# build rom
source build/envsetup.sh
# export SELINUX_IGNORE_NEVERALLOWS=true
lunch syberia_beryllium-userdebug
export TZ=Asia/Dhaka #put before last build command
export BUILD_HOSTNAME=PaperBoy
make bacon

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P

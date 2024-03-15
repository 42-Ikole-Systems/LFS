
BOOT_FILES_DIR = boot_files

# linux variables
LINUX_DIR = linux/
LINUX_KERNEL = linux/arch/x86/boot/bzImage

# userspace variables
BUSYBOX_DIR = busybox/
INITRAMFS_DIR = $(BOOT_FILES_DIR)/initramfs

all: build_linux build_busybox collect_boot_files create_filesystem_archive create_boot_file

build_linux:
	@echo Building linux...
	@$(MAKE) -C $(LINUX_DIR) menuconfig
	@$(MAKE) -C $(LINUX_DIR) -j 8

build_busybox:
	@echo building busybox...
	@$(MAKE) -C $(BUSYBOX_DIR) menuconfig
	@$(MAKE) -C $(BUSYBOX_DIR) -j 8

collect_boot_files:
	@echo collecting bootfiles...
	@mv $(LINUX_KERNEL) $(BOOT_FILES_DIR)

# Move busybox into the initramfs dir.
# This directory will be the initial filesystem the kernel loads after booting.
# Thats why we install busybox there.
	@$(MAKE) -C $(BUSYBOX_DIR) CONFIG_PREFIX=$(CURDIR)/$(INITRAMFS_DIR) install
	@rm $(INITRAMFS_DIR)/linuxrc

# Turn the initramfs directory into the initial filesystem.
create_filesystem_archive:
	@echo creating filesystem archive...
	@find $(INITRAMFS_DIR) | cpio -o -H newc > $(BOOT_FILES_DIR)/init.cpio

create_boot_file:
	@echo creating boot file...
	@dd if=/dev/zero of=$(BOOT_FILES_DIR)/boot bs=1M count=50

# create fat filesystem on boot file
	@mkfs -t fat $(BOOT_FILES_DIR)/boot
	@syslinux $(BOOT_FILES_DIR)/boot

# add kernel and initramfs to boot image
	@mkdir $(BOOT_FILES_DIR)/temp
	@mount $(BOOT_FILES_DIR)/boot $(BOOT_FILES_DIR)/temp
	@cp $(BOOT_FILES_DIR)/bzImage $(BOOT_FILES_DIR)/temp
	@cp $(BOOT_FILES_DIR)/init.cpio $(BOOT_FILES_DIR)/temp
	@unmount $(BOOT_FILES_DIR)/temp

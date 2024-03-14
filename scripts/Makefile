
BOOT_FILES_DIR = boot_files

# linux variables
LINUX_DIR = linux/
LINUX_KERNEL = linux/arch/x86/boot/bzImage

# userspace variables
BUSYBOX_DIR = busybox/
INITRAMFS_DIR = $(BOOT_FILES_DIR)/initramfs

all: build_linux build_busybox collect_boot_files

build_linux:
	@$(MAKE) -C $(LINUX_DIR) menuconfig
	@$(MAKE) -C $(LINUX_DIR) -j 8

build_busybox:
	@$(MAKE) -C $(BUSYBOX_DIR) menuconfig
	@$(MAKE) -C $(BUSYBOX_DIR) -j 8

collect_boot_files:
	@mkdir $(BOOT_FILES_DIR)
	@mv $(LINUX_KERNEL) $(BOOT_FILES_DIR)

# Move busybox into the initramfs dir.
# This directory will be the initial filesystem the kernel loads after booting.
# Thats why we install busybox there.
	@$(MAKE) -C $(BUSYBOX_DIR) CONFIG_PREFIX=$(INITRAMFS_DIR) install

################################################################################
#
# tpm2-tools
#
################################################################################

# TPM2_TOOLS_EXT_VERSION = 0cb093f1d0194c5d5fd8e8bb6abab0d97c0cf7a8
# TPM2_TOOLS_EXT_SITE = https://github.com/tpm2-software/tpm2-tools.git
# TPM2_TOOLS_EXT_SITE_METHOD = git

TPM2_TOOLS_EXT_VERSION = 5.6-rc0
TPM2_TOOLS_EXT_SOURCE = tpm2-tools-$(TPM2_TOOLS_EXT_VERSION).tar.gz
TPM2_TOOLS_EXT_SITE = https://github.com/tpm2-software/tpm2-tools/releases/download/$(TPM2_TOOLS_EXT_VERSION)
TPM2_TOOLS_EXT_LICENSE = BSD-3-Clause
TPM2_TOOLS_EXT_LICENSE_FILES = doc/LICENSE
TPM2_TOOLS_EXT_CPE_ID_VENDOR = tpm2-tools_project
TPM2_TOOLS_EXT_SELINUX_MODULES = tpm2
TPM2_TOOLS_EXT_DEPENDENCIES = libcurl openssl tpm2-tss host-pkgconf

# -fstack-protector-all and FORTIFY_SOURCE=2 is used by
# default. Disable that so the BR2_SSP_* / BR2_FORTIFY_SOURCE_* options
# in the toolchain wrapper and CFLAGS are used instead
TPM2_TOOLS_EXT_CONF_OPTS = --disable-hardening

# do not build man pages
TPM2_TOOLS_EXT_CONF_ENV += ac_cv_prog_PANDOC=''

ifeq ($(BR2_PACKAGE_TPM2_TOOLS_EXT_FAPI),y)
TPM2_TOOLS_EXT_CONF_OPTS += --enable-fapi
else
TPM2_TOOLS_EXT_CONF_OPTS += --disable-fapi
endif

# This is required because ./bootstrap later requires git data
# define TPM2_TOOLS_EXT_COPY_GIT
#     cp -r $(SRCDIR)/.git $(@D)/.git
# endef

# define TPM2_TOOLS_EXT_BOOTSTRAP
#     cd $(@D) && ./bootstrap
# endef

# TPM2_TOOLS_EXT_OVERRIDE_SRCDIR_RSYNC_EXCLUSIONS = --include .git
# TPM2_TOOLS_EXT_POST_RSYNC += TPM2_TOOLS_EXT_COPY_GIT
# TPM2_TOOLS_EXT_PRE_CONFIGURE_HOOKS += TPM2_TOOLS_EXT_BOOTSTRAP

$(eval $(autotools-package))

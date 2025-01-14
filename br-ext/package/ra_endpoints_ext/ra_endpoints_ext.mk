RA_ENDPOINTS_EXT_VERSION = 1.0
RA_ENDPOINTS_EXT_SOURCE = local
RA_ENDPOINTS_EXT_SITE = $(BR2_PACKAGE_RA_ENDPOINTS_EXT_SITE)
RA_ENDPOINTS_EXT_SITE_METHOD = local
RA_ENDPOINTS_EXT_DEPENDENCIES = optee_client_ext

define RA_ENDPOINTS_EXT_BUILD_CMDS
	$(MAKE) -C $(@D) CROSS_COMPILE=$(BR2_PACKAGE_RA_ENDPOINTS_EXT_CROSS_COMPILE) OPTEE_ROOT=$(BR2_PACKAGE_RA_ENDPOINTS_EXT_OPTEE_ROOT_PATH)
endef

define RA_ENDPOINTS_EXT_INSTALL_TARGET_CMDS
	$(INSTALL) -D -m 0755 $(@D)/ra_verifier  $(TARGET_DIR)/usr/bin/ra_verifier
	$(INSTALL) -D -m 0755 $(@D)/ra_prover  $(TARGET_DIR)/usr/bin/ra_prover
	$(INSTALL) -D -m 0755 $(RA_ENDPOINTS_EXT_PKGDIR)/S50time $(TARGET_DIR)/etc/init.d/S50time
endef

$(eval $(generic-package))

class gitfiles::enable_services (
) {
  gitfiles::enable_service { [ 'gpm', 'lightdm', 'onBoot', 'onBoot-network', 'NetworkManager' ]: }
}

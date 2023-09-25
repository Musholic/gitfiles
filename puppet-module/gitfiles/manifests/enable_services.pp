class gitfiles::enable_services (
) {
  gitfiles::enable_service { [ 'NetworkManager', 'gpm', 'lightdm', 'onBoot', 'onBoot-network' ]: }
}

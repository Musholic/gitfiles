define gitfiles::enable_service (
  $service = $title,
) {
  exec { "Enable service $service":
    command => "/usr/bin/systemctl enable $service",
    unless  => "/usr/bin/systemctl is-enabled $service",
  }
}

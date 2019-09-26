job "autossh" {
  region      = "${node.region}"
  datacenters = ["${node.datacenter}"]

  type        = "system"

  group "ssh-tunnels" {
    count = 1

    task "grape-tunnel" {
      driver = "raw_exec"

      config {
        command = "/usr/bin/autossh"
        args    = [
          "-T", "-N", "-n", "-M", "0",
          "-o", "ServerAliveInterval 30",
          "-o", "ServerAliveCountMax 3",
          "-R", "4544:localhost:44",
          "root@grape.zalad.io",
          "-p", "44"
        ]
      }
    }
  }
}


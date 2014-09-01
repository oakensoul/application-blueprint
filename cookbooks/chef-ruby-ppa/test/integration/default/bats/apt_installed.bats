#!/usr/bin/env bats

@test "apt-get binary is found in PATH" {
  run which apt-get
  [ "$status" -eq 0 ]
}
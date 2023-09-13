.PHONY: all os home

ROOT_DIR := $(dir $(realpath $(lastword $(MAKEFILE_LIST))))

all: os home

os:
	sudo nixos-rebuild switch --flake "$(ROOT_DIR)"

home:
	home-manager switch --flake "$(ROOT_DIR)"

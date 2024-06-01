.PHONY: all os home news

ROOT_DIR := $(dir $(realpath $(lastword $(MAKEFILE_LIST))))

all: os home

os:
	sudo nixos-rebuild boot --flake "$(ROOT_DIR)"

home:
	home-manager switch --flake "$(ROOT_DIR)"

news:
	home-manager news --flake "$(ROOT_DIR)"

gen:
	nix-env --list-generations

gen-home:
	home-manager generations

# home-manager remove-generations $(seq n m)
# sudo nix-env --delete-generations old

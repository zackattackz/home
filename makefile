.PHONY: all os home news

ROOT_DIR := $(dir $(realpath $(lastword $(MAKEFILE_LIST))))

all: os home

os:
	sudo nixos-rebuild boot --flake "$(ROOT_DIR)"

oss:
	sudo nixos-rebuild switch --flake "$(ROOT_DIR)"

home:
	home-manager switch --flake "$(ROOT_DIR)"

news:
	home-manager news --flake "$(ROOT_DIR)"

gen:
	nix-env --list-generations
	sudo nix-env --profile /nix/var/nix/profiles/system  --list-generations

gen-home:
	home-manager generations

rollback-home:
	bash $(home-manager generations | fzf | awk -F '-> ' '{print $2 "/activate"}')

expire-home:
	home-manager generations | cut -d' ' -f 5 | sed 1d | xargs -I _ home-manager remove-generations _

expire-system:
	nix-env --delete-generations old
	sudo nix-env --profile /nix/var/nix/profiles/system --delete-generations old

garbage:
	sudo nix-collect-garbage
	sudo nix-store --optimise
	sudo nix-collect-garbage

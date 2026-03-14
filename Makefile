################ 
# OS Detection #
################

# On Windows, GNU Make exposes $(OS) = "Windows_NT".
# On macOS, uname -s returns "Darwin".
# Everything else is treated as Ubuntu/Linux.

ifeq ($(OS),Windows_NT)
  PLATFORM := windows
else
  UNAME_S := $(shell uname -s)
  ifeq ($(UNAME_S),Darwin)
    PLATFORM := macosx
  else
    PLATFORM := linux
  endif
endif

OS_MAKEFILE := Makefile.$(PLATFORM)

############# 
# Variables #
#############

USER ?= $(shell whoami)

GIT_USER_NAME ?= "op://Private/github/name"
GIT_USER_EMAIL ?= "op://Private/github/email"

GIT_SSH_SIGNERS ?= "op://Private/github/signers"

GIT_SSH_CONFIGS_NAME ?= "id_github"
GIT_SSH_CONFIGS_PATH ?= "op://Private/github ssh"

########### 
# Targets #
###########

all:
	@echo "Building with $(OS_MAKEFILE)"
	$(MAKE) -f $(OS_MAKEFILE) all

upgrade:
	@echo "Upgrading with $(OS_MAKEFILE)"
	$(MAKE) -f $(OS_MAKEFILE) upgrade

symlink:
	@echo "Symlinking with $(OS_MAKEFILE)"
	$(MAKE) -f $(OS_MAKEFILE) symlink
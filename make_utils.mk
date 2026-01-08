# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    make_utils.mk                                      :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: jaubry-- <jaubry--@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2025/08/15 19:28:47 by jaubry--          #+#    #+#              #
#    Updated: 2026/01/07 23:57:15 by jaubry--         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

SHELL		:= /bin/bash

# Makefile Variables
FAST		= $(if $(filter fast,$(MAKECMDGOALS)),1,0)
INSPECT		= $(if $(filter inspect,$(MAKECMDGOALS)),1,0)
PROFILE		= $(if $(filter profile,$(MAKECMDGOALS)),1,0)

ifeq ($(FAST),1)
	RULE = fast
else ifeq ($(INSPECT),1)
	RULE = inspect
else ifeq ($(PROFILE),1)
	RULE = profile
endif

# Variables
NPROC		= $(shell nproc)

#RESOLUTION	= $(shell xrandr | sed -n '/primary/{n;p;}' | awk '{print $$1}')
#MAX_WIDTH	= $(shell echo $(RESOLUTION) | cut -d 'x' -f 1)
#MAX_HEIGHT	= $(shell echo $(RESOLUTION) | cut -d 'x' -f 2-)
MAX_SIZE	= $(shell xrandr | grep "primary" | awk '{print $$4}' | cut -d '+' -f 1)
MAX_WIDTH	= $(shell echo $(MAX_SIZE) | cut -d 'x' -f 1)
MAX_HEIGHT	= $(shell echo $(MAX_SIZE) | cut -d 'x' -f 2)

# Dep Directories
LIBDIR		= $(ROOTDIR)/lib
MKIDIR		= $(ROOTDIR)/.

# Flags
ifeq ($(PROFILE),1)
	PROFILE_FLAGS = -g3 -pg
else ifeq ($(INSPECT),1)
	INSPECT_FLAGS = -g3
endif

ifeq ($(FAST),1)
	OFLAGS		= -Ofast -march=native -mtune=native -msse3
	FFLAGS		= $(OFLAGS) -flto
endif

# Sys binaries
STD_AR			= ar
STD_ar			= ranlib

HOME_AR			= ar
HOME_RANLIB		= ranlib
HOME_GCC		= gcc-14
HOME_CFLAGS		= -Wno-error=maybe-uninitialized \
				  -Wno-error=stringop-overflow \
				  -Wno-error=alloc-size

FT_AR			= llvm-ar-12
FT_RANLIB		= llvm-ranlib-12
FT_GCC			= gcc-12

GET_ID = cat /etc/machine-id | sha256sum | cut -d' ' -f1
HOME_ID	= 6bb6eb3dbd1b58e9b11f9bba389b9fa248353ef0dd2fea7e9f1f5aeed881747d
ifeq ($(shell $(GET_ID)), $(HOME_ID))
	FAST_AR			= $(HOME_AR)
	FAST_RANLIB		= $(HOME_RANLIB)

	MLX_GCC			= $(HOME_GCC)

	CC				= cc $(HOME_CFLAGS)
else
ifeq ($(PROFILE),1)
	PROFILE_FLAGS	+= -Rpass-missed=.*
endif
	FAST_AR			= $(FT_AR)
	FAST_RANLIB		= $(FT_RANLIB)

	MLX_GCC			= $(FT_GCC)
endif

# Print utils
include $(ROOTDIR)/mkidir/colors.mk


# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    make_utils.mk                                      :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: jaubry-- <jaubry--@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2025/08/15 19:28:47 by jaubry--          #+#    #+#              #
#    Updated: 2025/09/24 19:41:29 by jaubry--         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

SHELL		:= /bin/bash

# Makefile Variables
FAST		= $(if $(filter fast,$(MAKECMDGOALS)),1,0)
DEBUG		= $(if $(filter debug,$(MAKECMDGOALS)),1,0)

ifeq ($(FAST),1)
	RULE = fast
else ifeq ($(DEBUG),1)
	RULE = debug
endif

# Dep Directories
LIBDIR		= $(ROOTDIR)/lib
MKIDIR		= $(ROOTDIR)/.

# Flags
ifeq ($(DEBUG),1)
	DEBUG_FLAGS = -g3
endif
#-pg -Rpass-missed=.*

ifeq ($(FAST),1)
	OFLAGS		= -Ofast -march=native -mtune=native -msse3
	FFLAGS		= $(OFLAGS) -flto
endif

# Sys binaries
STD_AR			= ar
STD_RANLIB		= ranlib

GET_ID = cat /etc/machine-id | sha256sum | cut -d' ' -f1
HOME_ID	= 6bb6eb3dbd1b58e9b11f9bba389b9fa248353ef0dd2fea7e9f1f5aeed881747d
ifeq ($(shell $(GET_ID)), $(HOME_ID))
	FAST_AR		= ar
	FAST_RANLIB	= ranlib

	MLX_GCC		= gcc-14
else
	FAST_AR		= llvm-ar-12
	FAST_RANLIB	= llvm-ranlib-12

	MLX_GCC		= gcc-12
endif

# Print utils
include $(ROOTDIR)/mkidir/colors.mk


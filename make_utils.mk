# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    make_utils.mk                                      :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: jaubry-- <jaubry--@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2025/08/15 19:28:47 by jaubry--          #+#    #+#              #
#    Updated: 2025/09/09 10:12:33 by jaubry--         ###   ########.fr        #
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

ifeq ($(shell uname -r), 6.16.5-2-cachyos)
	FAST_AR		= llvm-ar
	FAST_RANLIB	= llvm-ranlib

	MLX_GCC		= gcc-14
else
	FAST_AR		= llvm-ar-12
	FAST_RANLIB	= llvm-ranlib-12

	MLX_GCC		= gcc-12
endif

# Print utils
include $(ROOTDIR)/mkidir/colors.mk


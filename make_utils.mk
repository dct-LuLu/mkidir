# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    make_utils.mk                                      :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: jaubry-- <jaubry--@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2025/08/15 19:28:47 by jaubry--          #+#    #+#              #
#    Updated: 2025/08/20 20:33:45 by jaubry--         ###   ########.fr        #
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
	OFLAGS		= -Ofast -ffast-math -funroll-loops \
				  -march=native -mtune=native -msse3
	FFLAGS		= $(OFLAGS) -flto
endif

# Sys binaries
STD_AR			= ar
FAST_AR			= llvm-ar-12

STD_RANLIB		= ranlib
FAST_RANLIB		= llvm-ranlib-12

MLX_GCC			= gcc-12

# Print utils
include $(ROOTDIR)/mkidir/colors.mk


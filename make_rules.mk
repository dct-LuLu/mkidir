# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    make_rules.mk                                      :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: jaubry-- <jaubry--@student.42lyon.fr>      +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2026/02/16 19:30:58 by jaubry--          #+#    #+#              #
#    Updated: 2026/02/16 19:55:40 by jaubry--         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

VERBOSE	= 0

all:		$(NAME)
fast:		$(NAME)
debug:		$(NAME)
inspect:	$(NAME)
profile:	$(NAME)
san-mem:	$(NAME)
san-leak:	$(NAME)
san-ub:		$(NAME)

$(OBJDIR)/%.o: %.c $(INCLUDES) | buildmsg $(OBJDIR) $(DEPDIR)
	$(call bin-compile-obj-msg)
ifeq ($(VERBOSE),1)
	$(CF) $(DFLAGS) -c $< -o $@
else
	@$(CF) $(DFLAGS) -c $< -o $@
endif

$(OBJDIR) $(DEPDIR):
	$(call color,$(CYAN),"Creating directory %UL%$@")
	@mkdir -p $@

print-% : ; $(info $* is a $(flavor $*) variable set to [$($*)]) @true

re: 		fclean all
refast:		fclean fast
redebug:	fclean debug
reinspect:	fclean inspect
reprofile:	fclean profile
resan-mem:	fclean san-mem
resan-leak:	fclean san-leak
resan-ub:	fclean san-ub

.PHONY: re refast redebug reinspect reprofile resan-mem resan-leak resan-ub
.PHONY: print-%

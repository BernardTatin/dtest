#
# compiler.mk
#

# choose the compiler (dmd | ldc2)
compiler ?= dmd
# choose the version  (debug | release)
version ?= debug

ifeq ($(compiler),dmd)
	_version = -$(version)
	_color = -color
	_more_options = -dw
	ifeq ($(version),release)
		_more_options += -g -gf -gs -gx
	else
		_more_options += -inline -O
	endif
else
	_version =
	_color = --enable-color=true
endif
# basic compiler command
D = $(compiler) -I=. $(_version) $(_color) $(_more_options)



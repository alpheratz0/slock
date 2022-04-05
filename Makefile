# slock - simple screen locker
# See LICENSE file for copyright and license details.

# slock version
VERSION = 1.4

# Customize below to fit your system

# paths
PREFIX = /usr/local
MANPREFIX = ${PREFIX}/share/man

X11INC = /usr/X11R6/include
X11LIB = /usr/X11R6/lib

# includes and libs
INCS = -I. -I/usr/include -I${X11INC}
LIBS = -L/usr/lib -lc -lcrypt -L${X11LIB} -lX11 -lXext -lXrandr

# flags
CPPFLAGS = -DVERSION=\"${VERSION}\" -D_DEFAULT_SOURCE -DHAVE_SHADOW_H
CFLAGS = -std=c99 -pedantic -Wall -Os ${INCS} ${CPPFLAGS}
LDFLAGS = -s ${LIBS}
COMPATSRC = src/explicit_bzero.c

# On OpenBSD and Darwin remove -lcrypt from LIBS
#LIBS = -L/usr/lib -lc -L${X11LIB} -lX11 -lXext -lXrandr
# On *BSD remove -DHAVE_SHADOW_H from CPPFLAGS
# On NetBSD add -D_NETBSD_SOURCE to CPPFLAGS
#CPPFLAGS = -DVERSION=\"${VERSION}\" -D_BSD_SOURCE -D_NETBSD_SOURCE
# On OpenBSD set COMPATSRC to empty
#COMPATSRC =

# compiler and linker
CC = cc

SRC = src/slock.c ${COMPATSRC}
OBJ = ${SRC:.c=.o}

all: slock

${OBJ}: src/config.h \
		src/arg.h \
		src/util.h

slock: ${OBJ}
	@${CC} -o $@ ${OBJ} ${LDFLAGS}

clean:
	@rm -f slock ${OBJ} slock-${VERSION}.tar.gz

dist: clean
	@mkdir -p slock-${VERSION}
	@cp -R LICENSE Makefile README man src slock-${VERSION}
	@tar -cf slock-${VERSION}.tar slock-${VERSION}
	@gzip slock-${VERSION}.tar
	@rm -rf slock-${VERSION}

install: all
	@mkdir -p ${DESTDIR}${PREFIX}/bin
	@cp -f slock ${DESTDIR}${PREFIX}/bin
	@chmod 755 ${DESTDIR}${PREFIX}/bin/slock
	@chmod u+s ${DESTDIR}${PREFIX}/bin/slock
	@mkdir -p ${DESTDIR}${MANPREFIX}/man1
	@sed "s/VERSION/${VERSION}/g" <man/slock.1 >${DESTDIR}${MANPREFIX}/man1/slock.1
	@chmod 644 ${DESTDIR}${MANPREFIX}/man1/slock.1

uninstall:
	@rm -f ${DESTDIR}${PREFIX}/bin/slock
	@rm -f ${DESTDIR}${MANPREFIX}/man1/slock.1

.PHONY: all clean dist install uninstall

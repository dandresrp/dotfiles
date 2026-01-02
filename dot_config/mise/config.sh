export PHP_BUILD_CONFIGURE_OPTS="--with-iconv=/opt/homebrew/opt/libiconv"
export LDFLAGS="-L/opt/homebrew/opt/libiconv/lib $LDFLAGS"
export CPPFLAGS="-I/opt/homebrew/opt/libiconv/include $CPPFLAGS"
export PATH="/opt/homebrew/opt/bison/bin:$PATH"

" hash.vim
" @Author:      Tom Link (mailto:micathom AT gmail com?subject=[vim])
" @License:     GPL (see http://www.gnu.org/licenses/gpl.txt)
" @Created:     2012-12-14.
" @Last Change: 2010-09-26.
" @Revision:    145


function! tlib#hash#CRC32(chars) "{{{3
    let rv = ''
    if has('ruby')
        ruby << EOR
        require 'zlib'
        VIM::command('let rv = "%08x"' % Zlib.crc32(VIM::evaluate("a:chars")))
EOR
        " elseif has('python')
        " elseif has('perl')
        " elseif has('tcl')
    else
        throw "tlib: No implementation for CRC32"
        " if !exists('s:crc_table')
        "     let s:crc_table = [
        "                 \ [0],
        "                 \ [0,1,1,0,1,0,0,1,0,0,0,0,1,1,0,0,1,1,1,0,0,0,0,0,1,1,1,0,1,1,1],
        "                 \ [0,0,1,1,0,1,0,0,1,0,0,0,0,1,1,0,0,1,1,1,0,0,0,0,0,1,1,1,0,1,1,1],
        "                 \ [0,1,0,1,1,1,0,1,1,0,0,0,1,0,1,0,1,0,0,1,0,0,0,0,1,0,0,1,1,0,0,1],
        "                 \ [1,0,0,1,1,0,0,0,0,0,1,0,0,0,1,1,1,0,1,1,0,1,1,0,1,1,1],
        "                 \ [1,1,1,1,0,0,0,1,0,0,1,0,1,1,1,1,0,1,0,1,0,1,1,0,0,0,0,0,1,1,1],
        "                 \ [1,0,1,0,1,1,0,0,1,0,1,0,0,1,0,1,1,1,0,0,0,1,1,0,1,0,0,1,0,1,1,1],
        "                 \ [1,1,0,0,0,1,0,1,1,0,1,0,1,0,0,1,0,0,1,0,0,1,1,0,0,1,1,1,1,0,0,1],
        "                 \ [0,1,0,0,1,1,0,0,0,0,0,1,0,0,0,1,1,1,0,1,1,0,1,1,0,1,1,1],
        "                 \ [0,0,1,0,0,1,0,1,0,0,0,1,1,1,0,1,0,0,1,1,1,0,1,1,1,0,0,1,1,1,1],
        "                 \ [0,1,1,1,1,0,0,0,1,0,0,1,0,1,1,1,1,0,1,0,1,0,1,1,0,0,0,0,0,1,1,1],
        "                 \ [0,0,0,1,0,0,0,1,1,0,0,1,1,0,1,1,0,1,0,0,1,0,1,1,1,1,1,0,1,0,0,1],
        "                 \ [1,1,0,1,0,1,0,0,0,0,1,1,0,0,1,0,0,1,1,0,1,1,0,1,1,0,0,1],
        "                 \ [1,0,1,1,1,1,0,1,0,0,1,1,1,1,1,0,1,0,0,0,1,1,0,1,0,1,1,1,1,1,1],
        "                 \ [1,1,1,0,0,0,0,0,1,0,1,1,0,1,0,0,0,0,0,1,1,1,0,1,1,1,1,0,0,1,1,1],
        "                 \ [1,0,0,0,1,0,0,1,1,0,1,1,1,0,0,0,1,1,1,1,1,1,0,1,0,0,0,0,1,0,0,1],
        "                 \ [0,0,1,0,0,1,1,0,0,0,0,0,1,0,0,0,1,1,1,0,1,1,0,1,1,0,1,1,1],
        "                 \ [0,1,0,0,1,1,1,1,0,0,0,0,0,1,0,0,0,0,0,0,1,1,0,1,0,1,0,1,0,1,1],
        "                 \ [0,0,0,1,0,0,1,0,1,0,0,0,1,1,1,0,1,0,0,1,1,1,0,1,1,1,0,0,1,1,1,1],
        "                 \ [0,1,1,1,1,0,1,1,1,0,0,0,0,0,1,0,0,1,1,1,1,1,0,1,0,0,1,0,0,0,0,1],
        "                 \ [1,0,1,1,1,1,1,0,0,0,1,0,1,0,1,1,0,1,0,1,1,0,1,1,0,1,0,1,1],
        "                 \ [1,1,0,1,0,1,1,1,0,0,1,0,0,1,1,1,1,0,1,1,1,0,1,1,1,0,1,1,0,1,1],
        "                 \ [1,0,0,0,1,0,1,0,1,0,1,0,1,1,0,1,0,0,1,0,1,0,1,1,0,0,1,0,1,1,1,1],
        "                 \ [1,1,1,0,0,0,1,1,1,0,1,0,0,0,0,1,1,1,0,0,1,0,1,1,1,1,0,0,0,0,0,1],
        "                 \ [0,1,1,0,1,0,1,0,0,0,0,1,1,0,0,1,0,0,1,1,0,1,1,0,1,1,0,0,1],
        "                 \ [0,0,0,0,0,0,1,1,0,0,0,1,0,1,0,1,1,1,0,1,0,1,1,0,0,0,1,0,0,1,1],
        "                 \ [0,1,0,1,1,1,1,0,1,0,0,1,1,1,1,1,0,1,0,0,0,1,1,0,1,0,1,1,1,1,1,1],
        "                 \ [0,0,1,1,0,1,1,1,1,0,0,1,0,0,1,1,1,0,1,0,0,1,1,0,0,1,0,1,0,0,0,1],
        "                 \ [1,1,1,1,0,0,1,0,0,0,1,1,1,0,1,0,1,0,0,0,0,0,0,0,0,0,1,0,1],
        "                 \ [1,0,0,1,1,0,1,1,0,0,1,1,0,1,1,0,0,1,1,0,0,0,0,0,1,1,0,0,0,1,1],
        "                 \ [1,1,0,0,0,1,1,0,1,0,1,1,1,1,0,0,1,1,1,1,0,0,0,0,0,1,0,1,1,1,1,1],
        "                 \ [1,0,1,0,1,1,1,1,1,0,1,1,0,0,0,0,0,0,0,1,0,0,0,0,1,0,1,1,0,0,0,1],
        "                 \ [0,0,0,1,0,0,1,1,0,0,0,0,0,1,0,0,0,1,1,1,0,1,1,0,1,1,0,1,1,1],
        "                 \ [0,1,1,1,1,0,1,0,0,0,0,0,1,0,0,0,1,0,0,1,0,1,1,0,0,0,1,1,0,0,1],
        "                 \ [0,0,1,0,0,1,1,1,1,0,0,0,0,0,1,0,0,0,0,0,0,1,1,0,1,0,1,0,1,0,1,1],
        "                 \ [0,1,0,0,1,1,1,0,1,0,0,0,1,1,1,0,1,1,1,0,0,1,1,0,0,1,0,0,0,1,0,1],
        "                 \ [1,0,0,0,1,0,1,1,0,0,1,0,0,1,1,1,1,1,0,0,0,0,0,0,0,0,1,1,1,1],
        "                 \ [1,1,1,0,0,0,1,0,0,0,1,0,1,0,1,1,0,0,1,0,0,0,0,0,1,1,0,1,0,0,1],
        "                 \ [1,0,1,1,1,1,1,1,1,0,1,0,0,0,0,1,1,0,1,1,0,0,0,0,0,1,0,0,1,0,1,1],
        "                 \ [1,1,0,1,0,1,1,0,1,0,1,0,1,1,0,1,0,1,0,1,0,0,0,0,1,0,1,0,0,1,0,1],
        "                 \ [0,1,0,1,1,1,1,1,0,0,0,1,0,1,0,1,1,0,1,0,1,1,0,1,1,0,1,0,1,1],
        "                 \ [0,0,1,1,0,1,1,0,0,0,0,1,1,0,0,1,0,1,0,0,1,1,0,1,0,1,0,0,0,0,1],
        "                 \ [0,1,1,0,1,0,1,1,1,0,0,1,0,0,1,1,1,1,0,1,1,1,0,1,1,1,0,1,1,0,1,1],
        "                 \ [0,0,0,0,0,0,1,0,1,0,0,1,1,1,1,1,0,0,1,1,1,1,0,1,0,0,1,1,0,1,0,1],
        "                 \ [1,1,0,0,0,1,1,1,0,0,1,1,0,1,1,0,0,0,0,1,1,0,1,1,0,1,0,0,1,1],
        "                 \ [1,0,1,0,1,1,1,0,0,0,1,1,1,0,1,0,1,1,1,1,1,0,1,1,1,0,1,0,0,0,1],
        "                 \ [1,1,1,1,0,0,1,1,1,0,1,1,0,0,0,0,0,1,1,0,1,0,1,1,0,0,1,1,1,0,1,1],
        "                 \ [1,0,0,1,1,0,1,0,1,0,1,1,1,1,0,0,1,0,0,0,1,0,1,1,1,1,0,1,0,1,0,1],
        "                 \ [0,0,1,1,0,1,0,1,0,0,0,0,1,1,0,0,1,0,0,1,1,0,1,1,0,1,1,0,0,1],
        "                 \ [0,1,0,1,1,1,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,0,1,1,1,0,0,0,1,0,1],
        "                 \ [0,0,0,0,0,0,0,1,1,0,0,0,1,0,1,0,1,1,1,0,1,0,1,1,0,0,0,1,0,0,1,1],
        "                 \ [0,1,1,0,1,0,0,0,1,0,0,0,0,1,1,0,0,0,0,0,1,0,1,1,1,1,1,1,1,1,0,1],
        "                 \ [1,0,1,0,1,1,0,1,0,0,1,0,1,1,1,1,0,0,1,0,1,1,0,1,1,0,0,0,0,1],
        "                 \ [1,1,0,0,0,1,0,0,0,0,1,0,0,0,1,1,1,1,0,0,1,1,0,1,0,1,1,0,1,0,1],
        "                 \ [1,0,0,1,1,0,0,1,1,0,1,0,1,0,0,1,0,1,0,1,1,1,0,1,1,1,1,1,0,0,1,1],
        "                 \ [1,1,1,1,0,0,0,0,1,0,1,0,0,1,0,1,1,0,1,1,1,1,0,1,0,0,0,1,1,1,0,1],
        "                 \ [0,1,1,1,1,0,0,1,0,0,0,1,1,1,0,1,0,1,0,0,0,0,0,0,0,0,0,1,0,1],
        "                 \ [0,0,0,1,0,0,0,0,0,0,0,1,0,0,0,1,1,0,1,0,0,0,0,0,1,1,1,1,1,0,1],
        "                 \ [0,1,0,0,1,1,0,1,1,0,0,1,1,0,1,1,0,0,1,1,0,0,0,0,0,1,1,0,0,0,1,1],
        "                 \ [0,0,1,0,0,1,0,0,1,0,0,1,0,1,1,1,1,1,0,1,0,0,0,0,1,0,0,0,1,1,0,1],
        "                 \ [1,1,1,0,0,0,0,1,0,0,1,1,1,1,1,0,1,1,1,1,0,1,1,0,1,1,1,1,0,1],
        "                 \ [1,0,0,0,1,0,0,0,0,0,1,1,0,0,1,0,0,0,0,1,0,1,1,0,0,0,0,1,1,0,1],
        "                 \ [1,1,0,1,0,1,0,1,1,0,1,1,1,0,0,0,1,0,0,0,0,1,1,0,1,0,0,0,0,0,1,1],
        "                 \ [1,0,1,1,1,1,0,0,1,0,1,1,0,1,0,0,0,1,1,0,0,1,1,0,0,1,1,0,1,1,0,1],
        "                 \ [0,0,0,0,1,0,0,1,1,0,0,0,0,0,1,0,0,0,1,1,1,0,1,1,0,1,1,0,1,1,1],
        "                 \ [0,1,1,0,0,0,0,0,1,0,0,0,1,1,1,0,1,1,0,1,1,0,1,1,1],
        "                 \ [0,0,1,1,1,1,0,1,0,0,0,0,0,1,0,0,0,1,0,0,1,0,1,1,0,0,0,1,1,0,0,1],
        "                 \ [0,1,0,1,0,1,0,0,0,0,0,0,1,0,0,0,1,0,1,0,1,0,1,1,1,1,1,1,0,1,1,1],
        "                 \ [1,0,0,1,0,0,0,1,1,0,1,0,0,0,0,1,1,0,0,0,1,1,0,1,1,0,0,0,1,1,1],
        "                 \ [1,1,1,1,1,0,0,0,1,0,1,0,1,1,0,1,0,1,1,0,1,1,0,1,0,1,1],
        "                 \ [1,0,1,0,0,1,0,1,0,0,1,0,0,1,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,0,0,1],
        "                 \ [1,1,0,0,1,1,0,0,0,0,1,0,1,0,1,1,0,0,0,1,1,1,0,1,0,0,0,1,0,1,1,1],
        "                 \ [0,1,0,0,0,1,0,1,1,0,0,1,0,0,1,1,1,1,1,0,0,0,0,0,0,0,0,1,1,1,1],
        "                 \ [0,0,1,0,1,1,0,0,1,0,0,1,1,1,1,1,0,0,0,0,0,0,0,0,1,1,1,1],
        "                 \ [0,1,1,1,0,0,0,1,0,0,0,1,0,1,0,1,1,0,0,1,0,0,0,0,0,1,1,0,1,0,0,1],
        "                 \ [0,0,0,1,1,0,0,0,0,0,0,1,1,0,0,1,0,1,1,1,0,0,0,0,1,0,0,0,0,1,1,1],
        "                 \ [1,1,0,1,1,1,0,1,1,0,1,1,0,0,0,0,0,1,0,1,0,1,1,0,1,1,1,1,1,1,1],
        "                 \ [1,0,1,1,0,1,0,0,1,0,1,1,1,1,0,0,1,0,1,1,0,1,1,0,0,0,0,1],
        "                 \ [1,1,1,0,1,0,0,1,0,0,1,1,0,1,1,0,0,0,1,0,0,1,1,0,1,0,0,0,1,0,0,1],
        "                 \ [1,0,0,0,0,0,0,0,0,0,1,1,1,0,1,0,1,1,0,0,0,1,1,0,0,1,1,0,0,1,1,1],
        "                 \ [0,0,1,0,1,1,1,1,1,0,0,0,1,0,1,0,1,1,0,1,0,1,1,0,1,1,0,1,0,1,1],
        "                 \ [0,1,0,0,0,1,1,0,1,0,0,0,0,1,1,0,0,0,1,1,0,1,1,0,0,0,1,1,1],
        "                 \ [0,0,0,1,1,0,1,1,0,0,0,0,1,1,0,0,1,0,1,0,0,1,1,0,1,0,1,0,0,0,0,1],
        "                 \ [0,1,1,1,0,0,1,0,0,0,0,0,0,0,0,0,0,1,0,0,0,1,1,0,0,1,0,0,1,1,1,1],
        "                 \ [1,0,1,1,0,1,1,1,1,0,1,0,1,0,0,1,0,1,1,0,0,0,0,0,0,0,1,1,0,1,1],
        "                 \ [1,1,0,1,1,1,1,0,1,0,1,0,0,1,0,1,1,0,0,0,0,0,0,0,1,1,0,1,1],
        "                 \ [1,0,0,0,0,0,1,1,0,0,1,0,1,1,1,1,0,0,0,1,0,0,0,0,0,1,0,0,0,0,0,1],
        "                 \ [1,1,1,0,1,0,1,0,0,0,1,0,0,0,1,1,1,1,1,1,0,0,0,0,1,0,1,0,1,1,1,1],
        "                 \ [0,1,1,0,0,0,1,1,1,0,0,1,1,0,1,1,0,0,0,0,1,1,0,1,1,0,1,0,0,1,1],
        "                 \ [0,0,0,0,1,0,1,0,1,0,0,1,0,1,1,1,1,1,1,0,1,1,0,1,0,1,0,0,1],
        "                 \ [0,1,0,1,0,1,1,1,0,0,0,1,1,1,0,1,0,1,1,1,1,1,0,1,1,1,0,1,0,0,0,1],
        "                 \ [0,0,1,1,1,1,1,0,0,0,0,1,0,0,0,1,1,0,0,1,1,1,0,1,0,0,1,1,1,1,1,1],
        "                 \ [1,1,1,1,1,0,1,1,1,0,1,1,1,0,0,0,1,0,1,1,1,0,1,1,0,1,0,0,0,1,1],
        "                 \ [1,0,0,1,0,0,1,0,1,0,1,1,0,1,0,0,0,1,0,1,1,0,1,1,1,0,1,0,1],
        "                 \ [1,1,0,0,1,1,1,1,0,0,1,1,1,1,1,0,1,1,0,0,1,0,1,1,0,0,1,1,0,0,0,1],
        "                 \ [1,0,1,0,0,1,1,0,0,0,1,1,0,0,1,0,0,0,1,0,1,0,1,1,1,1,0,1,1,1,1,1],
        "                 \ [0,0,0,1,1,0,1,0,1,0,0,0,0,1,1,0,0,1,0,0,1,1,0,1,1,0,1,1,0,0,1],
        "                 \ [0,1,1,1,0,0,1,1,1,0,0,0,1,0,1,0,1,0,1,0,1,1,0,1,0,1,0,1,1,1],
        "                 \ [0,0,1,0,1,1,1,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,0,1,1,1,0,0,0,1,0,1],
        "                 \ [0,1,0,0,0,1,1,1,0,0,0,0,1,1,0,0,1,1,0,1,1,1,0,1,0,0,1,0,1,0,1,1],
        "                 \ [1,0,0,0,0,0,1,0,1,0,1,0,0,1,0,1,1,1,1,1,1,0,1,1,0,1,0,1,0,0,1],
        "                 \ [1,1,1,0,1,0,1,1,1,0,1,0,1,0,0,1,0,0,0,1,1,0,1,1,1,0,1,1,1,1],
        "                 \ [1,0,1,1,0,1,1,0,0,0,1,0,0,0,1,1,1,0,0,0,1,0,1,1,0,0,1,0,0,1,0,1],
        "                 \ [1,1,0,1,1,1,1,1,0,0,1,0,1,1,1,1,0,1,1,0,1,0,1,1,1,1,0,0,1,0,1,1],
        "                 \ [0,1,0,1,0,1,1,0,1,0,0,1,0,1,1,1,1,0,0,1,0,1,1,0,1,1,0,0,0,0,1],
        "                 \ [0,0,1,1,1,1,1,1,1,0,0,1,1,0,1,1,0,1,1,1,0,1,1,0,0,0,1,0,1,1],
        "                 \ [0,1,1,0,0,0,1,0,0,0,0,1,0,0,0,1,1,1,1,0,0,1,1,0,1,0,1,1,0,1,0,1],
        "                 \ [0,0,0,0,1,0,1,1,0,0,0,1,1,1,0,1,0,0,0,0,0,1,1,0,0,1,0,1,1,0,1,1],
        "                 \ [1,1,0,0,1,1,1,0,1,0,1,1,0,1,0,0,0,0,1,0,0,0,0,0,0,0,1,0,0,0,1],
        "                 \ [1,0,1,0,0,1,1,1,1,0,1,1,1,0,0,0,1,1,0,0,0,0,0,0,1,1,0,0,1,1],
        "                 \ [1,1,1,1,1,0,1,0,0,0,1,1,0,0,1,0,0,1,0,1,0,0,0,0,0,1,0,1,0,1,0,1],
        "                 \ [1,0,0,1,0,0,1,1,0,0,1,1,1,1,1,0,1,0,1,1,0,0,0,0,1,0,1,1,1,0,1,1],
        "                 \ [0,0,1,1,1,1,0,0,1,0,0,0,1,1,1,0,1,0,1,0,0,0,0,0,0,0,0,0,1,0,1],
        "                 \ [0,1,0,1,0,1,0,1,1,0,0,0,0,0,1,0,0,1,0,0,0,0,0,0,1,1,1,0,0,1],
        "                 \ [0,0,0,0,1,0,0,0,0,0,0,0,1,0,0,0,1,1,0,1,0,0,0,0,0,1,1,1,1,1,0,1],
        "                 \ [0,1,1,0,0,0,0,1,0,0,0,0,0,1,0,0,0,0,1,1,0,0,0,0,1,0,0,1,0,0,1,1],
        "                 \ [1,0,1,0,0,1,0,0,1,0,1,0,1,1,0,1,0,0,0,1,0,1,1,0,1,1,1,0,1,0,1],
        "                 \ [1,1,0,0,1,1,0,1,1,0,1,0,0,0,0,1,1,1,1,1,0,1,1,0,0,0,0,0,0,1],
        "                 \ [1,0,0,1,0,0,0,0,0,0,1,0,1,0,1,1,0,1,1,0,0,1,1,0,1,0,0,1,1,1,0,1],
        "                 \ [1,1,1,1,1,0,0,1,0,0,1,0,0,1,1,1,1,0,0,0,0,1,1,0,0,1,1,1,0,0,1,1],
        "                 \ [0,1,1,1,0,0,0,0,1,0,0,1,1,1,1,1,0,1,1,1,1,0,1,1,0,1,1,1,1,0,1],
        "                 \ [0,0,0,1,1,0,0,1,1,0,0,1,0,0,1,1,1,0,0,1,1,0,1,1,1,0,0,1,0,1],
        "                 \ [0,1,0,0,0,1,0,0,0,0,0,1,1,0,0,1,0,0,0,0,1,0,1,1,0,0,0,0,1,1,0,1],
        "                 \ [0,0,1,0,1,1,0,1,0,0,0,1,0,1,0,1,1,1,1,0,1,0,1,1,1,1,1,0,0,0,1,1],
        "                 \ [1,1,1,0,1,0,0,0,1,0,1,1,1,1,0,0,1,1,0,0,1,1,0,1,1,0,0,1,1,0,1],
        "                 \ [1,0,0,0,0,0,0,1,1,0,1,1,0,0,0,0,0,0,1,0,1,1,0,1,0,1,1,1,0,1],
        "                 \ [1,1,0,1,1,1,0,0,0,0,1,1,1,0,1,0,1,0,1,1,1,1,0,1,1,1,1,0,1,1,0,1],
        "                 \ [1,0,1,1,0,1,0,1,0,0,1,1,0,1,1,0,0,1,0,1,1,1,0,1,0,0,0,0,0,0,1,1],
        "                 \ [0,0,0,0,0,1,0,0,1,1,0,0,0,0,0,1,0,0,0,1,1,1,0,1,1,0,1,1,0,1,1,1],
        "                 \ [0,1,1,0,1,1,0,1,1,1,0,0,1,1,0,1,1,1,1,1,1,1,0,1,0,1,0,1,1,0,0,1],
        "                 \ [0,0,1,1,0,0,0,0,0,1,0,0,0,1,1,1,0,1,1,0,1,1,0,1,1,1],
        "                 \ [0,1,0,1,1,0,0,1,0,1,0,0,1,0,1,1,1,0,0,0,1,1,0,1,0,0,1,0,1,1,1],
        "                 \ [1,0,0,1,1,1,0,0,1,1,1,0,0,0,1,0,1,0,1,0,1,0,1,1,0,1,0,1,0,1,1,1],
        "                 \ [1,1,1,1,0,1,0,1,1,1,1,0,1,1,1,0,0,1,0,0,1,0,1,1,1,0,1,1,1,0,0,1],
        "                 \ [1,0,1,0,1,0,0,0,0,1,1,0,0,1,0,0,1,1,0,1,1,0,1,1,0,0,1],
        "                 \ [1,1,0,0,0,0,0,1,0,1,1,0,1,0,0,0,0,0,1,1,1,0,1,1,1,1,0,0,1,1,1],
        "                 \ [0,1,0,0,1,0,0,0,1,1,0,1,0,0,0,0,1,1,0,0,0,1,1,0,1,1,0,0,0,1,1,1],
        "                 \ [0,0,1,0,0,0,0,1,1,1,0,1,1,1,0,0,0,0,1,0,0,1,1,0,0,0,1,0,1,0,0,1],
        "                 \ [0,1,1,1,1,1,0,0,0,1,0,1,0,1,1,0,1,0,1,1,0,1,1,0,1,0,1,1],
        "                 \ [0,0,0,1,0,1,0,1,0,1,0,1,1,0,1,0,0,1,0,1,0,1,1,0,0,1,0,1,1,1,1],
        "                 \ [1,1,0,1,0,0,0,0,1,1,1,1,0,0,1,1,0,1,1,1,0,0,0,0,0,0,1,0,0,1,1,1],
        "                 \ [1,0,1,1,1,0,0,1,1,1,1,1,1,1,1,1,1,0,0,1,0,0,0,0,1,1,0,0,1,0,0,1],
        "                 \ [1,1,1,0,0,1,0,0,0,1,1,1,0,1,0,1,0,0,0,0,0,0,0,0,0,1,0,1],
        "                 \ [1,0,0,0,1,1,0,1,0,1,1,1,1,0,0,1,1,1,1,0,0,0,0,0,1,0,1,1,1,1,1],
        "                 \ [0,0,1,0,0,0,1,0,1,1,0,0,1,0,0,1,1,1,1,1,0,0,0,0,0,0,0,0,1,1,1,1],
        "                 \ [0,1,0,0,1,0,1,1,1,1,0,0,0,1,0,1,0,0,0,1,0,0,0,0,1,1,1,0,0,0,0,1],
        "                 \ [0,0,0,1,0,1,1,0,0,1,0,0,1,1,1,1,1,0,0,0,0,0,0,0,0,1,1,1,1],
        "                 \ [0,1,1,1,1,1,1,1,0,1,0,0,0,0,1,1,0,1,1,0,0,0,0,0,1,0,0,1,0,1,1],
        "                 \ [1,0,1,1,1,0,1,0,1,1,1,0,1,0,1,0,0,1,0,0,0,1,1,0,1,1,1,0,1,1,1,1],
        "                 \ [1,1,0,1,0,0,1,1,1,1,1,0,0,1,1,0,1,0,1,0,0,1,1,0,0,0,0,0,0,0,0,1],
        "                 \ [1,0,0,0,1,1,1,0,0,1,1,0,1,1,0,0,0,0,1,1,0,1,1,0,1,0,0,1,1],
        "                 \ [1,1,1,0,0,1,1,1,0,1,1,0,0,0,0,0,1,1,0,1,0,1,1,0,0,1,1,1,0,1,1],
        "                 \ [0,1,1,0,1,1,1,0,1,1,0,1,1,0,0,0,0,0,1,0,1,0,1,1,0,1,1,1,1,1,1,1],
        "                 \ [0,0,0,0,0,1,1,1,1,1,0,1,0,1,0,0,1,1,0,0,1,0,1,1,1,0,0,1,0,0,0,1],
        "                 \ [0,1,0,1,1,0,1,0,0,1,0,1,1,1,1,0,0,1,0,1,1,0,1,1,0,0,0,0,1],
        "                 \ [0,0,1,1,0,0,1,1,0,1,0,1,0,0,1,0,1,0,1,1,1,0,1,1,1,1,1,0,0,1,1],
        "                 \ [1,1,1,1,0,1,1,0,1,1,1,1,1,0,1,1,1,0,0,1,1,1,0,1,1,0,0,1,1,1,1,1],
        "                 \ [1,0,0,1,1,1,1,1,1,1,1,1,0,1,1,1,0,1,1,1,1,1,0,1,0,1,1,1,0,0,0,1],
        "                 \ [1,1,0,0,0,0,1,0,0,1,1,1,1,1,0,1,1,1,1,0,1,1,0,1,1,1,1,0,1],
        "                 \ [1,0,1,0,1,0,1,1,0,1,1,1,0,0,0,1,0,0,0,0,1,1,0,1,0,0,0,0,0,1,1],
        "                 \ [0,0,0,1,0,1,1,1,1,1,0,0,0,1,0,1,0,1,1,0,1,0,1,1,0,1,1,0,1,0,1,1],
        "                 \ [0,1,1,1,1,1,1,0,1,1,0,0,1,0,0,1,1,0,0,0,1,0,1,1,1,0,0,0,0,1,0,1],
        "                 \ [0,0,1,0,0,0,1,1,0,1,0,0,0,0,1,1,0,0,0,1,1,0,1,1,0,0,0,1,1,1],
        "                 \ [0,1,0,0,1,0,1,0,0,1,0,0,1,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,0,0,1],
        "                 \ [1,0,0,0,1,1,1,1,1,1,1,0,0,1,1,0,1,1,0,1,1,1,0,1,1,0,0,0,1,0,1,1],
        "                 \ [1,1,1,0,0,1,1,0,1,1,1,0,1,0,1,0,0,0,1,1,1,1,0,1,0,1,1,0,0,1,0,1],
        "                 \ [1,0,1,1,1,0,1,1,0,1,1,0,0,0,0,0,1,0,1,0,1,1,0,1,1,1,1,1,1,1],
        "                 \ [1,1,0,1,0,0,1,0,0,1,1,0,1,1,0,0,0,1,0,0,1,1,0,1,0,0,0,1,0,0,1],
        "                 \ [0,1,0,1,1,0,1,1,1,1,0,1,0,1,0,0,1,0,1,1,0,0,0,0,0,0,0,1,1,0,1,1],
        "                 \ [0,0,1,1,0,0,1,0,1,1,0,1,1,0,0,0,0,1,0,1,0,0,0,0,1,1,1,1,0,1,0,1],
        "                 \ [0,1,1,0,1,1,1,1,0,1,0,1,0,0,1,0,1,1,0,0,0,0,0,0,0,1,1,0,1,1],
        "                 \ [0,0,0,0,0,1,1,0,0,1,0,1,1,1,1,0,0,0,1,0,0,0,0,0,1,0,0,0,0,0,1],
        "                 \ [1,1,0,0,0,0,1,1,1,1,1,1,0,1,1,1,0,0,0,0,0,1,1,0,1,1,1,1,1,0,1,1],
        "                 \ [1,0,1,0,1,0,1,0,1,1,1,1,1,0,1,1,1,1,1,0,0,1,1,0,0,0,0,1,0,1,0,1],
        "                 \ [1,1,1,1,0,1,1,1,0,1,1,1,0,0,0,1,0,1,1,1,0,1,1,0,1,0,0,0,1,1],
        "                 \ [1,0,0,1,1,1,1,0,0,1,1,1,1,1,0,1,1,0,0,1,0,1,1,0,0,1,1,0,0,0,1],
        "                 \ [0,0,1,1,0,0,0,1,1,1,0,0,1,1,0,1,1,0,0,0,0,1,1,0,1,1,0,1,0,0,1,1],
        "                 \ [0,1,0,1,1,0,0,0,1,1,0,0,0,0,0,1,0,1,1,0,0,1,1,0,0,0,1,1,1,1,0,1],
        "                 \ [0,0,0,0,0,1,0,1,0,1,0,0,1,0,1,1,1,1,1,1,0,1,1,0,1,0,1,0,0,1],
        "                 \ [0,1,1,0,1,1,0,0,0,1,0,0,0,1,1,1,0,0,0,1,0,1,1,0,0,1,0,0,1,0,1],
        "                 \ [1,0,1,0,1,0,0,1,1,1,1,0,1,1,1,0,0,0,1,1,0,0,0,0,0,0,1,1,0,0,1,1],
        "                 \ [1,1,0,0,0,0,0,0,1,1,1,0,0,0,1,0,1,1,0,1,0,0,0,0,1,1,0,1,1,1,0,1],
        "                 \ [1,0,0,1,1,1,0,1,0,1,1,0,1,0,0,0,0,1,0,0,0,0,0,0,0,1,0,0,0,1],
        "                 \ [1,1,1,1,0,1,0,0,0,1,1,0,0,1,0,0,1,0,1,0,0,0,0,0,1,0,1,0,1,0,1],
        "                 \ [0,1,1,1,1,1,0,1,1,1,0,1,1,1,0,0,0,1,0,1,1,1,0,1,1,0,1,0,0,0,1,1],
        "                 \ [0,0,0,1,0,1,0,0,1,1,0,1,0,0,0,0,1,0,1,1,1,1,0,1,0,1,0,0,1,1,0,1],
        "                 \ [0,1,0,0,1,0,0,1,0,1,0,1,1,0,1,0,0,0,1,0,1,1,0,1,1,1,0,1,0,1],
        "                 \ [0,0,1,0,0,0,0,0,0,1,0,1,0,1,1,0,1,1,0,0,1,1,0,1,0,0,1,1,1,0,1],
        "                 \ [1,1,1,0,0,1,0,1,1,1,1,1,1,1,1,1,1,1,1,0,1,0,1,1,0,1,0,0,0,0,1,1],
        "                 \ [1,0,0,0,1,1,0,0,1,1,1,1,0,0,1,1,0,0,0,0,1,0,1,1,1,0,1,0,1,1,0,1],
        "                 \ [1,1,0,1,0,0,0,1,0,1,1,1,1,0,0,1,1,0,0,1,1,0,1,1,0,0,1,1,0,1],
        "                 \ [1,0,1,1,1,0,0,0,0,1,1,1,0,1,0,1,0,1,1,1,1,0,1,1,1,1,0,1,1,0,1],
        "                 \ [0,0,0,0,1,1,0,1,0,1,0,0,0,0,1,1,0,0,1,0,0,1,1,0,1,1,0,1,1,0,0,1],
        "                 \ [0,1,1,0,0,1,0,0,0,1,0,0,1,1,1,1,1,1,0,0,0,1,1,0,0,0,1,1,0,1,1,1],
        "                 \ [0,0,1,1,1,0,0,1,1,1,0,0,0,1,0,1,0,1,0,1,0,1,1,0,1,0,1,0,1,1,1],
        "                 \ [0,1,0,1,0,0,0,0,1,1,0,0,1,0,0,1,1,0,1,1,0,1,1,0,0,1],
        "                 \ [1,0,0,1,0,1,0,1,0,1,1,0,0,0,0,0,1,0,0,1,0,0,0,0,0,0,1,1,1,0,0,1],
        "                 \ [1,1,1,1,1,1,0,0,0,1,1,0,1,1,0,0,0,1,1,1,0,0,0,0,1,1,0,1,0,1,1,1],
        "                 \ [1,0,1,0,0,0,0,1,1,1,1,0,0,1,1,0,1,1,1,0,0,0,0,0,0,1,0,0,1,1,1],
        "                 \ [1,1,0,0,1,0,0,0,1,1,1,0,1,0,1,0,0,0,0,0,0,0,0,0,1,0,1],
        "                 \ [0,1,0,0,0,0,0,1,0,1,0,1,0,0,1,0,1,1,1,1,1,1,0,1,1,0,1,0,1,0,0,1],
        "                 \ [0,0,1,0,1,0,0,0,0,1,0,1,1,1,1,0,0,0,0,1,1,1,0,1,0,1,0,0,0,1,1,1],
        "                 \ [0,1,1,1,0,1,0,1,1,1,0,1,0,1,0,0,1,0,0,0,1,1,0,1,1,1,0,1,1,1,1],
        "                 \ [0,0,0,1,1,1,0,0,1,1,0,1,1,0,0,0,0,1,1,0,1,1,0,1,0,0,1,1],
        "                 \ [1,1,0,1,1,0,0,1,0,1,1,1,0,0,0,1,0,1,0,0,1,0,1,1,0,1,0,0,1,0,0,1],
        "                 \ [1,0,1,1,0,0,0,0,0,1,1,1,1,1,0,1,1,0,1,0,1,0,1,1,1,0,1,0,0,1,1,1],
        "                 \ [1,1,1,0,1,1,0,1,1,1,1,1,0,1,1,1,0,0,1,1,1,0,1,1,0,0,1,1,1,1,1],
        "                 \ [1,0,0,0,0,1,0,0,1,1,1,1,1,0,1,1,1,1,0,1,1,0,1,1,1,1,0,1],
        "                 \ [0,0,1,0,1,0,1,1,0,1,0,0,1,0,1,1,1,1,0,0,1,0,1,1,0,1,1,0,0,0,0,1],
        "                 \ [0,1,0,0,0,0,1,0,0,1,0,0,0,1,1,1,0,0,1,0,1,0,1,1,1,0,0,0,1,1,1,1],
        "                 \ [0,0,0,1,1,1,1,1,1,1,0,0,1,1,0,1,1,0,1,1,1,0,1,1,0,0,0,1,0,1,1],
        "                 \ [0,1,1,1,0,1,1,0,1,1,0,0,0,0,0,1,0,1,0,1,1,0,1,1,1,1,1,1,1],
        "                 \ [1,0,1,1,0,0,1,1,0,1,1,0,1,0,0,0,0,1,1,1,1,1,0,1,1,0,0,0,0,0,0,1],
        "                 \ [1,1,0,1,1,0,1,0,0,1,1,0,0,1,0,0,1,0,0,1,1,1,0,1,0,1,1,0,1,1,1,1],
        "                 \ [1,0,0,0,0,1,1,1,1,1,1,0,1,1,1,0,0,0,0,0,1,1,0,1,1,1,1,1,0,1,1],
        "                 \ [1,1,1,0,1,1,1,0,1,1,1,0,0,0,1,0,1,1,1,0,1,1,0,1,0,0,0,1,1],
        "                 \ [0,1,1,0,0,1,1,1,0,1,0,1,1,0,1,0,0,0,0,1,0,0,0,0,0,0,0,1,0,0,0,1],
        "                 \ [0,0,0,0,1,1,1,0,0,1,0,1,0,1,1,0,1,1,1,1,0,0,0,0,1,1,1,1,1,1,1,1],
        "                 \ [0,1,0,1,0,0,1,1,1,1,0,1,1,1,0,0,0,1,1,0,0,0,0,0,0,1,1,0,0,1,1],
        "                 \ [0,0,1,1,1,0,1,0,1,1,0,1,0,0,0,0,1,0,0,0,0,0,0,0,1,0,0,0,1],
        "                 \ [1,1,1,1,1,1,1,1,0,1,1,1,1,0,0,1,1,0,1,0,0,1,1,0,1,1,1,1,0,0,0,1],
        "                 \ [1,0,0,1,0,1,1,0,0,1,1,1,0,1,0,1,0,1,0,0,0,1,1,0,0,0,0,1,1,1,1,1],
        "                 \ [1,1,0,0,1,0,1,1,1,1,1,1,1,1,1,1,1,1,0,1,0,1,1,0,1,0,0,0,0,1,1],
        "                 \ [1,0,1,0,0,0,1,0,1,1,1,1,0,0,1,1,0,0,1,1,0,1,1,0,0,1,1,0,1],
        "                 \ [0,0,0,1,1,1,1,0,0,1,0,0,0,1,1,1,0,1,0,1,0,0,0,0,0,0,0,0,0,1,0,1],
        "                 \ [0,1,1,1,0,1,1,1,0,1,0,0,1,0,1,1,1,0,1,1,0,0,0,0,1,1,1,0,1,0,1,1],
        "                 \ [0,0,1,0,1,0,1,0,1,1,0,0,0,0,0,1,0,0,1,0,0,0,0,0,0,1,1,1,0,0,1],
        "                 \ [0,1,0,0,0,0,1,1,1,1,0,0,1,1,0,1,1,1,0,0,0,0,0,0,1,0,0,1,1,1],
        "                 \ [1,0,0,0,0,1,1,0,0,1,1,0,0,1,0,0,1,1,1,0,0,1,1,0,1,1,1,0,0,1,0,1],
        "                 \ [1,1,1,0,1,1,1,1,0,1,1,0,1,0,0,0,0,0,0,0,0,1,1,0,0,0,0,0,1,0,1,1],
        "                 \ [1,0,1,1,0,0,1,0,1,1,1,0,0,0,1,0,1,0,0,1,0,1,1,0,1,0,0,1,0,0,1],
        "                 \ [1,1,0,1,1,0,1,1,1,1,1,0,1,1,1,0,0,1,1,1,0,1,1,0,0,1,1,1,1,1],
        "                 \ [0,1,0,1,0,0,1,0,0,1,0,1,0,1,1,0,1,0,0,0,1,0,1,1,0,1,1,1,0,1,0,1],
        "                 \ [0,0,1,1,1,0,1,1,0,1,0,1,1,0,1,0,0,1,1,0,1,0,1,1,1,0,0,1,1,0,1,1],
        "                 \ [0,1,1,0,0,1,1,0,1,1,0,1,0,0,0,0,1,1,1,1,1,0,1,1,0,0,0,0,0,0,1],
        "                 \ [0,0,0,0,1,1,1,1,1,1,0,1,1,1,0,0,0,0,0,1,1,0,1,1,1,1,1,0,1,1],
        "                 \ [1,1,0,0,1,0,1,0,0,1,1,1,0,1,0,1,0,0,1,1,1,1,0,1,1,0,0,1,0,1,0,1],
        "                 \ [1,0,1,0,0,0,1,1,0,1,1,1,1,0,0,1,1,1,0,1,1,1,0,1,0,1,1,1,1,0,1,1],
        "                 \ [1,1,1,1,1,1,1,0,1,1,1,1,0,0,1,1,0,1,0,0,1,1,0,1,1,1,1,0,0,0,1],
        "                 \ [1,0,0,1,0,1,1,1,1,1,1,1,1,1,1,1,1,0,1,0,1,1,0,1,0,0,0,0,1,1],
        "                 \ [0,0,1,1,1,0,0,0,0,1,0,0,1,1,1,1,1,0,1,1,1,1,0,1,1,0,1,1,1,1,0,1],
        "                 \ [0,1,0,1,0,0,0,1,0,1,0,0,0,0,1,1,0,1,0,1,1,1,0,1,0,1,0,1,0,0,1,1],
        "                 \ [0,0,0,0,1,1,0,0,1,1,0,0,1,0,0,1,1,1,0,0,1,1,0,1,1,1,0,0,1,0,1],
        "                 \ [0,1,1,0,0,1,0,1,1,1,0,0,0,1,0,1,0,0,1,0,1,1,0,1,0,0,1,0,0,1],
        "                 \ [1,0,1,0,0,0,0,0,0,1,1,0,1,1,0,0,0,0,0,0,1,0,1,1,0,1,0,1,1,1,0,1],
        "                 \ [1,1,0,0,1,0,0,1,0,1,1,0,0,0,0,0,1,1,1,0,1,0,1,1,1,0,1,1,0,0,1,1],
        "                 \ [1,0,0,1,0,1,0,0,1,1,1,0,1,0,1,0,0,1,1,1,1,0,1,1,0,0,1,0,1,0,1],
        "                 \ [1,1,1,1,1,1,0,1,1,1,1,0,0,1,1,0,1,0,0,1,1,0,1,1,1,1,0,0,0,1],
        "                 \ [0,1,1,1,0,1,0,0,0,1,0,1,1,1,1,0,0,1,1,0,0,1,1,0,1,1,0,0,1,1,0,1],
        "                 \ [0,0,0,1,1,1,0,1,0,1,0,1,0,0,1,0,1,0,0,0,0,1,1,0,0,0,1,0,0,0,1,1],
        "                 \ [0,1,0,0,0,0,0,0,1,1,0,1,1,0,0,0,0,0,0,1,0,1,1,0,1,0,1,1,1,0,1],
        "                 \ [0,0,1,0,1,0,0,1,1,1,0,1,0,1,0,0,1,1,1,1,0,1,1,0,0,1,0,1,0,1],
        "                 \ [1,1,1,0,1,1,0,0,0,1,1,1,1,1,0,1,1,1,0,1,0,0,0,0,0,0,1,0,1,1,0,1],
        "                 \ [1,0,0,0,0,1,0,1,0,1,1,1,0,0,0,1,0,0,1,1,0,0,0,0,1,1,0,0,0,0,1,1],
        "                 \ [1,1,0,1,1,0,0,0,1,1,1,1,1,0,1,1,1,0,1,0,0,0,0,0,0,1,0,1,1,0,1],
        "                 \ [1,0,1,1,0,0,0,1,1,1,1,1,0,1,1,1,0,1,0,0,0,0,0,0,1,0,1,1,0,1]
        "                 \  ]      
        " endif
        " let crc = [0]
        " let x00FFFFFF = tlib#bitwise#Num2Bits(0x00FFFFFF)
        " for char in split(a:chars, '\zs')
        "     let byte = char2nr(char)
        "     let v0 = tlib#bitwise#ShiftRight(crc, 8)
        "     " TLogVAR byte, v0
        "     let v1 = tlib#bitwise#AND(v0, x00FFFFFF, 'bits')
        "     " TLogVAR v1
        "     let i1 = tlib#bitwise#XOR(crc, byte, 'bits')
        "     let i2 = tlib#bitwise#Bits2Num(tlib#bitwise#AND(i1, 0xff, 'bits'))
        "     " TLogVAR i1, i2
        "     let v2 = s:crc_table[i2]
        "     " TLogVAR v2
        "     let crc = tlib#bitwise#XOR(v1, v2, 'bits')
        "     " TLogVAR crc
        " endfor
        " " TLogVAR crc
        " let rv = tlib#bitwise#Bits2Num(crc, 16)
    endif
    return rv
endf


function! tlib#hash#Adler32(chars) "{{{3
    if !exists('*or')
        throw "TLIB: Vim version doesn't support bitwise or()"
    endif
    let mod_adler = 65521
    let a = 1
    let b = 0
    for index in range(len(a:chars))
        let c = char2nr(a:chars[index])
        let a = (a + c) % mod_adler
        let b = (b + a) % mod_adler
    endfor
    let checksum = or(b * float2nr(pow(2, 16)), a)
    return printf("%08X", checksum)
endf



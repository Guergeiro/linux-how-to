" Grep+Quickfix https://gist.github.com/romainl/56f0c28ef953ffc157f36cc495947ab3
function! <sid>Grep(...)
  return system(join([&grepprg] + [expandcmd(join(a:000, " "))], " "))
endfunction
command! -nargs=+ -complete=file_in_path -bar Grep  cgetexpr <sid>Grep(<f-args>)
command! -nargs=+ -complete=file_in_path -bar LGrep lgetexpr <sid>Grep(<f-args>)
cnoreabbrev <expr> grep  (getcmdtype() ==# ':' && getcmdline() ==# 'grep')  ? 'Grep'  : 'grep'
cnoreabbrev <expr> lgrep (getcmdtype() ==# ':' && getcmdline() ==# 'lgrep') ? 'LGrep' : 'lgrep'
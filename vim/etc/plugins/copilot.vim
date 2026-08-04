" copilot.vim は dein_lazy.toml で on_cmd = ['Copilot'] の遅延ロード。
" 下の :Copilot が走った時点で初めてプラグインとLSPサーバが起動する。
nnoremap <silent> <Leader>tj :call <SID>SetupCopilot()<CR>

function! s:SetupCopilot() abort
  let g:copilot_no_tab_map = v:true
  imap <silent><script><expr> <C-J> copilot#Accept("\<CR>")
  Copilot split
endfunction

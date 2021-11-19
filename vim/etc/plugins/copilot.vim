nnoremap <Leader>tj call s:SetupCopilot()

function! s:SetupCopilot() abort
  let g:copilot_no_tab_map = v:true
  imap <silent><script><expr> <C-J> copilot#Accept("\<CR>")
  Copilot split
endfunction

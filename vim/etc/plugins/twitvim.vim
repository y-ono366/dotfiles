:command St SwitchLoginTwitter
:command Tw PosttoTwitter
:command Tl FriendsTwitter
:command Trp RepliesTwitter
:command Ntl NextTwitter
:command Ptl PreviousTwitter
let g:twitvim_count = 30
set statusline+=%{twitvim#get_current_username()}

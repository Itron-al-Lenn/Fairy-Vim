--[[
    .....                         .                                                         .                        
 .H8888888x.  '`+                @88>                 ..                                   @88>                      
:888888888888x.  !               %8P      .u    .    @L                  ...     ..        %8P      ..    .     :    
8~    `"*88888888"       u        .     .d88B :@8c  9888i   .dL       :~""888h.:^"888:      .     .888: x888  x888.  
!      .  `f""""      us888u.   .@88u  ="8888f8888r `Y888k:*888.     8X   `8888X  8888>   .@88u  ~`8888~'888X`?888f` 
 ~:...-` :8L <)88: .@88 "8888" ''888E`   4888>'88"    888E  888I    X888n. 8888X  ?888>  ''888E`   X888  888X '888>  
    .   :888:>X88! 9888  9888    888E    4888> '      888E  888I    '88888 8888X   ?**h.   888E    X888  888X '888>  
 :~"88x 48888X ^`  9888  9888    888E    4888>        888E  888I      `*88 8888~ x88x.     888E    X888  888X '888>  
<  :888k'88888X    9888  9888    888E   .d888L .+     888E  888I     ..<"  88*`  88888X    888E    X888  888X '888>  
  d8888f '88888X   9888  9888    888&   ^"8888*"     x888N><888'        ..XC.    `*8888k   888&   "*88%""*88" '888!` 
 :8888!    ?8888>  "888*""888"   R888"     "Y"        "88"  888       :888888H.    `%88>   R888"    `~    "    `"`   
 X888!      8888~   ^Y"   ^Y'     ""                        88F      <  `"888888:    X"     ""                       
 '888       X88f                                           98"             %888888x.-`                               
  '%8:     .8*"                                          ./"                 ""**""                                  
     ^----~"`                                           ~`                                                           

]]

-- Set the leader keys
vim.g.mapleader = ' '
vim.g.maplocalleader = ','

-- [[ Setting options ]]
require 'options'

-- [[ Basic Keymaps ]]
require 'keymaps'

-- [[ Configure and install plugin manager ]]
require 'lazy-config'

-- [[ LSP Config ]]
require 'lsp'

-- [[ Snippets ]]
vim.g.tex_flavor = 'latex'

-- [[ Neovide ]]
if vim.g.neovide then
  require 'neovide'
end

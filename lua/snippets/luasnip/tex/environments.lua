local ls = require 'luasnip'
local s = ls.snippet
local autos = ls.extend_decorator.apply(s, { snippetType = 'autosnippet' })
local i = ls.insert_node
local f = ls.function_node
local fmta = require('luasnip.extras.fmt').fmta

local env = require 'util.tex_conditionals'
return {
  autos(
    { trig = 'mk', dscr = 'Inline math', condition = env.in_text },
    fmta(
      [[
      $ <> $ 
      ]],
      { i(1) }
    )
  ),
  autos(
    { trig = 'dm', dscr = 'Math block', condition = env.in_text },
    fmta(
      [[


      \[
      <>
      \]
      <>
      ]],
      { i(1), i(0) }
    )
  ),
}

local ls = require 'luasnip'
local s = ls.snippet
local autos = ls.extend_decorator.apply(s, { snippetType = 'autosnippet' })
local f = ls.function_node

local greek = {
  A = 'lpha',
  B = 'eta',
  G = 'amma',
  D = 'elta',
  E = 'psilon',
  Z = 'eta',
  H = 'eta',
  T = 'heta',
  I = 'ota',
  K = 'appa',
  L = 'ambda',
  M = 'u',
  N = 'u',
  X = 'i',
  P = 'i',
  R = 'ho',
  S = 'igma',
  U = 'psilon',
  C = 'hi',
  O = 'mega',
}

return {
  autos(
    {
      trig = [[@(\w)]],
      dscr = 'Greek letters',
      trigEngine = 'ecma',
    },
    f(function(_, snip)
      local captured = snip.captures[1]
      return '\\' .. captured .. greek[string.upper(captured)]
    end)
  ),
  autos(
    {
      trig = '(pi|Pi|tau|Tau|omicron|Omicron|phi|Phi|psi|Psi)',
      dscr = 'Greek letters without an snippet using @',
      trigEngine = 'ecma',
    },
    f(function(_, snip)
      return '\\' .. snip.captures[1]
    end)
  ),
}

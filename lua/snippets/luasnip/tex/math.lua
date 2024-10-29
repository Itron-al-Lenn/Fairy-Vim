local ls = require 'luasnip'
local s = ls.snippet
local autos = ls.extend_decorator.apply(s, { snippetType = 'autosnippet' })
local i = ls.insert_node
local f = ls.function_node
local fmta = require('luasnip.extras.fmt').fmta

local cap = function(index)
  return f(function(_, snip)
    return snip.captures[index]
  end)
end
local env = require 'util.tex_conditionals'
return {
  -- Fractions
  autos(
    {
      trig = 'ff',
      dscr = 'Fraction',
      condition = env.in_mathzone,
    },
    fmta(
      [[
      \frac{<>}{<>}
      ]],
      { i(1), i(2) }
    )
  ),
  autos({
    trig = [[\((.+)\)\/]],
    dscr = 'Fraction with a bracket',
    trigEngine = 'ecma',
    condition = env.in_mathzone,
  }, fmta([[\frac{<>}{<>}]], { cap(1), i(1) })),
  autos({
    trig = [[([\w\d])\/]],
    dscr = 'Fraction without bracket',
    trigEngine = 'ecma',
    condition = env.in_mathzone,
  }, fmta([[\frac{<>}{<>}]], { cap(1), i(1) })),

  -- Subscripts
  autos({
    trig = [[([\w+}])(\d+)\2]],
    dscr = 'Subscripts',
    trigEngine = 'ecma',
    condition = env.in_mathzone,
  }, fmta('<>_{<>}', { cap(1), cap(2) })),
}

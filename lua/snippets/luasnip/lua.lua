local ls = require 'luasnip'
local s = ls.snippet
local i = ls.insert_node
local fmta = require('luasnip.extras.fmt').fmta

return {
  s(
    {
      trig = 'snippet',
      dscr = 'LuaSnip Snippet',
    },
    fmta(
      [[
				s(
					{
						trig = '<>', dscr = '<>', condition = <>,
					},
					<>
				),
				]],
      {
        i(1, 'TRIGGER'),
        i(2, 'DESCRIPTION'),
        i(3, 'env.'),
        i(4),
      }
    )
  ),
  s(
    {
      trig = 'asnippet',
      dscr = 'LuaSnip Autosnippet. Requires: local autos = ls.extend_decorator.apply(s, { snippetType = "autosnippet" })',
    },
    fmta(
      [[
				autos(
					{
						trig = '<>', dscr = '<>', condition = <>,
					},
					<>
				),
				]],
      {
        i(1, 'TRIGGER'),
        i(2, 'DESCRIPTION'),
        i(3, 'env.'),
        i(4),
      }
    )
  ),
  s(
    {
      trig = 'regautos',
      dscr = 'Snippet with regex',
    },
    fmta(
      [[
        autos(
        {
          trig = '<>', dscr = '<>', trigEngine = 'ecma' condition = <>,
        },
        <>
        )
        ]],
      { i(1, 'TRIGGER'), i(2, 'DESCRIPTION'), i(3, 'env.'), i(4) }
    )
  ),
  s(
    {
      trig = 'fmt',
      dscr = 'Formated node',
    },
    fmta(
      [[
      fmta(
      <>
      { <> }
      )
      ]],
      { i(1), i(2) }
    )
  ),
}

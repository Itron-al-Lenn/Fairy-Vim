
local snippets = {}

local autosnippets = {
	s(
		{trig = "//", priority = 0 },
		fmta("\\frac{<>}{<>}", { i(1), i(2) })
	),

	s(
		{
			trig = "(%w+)/",
			trigEngine = "pattern",
			priority = 1,
		},
		fmta(
			"\\frac{<>}{<>}",
			{
				f(function (_, snip) return snip.captures[1] end),
				i(1),
			}
		)
	),

	s(
		{
			trig = "%((.+)%)//",
			trigEngine = "pattern",
			priority = 2,
		},
		fmta(
			"\\frac{<>}{<>}",
			{
				f(function (_, snip) return snip.captures[1] end),
				i(1),
			}
		)
	),
}

return snippets, autosnippets

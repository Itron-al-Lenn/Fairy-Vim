local cond = require("snippets.luasnip.latex.util.conditions")
local M = {}

M.snippets = {}
M.autosnippets = {
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

for _, s in ipairs(M.snippets) do
	s[1].condition = cond.in_mathzone
end

for _, s in ipairs(M.autosnippets) do
	s[1].condition = cond.in_mathzone
end

return M

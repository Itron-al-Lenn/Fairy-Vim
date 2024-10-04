local tail = ";"


return {
} , {
	s(
		{ trig = "beg" .. tail, dscr = "begin/end" },
		fmta(
			[[
			\begin{<>}
			<>
			\end{<>}
			]],
			{
				i(1),
				i(2),
				f(function(args, _, _) return args[1][1]  end, {1})
			}
		)
	),

	-- Math mode
	s(
		{ trig = "mk", dscr = "inline_math" },
		fmta( "$<>$", i(1))
	),

	s(
		{ trig = "dm", dscr = "display_math" },
		fmta(
			[[
			$$
			<>
			$$
			]],
			i(1)
		)
	),

	-- Super/Sub-scripts
	s(
		{ trig = "(%a)(%d)", trigEngine = "pattern", priority = 0 },
		f(function(_, snip) return string.format("%s_{%s}", snip.captures[1], snip.captures[2]) end)
	),

	s(
		{ trig = "td" .. tail, condition = in_mathzone },
		fmta("_{<>}", i(1))
	),

	s(
		"sb" .. tail,
		fmta("_{<>}", i(1))
	),


	-- Characters

	s("EE", t("\\mathbb{E}")),
	s("CC", t("\\mathbb{C}")),
	s("NN", t("\\mathbb{N}")),
	s("RR", t("\\mathbb{R}")),
	s("ZZ", t("\\mathbb{Z}")),

	s(";a", t("\\alpha")),
	s(";b", t("\\beta")),
	s(";g", t("\\gamma")),
	s(";t", t("\\tau")),

	s("~~", t("\\sim")),


	-- Logic and Sets
	s(
		"fa" .. tail,
		t("\\forall")
	),

	s(
		"n" .. tail,
		t("\\in")
	),

	s(
		"nn" .. tail,
		t("\\notin")
	),
}

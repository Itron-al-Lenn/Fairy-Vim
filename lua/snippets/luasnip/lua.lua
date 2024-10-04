return {
	s(
		{ -- Table 1: snippet parameters
			trig = "snippet",
			snippetType = "snippet",
		},
		fmta(
			[[
				s(
					{
						trig = "<1>",
						dscr = "<2>",
						snippetType = "<3>",
					},
					<4>
				),
				]],
			{
				i(1, "TRIGGER"),
				i(2, "DESCRIPTION"),
				i(3, "snippet"),
				i(4),
			}
		)
	),
}

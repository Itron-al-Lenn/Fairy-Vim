return {
	postfix(".br", {
		f(function(_, parent)
			return "[" .. parent.snippet.env.POSTFIX_MATCH .. "]"
		end, {}),
	}),

	postfix(".fr", {
		f(function(_, parent)
			return "\frac{" .. parent.snippet.env.POSTFIX_MATCH .. "}{$1}"
		end, {}),
	}),
}

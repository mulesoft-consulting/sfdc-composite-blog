%dw 2.0
output application/json 
---

{
	results: payload.results,
	success: if(vars.errorDescription != null) false else true,
	(if (vars.errorDescription != null)
		{
			"error": vars.errorDescription
		} else {}
	)
}
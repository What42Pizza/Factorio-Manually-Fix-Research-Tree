--[[
	
	If you need to fix the research tree by changing the prerequisites or
	science packs of a research, you can easily do so here. If something else
	needs to be changed, you can add an issue on GitHub and I'll probably add
	the ability to change it (assuming I notice the issue, you might have to
	reach out to me).
	
	NOTE: research is internally reffered to as 'technologies'
	NOTE: the entire game has to be reloaded for changes to take effect
	
	To override a technology, copy-paste the example code and replace all the
	technology and science names with whatever you want. All fields have to
	be filled out or it will be assumed to be an empty list and it give a
	warning.
	
--]]

fixes = {
	{
		name = "example-technology", -- the mod knows to ignore changes make to 'example-technology'
		prerequisites = {
			"example-technology-pre-1",
			"example-technology-pre-2",
			-- etc
		},
		sciences = {
			{"example-science-pack-1", 1},
			{"example-science-pack-2", 1},
			-- etc
		}
	},
	-- etc
}

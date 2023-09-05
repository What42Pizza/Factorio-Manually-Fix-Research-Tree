require("utils")



require("research fixes")



if printData then
	log("======== ALL TECHNOLOGY NAMES ========")
	for _,tech in pairs(data.raw.technology) do
		log(tech.name)
	end
	log("======== ALL SCIENCE (and tool) NAMES ========")
	for _,tool in pairs(data.raw.tool) do
		log(tool.name)
	end
	log("======== END OF DATA ========")
end



for _,fix in ipairs(fixes) do
	if fix.name == "example-technology" then goto continue end
	
	
	-- fix input
	
	local tech = data.raw.technology[fix.name]
	if not tech then
		warn("research fix failed: technology \"" .. fix.name .. "\" does not exist")
		goto continue
	end
	
	if not fix.prerequisites then
		fix.prerequisites = {}
		warn("fix for \"" .. fix.name .. "\" has no prerequisites")
	end
	if not fix.sciences then
		fix.sciences = {}
		warn("fix for \"" .. fix.name .. "\" has no sciences")
	end
	
	removeItemsFromTable(fix.prerequisites, function(prereqName)
		local isMissing = type(data.raw.technology[prereqName]) == "nil"
		if isMissing then
			warn("fix for \"" .. fix.name .. "\" has an invalid technology: \"" .. prereqName .. "\"")
		end
		return isMissing
	end)
	removeItemsFromTable(fix.sciences, function(science)
		if type(science) ~= "table" then
			warn("fix for \"" .. fix.name .. "\" has an invalid science: it must be table with the science name and amount")
			return true
		end
		local scienceName = science[1]
		if type(data.raw.tool[scienceName]) == "nil" then
			warn("fix for \"" .. fix.name .. "\" has an invalid science: \"" .. scienceName .. "\"")
			return true
		end
		return false -- means don't remove
	end)
	
	
	-- apply fix
	
	tech.prerequisites = fix.prerequisites
	if tech.normal then tech.normal.prerequisites = fix.prerequisites end
	if tech.expensive then tech.expensive.prerequisites = fix.prerequisites end
	
	tech.unit.ingredients = fix.sciences
	if tech.normal then tech.normal.unit.ingredients = fix.sciences end
	if tech.expensive then tech.expensive.unit.ingredients = fix.sciences end
	
	log("Applied fix for \"" .. fix.name .. "\"")
	
	
	::continue::
end

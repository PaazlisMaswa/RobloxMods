local Tabler={}

function Tabler.GetProperties(t):()->(any,any,number)
	local i=0
	local function NextProperty() i=i+1 if t[i] then return t[i],t[t[i]],i end end
	return NextProperty
end

return Tabler

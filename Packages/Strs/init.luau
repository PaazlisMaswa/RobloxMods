local Strs={}

local function InvalidArgumentNumber(v,i,s)
	assert(type(v)=="number",`Invalid argument #{i} (number expected, got {typeof(v)}) to Strs.{s}`)
end

local function InvalidArgumentString(v,i,s)
	assert(type(v)=="string",`Invalid argument #{i} (string expected, got {typeof(v)}) to Strs.{s}`)
end

local function InvalidArgumentTable(v,i,s)
	assert(type(v)=="table",`Invalid argument #{i} (table expected, got {typeof(v)}) to Strs.{s}`)
end

function Strs.TryNumber(s,defautValue,originalValue)
	if type(s)=="string" or type(s)=="number" then
		if tonumber(s) then return tonumber(s) end
		local ls=string.lower(s)
		if ls=="reset" or ls=="default" or ls=="original" or ls=="origin" then return tonumber(originalValue) or tonumber(defautValue) end
		if ls=="inf" or ls=="huge" or "infinite" then return math.huge end
		if ls=="-inf" or ls=="-huge" or "-infinite" then return -math.huge end
		return tonumber(defautValue)
	end
	return nil
end

function Strs.IsOriginal(s)
	s=string.lower(tostring(s)) 
	for i,v in ipairs({"reset","default","original","origin"}) do if string.find(s,v) then return true end end
	return false
end

function Strs.GetLines(s):()
	InvalidArgumentString(s,1,"GetLines")
	local lastBreak=0
	local function NextLine()
		if lastBreak==#s then return nil end
		local line,nextBreak=nil,string.find(s,"\n",lastBreak+1)		
		if nextBreak then
			line=s:sub(lastBreak+1,nextBreak-1)
			lastBreak=nextBreak
		else
			line=s:sub(lastBreak+1,#s)
			lastBreak=#s
		end
		return line
	end
	return NextLine
end

function Strs.IsEmpty(s)
	if type(s)=="string" then
		if string.len(s)==0 then return true end
		local v=string.match(s,"^%s*$")
		if v==nil then return false end
		return true
	end
	return true
end

function Strs.IsStrings(s1,s2)
	InvalidArgumentString(s1,1,"IsStrings")
	InvalidArgumentTable(s2,2,"IsStrings")
	for i,v in ipairs(s2) do if s1==v then return true end end return false
end

function Strs.ToNumberString(v,maxFloat)
	local x=type(v)=="string" and tonumber(v) or v
	InvalidArgumentNumber(x,1,"ToNumberString")
	maxFloat=if type(maxFloat)=="number" and maxFloat>0 then maxFloat else 3
	if x==math.floor(x) then return tostring(math.floor(x)) end
	local s=string.format(`%.{maxFloat}f`,x)
	s=string.gsub(s,"%.?0+$","")
	return s
end

function Strs.ToPersentase(x,max,maxFloat,reverse)
	if type(x)~="number" or x==0 then return "0%" end
	if (x>=math.huge or x<=-math.huge) then return "∞%" end
	maxFloat=if type(maxFloat)=="number" and maxFloat>0 then maxFloat else 2
	local percentage=math.floor(x)*100
	if not reverse then
		if max then percentage=math.floor(x/max)*100 end
	else
		if max then
			percentage=(1/max)*x
			if percentage>=1 then 
				return "100%"
			else
				percentage=percentage*100
			end
		end
	end
	local s=string.format(`%.{maxFloat}f`,percentage)
	s=s.."%"
	if max and x>=max then s="100%" end
	return s
end

function Strs.RandomString()
	local length=math.random(10,20)
	local array={}
	for i=1,length do
		array[i]=string.char(math.random(32,126))
	end
	return table.concat(array)
end

return Strs

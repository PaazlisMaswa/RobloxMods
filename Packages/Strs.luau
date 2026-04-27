local MathHuge,MathFloor,StringGsub,StringFormat,StringFind,StringLen,StringMatch=math.huge,math.floor,string.gsub,string.format,string.find,string.len,string.match

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

function Strs.GetLines(s:string):()->(string)
	InvalidArgumentString(s,1,"GetLines")
	local lastBreak=0
	local function NextLine()
		if lastBreak==#s then return nil end
		local line,nextBreak=nil,StringFind(s,"\n",lastBreak+1)		
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

function Strs.IsEmpty(s:any):boolean
	if type(s)=="string" then
		if StringLen(s)==0 then return true end
		local v=StringMatch(s,"^%s*$")
		if v==nil then return false end
		return true
	end
	return true
end

function Strs.IsStrings(s1:string,s2:{string}):boolean
	InvalidArgumentString(s1,1,"IsStrings")
	InvalidArgumentTable(s2,2,"IsStrings")
	for i,v in ipairs(s2) do if s1==v then return true end end return false
end

function Strs.ToNumberString(v:any,maxFloat:number?):string
	local x=type(v)=="string" and tonumber(v) or v
	InvalidArgumentNumber(x,1,"ToNumberString")
	maxFloat=if type(maxFloat)=="number" and maxFloat>0 then maxFloat else 3
	if x==MathFloor(x) then return tostring(MathFloor(x)) end
	local s=StringFormat(`%.{maxFloat}f`,x)
	s=StringGsub(s,"%.?0+$","")
	return s
end

function Strs.ToPersentase(x:number,max:number?,maxFloat:number?,reverse:boolean?):string
	if type(x)~="number" or x==0 then return "0%" end
	if (x>=MathHuge or x<=-MathHuge) then return "∞%" end
	maxFloat=if type(maxFloat)=="number" and maxFloat>0 then maxFloat else 2
	local percentage=MathFloor(x)*100
	if not reverse then
		if max then percentage=MathFloor(x/max)*100 end
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
	local s=StringFormat(`%.{maxFloat}f`,percentage)
	s=s.."%"
	if max and x>=max then s="100%" end
	return s
end

return Strs

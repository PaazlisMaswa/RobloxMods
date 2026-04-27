-- Instancer by @Paazlis

local RunService=game:GetService("RunService")

local PartProperties={"Name","Anchored","Locked","CanCollide","Transparency","Color","Material","Reflectance","CFrame","BackSurface","BottomSurface","FrontSurface","LeftSurface","RightSurface","TopSurface","Size"}

local MathFloor,StringFormat,StringFind,StringGmatch,StringSub,InstanceNew,TaskWait,TableInsert,TableRemove=math.floor,string.format,string.find,string.gmatch,string.sub,Instance.new,task.wait,table.insert,table.remove

local function InvalidArgumentInstance(v,i,s)
	assert(typeof(v)=="Instance",`Invalid argument #{i} (Instance expected, got {typeof(v)})`)
end

local function InvalidArgumentFunction(v,i,s)
	assert(type(v)=="function",`Invalid argument #{i} (function expected, got {typeof(v)}) to Instancer.{s}`)
end

local function InvalidArgumentString(v,i,s)
	assert(type(v)=="string",`Invalid argument #{i} (string expected, got {typeof(v)}) to Instancer.{s}`)
end

local function InvalidArgumentTable(v,i,s)
	assert(type(v)=="table",`Invalid argument #{i} (table expected, got {typeof(v)}) to Instancer.{s}`)
end

local Instancer={}

function Instancer.FindOrCreateChild(instance,name,className,data)
	InvalidArgumentInstance(instance,1,"FindOrCreateChild")
	InvalidArgumentString(name,2,"FindOrCreateChild")
	InvalidArgumentString(className,3,"FindOrCreateChild")
	data=type(data)=="table" and data or {}
	local c=nil
	for i,v in ipairs(instance:GetChildren()) do if v.Name==name and v:IsA(className) then c=v break end end
	if not c then
		c=Instance.new(className)
		c.Name=name
		local parent=instance
		for k,v in pairs(data) do
			if type(k)=="string" then
				if k=="Parent" then
					parent=v
				else
					pcall(function() c[k]=v end)
				end
			end
		end
		c.Parent=parent
	end
	return c
end

function Instancer.CreateVariable(instance,variables,name)
	InvalidArgumentInstance(instance,1,"CreateVariable")
	InvalidArgumentTable(variables,2,"CreateVariable")

	local currentName=type(name)=="string" and name or instance.Name

	-- Remove symbols
	local nameWithoutSymbols=""
	for v in string.gmatch(currentName,"[%w_]") do nameWithoutSymbols=nameWithoutSymbols..v end

	-- Check for string
	local baseName=""
	if #nameWithoutSymbols==0 then
		baseName=instance.ClassName
	elseif string.find(string.sub(nameWithoutSymbols,1,1),"%d") then
		baseName="_"..nameWithoutSymbols
	else
		baseName=nameWithoutSymbols
	end

	-- Check for original name
	local isOriginal=true
	for i,v in pairs(variables) do if v==baseName then isOriginal=false break end end
	if isOriginal then variables[instance]=baseName return end

	-- Check for duplicate name
	local count=1
	local isDuplicate=false
	while true do
		isDuplicate=false
		local mainBaseName=baseName.."_"..tostring(count)
		for i,v in pairs(variables) do if v==mainBaseName then isDuplicate=true break end end
		count=count+1
		if not isDuplicate then variables[instance]=mainBaseName return end
		task.wait()
	end
end

function Instancer.ConvertMeshPartToSpecialMesh(instance)
	if instance and instance.Parent and instance:IsA("MeshPart") then
		local meshId,textureId=instance.MeshId,instance.TextureID
		local part=Instance.new("Part")
		for i,v in ipairs(PartProperties) do if pcall(function() return part[v] end) then part[v]=instance[v] end end
		local specialMesh=Instance.new("SpecialMesh")
		specialMesh.Name="SpecialMesh"
		specialMesh.MeshType=Enum.MeshType.FileMesh
		specialMesh.MeshId=meshId
		specialMesh.TextureId=textureId
		specialMesh.Scale=(1/instance.MeshSize)*instance.ExtentsSize
		specialMesh.Parent=part
		part.Parent=instance.Parent
		local t={}
		for j,k in ipairs(instance:GetDescendants()) do if not k:IsA("SurfaceAppearance") then k.Parent=part else table.insert(t,k) end end

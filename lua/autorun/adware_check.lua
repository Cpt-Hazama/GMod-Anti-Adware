/*
	Based on Zaurzo's code (he made a post in Necros' Discord), this is a 'user-friendly' adware filter.
	It is not 100% accurate, but it is good enough for most purposes.
	To view all found adware, open your console and paste this into it: lua_run listViruses()
*/

local table_value = table.HasValue
local table_insert = table.insert
local string_find = string.find
local string_explode = string.Explode
local http_Fetch = http.Fetch

local function SendMsg(txt,colCode)
	if SERVER then
		net.Start("AdwareCheck_Msg")
			net.WriteString(txt)
			net.WriteInt(colCode or 3,6)
		net.Broadcast()
	end
end

local safe = {
    [".com"] = true,
    [".org"] = true,
    [".net"] = true,
    [".edu"] = true,
    [".web"] = true,
    [".html"] = true
}
local potentialVirus = {}

if SERVER then
	util.AddNetworkString("AdwareCheck_Msg")
else
	local colRed = Color(255, 0, 0)
	local colGreen = Color(0, 255, 0)
	local colBlue = Color(0, 0, 255)
	net.Receive("AdwareCheck_Msg", function()
		local msg = net.ReadString()
		local msgCol = net.ReadInt(6)

		if msgCol == 1 then
			chat.AddText(colRed, "[Adware Check] ")
			chat.AddText(Color(255, 255, 255), msg)
			chat.AddText(Color(255, 255, 255), "\n")
			surface.PlaySound("buttons/blip1.wav")
		elseif msgCol == 2 then
			MsgC(colGreen, "[Adware Check] ")
			MsgC(Color(255, 255, 255), msg)
			MsgC(Color(255, 255, 255), "\n")
		elseif msgCol == 3 then
			MsgC(colBlue, "[Adware Check] ")
			MsgC(Color(255, 255, 255), msg)
			MsgC(Color(255, 255, 255), "\n")
		end
	end)
end

http.Fetch = function(url,...)
    local args = string_explode("/",url)
    local hostPage = !string_find(url,"/") && url or args[3]
    local domain = string_explode(".",hostPage)
    domain = "." .. domain[#domain]

	SendMsg("Checking '" .. url .. "' [" .. hostPage .. "] for adware...",3)
    if safe[domain] != true then
		if !table_value(potentialVirus,url) then
			SendMsg("Potential Adware Detected! Check your console for details.",1)
			table_insert(potentialVirus,url)
		end
		print("POTENTIAL ADWARE DETECTED! BLOCKING THE FOLLOWING URL: " .. url)
        return
	else
		SendMsg("No virus detected!",2)
    end

    return http_Fetch(url,...)
end

function listViruses()
	for _,v in pairs(potentialVirus) do
		print(v)
	end
end
// Based on Zaurzo's code, this is a 'user-friendly' adware filter.
// It is not 100% accurate, but it is good enough for most purposes.
// To view all found adware, open your console and paste this into it: lua_run listViruses()

local table_value = table.HasValue
local table_insert = table.insert
local string_find = string.find
local httpFetch = http.Fetch

local safe = {
    [".com"] = true,
    [".org"] = true,
}
local foundViruses = {}

http.Fetch = function(url,...)
    for domain,__ in pairs(safe) do
        if !string_find(url,domain) then
			if !table_value(foundViruses,url) then
				if IsValid(Entity(1)) then
					Entity(1):ChatPrint("Potential Adware Detected! Check your console for details.")
				end
				table_insert(foundViruses,url)
			end
			print("POTENTIAL ADWARE DETECTED! BLOCKING THE FOLLOWING URL: " .. url)
			return
		end
    end

    return httpFetch(url,...)
end

function listViruses()
	for _,v in pairs(foundViruses) do
		print(v)
	end
end
// Based on Zaurzo's code, this is a 'user-friendly' adware filter.
// It is not 100% accurate, but it is good enough for most purposes.
// To view all found adware, open your console and paste this into it: lua_run listViruses()

local safe = {
    [".com"] = true,
    [".org"] = true,
}
local foundViruses = {}

local httpFetch = http.Fetch
http.Fetch = function(url,...)
    for domain,__ in pairs(safe) do
        if !string.find(url,domain) then
			if !table.HasValue(foundViruses,url) then
				if IsValid(Entity(1)) then
					Entity(1):ChatPrint("Adware Detected! Check your console for details.")
				end
				table.insert(foundViruses,url)
			end
			print("ADWARE DETECTED! BLOCKING THE FOLLOWING URL: " .. url)
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
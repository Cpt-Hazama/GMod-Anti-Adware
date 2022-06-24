To install, put the 'Anti Adware' folder into '/GarrysMod/garrysmod/addons/'
The folder structure should look like this if you installed it correctly

    GarrysMod/
        garrysmod/
            addons/
                Anti Adware/
                    lua/
                        autorun/
                            adware_check.lua

This is based on Zaurzo's code, this is a 'user-friendly' adware filter
It is not 100% accurate, but it is good enough for most purposes
To view all found adware, open your console and paste this into it while in a game: lua_run listViruses()
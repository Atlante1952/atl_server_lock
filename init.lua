atl_server_lock = {}
atl_server_lock.modpath = minetest.get_modpath("atl_server_lock")
atl_server_lock.mod_storage = minetest.get_mod_storage()
atl_server_lock.server_locked = atl_server_lock.load_server_lock_state()
atl_server_lock.server_locked_message = "-!- The server is now locked."

function atl_server_lock.load_file(path)
    local status, err = pcall(dofile, path)
    if not status then
        minetest.log("error", "-!- Failed to load file: " .. path .. " - Error: " .. err)
    else
        minetest.log("action", "-!- Successfully loaded file: " .. path)
    end
end

if atl_server_lock.modpath then
    local files_to_load = {
        "script/api.lua",
        "script/events.lua",
        "script/commands.lua",
        "script/privs.lua",
    }

    for _, file in ipairs(files_to_load) do
        atl_server_lock.load_file(atl_server_lock.modpath .. "/" .. file)
    end
else
    minetest.log("error", "-!- Files in " .. atl_server_lock.modpath .. " mod are not set or valid.")
end
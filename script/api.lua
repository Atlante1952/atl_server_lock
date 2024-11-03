
local S = minetest.get_translator("atl_server_lock")

function atl_server_lock.load_server_lock_state()
    return atl_server_lock.mod_storage:get_string("server_locked") == "true",
           atl_server_lock.mod_storage:get_string("server_lock_reason") or ""
end

function atl_server_lock.save_server_lock_state(locked, reason)
    atl_server_lock.mod_storage:set_string("server_locked", tostring(locked))
    atl_server_lock.mod_storage:set_string("server_lock_reason", reason or "")
end

atl_server_lock.server_locked, atl_server_lock.lock_reason = atl_server_lock.load_server_lock_state()
atl_server_lock.default_locked_message = minetest.colorize("orange", "-!- The server is now locked")

function atl_server_lock.get_full_lock_message()
    if atl_server_lock.lock_reason and atl_server_lock.lock_reason ~= "" then
        return atl_server_lock.default_locked_message .. minetest.colorize("orange", " for the following reason : " .. atl_server_lock.lock_reason)
    else
        return atl_server_lock.default_locked_message
    end
end

function atl_server_lock.lock_server(player_name, reason)
    atl_server_lock.server_locked = not atl_server_lock.server_locked
    atl_server_lock.lock_reason = reason or ""
    atl_server_lock.save_server_lock_state(atl_server_lock.server_locked, atl_server_lock.lock_reason)

    if atl_server_lock.server_locked then
        minetest.chat_send_player(player_name, atl_server_lock.get_full_lock_message())
        for _, player in ipairs(minetest.get_connected_players()) do
            local name = player:get_player_name()
            local privs = minetest.get_player_privs(name)
            if not privs.server_lock and not privs.server then
                minetest.kick_player(name, atl_server_lock.get_full_lock_message())
            end
        end
    else
        minetest.chat_send_player(player_name, minetest.colorize("orange", "-!- The server is now unlocked."))
    end
end

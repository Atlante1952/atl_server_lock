local S = minetest.get_translator("atl_server_lock")

function atl_server_lock.load_server_lock_state()
    return atl_server_lock.mod_storage:get_string("server_locked") == "true"
end

function atl_server_lock.save_server_lock_state(locked)
    atl_server_lock.mod_storage:set_string("server_locked", tostring(locked))
end

function atl_server_lock.lock_server(player_name)
    atl_server_lock.server_locked = not atl_server_lock.server_locked
    atl_server_lock.save_server_lock_state(atl_server_lock.server_locked)

    if atl_server_lock.server_locked then
        minetest.chat_send_player(player_name, S(atl_server_lock.server_locked_message))
        for _, player in ipairs(minetest.get_connected_players()) do
            local name = player:get_player_name()
            local privs = minetest.get_player_privs(name)
            if not privs.server_lock and not privs.server then
                minetest.kick_player(name, S(atl_server_lock.server_locked_message))
            end
        end
    else
        minetest.chat_send_player(player_name, S("-!- The server is now unlocked."))
    end
end


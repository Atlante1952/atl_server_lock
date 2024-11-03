minetest.register_on_prejoinplayer(function(name, ip)
    if atl_server_lock.server_locked then
        local privs = minetest.get_player_privs(name) or {}
        if not privs.server_lock and not privs.server then
            return atl_server_lock.get_full_lock_message()
        end
    end
end)
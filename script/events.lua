minetest.register_on_prejoinplayer(function(name, ip)
    if atl_server_lock.server_locked_messageserver_locked then
        local privs = minetest.get_player_privs(name)
        if not privs.anti_join and not privs.server then
            return atl_server_lock.server_locked_message
        end
    end
end)
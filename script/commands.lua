minetest.register_chatcommand("lock_server", {
    description = "Locks or unlocks the server",
    privs = {server = true},
    params = "<reason>",
    func = function(player_name, param)
        atl_server_lock.lock_server(player_name, param)
    end,
})
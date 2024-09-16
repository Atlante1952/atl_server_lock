minetest.register_chatcommand("lock_server", {
    description = "Locks or unlocks the server",
    privs = {server = true},
    func = function(player_name)
        atl_server_lock.lock_server(player_name)
    end,
})
minetest.register_privilege("server_lock", {
    description = "Allows joining even when the server is locked",
    give_to_singleplayer = false,
    give_to_admin = true
})

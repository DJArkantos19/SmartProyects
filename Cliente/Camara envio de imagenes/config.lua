application = {
	content = {
		width = 720,
		height = 1280,
		scale = "letterBox",
		fps = 30,

		--[[
        imageSuffix = {
		    ["@2x"] = 2,
		}
		--]]
	},
settings =
{
    android =
    {
        usesPermissions =
        {
			"android.permission.CAMERA",
            "android.permission.WRITE_EXTERNAL_STORAGE",
        },
    },
}
    --[[
    -- Push notifications

    notification =
    {
        iphone =
        {
            types =
            {
                "badge", "sound", "alert", "newsstand"
            }
        }
    }
    --]]
}

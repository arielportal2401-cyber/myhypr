
hl.config({
    general = {
        gaps_in  = 5,
        gaps_out = 20,

        border_size = 0,

        col = {
            active_border   = { colors = {"rgba(255,200,200,0.)"}},
            inactive_border = "rgba(50,50,50,0.25)",
        },

        -- Set to true to enable resizing windows by clicking and dragging on borders and gaps
        resize_on_border = false,

        -- Please see https://wiki.hypr.land/Configuring/Advanced-and-Cool/Tearing/ before you turn this on
        allow_tearing = false,

        layout = "dwindle",
    },

    decoration = {
        rounding       = 20,
        rounding_power = 2,

        -- Change transparency of focused and unfocused windows
        active_opacity   = 0.96,
        inactive_opacity = 0.88,

        shadow = {
            enabled      = true,
            range        = 15,
            render_power = 2,
            color        = 0x80000000,
        },

        blur = {
            enabled   = false,
            size      = 13,
            passes    = 3,
            vibrancy  = 0.1696,
        },
    },

    animations = {
        enabled = true,
    },
})

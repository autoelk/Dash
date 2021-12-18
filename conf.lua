function love.conf(t)
    t.console = true                    -- Attach a console (boolean, Windows only)
    t.window.title = "Dash"             -- The window title (string)
    t.window.icon = nil                 -- Filepath to an image to use as the window's icon (string)
    t.window.width = 1280               -- The window width (number)
    t.window.height = 720               -- The window height (number)
    t.window.borderless = false         -- Remove all border visuals from the window (boolean)
    t.window.resizable = true           -- Let the window be user-resizable (boolean)
    t.window.minwidth = 1               -- Minimum window width if the window is resizable (number)
    t.window.minheight = 1              -- Minimum window height if the window is resizable (number)
    t.window.fullscreen = false         -- Enable fullscreen (boolean)
    t.window.fullscreentype = "desktop" -- Choose between "desktop" fullscreen or "exclusive" fullscreen mode (string)
end
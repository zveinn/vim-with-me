local TCP = require("vim-with-me.tcp").TCP
local App = require("vim-with-me.app")

---@type VWMApp | nil
local app = nil

function START()
    assert(app == nil, "client already started")

    local conn = TCP:new()
    conn:start(function()
        local function handle_commands(cmd)
            print("handled command", vim.inspect(cmd))
        end
        app = App:new(conn):on_cmd_received(handle_commands)
    end)
end

function CLOSE()
    assert(app ~= nil, "app not started")
    app:close()
end

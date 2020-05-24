VERSION = "1.1.0"

local micro = import("micro")
local config = import("micro/config")

function joinLines(v)
    local nLines = 1
    local cursor = v.Cursor

    if cursor:HasSelection() then
        local b, a = cursor.CurSelection[1], cursor.CurSelection[2]
        nLines = math.abs(a.Y - b.Y)
    end

    for _ = 1, nLines, 1 do
        v:EndOfLine()
        v:Delete()
        v.Buf:Insert(-cursor.Loc, " ")
        v:SelectWordRight()
        v:SelectWordLeft()
        v:Delete()
        v:EndOfLine()
    end
end

function init()
    config.MakeCommand("joinLines", joinLines, config.NoComplete)
    config.TryBindKey("Alt-j", "lua:joinLines.joinLines", false)
    config.AddRuntimeFile("joinLines", config.RTHelp, "help/join-lines-plugin.md")
end

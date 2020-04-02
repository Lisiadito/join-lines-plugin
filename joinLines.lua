VERSION = "1.0.1"

function joinLines()
    local v = CurView()
    local a, b, c = nil, nil, v.Cursor
    local selection = c:GetSelection()

    if c:HasSelection() then
        if c.CurSelection[1]:GreaterThan(-c.CurSelection[2]) then
            a, b = c.CurSelection[2], c.CurSelection[1]
        else
            a, b = c.CurSelection[1], c.CurSelection[2]
        end
        a = Loc(a.X, a.Y)
        b = Loc(b.X, b.Y)
        selection = c:GetSelection()
    else
        -- get beginning of curent line
        local startLoc = Loc(0, c.Loc.Y)  
        -- get the last position of the next line 
        local xNext = string.len(v.Buf:Line(c.Loc.Y+1))

        a = startLoc
        b = Loc(xNext, c.Loc.Y+1)

        c:SetSelectionStart(startLoc)
        c:SetSelectionEnd(b)
        selection = c:GetSelection()
    end    

    -- swap all whitespaces with a single space
    local modifiedSelection = string.gsub(selection, "\n%s*", " ")
    -- write modified selection to buffer
    v.Buf:Replace(a, b, modifiedSelection)    
end

MakeCommand("joinLines", "joinLines.joinLines")
BindKey("Alt-j", "joinLines.joinLines")

AddRuntimeFile("joinLines", "help", "help/join-lines-plugin.md")

Rig = { name = 'Rig' }

function Rig.init ( rig )
        if rig == Rig then
                return setmetatable ( {}, { __index = CCRig } )
        end
        return rig or setmetatable ( {}, { __index = CCRig } )
end

function Rig:debug ()
        print ( '-----')
        for k, v in pairs ( self ) do print ( k, v ) end
        print ( '-----')
end

--[[------------------------------------------------------------
Example rig initializer
--------------------------------------------------------------]]
function Rig:initExample ()
        local example = rig.init ( self )
        table.insert ( example, "Here's a string" )
        return example
end
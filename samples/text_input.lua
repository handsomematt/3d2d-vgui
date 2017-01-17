-- 3D2D-VGUI --
-- Example shows how to freeze the player and listen for their input in DTextEntry

require "3d2dvgui"

local tr = LocalPlayer():GetEyeTrace()
local pos = tr.HitPos + tr.HitNormal * 4
local ang = tr.HitNormal:Angle()
ang:RotateAroundAxis( ang:Up(), 90 )
ang:RotateAroundAxis( ang:Forward() * -1, -90 )

local fr = vgui.Create( "DFrame" )
fr:SetPos( 0, 0 )
fr:SetSize( 300, 60 )
fr:SetTitle( "Testframe" )
fr:SetKeyboardInputEnabled( true )
fr:SetMouseInputEnabled( true )

local tb = vgui.Create( "DTextEntry", fr )
tb:SetPos( 10, 30 )
tb:SetSize( 280, 20 )
tb.OOnMousePressed = tb.OnMousePressed
function tb:OnMousePressed( mc )
	LocalPlayer():Freeze()
	return tb:OOnMousePressed( mc )
end

hook.Add( "PostDrawOpaqueRenderables", "DrawSample3D2DFrame" .. math.random(), function()
	vgui.Start3D2D( pos, ang, 1 )
		fr:Paint3D2D()
	vgui.End3D2D()
end )

local lastkey
hook.Add( "Think", "PanelKeyInput", function()	
	if ( !tb:IsValid() ) then return end
	
	for i = 1, 36 do
		if ( input.IsKeyDown( i ) ) then
			if ( i == lastkey ) then break end
			
			if ( i >= 1 and i <= 10 ) then
				tb:SetText( tb:GetValue() .. string.char( i + 47 ) )
			elseif ( i >= 11 and i <= 36 ) then
				tb:SetText( tb:GetValue() .. string.char( i + 86 ) )
			end
			
			lastkey = i
			break
		end
	end
end )
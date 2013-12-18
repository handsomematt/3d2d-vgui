--	3D2D vgui sample
--		By Overv

if ( !vgui.Start3D2D ) then include( "3d2dvgui.lua" ) end

local tr = LocalPlayer():GetEyeTrace()
local pos = tr.HitPos + tr.HitNormal * 4
local ang = tr.HitNormal:Angle()
ang:RotateAroundAxis( ang:Up(), 90 )
ang:RotateAroundAxis( ang:Forward() * -1, -90 )

local sampleFrame = vgui.Create( "DFrame" )
sampleFrame:SetPos( 0, 0 )
sampleFrame:SetSize( 200, 250 )
sampleFrame:SetTitle( "Sample 3D2D frame" )

local combobox

local button = vgui.Create( "DButton", sampleFrame )
button:SetPos( 10, 30 )
button:SetSize( 180, 20 )
button:SetText( "Clear" )
button.DoClick = function()
	combobox:Clear()
end

local button2 = vgui.Create( "DButton", sampleFrame )
button2:SetPos( 10, 60 )
button2:SetSize( 180, 20 )
button2:SetText( "Add items" )
button2.DoClick = function()
	for i = 1, 5 do
		combobox:AddItem( math.random( 1, 10 ) )
	end
	combobox:SelectItem( combobox:GetItems()[1] )
end

combobox = vgui.Create( "DComboBox", sampleFrame )
combobox:SetPos( 10, 120 )
combobox:SetSize( 180, 120 )
for i = 1, 5 do
	combobox:AddItem( math.random( 1, 10 ) )
end
combobox:SelectItem( combobox:GetItems()[1] )

local checkbox = vgui.Create( "DCheckBoxLabel", sampleFrame )
checkbox:SetPos( 10, 90 )
checkbox:SetSize( 180, 15 )
checkbox:SetText( "Sample checkbox" )
checkbox.Identifier = "checkbox"

hook.Add( "PostDrawOpaqueRenderables", "DrawSample3D2DFrame" .. math.random(), function()
	vgui.Start3D2D( pos, ang, 1 )
		sampleFrame:Paint3D2D()
	vgui.End3D2D()
end )
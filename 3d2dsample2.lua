--	3D2D vgui sample #2
--		By Overv

if ( !vgui.Start3D2D ) then include( "3d2dvgui.lua" ) end

local origin = Vector( 300, -1919, 200 )

if ( frame ) then frame:Remove() for _, pnl in ipairs( frames ) do pnl:Remove() end end
frames = {}

frame = vgui.Create( "DFrame" )
frame:SetPos( 0, 0 )
frame:SetSize( 400, 250 )
frame:SetTitle( "Test" )

label = vgui.Create( "DLabel", frame )
label:SetPos( 10, 30 )
label:SetText( "Hello, world!" )

label2 = vgui.Create( "DLabel", frame )
label2:SetPos( 10, 50 )
label2:SetText( "Second label, with a color." )
label2:SetTextColor( Color( 255, 255, 100, 255 ) )

button = vgui.Create( "DButton", frame )
button:SetPos( 10, 190 )
button:SetSize( 100, 20 )
button:SetText( "Add player" )
button.DoClick = function()
	listview:AddLine( "Bot" .. #listview:GetLines(), math.random( 20 ), math.random( 20, 180 ) )
end

button2 = vgui.Create( "DButton", frame )
button2:SetPos( 10, 220 )
button2:SetSize( 100, 20 )
button2:SetText( "Open frame" )
button2.DoClick = function()
	local newframe = vgui.Create( "DFrame" )
	newframe:SetPos( 450, 0 )
	newframe:SetSize( 150, 200 )
	newframe:SetTitle( "New frame #" .. #frames + 1 )
	
	local closebut = vgui.Create( "DButton", newframe )
	closebut:SetPos( 10, 30 )
	closebut:SetSize( 100, 20 )
	closebut:SetText( "Close me" )
	closebut.DoClick = function()
		newframe:Remove()
	end
	
	table.insert( frames, newframe )
end

listview = vgui.Create( "DListView", frame )
listview:SetPos( 150, 30 )
listview:SetSize( 240, 210 )
listview:AddColumn( "Player" )
listview:AddColumn( "Frags" )
listview:AddColumn( "Ping" )

--	Drawing

hook.Add( "PostDrawOpaqueRenderables", "DrawSample3D2DFrame2", function()	
	vgui.Start3D2D( origin, Angle( 0, 180, 90 ), 1 )
		frame:Paint3D2D()
		
		for _, frame in ipairs( frames ) do
			frame:Paint3D2D()
		end
	vgui.End3D2D()
end )
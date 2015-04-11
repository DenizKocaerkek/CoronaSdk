local physics = require( "physics" )
local widget = require( "widget" )

physics.setGravity( 0, 9.8 )
physics.start()

local lbounce = 0.9

local centerX = display.contentCenterX
local centerY = display.contentCenterY
local _W = display.contentWidth
local _H = display.contentHeight

display.setStatusBar( display.DefaultStatusBar )

local top 		= display.newLine( 10, 		10, 	_W -10, 	10 )
local right 	= display.newLine( _W - 10, 10, 	_W- 10, 	_H -20 )
local bottom	= display.newLine( 10, 		_H -20, 	_W -10, 	_H -20  )
local left 	= display.newLine( 10, 		10, 	10, 	_H -20 )


local ball =   display.newImage( "redstone.png",centerX, centerY ) 
ball:setFillColor( 0.5 )
ball:scale( 0.2, 0.2 )

--local redball = display.newCircle( centerX-30, centerY-50, 30 )
--redball:setFillColor( 1,0,0)

local greenball = display.newImage( "yellowstone.png",centerX-10, centerY ) 
greenball:scale( 0.2, 0.2 )

local blueball = display.newImage( "lacistone.png",centerX, centerY -10) 
blueball:scale( 0.2, 0.2 )

 physics.addBody( top, "static", { friction=0.5, bounce=lbounce } )
 physics.addBody( right, "static", { friction=0.5, bounce=lbounce } )
 physics.addBody( bottom, "static", { friction=0.5, bounce=lbounce } )
 physics.addBody( left, "static", { friction=0.5, bounce=lbounce } )

physics.addBody( ball,"dynamic", { density=1.0, friction=0.3, bounce=lbounce, radius=30 } )
--hysics.addBody( redball,"dynamic", { density=1.0, friction=0.3, bounce=lbounce, radius=30 } )
physics.addBody( greenball,"dynamic", { density=1.0, friction=0.3, bounce=lbounce, radius=20 } )
physics.addBody( blueball,"dynamic", { density=1.0, friction=0.3, bounce=lbounce, radius=10 } )

local function urTiltFunc( event )
        physics.setGravity( 50 * event.xGravity, -50 * event.yGravity )
end

Runtime:addEventListener( "accelerometer", urTiltFunc )

-- Function to handle button events
local function handleButtonEvent( event )

    if ( "ended" == event.phase ) then
  blueball = display.newImage( "lacistone.png",centerX-1, centerY ) 
blueball:scale( 0.1, 0.1 )
		physics.addBody( blueball,"dynamic", { density=0, friction=0, bounce=0, radius=6 } )
    end
end

-- Create the widget
local button1 = widget.newButton
{
    left = 0,
    top = _H-50,
    id = "button1",
    label = "Mavi Top",
    onEvent = handleButtonEvent
}
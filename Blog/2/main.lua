-- kullandığımız kütüphaneleri tanımlıyoruz.
local physics = require( "physics" )
local widget = require( "widget" )

-- fizik motorunu ayarlıyoruz.
-- çizim modu ayarlanıyor, debug modda fizik nesnelerinin sınırları çizilir.
-- böylece yaptığımız tanımların doğruluğunu test edebiliriz.
physics.setDrawMode( "normal" )  -- hybrid, normal , debug

-- yer çekimi ayarlanıyor.  9.8 değeri Dünyanın yerçekimine karşılık geliyor.
physics.setGravity( 0, 9.8 )

-- fizik motorunu çalıştırıypruz.
physics.start()

local lbounce = 0.9

-- uygulamanın devamında çok kullanacağımız bazı değerleri ayarlıyoruz.
local centerX = display.contentCenterX  -- ekranın yatay koordinatta orta noktası. 
local centerY = display.contentCenterY  -- ekranın dikey koordinatta orta noktası
local _W = display.contentWidth         -- ekranın genişliği
local _H = display.contentHeight        -- ekranın yüksekliği

display.setStatusBar( display.DefaultStatusBar )

-- ekranın etrafına bir çerçeve çiziyoruz.
local top 		= display.newLine( 10, 		10, 	_W -10, 	10 )
local right 	= display.newLine( _W - 10, 10, 	_W- 10, 	_H -20 )
local bottom	= display.newLine( 10, 		_H -20, 	_W -10, 	_H -20  )
local left 	    = display.newLine( 10, 		10, 	10, 	_H -20 )


 -- ekranın etrafına çizdiğimiz çerçeveyi fizik motoruna statik (sabit) nesneler olarak tanımlıyoruz.
 -- böylece çerçeve içine koyacağımız dinamik fizik neseneleri bu sınırlar dışına çıkamayacak.
 physics.addBody( top, "static", { friction=0.5, bounce=lbounce } )
 physics.addBody( right, "static", { friction=0.5, bounce=lbounce } )
 physics.addBody( bottom, "static", { friction=0.5, bounce=lbounce } )
 physics.addBody( left, "static", { friction=0.5, bounce=lbounce } )


-- topları tanımlıyoruz.
local redball = display.newImage( "redball.png",centerX-10, centerY ) 
local yellowball = display.newImage( "yellowball.png",centerX-10, centerY ) 
local blueball = display.newImage( "blueball.png",centerX, centerY -10) 

-- topları fizik motoruna dinamik neseneler olarak tanımlıyoruz.
physics.addBody( redball,"dynamic", { density=1.0, friction=0.3, bounce=lbounce, radius = redball.contentWidth / 2 } )
physics.addBody( yellowball,"dynamic", { density=1.0, friction=0.3, bounce=lbounce, radius = yellowball.contentWidth / 2 } )
physics.addBody( blueball,"dynamic", { density=1.0, friction=0.3, bounce=lbounce, radius = blueball.contentWidth / 2 } )

-- yerçekiminin cihazımızı çevirdiğimiz yere göre ayarlanması için aşağıdaki fonksiyonu kullanacağız.
local function urTiltFunc( event )
        -- yerçekimi cihazın eğimine göre ayarlanıyor.
        physics.setGravity( 50 * event.xGravity, -50 * event.yGravity )
end

-- cihazın hareketlerini yakalamak için aşağıdaki satırı yazıyoruz.
-- accelerometer değeri her değiştiğinde urlTiltFunc çağırılacak.
Runtime:addEventListener( "accelerometer", urTiltFunc )

 
-- ekrana yeni bir top ekleyebilmek için aşağıdaki fonksiyonu yazdık. 
local function addBlueButton( event )
    if ( "ended" == event.phase ) then
  		blueball = display.newImage( "blueball.png",centerX-1, centerY ) 
		physics.addBody( blueball,"dynamic", { density=0, friction=0, bounce=0, radius = blueball.contentWidth / 2} )
    end
end
-- ekrana yeni bir top eklemek için kullanacağımız tuşu tanımlıyoruz.
local redButton = widget.newButton
{
    left = 0,
    top = _H-30,
    id = "redButton",
    label = "Add Blue",
    onEvent = addBlueButton
}

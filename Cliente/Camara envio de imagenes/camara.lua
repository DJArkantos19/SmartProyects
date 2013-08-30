local storyboard = require ("storyboard")
local scene = storyboard.newScene()



function scene:createScene(event)

	local screenGroup = self.view


	background = display.newImage("fondo1.png")
	screenGroup:insert(background)

        btnCamara = display.newImage("btnCamara.png")
        btnCamara:setReferencePoint(display.BottomLeftReferencePoint)
        btnCamara.x = 250
        btnCamara.y = display.contentHeight - 800
        screenGroup:insert(btnCamara)

        btnGaleria = display.newImage("btnGaleria.png")
        btnGaleria:setReferencePoint(display.BottomRightReferencePoint)
        btnGaleria.x = display.contentWidth - 250
        btnGaleria.y = display.contentHeight - 450
        screenGroup:insert(btnGaleria)

		btnVerImagen = display.newImage("btnGaleria2.png")
        btnVerImagen:setReferencePoint(display.BottomRightReferencePoint)
        btnVerImagen.x = display.contentWidth - 250
        btnVerImagen.y = display.contentHeight - 250
        screenGroup:insert(btnVerImagen)

		btnDescarga = display.newImage("btnDescarga.png")
        btnDescarga:setReferencePoint(display.BottomRightReferencePoint)
        btnDescarga.x = display.contentWidth - 250
        btnDescarga.y = display.contentHeight - 0
        screenGroup:insert(btnDescarga)
--
end

--~ function onComplete(event)
--~    if event.completed then
--~       -- Disparo de Camara tomado correctamente
--~       -- Mostrar a la máxima resolución pasando en true.
--~       display.newImage("reconocimientoFacial.jpg", system.DocumentsDirectory, true)
--~    else
--~       -- User canceled out.
--~    end
--~ end


function onComplete(event)
   if event.completed then
      -- Disparo de Camara tomado correctamente
      -- Mostrar a la máxima resolución pasando en true.
--~ 	  local staging_image = display.newImage("reconocimientoFacial.jpg", system.TemporaryDirectory, true)
--~ 			staging_image.x = display.contentWidth/2
--~ 			staging_image.y = display.contentHeight/2
--~ 			group:insert(staging_image)
   else
      -- User canceled out.
   end
end

function camara(event)

if event.phase == "began" then
 native.showAlert( "Corona", "Ingreso camara.", { "OK" } )

--~  local onComplete = function(event)
--~  native.showAlert( "Corona", "Ingreso oncomplete.", { "OK" } )
--~    if event.completed then
--~       -- Camera shot was successfully taken.
--~       -- Display at full resolution by passing in true.
--~       display.newImage("reconocimientoFacial.jpg", system.TemporaryDirectory, true)
--~    else
--~       -- User canceled out.
--~    end
--~ end
native.showAlert( "Corona", "antes de rutaarchico.", { "OK" } )
		local rutaArchivo = { baseDir = system.TemporaryDirectory , filename = "reconocimientoFacial.jpg" }
		native.showAlert( "Corona", "antes lanzar camara", { "OK" } )
		media.show( media.Camera, onComplete, rutaArchivo)
		native.showAlert( "Corona", "Despues lanzar camara", { "OK" } )


	end
end

function lanzarGaleria(event)
	if event.phase == "began" then
		media.show( media.PhotoLibrary, listener)
	end
end

function mostrarImagen(event)
if event.phase == "began" then


	  local staging_image = display.newImage("reconocimientoFacial.jpg", system.TemporaryDirectory, true)
			staging_image.x = display.contentWidth/3
			staging_image.y = display.contentHeight/3
			group:insert(staging_image)

	end
end

function descarga(event)
if event.phase == "began" then

-- Load the relevant LuaSocket modules
local http = require("socket.http")
local ltn12 = require("ltn12")

-- Create local file for saving data
local path = system.pathForFile( "hello.png", system.DocumentsDirectory )
myFile = io.open( path, "w+b" )

-- Request remote file and save data to local file
http.request{
    url = "http://developer.anscamobile.com/demo/hello.png",
    sink = ltn12.sink.file(myFile),
}

-- Display local file
testImage = display.newImage("hello.png",system.DocumentsDirectory,60,50);
end

end

function scene:enterScene(event)

	btnCamara:addEventListener("touch", camara)
        btnGaleria:addEventListener("touch", lanzarGaleria)
		 btnVerImagen:addEventListener("touch", mostrarImagen)
		  btnDescarga:addEventListener("touch", descarga)

end

function scene:exitScene(event)
	btnCamara:removeEventListener("touch", camara)
        btnGaleria:removeEventListener("touch", lanzarGaleria)
		 btnVerImagen:addEventListener("touch", mostrarImagen)
		  btnDescarga:addEventListener("touch", descarga)
end

function scene:destroyScene(event)

end

scene:addEventListener("createScene", scene)
scene:addEventListener("enterScene", scene)
scene:addEventListener("exitScene", scene)
scene:addEventListener("destroyScene", scene)

return scene

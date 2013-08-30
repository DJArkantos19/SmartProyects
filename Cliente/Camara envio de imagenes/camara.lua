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

--~ 		btnVerImagen = display.newImage("btnGaleria2.png")
--~         btnVerImagen:setReferencePoint(display.BottomRightReferencePoint)
--~         btnVerImagen.x = display.contentWidth - 250
--~         btnVerImagen.y = display.contentHeight - 250
--~         screenGroup:insert(btnVerImagen)

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

local function networkListener( event )
        if ( event.isError ) then
                print( "Network error!")
        elseif ( event.phase == "ended" ) then
                print ( "Upload complete!" )
        end
end


function onComplete(event)
   if event.completed then
      -- Disparo de Camara tomado correctamente
      -- Mostrar a la máxima resolución pasando en true.
--~ 	  local staging_image = display.newImage("reconocimientoFacial.jpg", system.TemporaryDirectory, true)
--~ 			staging_image.x = display.contentWidth/2
--~ 			staging_image.y = display.contentHeight/2
--~ 			group:insert(staging_image)

		network.upload(
			"http://181.55.218.31:9000",
			"POST",
			networkListener,
			"reconocimientoFacial.jpg",
			system.TemporaryDirectory,
			"image/jpg"
			)



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


function scene:enterScene(event)

	btnCamara:addEventListener("touch", camara)
        btnGaleria:addEventListener("touch", lanzarGaleria)
--~ 		 btnVerImagen:addEventListener("touch", mostrarImagen)

end

function scene:exitScene(event)
	btnCamara:removeEventListener("touch", camara)
        btnGaleria:removeEventListener("touch", lanzarGaleria)
--~ 		 btnVerImagen:addEventListener("touch", mostrarImagen)
end

function scene:destroyScene(event)

end

scene:addEventListener("createScene", scene)
scene:addEventListener("enterScene", scene)
scene:addEventListener("exitScene", scene)
scene:addEventListener("destroyScene", scene)

return scene

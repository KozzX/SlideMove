local vermelho = display.newRect( display.contentCenterX, display.contentCenterY, 50, 50 )
vermelho:setFillColor( 1,0,0 )

local tempoInicio = 0
local velocidade = 0.3
local movendo = false
local tempoClick = 0
local tempoCliclAnte = 0

local function moverX( x )
	local distancia 
	if vermelho.x > x then
		distancia = vermelho.x - x
	elseif vermelho.x < x then
		distancia = x - vermelho.x
	end
	
	if distancia ~= nil then
		transition.cancel(  )
		transition.moveTo( vermelho, {x = x,time=(distancia / velocidade)} )
	end
end

local function moverY( y )
	local distancia 
	if vermelho.y > y then
		distancia = vermelho.y - y
	elseif vermelho.y < y then
		distancia = y - vermelho.y
	end
	if distancia ~= nil then
		transition.cancel(  )
		transition.moveTo( vermelho, {y = y,time=(distancia / velocidade)} )
	end
end

function onTouch( event )
	if event.phase == "began" then
		tempoInicio = event.time
		azul = display.newRect( event.xStart,event.yStart, 0, 0 )
		azul:setFillColor( 0,0,1 )	
		azul.alpha = 0.2

		tempoCliclAnte = tempoClick
		tempoClick = event.time

		if (tempoClick - tempoCliclAnte) < 200 then
			transition.cancel(  )
		end	


	elseif event.phase == "moved" then
		if event.xStart < event.x then
			azul.anchorX = 0
			azul.width = event.x - event.xStart
		end
		if event.xStart > event.x then
			azul.anchorX = 1
			azul.width = event.xStart - event.x
		end
		if event.yStart < event.y then
			azul.anchorY = 0
			azul.height = event.y - event.yStart
		end
		if event.yStart > event.y then
			azul.anchorY = 1
			azul.height = event.yStart - event.y
		end
		
		local intervalo = event.time - tempoInicio
		if movendo == false then

			if event.x >= (event.xStart + 30) and (event.y >= (event.yStart - 30) and event.y <= (event.yStart + 30)) and intervalo < 300 then
				print( "direita")
				moverX(display.contentWidth-vermelho.width/2)
				movendo = true
			end 
			if event.x <= (event.xStart - 30) and (event.y >= (event.yStart - 30) and event.y <= (event.yStart + 30))  and intervalo < 300 then
				print( "esquerda")
				moverX(vermelho.width/2)
				movendo = true
			end
			if event.y >= (event.yStart + 30) and (event.x >= (event.xStart - 30) and event.x <= (event.xStart + 20)) and intervalo < 300 then
				print( "baixo")
				moverY(display.contentHeight-vermelho.height/2)
				movendo = true
			end 
			if event.y <= (event.yStart - 30) and (event.x >= (event.xStart - 30) and event.x <= (event.xStart + 30)) and intervalo < 300 then
				print( "cima")
				moverY(vermelho.height/2)
				movendo = true
			end 
			
		end

	elseif event.phase == "ended" then
		movendo = false
		
		display.remove( azul )
	end

end

Runtime:addEventListener( "touch", onTouch )



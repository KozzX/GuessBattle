local spinIcon

function new(  )

    spinIcon = display.newImage( "upload.png", display.contentCenterX, display.contentCenterY )
    spinIcon.width = spinIcon.width/9
    spinIcon.height = spinIcon.height/9 

    local function spin(  )
        spinIcon:rotate( 9 )
        if (spinIcon.rotation%360 == 0) then
            timer.pause( spinTimer )
            transition.to( spinIcon, {width=spinIcon.width*1.7,height=spinIcon.height/2,time=200,onComplete=function (  )
                transition.to( spinIcon, {width=spinIcon.width/1.7,height=spinIcon.height*2,time=200,onComplete=function (  )        
                    timer.resume( spinTimer )    
                end} )    
            end} )   
        end
    end
    spinTimer = timer.performWithDelay( 10, spin , -1 )

    return spinIcon
end

function remover()  
    timer.cancel( spinTimer )
    print("remover",spinIcon)
    transition.cancel(spinIcon)
    display.remove( spinIcon )
    spinIcon = nil
            
end
        
return {
    new = new,
    remover = remover
}
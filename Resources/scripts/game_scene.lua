print("hello moon game lua")
local enemy = require("scripts/enemy.lua")
 local hero = require("scripts/player.lua")
 require("scripts/wave.lua")

function debug_trace( mgs  )
	print("...............")
	print("lua error is :"..string.Format(msg))
	print(debug.traceback())
	print(".................")

	-- body
end
local bgSprite1
local bgSprite2
local director = CCDirector:sharedDirector()

local soundEngine = SimpleAudioEngine:sharedEngine()

function create_player(root )
	-- body
	hero:create_hero(root )

end
enemyArray = CCArray:create();
enemyArray:retain()
function create_enemys(root)
print("crate enemys....")
	for k,v in pairs(wave) do
		local delay = v.delay
		local startX = v.startX
		local startY = v.startY
		local endX = v.endX
		local endY = v.endY
		print(delay )
		enemy:create_enemy(root,startX ,startY)
		local ePos = CCPoint(endX,endY)

		
		enemy:move(delay,ePos)
	
		enemyArray:addObject(enemy:getenemyspr())
		

	end
	
	-- body
end
local function create_bglayer()
print("crate bglayer ")
	local bglayer = CCLayer:create()
	CCSpriteFrameCache:sharedSpriteFrameCache():addSpriteFramesWithFile("res/textureTransparentPack.plist")
	 bgsprite1 = CCSprite:createWithSpriteFrameName("bg01.png")
	 bgsprite2 = CCSprite:createWithSpriteFrameName("bg01.png")


	local gSize = CCDirector:sharedDirector():getWinSize()
	print(gSize.width,gSize.height)
	bglayer:addChild(bgsprite1,1)

	bgsprite1:setPosition(0,0)
	bgsprite1:setAnchorPoint(CCPointMake(0,0))
	bglayer:addChild(bgsprite2,1)
	print("add spr2")
	bgsprite2:setPosition(0,bgsprite1:getPositionY()+bgsprite1:getContentSize().height )
	bgsprite2:setAnchorPoint(CCPointMake(0,0))
	print("spr2 setpos")

	local function bg_run()

    local speed  = 2
    bgsprite1:setPositionY(bgsprite1:getPositionY()-2)
    bgsprite2:setPositionY(bgsprite1:getPositionY()+bgsprite1:getContentSize().height)

    if bgsprite2:getPositionY() <= 0 then 
    	bgsprite1:setPositionY(0)
    end 

	end
	create_player(bglayer )
	create_enemys(bglayer )
	CCDirector:sharedDirector():getScheduler():scheduleScriptFunc(bg_run ,1.0/60.0,false )
	print(" bglayer")
	local touchX 
	local touchY 
	local function register_touch_enent(  )
		local function onTouchBegin ( x,y )
			touchX = x
			touchY = y 
		
			return true 
		end
		local function onTouchMoved ( x,y )
			
			local subX = x - touchX 
			local subY = y - touchY 
			local heroCurx,heroCury = hero:getpos()
			hero:moveto(heroCurx+subX,heroCury+subY )
			touchX = x 
			touchY = y 
			-- body
		end
		local function onTouchEnded (  x,y )
			-- body
		end
		local function onTouch (enentype,x,y )
			
			if enentype == "began" then 
				return onTouchBegin(x,y)
			elseif enentype == "moved" then 

				return onTouchMoved(x,y)
			else
				return onTouchEnded(x,y)
			end 
         
			-- body
		end
		bglayer:registerScriptTouchHandler(onTouch,false,0,true )
		bglayer:setTouchEnabled(true )
		-- body
	end
	register_touch_enent()
	local function collistest()
		local enemycount = enemyArray:count()
		if enemycount==0 then
		    create_enemys(bglayer)
		    return
		end
		local  isCol = false 
		local  enindex ,buindex 
		for i=0,enemycount-1 do
			
			local enspr = enemyArray:objectAtIndex(i)
			-- if enSpr == nil  then
			--     break 
			-- end
			enspr = tolua.cast(enspr,"CCSprite")

			local bulletArray = hero:getBusArray()
			local bucount = bulletArray:count()
		

			for j=0,bucount-1 do 	
				local bSpr = bulletArray:objectAtIndex(j)
				-- if bSpr == nil  then
				--     break 
				-- end
				bSpr = tolua.cast(bSpr,"CCNode")

				 local buBox = bSpr:boundingBox()
				 local enBox = enspr:boundingBox()
				 if enBox:intersectsRect(buBox ) then
				     print ("hurt ")
				    isCol = true 
				    enindex = i
				    buindex = j 
				    break 
				 end
			end
			if isCol  then
				local enspr = enemyArray:objectAtIndex(enindex )
				local buspr = bulletArray:objectAtIndex(buindex)
			    enspr:removeFromParentAndCleanup(true)
				buspr:removeFromParentAndCleanup(true)

			    hero:getBusArray():fastRemoveObject(buspr)
			    enemyArray:fastRemoveObject(enspr)
			end
		end
	end
	CCDirector:sharedDirector():getScheduler():scheduleScriptFunc(collistest,1/50.0,false )
	return bglayer

end
local  function create_game_scene(  )
	
	local scene = CCScene:create()
		scene:addChild(create_bglayer())
       -- soundEngine:playBackgroundMusic("res/Music/bgMusic.mp3",true)
	return scene

	-- body
end 
function main(  )
	-- body
    collectgarbage("setpause", 100)
    collectgarbage("setstepmul", 5000)

	CCDirector:sharedDirector():runWithScene(create_game_scene())


end

xpcall(main,debug_trace)
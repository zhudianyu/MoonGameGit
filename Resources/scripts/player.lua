local hero = {}

local winSize = CCDirector:sharedDirector():getWinSize()

local hero_spr = nil 

local batchNode = nil 

bulletArray = nil 


function hero:create_hero (  root)
	print("create hero ")

	bulletArray = CCArray:create()
	bulletArray:retain()
	local cache = CCSpriteFrameCache:sharedSpriteFrameCache()
	cache:addSpriteFramesWithFile("res/textureTransparentPack.plist")
	print("add frame cache ")
	CCSpriteFrameCache:sharedSpriteFrameCache():addSpriteFramesWithFile("res/textureOpaquePack.plist")
	print("add opaque.list")
	 self.batchNode = CCSpriteBatchNode:create("res/textureOpaquePack.png")
	 self.batchNode:retain()
	 root:addChild(self.batchNode,3000)

	print("create batchnode")
	--创建子弹数组

	-- self:addchild(batchNode)

    local rect  = CCRectMake(0,0,60,43)
    print ("make rect ")
	hero_spr = CCSprite:createWithSpriteFrameName("ship01.png" )
	print("create spr wiht ship01.png ")
	root:addChild(hero_spr,1000)
	hero_spr:setPosition(winSize.width/2,hero_spr:getContentSize().height*1.5)
	print("hero setpos ")
	local frame1 = cache:spriteFrameByName("ship01.png")
	rect = CCRectMake(60,0,60,63)
	local frame2  =cache:spriteFrameByName("ship02.png")
    
	local framearray = CCArray:create()
	print ("create arrray ")
	framearray:addObject(frame1)
	framearray:addObject(frame2)
	print("array add end ")
	local animation = CCAnimation:createWithSpriteFrames(framearray,0.1)
	print("animation crate")
	 print ("crate animation ")
	 local animate = CCAnimate:create(animation)
	 print ("crate animate  ")
	 hero_spr:runAction(CCRepeatForever:create(animate ))
	-- body
print("hero end ")
--创建子弹

local function create_new_bullets()
	local b = CCSprite:createWithSpriteFrameName("W1.png")
	--b = tolua:cast(b,"CCNode")
	self.batchNode:addChild(b)

	b:setPosition(hero_spr:getPositionX(),hero_spr:getPositionY()+20)
	bulletArray:addObject(b)
	--print("create bullets")
end
--移动子弹
local function move_bullets()
	local speed = 10
	local array_count = bulletArray:count()
	for i=0,array_count-1 do
		local b = bulletArray:objectAtIndex(i)
		b = tolua.cast(b,"CCNode")
	--	print("before "..b:getPositionY())
		b:setPositionY(b:getPositionY()+speed)
	--	print("after "..b:getPositionY())


	end
end
CCDirector:sharedDirector():getScheduler():scheduleScriptFunc(create_new_bullets,0.5,false)
CCDirector:sharedDirector():getScheduler():scheduleScriptFunc(move_bullets,0.02,false)
end
function hero:getBusArray()
			
	return bulletArray
end
function hero:getpos ()
	return hero_spr:getPositionX(),hero_spr:getPositionY()

	-- body
end
function hero:moveto(x,y )
	hero_spr:setPosition(CCPointMake(x,y))
end

return hero 
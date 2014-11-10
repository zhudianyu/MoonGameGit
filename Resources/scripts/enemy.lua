

local enemy = {}
enemysprite = nil 

function enemy:create_enemy ( root,x,y )
	enemysprite = CCSprite:createWithSpriteFrameName("E0.png")
	root:addChild(enemysprite,2000)
	enemysprite:setPosition(CCPoint(x,y))

	-- body
end
function enemy:move(delay ,point )
	
	local array = CCArray:create()

	array:addObject(CCDelayTime:create(delay))

	array:addObject(CCMoveTo:create(1.0,point))

	enemysprite:runAction(CCSequence:create(array))
print("enemy move4566 ")
end
function enemy:getenemyspr()
	return enemysprite
end
return enemy
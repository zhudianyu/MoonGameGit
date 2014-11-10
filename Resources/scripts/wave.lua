
wave = {
	
	{
	  delay = 1.0,
	  startX = 200,
	  startY = 100,
	   endX = 200,
     endY =150,
    },
	{
		delay = 2.0,
		startX = -200,
		startY = 200,
		endX = 100,
		endY = 350
	}
}
for k,v in pairs(wave) do
	print(v.delay)
end
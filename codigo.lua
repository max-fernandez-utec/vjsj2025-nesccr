function _init()
	j=make_player()
	e=make_enemy()
end

function _update()
	-- acciones jugador
	j.dx=0
	j.dy=0
	if (btn(⬅️)) j.dx=-1
	if (btn(➡️)) j.dx+=1
	if (btn(⬆️)) j.dy=-1
	if (btn(⬇️)) j.dy+=1
	
	-- disparo jug
	if (btnp(🅾️)) shoot(j.x,j.y-8,0,-3)	
	
	for e in all(entities) do
		e.upd()
	end
end

function _draw()
	cls()
	
	for e in all(entities) do
		e.drw()
	end
	
	-- interfaz de usuario
	map()
	
	print(#entities,0,9,8)
end

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
-->8
-- entidades
entities={}

function make_entity()
	local e={
		x=0,y=0,dx=0,dy=0,
		cnt=0,
		s=1,sprs={1},
	}
	
	e.upd=function()
		e.x+=e.dx
		e.y+=e.dy
	
		e.s=1 + e.cnt % #e.sprs
		e.cnt+=1
	end
	
	e.drw=function()
		spr(e.sprs[e.s],e.x,e.y)
	end
	
	add(entities,e)
	
	return e
end

function make_player()
	local j=make_entity()
	j.x=64
	j.y=64
	j.sprs={17,18,19,20}
	
	local aux=j.upd
	j.upd=function()
		if (j.x<-3) j.x=-3
		if (j.y<0) j.y=0
		if (j.x>124) j.x=124
		if (j.y>124) j.y=124
		aux()
	end
	
	j.drw=function()
		-- cuerpo de la nave
		spr(1,j.x,j.y)
		
		-- fuego
		spr(j.sprs[j.s],j.x,j.y+8)
	end
	
	return j
end

function make_enemy()
	local e=make_entity()
	
	e.x=64
	e.y=12
	e.sprs={32,33,34,35}
	
	return e
end
-->8
-- particulas
shoots={}

function make_shoot()
	local s=make_entity()
	s.sprs={21}
	
	local aux=s.upd
	s.upd=function()
		aux()
		
		if 
			s.y<-10 or 
			s.x<-10 or 
			s.y>130 or 
			s.x>130 then
			-- destruir el disparo
			del(entities,s)
		end
	end
	
	return s
end

function shoot(x,y,dx,dy)
	local s=make_shoot()
	s.x=x
	s.y=y
	s.dx=dx
	s.dy=dy
	
	sfx(0)
	
	return s
end

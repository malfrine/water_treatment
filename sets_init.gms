$Title sets_init

*SUPERSETS

sets

	tu		'treatment unit'
		/ st	skim tank
		  igf	induced gas flotation
		  orf	oil removal filter
		  hcy	hydro-cyclone
		  ls	warm-hot lime softener
		  evap	evaporator
		  wac	weak acid cation exchanger	
		/
	
	c		'contaminant'
		/ o		oil	
		  s		silica
		  th	total hardness
		  tss	total suspended solids
		/
	
	s		'water source'
		/ pw	produced water
		  muw	make-up water
		  bbd 	boiler blowdown 
		/
	
	cs 	'steam generation cases'
	 	/1*4/ ;

*MULTI-DIMENSIONAL SETS

alias(tu,tup);

set tu_tup(tu,tup) 'all recycle streams'
	/	st.igf, st.orf, st.hcy, st.ls, st.evap, st.wac,
		igf.st, igf.orf, igf.hcy, igf.ls, igf.evap, igf.wac,
		orf.st, orf.igf, orf.hcy, orf.ls, orf.evap, orf.wac,
		hcy.st, hcy.igf, hcy.orf, hcy.ls, hcy.evap, hcy.wac,
		ls.st, ls.igf, ls.orf, ls.hcy, ls.evap, ls.wac,
		evap.st, evap.igf, evap.orf, evap.hcy, evap.ls, evap.wac,
		wac.st, wac.igf, wac.orf, wac.hcy, wac.ls, wac.evap/ ;

display tu_tup;




$Title sets_init

*SUPERSETS

sets

        tu              'treatment unit'
                / st    skim tank
                  igf   induced gas flotation
                  orf   oil removal filter
                  hcy   hydro-cyclone
                  ls    warm-hot lime softener
                  evap  evaporator
                  wac   weak acid cation exchanger
                /

        c               'contaminant'
                / o     oil
                  s     silica
                  th    total hardness
                  tss   total suspended solids
                /

        s               'water source'
                / pw    produced water
                  muw   make-up water
                  bbd   boiler blowdown
                /

        cs      'steam generation cases'
                /1*4/ ;

alias(tu,tup);





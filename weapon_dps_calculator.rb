	player = {
		health: 250,
		stamina: 100,
	}
	weapons = {

	  longsword: {damage: 80, swing_speed: 0.5, length: 3,   stamina_cost: 15, weight: 3},
	  dagger: {damage: 56, swing_speed: 0.25, length: 1, stamina_cost: 7, weight: 0.5},
	  greatsword: {damage: 130, swing_speed: 0.8, length: 5, stamina_cost: 33, weight: 12},
	}


	weapon_outputs = Hash.new

	weapons.each do |key, value|
	  #Creating a new hash with weapon information
	  weapon_outputs[key] = {
	  	damage_per_second: value[:damage]/value[:swing_speed],
	  	total_swings_per_stamina_bar: player[:stamina]/value[:stamina_cost]
	  }
	end

	puts weapon_outputs
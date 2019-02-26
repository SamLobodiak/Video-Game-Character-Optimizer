	player = {
		health: 250,
		stamina: 100,
		equip_load: 75,
	}
	weapons = {

	  longsword: {damage: 80, swing_speed: 0.5, length: 3, stamina_cost: 15, weight: 3},
	  dagger: {damage: 56, swing_speed: 0.25, length: 1, stamina_cost: 7, weight: 0.5},
	  greatsword: {damage: 130, swing_speed: 0.8, length: 5, stamina_cost: 33, weight: 12},
	}

	weapon_outputs = Hash.new

	weapons.each do |key, value|
	  #Creating a new hash with weapon information
	  weapon_outputs[key] = {
	  	damage_per_second: value[:damage]/value[:swing_speed],
	  	total_swings_per_stamina_bar: player[:stamina]/value[:stamina_cost],
	  	#Room left to wear armour and be able to fast roll (25% of equip weight lets the player move fast)
	  	leftover_weight_for_armour_to_fast_roll: (player[:equip_load] * 0.25) - value[:weight],
	  	#Room left to wear armour and be able to medium speed roll (50% of equip weight lets the player move medium speed)
	  	leftover_weight_for_armour_to_medium_roll: (player[:equip_load] * 0.50) - value[:weight],
	  	#Room left to wear armour and be able to slow roll (100% of equip weight lets the player move at slow speed)
	  	leftover_weight_for_armour_to_slow_roll: (player[:equip_load] * 1.00) - value[:weight],
	  }
	end

  weapon_outputs.each do |x|
	  #Prettifying the weapon outputs for easier reading
    puts x
    puts " "
  end 
weapons = {

  longsword: { damage: 80, swing_speed: 0.5, length: 3,   stamina_cost: 25, weight: 4},
  
  dagger: {damage: 56, swing_speed: 0.25, length: 1, stamina_cost: 7, weight: 1},
}


weapons_damage_per_second = Hash.new

weapons.each do |key, value|
  #pushing these results onto the new hash
  weapons_damage_per_second[key] = value[:damage]/value[:swing_speed]
end

puts weapons_damage_per_second
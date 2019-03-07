player = {
  health: 250.0,
  stamina: 100.0,
  equip_max: 75.0,
}

weapons_output = Hash.new

temp = 0

#from the raw data, creating a hash of weapon names with their damage characteristics

for x in weapons
  # <=25% of equip load yields fast roll, >25% to <=50% yields medium roll, >50% to <=75% yields slow roll
  leftover_weight_for_armour_to_fast_roll = player[:equip_max] * 0.25 - x[:weight].to_f
  leftover_weight_for_armour_to_med_roll = player[:equip_max] * 0.50 - x[:weight].to_f
  leftover_weight_for_armour_to_fat_roll = player[:equip_max] * 1.00 - x[:weight].to_f
  #reqs_sum is the sum of the integers of strength, dexterity, faith, and intelligence required to wield the weapon
  reqs_sum = 0
  #Of this weapon, iterate through the stat requirements for it
  for y in x[:req]
    reqs_sum = reqs_sum + y[1]
  end
  #Outputting all of the data onto an output hash
  weapons_output.merge!(x[:name] => {"atk" => x[:atk], "weight" => x[:weight], "reqs_sum" => reqs_sum, "to_fast_roll" => leftover_weight_for_armour_to_fast_roll, "to_med_roll" => leftover_weight_for_armour_to_med_roll, "to_slow_roll" => leftover_weight_for_armour_to_fat_roll})
end

puts " "

#Example
puts weapons_output["Lucerne"]
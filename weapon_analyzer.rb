player = {
  health: 250.0,
  stamina: 100.0,
  equip_max: 100.0,
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

weapons_max = Hash.new
max_damage = 0
max_bonus = 0
max_magic = 0
# This code block runs find max algorithms on the weapons and puts the maxes on a new hash call 'weapons_max'
for key, value in weapons_output
  #Max physical damage onto a hash
  if value["atk"][:physical] > max_damage
    max_damage = value["atk"][:physical]
    weapons_max.merge!("highest_damage_physical" => { "name" => key, "amount" => max_damage})
  end
    #Max magic damage and putting it onto hash
  if value["atk"][:magic] > max_magic
    max_magic = value["atk"][:magic]
    weapons_max.merge!("highest_damage_magic" => {"name" => key, "amount" => max_magic})
  end
  #Max bonus (critical hit multiplier) and putting it onto a hash
  if value["atk"][:bonus] > max_bonus
    max_bonus = value["atk"][:bonus]
    weapons_max.merge!("highest_bonus" => {"name" => key, "amount" => max_bonus})
  end
end

#Example
puts weapons_output["Lucerne"]
puts " "
puts weapons_max.inspect

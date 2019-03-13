####Some of the raw weapon data 'weight' has 0 or nil values.  This creates conflicts.  To solve this I have to.
# 1. Give the 0 or nil values a value of '0.5' (a float) which is close to the actual weight in the video game.

for x in weapons
  if x[:weight] == nil || x[:weight] < 1
    x[:weight] = 0.5
  end
end
#############################

player = {
  health: 250.0,
  stamina: 100.0,
  equip_max: 100.0,
}

weapons_output = Hash.new

#from the raw data, creating a hash of weapon names with their damage characteristics
for x in weapons
  weight = x[:weight]
  #pre_reqs_sum is the sum of the integers of strength, dexterity, faith, and intelligence required to wield the weapon
  pre_reqs_sum = 0
  
  # <=25% of equip load yields fast roll, >25% to <=50% yields medium roll, >50% to <=75% yields slow roll
  leftover_weight_for_armour_to_fast_roll = player[:equip_max] * 0.25 - x[:weight].to_f
  leftover_weight_for_armour_to_med_roll = player[:equip_max] * 0.50 - x[:weight].to_f
  leftover_weight_for_armour_to_fat_roll = player[:equip_max] * 1.00 - x[:weight].to_f

  #Of this weapon, iterate through the stat requirements for it and sum them
  for y in x[:req]
    pre_reqs_sum = pre_reqs_sum + y[1]
  end

  bonus = x[:atk][:bonus]
  x[:atk].delete(:bonus)

  #Getting combined damage.  Combined damage is combining physical and elemental damage
  combined_damage = 0
  for key, value in x[:atk]
    combined_damage = combined_damage + value
  end
  
  dmg_per_weight = combined_damage / weight
  
  #Outputting all of the data onto an output hash
  weapons_output.merge!(x[:name] => {"atk" => x[:atk], "dmg_per_weight" => dmg_per_weight, "bonus" => bonus, "weight" => weight, "pre_reqs_sum" => pre_reqs_sum, "to_fast_roll" => leftover_weight_for_armour_to_fast_roll, "to_med_roll" => leftover_weight_for_armour_to_med_roll, "to_slow_roll" => leftover_weight_for_armour_to_fat_roll})

end

# Running find max algorithms on all of the weapons
weapons_max = Hash.new
max_damage = 0
max_bonus = 0
max_magic = 0
max_fire = 0
max_lightning = 0
max_dmg_per_weight = 0
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
  #finding max fire fire damage
  if value["atk"][:fire] > max_fire
    max_fire = value["atk"][:fire]    
    weapons_max.merge!("highest_damage_fire" => {"name" => key, "amount" => max_fire})
  end
  #finding max lightning damage weapon
  if value["atk"][:lightning] > max_lightning
    max_lightning = value["atk"][:lightning]    
    weapons_max.merge!("highest_damage_lightning" => {"name" => key, "amount" => max_lightning})
  end
  #Max bonus (critical hit multiplier) and putting it onto a hash
  if value["bonus"] > max_bonus
    max_bonus = value["bonus"]    
    weapons_max.merge!("highest_bonus" => {"name" => key, "amount" => max_bonus})
  end

  if value["dmg_per_weight"] > max_dmg_per_weight
    max_dmg_per_weight = value["dmg_per_weight"]    
    weapons_max.merge!("max_dmg_per_weight" => {"name" => key, "amount" => max_dmg_per_weight})
  end
end

for x in weapons_output
 puts x
 puts " "
end

puts weapons_max

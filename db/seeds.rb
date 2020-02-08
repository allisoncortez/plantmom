#Demo 2 users

allison = User.create(username: "Allison", email: "allizetorc@gmail.com", password: "password1")
barb = User.create(username: "Barbara", email: "barb@gmail.com", password: "password2") 

Plant.create(name:"Sunflower", description: "plant description here. Requires lots of light. Water twice a week.", care_level:"medium", user_id: allison.id)


#use AR to pre-associate data 
allison.plants.create(name:"Flower", description: "plant description here.", care_level:"minimal")


barbs_first_plant = barb.plants.build(name:"Sad Plant", description: "plant description here.", care_level:"expert")
barbs_first_plant.save



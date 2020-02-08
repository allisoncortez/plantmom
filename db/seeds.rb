#Demo 2 users

allison = User.create(username: "Allison", email: "allizetorc@gmail.com", password: "password1")
barb = User.create(username: "Barbara", email: "barb@gmail.com", password: "password2") 

Plant.create(name:"name", soil:"brown and grainy", sun_light: "a lot", water:"2 times a month, 1 teaspoon", user_id: allison.id)

allisons_first_plant = allison.plants.build(name: "dead_plant")



# t.string "name"
#     t.string "soil"
#     t.string "sun_light"
#     t.string "water"
#     t.integer "user_id"
#     t.datetime "created_at", null: false
#     t.datetime "updated_at", null: false
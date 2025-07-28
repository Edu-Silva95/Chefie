# Clear previous data
Favorite.destroy_all
Recipe.destroy_all
User.destroy_all

# Create users
users = [
  User.create!(email: "chef1@example.com", password: "password", username: "ChefOne"),
  User.create!(email: "chef2@example.com", password: "password", username: "ChefTwo")
]

# Categories and some sample titles
recipes_data = [
  {
    title: "Margherita Pizza",
    category: "Pizza",
    description: "Classic Neapolitan-style pizza with fresh mozzarella and basil.",
    ingredients: "Pizza dough, tomato sauce, fresh mozzarella, fresh basil, olive oil, salt",
    instructions: "1. Preheat oven to 250°C (480°F). 2. Roll out dough and spread tomato sauce. 3. Add mozzarella slices and basil leaves. 4. Drizzle with olive oil and bake for 10-12 minutes.",
    prep_time: "25 minutes"
  },
  {
    title: "Chocolate Lava Cake",
    category: "Dessert",
    description: "Rich molten chocolate center with a soft outer cake.",
    ingredients: "Dark chocolate, butter, eggs, sugar, flour, vanilla extract",
    instructions: "1. Melt chocolate and butter. 2. Whisk in eggs and sugar. 3. Fold in flour and vanilla. 4. Pour into ramekins and bake for 12 minutes at 200°C (390°F).",
    prep_time: "30 minutes"
  },
  {
    title: "Spicy Ramen",
    category: "Noodle",
    description: "Japanese-style noodles in spicy miso broth.",
    ingredients: "Ramen noodles, chicken broth, miso paste, chili oil, garlic, green onions, egg",
    instructions: "1. Boil broth and add miso paste and chili oil. 2. Cook noodles separately. 3. Assemble noodles and broth in bowl. 4. Top with soft-boiled egg and chopped green onions.",
    prep_time: "20 minutes"
  },
  {
    title: "Mojito",
    category: "Cocktails",
    description: "Refreshing cocktail with mint, lime, and rum.",
    ingredients: "White rum, fresh mint, lime juice, sugar, soda water, ice",
    instructions: "1. Muddle mint with sugar and lime juice. 2. Add rum and ice. 3. Top with soda water and stir.",
    prep_time: "5 minutes"
  },
  {
    title: "Caesar Salad",
    category: "Salad",
    description: "Crisp romaine lettuce with creamy dressing and croutons.",
    ingredients: "Romaine lettuce, Caesar dressing, croutons, parmesan cheese, black pepper",
    instructions: "1. Toss lettuce with dressing. 2. Top with croutons and shaved parmesan. 3. Sprinkle with pepper and serve.",
    prep_time: "10 minutes"
  },
  {
    title: "Tiramisu",
    category: "Dessert",
    description: "Layered Italian dessert with coffee-soaked ladyfingers.",
    ingredients: "Mascarpone, ladyfingers, espresso, sugar, eggs, cocoa powder",
    instructions: "1. Dip ladyfingers in espresso. 2. Layer with mascarpone mixture. 3. Repeat and chill for 4 hours. 4. Dust with cocoa before serving.",
    prep_time: "30 minutes + chilling"
  },
  {
    title: "Pesto Pasta",
    category: "Noodle",
    description: "Linguine tossed in a homemade basil pesto sauce.",
    ingredients: "Linguine, basil, garlic, pine nuts, parmesan, olive oil, salt",
    instructions: "1. Blend basil, garlic, pine nuts, and cheese with olive oil. 2. Cook pasta and toss with pesto. 3. Serve warm.",
    prep_time: "20 minutes"
  },
  {
    title: "Strawberry Daiquiri",
    category: "Cocktails",
    description: "Frozen cocktail with strawberries and lime.",
    ingredients: "Frozen strawberries, white rum, lime juice, sugar, ice",
    instructions: "1. Blend all ingredients until smooth. 2. Serve in chilled glasses.",
    prep_time: "5 minutes"
  },
  {
    title: "Greek Salad",
    category: "Salad",
    description: "Feta cheese, olives, and vegetables in olive oil dressing.",
    ingredients: "Cucumber, tomato, red onion, feta cheese, Kalamata olives, olive oil, oregano",
    instructions: "1. Chop vegetables. 2. Combine in bowl with olives and feta. 3. Drizzle with olive oil and sprinkle with oregano.",
    prep_time: "10 minutes"
  },
  {
    title: "Pepperoni Pizza",
    category: "Pizza",
    description: "Loaded with spicy pepperoni and bubbling mozzarella.",
    ingredients: "Pizza dough, tomato sauce, mozzarella, pepperoni slices, oregano",
    instructions: "1. Preheat oven to 250°C (480°F). 2. Roll out dough and add sauce. 3. Top with cheese and pepperoni. 4. Bake for 12-15 minutes.",
    prep_time: "25 minutes"
  }
]

# Create recipes, assigning each to a random user
recipes_data.each do |data|
  Recipe.create!(
    title: data[:title],
    description: data[:description],
    category: data[:category],
    user: users.sample
  )
end

puts "✅ Seeded #{User.count} users and #{Recipe.count} recipes."

# seeds.exs

# Define a list of seed files to be executed in order
seed_files = [
  "priv/repo/seeds/seed_products.ex",
  "priv/repo/seeds/seed_categories.ex",
  "priv/repo/seeds/seed_products_categories.ex",
  "priv/repo/seeds/seed_products_recommendations.ex",
  "priv/repo/seeds/seed_accounts.ex",
  "priv/repo/seeds/seed_featured_products.ex"
]

# Iterate over the seed files and run each one
Enum.each(seed_files, fn seed_file ->
  IO.puts("Running seed file: #{seed_file}")
  Code.eval_file(seed_file)
end)

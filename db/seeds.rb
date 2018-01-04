require 'csv'

FEELINGS_WORDS_FILE = Rails.root.join('db','seed_data','feelings_words.csv')
puts "Loading raw media data from #{MERCHANT_FILE}"

merchant_failures = []
CSV.foreach(FEELINGS_WORDS_FILE) do |row|
  merchant = Merchant.new
  merchant.name = row['name']
  merchant.username = row['username']
  merchant.email = row['email']
  merchant.provider = row['provider']
  merchant.uid = row['uid']
  puts "Created merchant: #{merchant.inspect}"
  successful = merchant.save
  if !successful
    merchant_failures << merchant
  end
end

puts "Added #{Merchant.count} merchant records"
puts "#{merchant_failures.length} merchants failed to save"

# CATEGORIES #

CATEGORY_FILE = Rails.root.join('db','seed_data','categories.csv')
puts "Loading raw media data from #{CATEGORY_FILE}"

category_failures = []
CSV.foreach(CATEGORY_FILE, :headers => true) do |row|
  category = Category.new
  category.name = row['name']
  puts "Created category: #{category.inspect}"
  successful = category.save
  if !successful
    category_failures << category
  end
end

puts "Added #{Category.count} category records"
puts "#{category_failures.length} categories failed to save"

require 'csv'

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


FEELINGS_WORDS_FILE = Rails.root.join('db','seed_data','feelings.csv')
puts "Loading raw media data from #{FEELINGS_WORDS_FILE}"

feeling_failures = []
CSV.foreach(FEELINGS_WORDS_FILE, :headers => true) do |row|
  feeling = Feeling.new
  feeling.name = row['word']
  feeling.category_id = row['category']
  feeling.rating = row['rating']
  puts "Created feeling: #{feeling.inspect}"
  successful = feeling.save
  if !successful
    feeling_failures << feeling
  end
end

puts "Added #{Feeling.count} new feelings"
puts "#{feeling_failures.length} feelings failed to save"

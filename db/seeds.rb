# Create categories
categories_title = ['Mobile development', 'Photo', 'Web design']
categories_title.each do |title|
  category = FactoryBot.create(:category, title: title)
  10.times { FactoryBot.create(:book, category: category) }
end

puts 'All seeds are create!'

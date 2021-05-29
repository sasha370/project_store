# Create categories
admin = User.create(first_name: 'Alex', phone: '+79063682969', email: 'budka52@bk.ru', password: 'A123456a',
                    password_confirmation: 'A123456a', role: 2, confirmed_at: DateTime.now)
users = FactoryBot.create_list(:user, 3)
categories_title = ['Mobile development', 'Photo', 'Web design']
categories_title.each do |title|
  category = FactoryBot.create(:category, title: title)
  15.times { FactoryBot.create(:project, category: category, user: users.sample) }
end

usual_user = User.create(first_name: 'Alex', phone: '+7906368000', email: 'kng.sasha@mail.ru', password: 'A123456a',
                         password_confirmation: 'A123456a', confirmed_at: DateTime.now)

puts 'All seeds are create!'

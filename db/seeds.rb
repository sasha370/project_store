# Create categories
admin = User.create(first_name: 'Alex', phone: '+79063682969', email: 'budka52@bk.ru', password: 'A123456a',
                    password_confirmation: 'A123456a', role: 2, confirmed_at: DateTime.now)
not_admin = User.create(first_name: 'Alex', phone: '+79063682969', email: 'kng.sasha@mail.ru', password: 'A123456a',
                    password_confirmation: 'A123456a', role: 0, confirmed_at: DateTime.now)
users = FactoryBot.create_list(:user, 3)
categories_title = ['Mobile development', 'Photo', 'Web design']
categories_title.each do |title|
  category = FactoryBot.create(:category, title: title)
  15.times { FactoryBot.create(:project, category: category, status: :published) }
  3.times { FactoryBot.create(:project, category: category, status: :newest) }
end

5.times do
  order = Order.create!(user: admin, status: :paid)
  order.projects << Project.take(5)
end


puts 'All seeds are create!'

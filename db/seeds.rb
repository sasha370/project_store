# Users
admin = User.create(first_name: 'Alex', phone: '+79063682969', email: 'budka52@bk.ru', password: 'A123456a',
                    password_confirmation: 'A123456a', role: 2, confirmed_at: DateTime.now)
not_admin = User.create(first_name: 'Alex', phone: '+79063682969', email: 'kng.sasha@mail.ru', password: 'A123456a',
                        password_confirmation: 'A123456a', role: 0, confirmed_at: DateTime.now)
users = FactoryBot.create_list(:user, 3)

#Projects
categories_title = ['Mobile development', 'Photo', 'Web design']
categories_title.each do |title|
  category = FactoryBot.create(:category, title: title)
  15.times { FactoryBot.create(:project, category: category, status: :published) }
  3.times { FactoryBot.create(:project, category: category, status: :newest) }
end

#Orders
5.times do
  order = Order.create!(user: admin, status: :paid)
  order.projects << Project.take(5)
end

#Payment
json = {
  operation_id: '1234567',
  notification_type: 'p2p-incoming',
  datetime: '2011-07-01T09:00:00.000+04:00',
  sha1_hash: 'f47d3fc727bdfd1fa1815b85426ce0041c54aeca',
  sender: '41001XXXXXXXX',
  codepro: false,
  currency: 643,
  amount: '300.99', # to_json cuts last symbol if float with .00
  withdraw_amount: 1.00,
  label: '1'
}
FactoryBot.create(:payment,
                  operation_id: json[:operation_id],
                  processed_at: json[:datetime],
                  metadata: json,
                  order: Order.first,
                  status: 10)

puts 'All seeds are create!'

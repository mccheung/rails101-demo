puts 'Hello World!'
puts "這個種子檔會自動建立一個帳號, 並且創建 20 個 groups, 每個 group 各 30 個 posts"

create_account = User.create([email: 'example@gmail.com', password: '12345678', password_confirmation: '12345678', name: '測試用帳號'])

create_groups = for i in 1..20 do
    Group.create!([title: "Group no.#{i}", description: "這是用種子建立的第 #{i} 個討論版", user_id: "1"])
    GroupUser.create(group_id: i, user_id: 1)
    for k in 1..30 do
        Post.create!([group_id: "#{i}",content: "這是用種子建立的第 #{k} 個留言", user_id: "1"])
    end
end

User.create!(
  [
    { name: 'まさや', email: 'user1@test.com', password: 'password' },
    { name: 'さとう', email: 'user2@test.com', password: 'password' },
    { name: 'タツヤ', email: 'user3@test.com', password: 'password' },
    { name: 'miko', email: 'user4@test.com', password: 'password' },
    { name: 'eri', email: 'user5@test.com', password: 'password' },
    { name: 'ダイチ', email: 'user6@test.com', password: 'password' },
    { name: 'とみえ', email: 'user7@test.com', password: 'password' },
    { name: '加藤', email: 'user8@test.com', password: 'password' },
    { name: 'えーいち', email: 'user9@test.com', password: 'password' },
    { name: 'かずのり', email: 'user10@test.com', password: 'password' },
  ]
)

10.times do |n|
  user = User.find(n + 1)
  user.avatar.attach(io: File.open("app/assets/images/sample#{n + 1}.jpg"), filename: "sample#{n + 1}.jpg")
end

Post.create!([
  { learning_language: 'Ruby', memo: '配列の勉強をしました！', learned_time: rand(60..700), user_id: rand(1..10) },
  { learning_language: 'JavaScript', memo: 'funcitonの学習', learned_time: rand(60..700), user_id: rand(1..10) },
  { learning_language: 'Python', memo: 'もくもく会に参加！', learned_time: rand(60..700), user_id: rand(1..10) },
  { learning_language: 'Go', memo: '最近のトレンド', learned_time: rand(60..700), user_id: rand(1..10) },
  { learning_language: 'PHP', memo: '今日は捗った！', learned_time: rand(60..700), user_id: rand(1..10) },
  { learning_language: 'Swift', memo: 'Swiftむずい(汗)', learned_time: rand(60..700), user_id: rand(1..10) },
  { learning_language: 'C++', memo: '今日の積み上げ', learned_time: rand(60..700), user_id: rand(1..10) },
  { learning_language: 'Ruby', memo: '今日の積み上げ', learned_time: rand(60..700), user_id: rand(1..10) },
  { learning_language: 'Java', memo: '今日の積み上げ', learned_time: rand(60..700), user_id: rand(1..10) },
  { learning_language: 'Ruby', memo: '今日の積み上げ', learned_time: rand(60..700), user_id: rand(1..10) },
  { learning_language: 'Ruby', memo: 'Arryの学習', learned_time: rand(60..700), user_id: rand(1..10) },
  { learning_language: 'Ruby', memo: 'みんながんばろー！', learned_time: rand(60..700), user_id: rand(1..10) },
  { learning_language: 'Kotlin', memo: 'プログラミング難しい(泣)', learned_time: rand(60..700), user_id: rand(1..10) },
  { learning_language: 'Kotlin', memo: '勉強！', learned_time: rand(60..700), user_id: rand(1..10) },
  { learning_language: 'Scala', memo: '今日はがんばった！', learned_time: rand(60..700), user_id: rand(1..10) },
  { learning_language: 'Scala', memo: '三度の飯より勉強', learned_time: rand(60..700), user_id: rand(1..10) },
  { learning_language: 'JavaScript', memo: '彼女より勉強！', learned_time: rand(60..700), user_id: rand(1..10) },
  { learning_language: 'JavaScript', memo: 'がんばりました！', learned_time: rand(60..700), user_id: rand(1..10) },
  { learning_language: 'JavaScript', memo: 'memo', learned_time: rand(60..700), user_id: rand(1..10) },
  { learning_language: 'Python', memo: 'もくもく会に参加', learned_time: rand(60..700), user_id: rand(1..10) },
  { learning_language: 'Python', memo: 'もくもく会に参加', learned_time: rand(60..700), user_id: rand(1..10) },
  { learning_language: 'Python', memo: '今日の積み上げ', learned_time: rand(60..700), user_id: rand(1..10) },
  { learning_language: 'Python', memo: '今日の積み上げ', learned_time: rand(60..700), user_id: rand(1..10) },
  { learning_language: 'Python', memo: '今日の積み上げ', learned_time: rand(60..700), user_id: rand(1..10) },
  { learning_language: 'Ruby', memo: 'youtubeやってます！', learned_time: rand(60..700), user_id: rand(1..10) },
  { learning_language: 'Ruby', memo: 'フォロー！よろしく', learned_time: rand(60..700), user_id: rand(1..10) },
  { learning_language: 'Ruby', memo: 'いいね！してね！', learned_time: rand(60..700), user_id: rand(1..10) },
  { learning_language: 'C#', memo: '今日の積み上げ', learned_time: rand(60..700), user_id: rand(1..10) },
  { learning_language: 'C#', memo: '初学者と繋がりたい', learned_time: rand(60..700), user_id: rand(1..10) },
  { learning_language: 'Ruby', memo: '初学者と繋がりたい', learned_time: rand(60..700), user_id: rand(1..10) },
])

10.times do |n|
  Like.create!(post_id: rand(20..30), user_id: n + 1)
end

Comment.create!([
  { body: 'ナイスファイト！', user_id: rand(1..10), post_id: 30 },
  { body: 'すごい！', user_id: rand(1..10), post_id: 30 },
  { body: 'いつも元気をもらってます！', user_id: rand(1..10), post_id: 30 },
  { body: 'その言語難しいよね＞＜', user_id: rand(1..10), post_id: 30 },
  { body: 'おつ〜', user_id: rand(1..10), post_id: 30 },
  { body: '明日もがんばろう！', user_id: rand(1..10), post_id: 29 },
  { body: 'もっとやれるはず！！', user_id: rand(1..10), post_id: 29 },
  { body: 'さすが！', user_id: rand(1..10), post_id: 29 },
  { body: 'おつかれー！', user_id: rand(1..10), post_id: 28 },
  { body: '神！', user_id: rand(1..10), post_id: 28 },
  { body: '明日はもっとやれるはず！', user_id: rand(1..10), post_id: 28 },
  { body: '拙者も頑張ります！', user_id: rand(1..10), post_id: 28 },
  { body: 'がんばりすぎて草', user_id: rand(1..10), post_id: 27 },
  { body: 'その言語大変だよね(汗)', user_id: rand(1..10), post_id: 27 },
  { body: 'はんぱねぇ。。。。', user_id: rand(1..10), post_id: 27 },
  { body: 'グッジョブ！！', user_id: rand(1..10), post_id: 26 },
  { body: '体には気をつけて＞＜', user_id: rand(1..10), post_id: 26 },
  { body: 'youtubeにも参考になる情報がありますよ！', user_id: rand(1..10), post_id: 25 },
  { body: 'いつも応援してます！', user_id: rand(1..10), post_id: 25 },
])

# user_a = User.find(1)
# user_b = User.find(2)

# 8.times do |n|
  # Follow_relationship.create!(following_id: user_a.id, follower_id: user_b.id)
# end

# Follow_relationship.create!(
#   follower_id: 1, follower_id: 2
# )
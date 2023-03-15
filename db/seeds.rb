Admin.create!(
   email: 'admin@example.com',
   password: '123456'
)

users = User.create!(
  [
    {email: 'nakamura@test.com', name: '中村', password: '123456', introduction: '建築写真を撮るのが好きです！' ,profile_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-user1.jpg"), filename: "sample-user1.jpg")},
    {email: 'tanaka@test.com', name: '田中', password: '123456', introduction: 'フォローお願いします' },
    {email: 'sato@test.com', name: '佐藤', password: '123456'}
  ]
)

Post.create!(
  [
    {architecture: '日本平夢テラス', architect: '隈研吾', address: '静岡県静岡市清水区草薙600-1', body: '県産木材を使い、富士山を望む自然景観と調和した設計', post_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post1.jpg"), filename: "sample-post1.jpg"), user_id: users[0].id },
    {architecture: '直島ホール', architect: '三分一博志', address: '香川県香川郡直島町696-1', body: '太陽光・風・地下水等の自然エネルギーを活用した建築', post_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post2.jpg"), filename: "sample-post2.jpg"), user_id: users[1].id },
    {architecture: '神勝寺 禅と庭のミュージアム', architect: '名和晃平', address: '広島県福山市沼隈町大字上山南01', body: '伝統的なこけら葺を応用し、全体を木材で包んだ船型の建物', post_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post3.jpg"), filename: "sample-post3.jpg"), user_id: users[2].id }
  ]
)


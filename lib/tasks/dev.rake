task sample_data: :environment do
  p "Creating sample data"

  if Rails.env.development? 
    FollowRequest.destroy_all
    Photo.destroy_all
    Comment.destroy_all
    Like.destroy_all
    User.destroy_all
   
  end

  usernames = Array.new {Faker::Name.first_name}

  usernames << "alice"
  usernames << "bob"

  usernames.each do |username|
    User.create(
    email: "#{username}@example.com",
    password: "password",
    username: username.downcase,
    private: [true,false].sample
  )
  end

  10.times do
    # p fake_username = Faker::Name.name
    # p fake_email = Faker::Internet.email
    #  p fake_password = [rand(6),rand(6),rand(6),rand(6),rand(6),rand(6)]
    #   fake_user = User.new
    #   fake_user.username = fake_username
    #   fake_user.email = fake_email
    #   fake_user.password = fake_password
    #   fake_user.private = true
    #   fake_user.save

        name = Faker::Name.first_name.downcase
        user = User.create(
          email: "#{name}@example.com",
          username: name,
          password: "password",
          private: [true,false].sample
        )

      # u.errors.full_messages
  end

  # user = User.first
  # user.photos.create(caption: Faker::Movie.title, image: "https://picsum.photos/200/300")

  # p user.photo.caption


  users = User.all

  users.each do |first_user|
    users.each do |second_user|
      if rand < 0.75
        first_user.sent_follow_requests.create(
          recipient: second_user,
          status: FollowRequest.statuses.keys.sample)
      end

      if rand < 0.75
        second_user.sent_follow_requests.create(
          recipient: first_user,
          status: FollowRequest.statuses.keys.sample)
      end
    end
  end

  10.times do 
  users.each do |user|
    photo = user.own_photos.create(
    caption: Faker::Movies::Departed.quote,
    image: "https://robohash.org/#{rand(999)}"
    )

    user.followers.each do |follower|

      if rand < 0.5
        # photo.fans << follower
        photo.likes.create(
          fan: follower
        )
      end

      if rand < 0.3
      photo.comments.create(
        body: Faker::TvShows::Friends.quote,
        author: follower
      )
      end

     
    end
    end
  end
 

  p "#{User.count} users have been created"
  p "#{FollowRequest.count} follow requests have been created"
  p "#{Like.count} likes have been created"
  p "#{Photo.count} photos have been created"
  p "#{Comment.count} comments have been created"


end
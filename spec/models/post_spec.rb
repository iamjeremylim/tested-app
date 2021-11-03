require 'rails_helper'

RSpec.describe Post, type: :model do
  current_user = User.first_or_create!(email: 'hello@world.com', password: '123456', password_confirmation: '123456')

  it 'has a title' do
    post = Post.new(
      title: '',
      body: 'This is a body',
      user: current_user,
      views: 0
    )

    expect(post).to_not be_valid     # because title presence false

    post.title = 'This is a title'
    expect(post).to be_valid         # because title presence true
  end

  it 'has a body' do
    post = Post.new(
      title: 'This is a title',
      body: '',
      user: current_user,
      views: 0
    )

    expect(post).to_not be_valid     # because body presence false

    post.body = 'This is a body'
    expect(post).to be_valid         # because body presence true
  end

  it 'has a title at least 2 characters long' do
    post = Post.new(
      title: 'T',
      body: 'This is a body',
      user: current_user,
      views: 0
    )

    expect(post).to_not be_valid     # because title is not at least 2 char long

    post.title = 'This is a title'
    expect(post).to be_valid         # because title is at least 2 char long
  end

  it 'has a body of at least 5 characters' do
    post = Post.new(
      title: 'Title',
      body: 'Body',
      user: current_user,
      views: 0
    )

    expect(post).to_not be_valid     # because body is not at least 5 char long

    post.body = 'A Body'
    expect(post).to be_valid         # because body is at least 5 char long
  end

  it 'has a body of at most 100 characters' do
    post = Post.new(
      title: 'Title',
      body: 'iILu4s7FNnryR7I4uqIfTDahXh2XMr3Ysu2R2FQKHA1HdCjJTMeq6nZKVBhe5b5PEC93NLEZQExgj3lfW5BB9KFOtllPB6QV80S8d',
      user: current_user,
      views: 0
    )

    expect(post).to_not be_valid     # because body is 101 char long

    post.body = 'DKImRsmH9F64Zn5z4pKvY78orU0sZ9y2MsxEBlaeQedgcCE1By1Pld1oMJVtahND7bLyrY0uGodPU2dmGo8LGzCwUirYZpfAT037'
    expect(post).to be_valid         # because body is 100 char long
  end

  it 'has numerical views' do
    post = Post.new(
      title: 'A Valid Title',
      body: 'A Valid Body',
      user: current_user,
      views: 0
    )

    expect(post.views).to be_a(Integer)
  end
end

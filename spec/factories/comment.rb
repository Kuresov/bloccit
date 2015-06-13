FactoryGirl.define do
  factory :comment do
    body "This is a new comment."
    user
    post

    default_scope { order('updated_at DESC') }

    after(:build) do |comment|
      comment.class.skip_callback(:create, :after, :send_favorite_emails)
    end
  end
end

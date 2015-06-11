class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable
  has_many :posts
  has_many :comments
  has_many :votes, dependent: :destroy
  has_many :favorites, dependent: :destroy
  mount_uploader :avatar, AvatarUploader

  def favorited(post)
    favorites.where(post_id: post.id).first
  end

  def voted(post)
    votes.where(post_id: post.id).first
  end

  def admin?
    role == 'admin'
  end

  def moderator?
    role == 'moderator'
  end

  def self.top_rated
    self.select('users.*') # Select all attribs of user
        .select('COUNT(DISTINCT comments.id) AS comments_count') # Count comments by the user
        .select('COUNT(DISTINCT posts.id) AS posts_count') # Count posts by the user
        .select('COUNT(DISTINCT comments.id) + COUNT(DISTINCT posts.id) AS rank') # Add posts count and comments count and label the sum as 'rank'
        .joins(:posts) # Ties posts table to users table via user_id
        .joins(:comments) # Ties comments to users table via user_id
        .group('users.id') # Group results, so each user will be returned in a distinct row
        .order('rank DESC') # Order results by 'rank' created in this function
  end
end

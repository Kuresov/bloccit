class FavoriteMailer < ApplicationMailer
  default from: "admin@bloccit.com"

  def new_comment(user, post, comment)
    #New Headers
    headers["Message-ID"] = "<comments/#{comment.id}@kuresov-bloccit.com>"
    headers["In-Reply-To"] = "<post/#{post.id}@kuresov-bloccit.com>"
    headers["References"] = "<post/#{post.id}@kuresov-bloccit.com>"

    @user = user
    @post = post
    @comment = comment

    mail(to: user.email, subject: "New comment on #{post.title}")
  end
end

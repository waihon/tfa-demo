module UsersHelper
  def profile_image_for(user)
    image_url = "https://secure.gravatar.com/avatar/#{user.gravatar_id}"
    image_tag image_url, alt: user.name, id: "profile-image", class: "img-thumbnail"
  end
end

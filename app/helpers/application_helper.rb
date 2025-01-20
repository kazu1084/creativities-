module ApplicationHelper
  def avator_for(user, size: "mini")
    image_tag user.profile.image
  end
end

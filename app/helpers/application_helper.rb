module ApplicationHelper
  def avator_for(user, size: "mini")
    image_tag user.icon_image
  end
end

module Slug

  def slug
    username.downcase.gsub(" ", "-")
  end
end
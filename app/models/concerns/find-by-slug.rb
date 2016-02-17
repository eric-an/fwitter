module FindBySlug

  def find_by_slug(slug)
    self.all.find{ |user| user.slug == slug }
  end
end
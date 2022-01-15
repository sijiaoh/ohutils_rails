module PostsHelper
  def copy_protect_class(post)
    return "" if policy(post).edit? || !post.copy_protect?

    "select-none print:hidden"
  end
end

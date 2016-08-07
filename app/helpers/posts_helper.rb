module PostsHelper

  def list_relating_subforums(post)
    post
      .subs
      .map { |subforum| link_to subforum.title, sub_url(subforum) }
      .join(", ")
      .html_safe
  end
  
end

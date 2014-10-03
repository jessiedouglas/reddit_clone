module ApplicationHelper
  def auth_token
    <<-HTML.html_safe
      <input
        type="hidden"
        name="authenticity_token"
        value="#{form_authenticity_token}">
    HTML
  end

  # def child_comment_display(comment)
#     <<-HTML.html_safe
#       <ul>
#         #{comment.child_comments.each do |comment|}
#         <li>#{comment.content}<br>
#           \t\t\tposted by #{comment.author.username} at #{comment.created_at}<br>
#           child_comment_display(comment)</li>
#         #{end}
#       </ul>
#       HTML
#   end
end

# == Schema Information
#
# Table name: comments
#
#  id         :integer          not null, primary key
#  content    :text             not null
#  author_id  :integer          not null
#  post_id    :integer          not null
#  created_at :datetime
#  updated_at :datetime
#

class Comment < ActiveRecord::Base
  validates :author_id, :post_id, :content, presence: true

  belongs_to :author,
    class_name: "User",
    foreign_key: :author_id,
    inverse_of: :comments

  belongs_to :post, inverse_of: :comments

  belongs_to :parent_comment,
    class_name: "Comment",
    foreign_key: :parent_comment_id,
    inverse_of: :child_comments

  has_many :child_comments,
    class_name: "Comment",
    foreign_key: :parent_comment_id,
    inverse_of: :parent_comment
end


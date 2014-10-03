# == Schema Information
#
# Table name: posts
#
#  id         :integer          not null, primary key
#  title      :string(255)      not null
#  url        :string(255)
#  content    :text
#  author_id  :integer          not null
#  created_at :datetime
#  updated_at :datetime
#

class Post < ActiveRecord::Base
  validates :title, :author_id, presence: true

  has_many :subs, through: :post_subs, source: :sub

  has_many :post_subs, inverse_of: :post

  has_many :comments, inverse_of: :post

  belongs_to :author,
  class_name: "User",
  foreign_key: :author_id,
  inverse_of: :posts

  has_many :top_level_comments,
    -> {where(parent_comment_id: nil)},
    class_name: "Comment"
end

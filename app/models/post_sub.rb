# == Schema Information
#
# Table name: post_subs
#
#  id         :integer          not null, primary key
#  post_id    :integer
#  sub_id     :integer          not null
#  created_at :datetime
#  updated_at :datetime
#

class PostSub < ActiveRecord::Base
  validates :sub, :post, presence: true

  belongs_to :sub, inverse_of: :post_subs
  belongs_to :post, inverse_of: :post_subs

end

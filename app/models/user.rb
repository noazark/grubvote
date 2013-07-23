class User < ActiveRecord::Base
  authenticates_with_sorcery!

  has_many :invites
  has_many :grub_sessions, foreign_key: :inviter_id
  has_many :votes, through: :invites
end
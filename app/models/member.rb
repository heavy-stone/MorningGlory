class Member < ApplicationRecord
  has_secure_password

  has_many :entries, dependent: :destroy
  has_many :votes, dependent: :destroy
  has_many :voted_entries, through: :votes, source: :entry
  has_one_attached :profile_picture
  attribute :new_profile_picture
  attribute :remove_profile_picture, :boolean

  validates :number, presence: true,
    numericality: {
      only_integer: true,
      greater_than: 0,
      less_than: 100,
      allow_blank: true # presence: ture のメッセージとの重複を避けるため
    },
    uniqueness: true
  validates :name, presence: true,
    format: { with: /\A[A-Za-z0-9_-]*\z/, allow_blank: true, message: :invalid_member_name },
    length: { minimum: 4, maximum: 20, allow_blank: true },
    uniqueness: { case_sensitive: false } # 大文字小文字を区別しない
  validates :full_name, presence: true, length: { maximum: 20 }
  validates :email, email: { allow_blank: true } # メールアドレスは空でもよい

  attr_accessor :current_password
  validates :password, presence: { if: :current_password },
    format: { with: /\A[A-Za-z0-9#?!@$%^&*_-]*\z/, allow_blank: true, message: :invalid_password },
    length: { minimum: 8, maximum: 12, allow_blank: true }

  validate if: :new_profile_picture do
    if new_profile_picture.respond_to?(:content_type)
      unless new_profile_picture.content_type.in?(ALLOWED_CONTENT_TYPES)
        errors.add(:new_profile_picture, :invalid_image_type)
      end
    else
      errors.add(:new_profile_picture, :invalid)
    end

    if new_profile_picture.size > 10.megabytes
      errors.add(:new_profile_picture, :invalid_image_size)
    end
  end

  before_save do
    if new_profile_picture
      self.profile_picture = new_profile_picture
      # self.profile_picture.attach(new_profile_picture)
    elsif remove_profile_picture
      self.profile_picture.purge
    end
  end

  # ユーザが投票できるかどうか
  def votable_for?(entry)
    entry && entry.author != self && !votes.exists?(entry_id: entry.id)
  end

  # ユーザ検索
  class << self
    def search(query)
      rel = order("number")
      if query.present?
        query.strip_all_space!
        rel = rel.where("name LIKE ? OR full_name LIKE ?",
          "%#{query}%", "%#{query}%")
      end
    end
  end
end

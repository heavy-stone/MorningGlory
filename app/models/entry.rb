class Entry < ApplicationRecord
  belongs_to :author, class_name: "Member", foreign_key: "member_id"
  has_many :images, class_name: "EntryImage"
  has_many :votes, dependent: :destroy
  has_many :voters, through: :votes, source: :member

  STATUS_VALUES = %w(draft member_only public)

  validates :title, presence: true, length: { maximum: 200 }
  validates :body, :posted_at, presence: true
  validates :status, inclusion: { in: STATUS_VALUES }
  validate :posted_at_check

  def posted_at_check
    if posted_at < Time.zone.local(2000, 1, 1, 0, 0, 0) || Time.zone.now.next_year < posted_at
      errors.add(:posted_at, :invalid_posted_at)
    end
  end

  scope :common, -> { where(status: "public") }
  # 公開と会員限定記事
  scope :published, -> { where("status <> ?", "draft") }
  # 公開と会員限定記事、または、その会員が書いた記事
  scope :full, -> (member) {
    where("status <> ? OR member_id = ?", "draft", member.id) }
  # 会員にはfull, 会員でない場合はcommon
  scope :readable_for, -> (member) { member ? full(member) : common }

  class << self
    def status_text(status)
      I18n.t("activerecord.attributes.entry.status_#{status}")
    end

    def status_options
      STATUS_VALUES.map { |status| [status_text(status), status] }
    end
  end
end

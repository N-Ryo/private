class DirectMessage < ApplicationRecord
  belongs_to :from, class_name: "User"
  belongs_to :to, class_name: "User"
  default_scope -> { order(created_at: :desc) }
  mount_uploader :picture, PictureUploader
  validates :from_id, presence: true
  validates :to_id, presence: true
  validates :message, presence: true, length: {maximum: 140}
  validate  :picture_size


  private

    # アップロードされた画像のサイズをバリデーションする
    def picture_size
      if picture.size > 5.megabytes
        errors.add(:picture, "should be less than 5MB")
      end
    end
end

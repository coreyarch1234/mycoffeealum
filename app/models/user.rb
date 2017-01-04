class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable
  mount_uploader :picture, PictureUploader
  validate  :picture_size, :tag_count
  enum role: [:student, :mentor, :staff]
  acts_as_taggable

  def self.search(search)
    if search
      search = search.downcase
      self.where("LOWER(first_name) LIKE ? or LOWER(last_name) LIKE ? or LOWER(title) LIKE ? or LOWER(description) LIKE ?", "%#{search}%","%#{search}%","%#{search}%","%#{search}%")
    else
      self.all
    end
  end

  private

    # Validates the size of an uploaded picture.
    def picture_size
      if picture.size > 5.megabytes
        errors.add(:picture, "should be less than 5MB")
      end
    end

    # Validates the size of an uploaded picture.
    def tag_count
      if tag_list.size > 5
        errors.add(:tag_list, "should be at most 5")
      end
    end
end

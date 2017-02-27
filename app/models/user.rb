class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

  #Mentor/Mentee Connections

  # source: :mentor matches with the belong_to :mentor identification in the Connection model
  has_many :mentor_connections, foreign_key: :mentee_id, class_name: "Connection", dependent: :destroy
  has_many :mentors, through: :mentor_connections, source: :mentor
  # mentor_connections "names" the Connection join table for accessing through the mentor association

  # source: :mentee matches with the belong_to :mentee identification in the Connection model
  has_many :mentee_connections, foreign_key: :mentor_id, class_name: "Connection", dependent: :destroy
  has_many :mentees, through: :mentee_connections, source: :mentee
  # mentor_connections "names" the Connection join table for accessing through the mentee association






  #Message System
  has_many :conversations, :foreign_key => :sender_id, dependent: :destroy

  #User attributes
  scope :role, -> (role) { where role: role }
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable
  mount_uploader :picture, PictureUploader
  validate  :picture_size, :tag_count
  validates :first_name, presence: true, length: { maximum: 20 }, :on => :update
  validates :last_name, presence: true, length: { maximum: 20 }, :on => :update
  validates :title, length: { maximum: 100 }
  validates :description, length: { maximum: 800 }
  VALID_LINKEDIN_REGEX = /|(?:(?:http|https):\/\/)?(?:www.)?linkedin.com\/in\/.*/
  validates :linkedin_url, format: { with: VALID_LINKEDIN_REGEX }
  enum role: [:student, :mentor, :alumni, :staff]
  acts_as_taggable

  def self.search(search)
    if search
      search = search.downcase
      self.where("LOWER(first_name) LIKE ? or LOWER(last_name) LIKE ? or LOWER(title) LIKE ? or LOWER(description) LIKE ?", "%#{search}%","%#{search}%","%#{search}%","%#{search}%")
    else
      self.all
    end
  end

  def self.all_except(user)
    where.not(id: user)
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
      if tag_list.size > 8
        errors.add(:tag_list, "should be at most 8")
      end
    end
end

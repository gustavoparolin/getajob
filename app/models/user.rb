class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :confirmable, :validatable, :omniauthable, omniauth_providers: %i[linkedin]

  has_many :boards, dependent: :destroy
  # has_many :lists, through: :boards

  belongs_to :person, dependent: :destroy
  accepts_nested_attributes_for :person

  extend FriendlyId
  friendly_id :email, use: [:slugged, :history, :finders]

  # mount_uploader :image, ImageUploader

  def person
    super || build_person
  end

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i

  validates :email, presence: true, uniqueness: true, format: VALID_EMAIL_REGEX

  serialize :oauth_raw_data
  before_create :generate_api_key

  def self.from_omniauth(oauth_data)

    person = Person.where(email: oauth_data.info.email).first_or_create(
      name: oauth_data.info.name,
      alternate_name: oauth_data.info.nickname,
      email: oauth_data.info.email,
      image: oauth_data.info.image,
      telephone: oauth_data.info.phone,
      address: oauth_data.info.location,
      headline: oauth_data.info.description,
      linkedin_profile: oauth_data.info.urls.public_profile
    )

    user = User.where(provider: oauth_data.provider, uid: oauth_data.uid).first_or_create(
      person_id: person.id,
      email: oauth_data.info.email,
      image: oauth_data.info.image,
      password: Devise.friendly_token[0,20],
      uid: oauth_data["uid"],
      provider: oauth_data["provider"],
      oauth_token: oauth_data["credentials"]["token"],
      oauth_raw_data: oauth_data
    )

    user.skip_confirmation!
    user
  end

  private
  def generate_api_key
    # We may accidently generate an api key that a user already owns.
    # To prevent from saving a duplicate key, we'll loop until
    # we can't find any users with that key.
    loop do
      # SecureRandom.hex(32) will generate a large string of random hex
      # characters (i.e A-F & 0-9)
      # We'll use this as user's api key for authentication with our
      # web api.
      self.api_key = SecureRandom.hex(32)
      break unless User.exists?(api_key: api_key)
    end
  end

end

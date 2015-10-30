class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable, :confirmable,
    :recoverable, :rememberable, :trackable, :validatable

  validates :full_name, presence: true

  has_many :rooms

  accepts_nested_attributes_for :rooms

  def to_s
    full_name
  end

  def full_name_with_email
    "#{self[:full_name]} (#{email})"
  end

  def available_rooms
    conn = Faraday.new(url: "https://api.hipchat.com") do |faraday|
      faraday.request :url_encoded
      faraday.response :json
      faraday.adapter Faraday.default_adapter
    end

    response = conn.get("/v2/room?auth_token=#{hipchat_token}")

    response.body["items"].map { |e| e["name"] }
  end
end

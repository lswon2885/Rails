require "open-uri"

class Pack < ApplicationRecord
  has_one_attached :image

  validates :product_name, :company_name, :price, presence: true
  validates :is_publish, exclusion: { in: [nil] }

  scope :published, -> { Pack.where(is_publish: true) }
  scope :unpublished, -> { Pack.where(is_publish: false) }

  has_many :carts, dependent: :destroy
  has_many :users, through: :carts

  has_many :order_items, dependent: :destroy
  has_many :orders, through: :order_items
  def self.set_dummy_datas
    20.times do |i|
      pack = Pack.new(
        product_name: Faker::Superhero.unique.name,
        company_name: Faker::Superhero.unique.power,
        price: [1000, 2000, 3000].sample
      )

      sample_image = open("https://picsum.photos/300/200?random=#{i}")
      pack.image.attach(io: sample_image, filename: "sample_#{i}.jpg")
      pack.save
    end
  end
end

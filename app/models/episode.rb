class Episode < ApplicationRecord
  # Validations
  validates :episode_url, presence: true, format: { with: URI::DEFAULT_PARSER.make_regexp(%w[http https]), message: "must be a valid URL" }
  validates :collection, presence: true
  validates :episode_title, presence: true
  validates :aired_at, presence: true

  # Scopes
  scope :from_collection, ->(collection_name) { where(collection: collection_name) }

  # Instance Methods
  def formatted_aired_date
    aired_at.strftime('%B %d, %Y') # e.g., "January 10, 2013"
  end
end

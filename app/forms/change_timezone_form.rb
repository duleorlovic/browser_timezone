class ChangeTimezoneForm
  include ActiveModel::Model

  FIELDS = %i[timezone_manual].freeze

  attr_accessor :user, *FIELDS

  validates :user, presence: true

  def initialize(attributes)
    super(attributes)

    return if user.blank?

    self.timezone_manual ||= user.timezone_manual
  end

  def save
    user.update! timezone_manual: timezone_manual
    true
  end

  def all_zones
    ActiveSupport::TimeZone.all.map do |time_zone|
      # We save tzinfo.name in db (second value)
      # ["(GMT+00:00) London", "Europe/London"],
      [time_zone.to_s, time_zone.tzinfo.name]
    end
  end
end

class Pig < ActiveRecord::Base
  # Constantes
  STATUSES = {
    :pregnant => 'P',
    :ready => 'R',
    :served => 'S',
    :indisposed => 'I'
  }.with_indifferent_access.freeze

  # Restricciones
  validates :tag, :presence => true, :uniqueness => true
  validates :status, :presence => true, :length => { :maximum => 1 },
    :allow_blank => true, :allow_nil => true
  validates :tag, :father, :mother, :genetics, :group, :location,
    :length => { :maximum => 255 }, :allow_blank => true, :allow_nil => true
  validates :status, :inclusion => { :in => STATUSES.values },
    :allow_blank => true, :allow_nil => true
  validates_date :birth, :next_heat, :allow_blank => true, :allow_nil => true

  # Relaciones
  has_many :services, :dependent => :destroy, :inverse_of => :pig,
    :order => "#{Service.table_name}.date ASC"
  has_many :deliveries, :dependent => :destroy, :inverse_of => :pig,
    :order => "#{Delivery.table_name}.date ASC"
  has_many :weanings, :dependent => :destroy, :inverse_of => :pig,
    :order => "#{Weaning.table_name}.date ASC"

  accepts_nested_attributes_for :services, :allow_destroy => true,
    :reject_if => proc { |attributes| attributes['date'].blank? }
  accepts_nested_attributes_for :deliveries, :allow_destroy => true,
    :reject_if => proc { |attributes| attributes['date'].blank? }
  accepts_nested_attributes_for :weanings, :allow_destroy => true,
    :reject_if => proc { |attributes| attributes['date'].blank? }

  def initialize(attributes = nil)
    super(attributes)

    self.status ||= STATUSES[:ready]
  end

  def next_expected_delivery_date(force_recalculate = false)
    if force_recalculate || @expected_delivery_date.blank?
      last_service_date = self.services.reject(&:new_record?).last.try(:date)
      with_current_service = last_service_date &&
        last_service_date > 120.days.ago.to_date

      if (self.pregnant? || self.served?) && with_current_service
        @expected_delivery_date = last_service_date + 111.days
      else
        @expected_delivery_date = nil
      end

      if @expected_delivery_date && @expected_delivery_date >= Date.today
        @expected_delivery_date
      end
    else
      @expected_delivery_date
    end
  end

  def status_text
    I18n.t(STATUSES.invert[self.status], :scope => [:view, :pigs, :status])
  end

  STATUSES.each do |status, values|
    define_method(:"#{status}?") { self.status == values }
  end
end
class Weaning < ActiveRecord::Base
  # Restricciones
  validates :date, :weaned, :nursed_weaned, :age, :average_weight,
    :presence => true
  validates :weaned, :nursed_weaned, :age,
    :numericality => {:only_integer => true},
    :allow_nil => true, :allow_blank => true
  validates :average_weight, :allow_nil => true, :allow_blank => true,
    :numericality => { :greater_than => 0, :less_than => 100 }
  validates_date :date, :allow_nil => true, :allow_blank => true

  # Relaciones
  belongs_to :pig

  def initialize(attributes = nil)
    super(attributes)

    self.weaned ||= 0
    self.nursed_weaned ||= 0
    self.age ||= 0
    self.average_weight ||= 0
  end
end
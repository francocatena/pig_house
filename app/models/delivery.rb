class Delivery < ActiveRecord::Base
  # Restricciones
  validates :date, :born, :live, :dead, :mummified, :adopted, :low,
    :presence => true
  validates :born, :live, :dead, :mummified, :adopted, :low,
    :numericality => {:only_integer => true},
    :allow_nil => true, :allow_blank => true
  validates_date :date, :allow_nil => true, :allow_blank => true

  # Relaciones
  belongs_to :pig

  def initialize(attributes = nil)
    super(attributes)

    self.born ||= 0
    self.live ||= 0
    self.dead ||= 0
    self.mummified ||= 0
    self.adopted ||= 0
    self.low ||= 0
  end
end
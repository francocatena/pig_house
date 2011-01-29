class Service < ActiveRecord::Base
  # Restricciones
  validates :date, :presence => true
  validates :stallion, :length => { :maximum => 255 }, :allow_blank => true,
    :allow_nil => true
  validates_date :date, :allow_nil => true, :allow_blank => true

  # Relaciones
  belongs_to :pig
end
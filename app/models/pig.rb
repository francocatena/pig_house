class Pig < ActiveRecord::Base
  # Restricciones
  validates :tag, :presence => true, :uniqueness => true
  validates :tag, :genetics, :group, :location, :length => { :maximum => 255 },
    :allow_blank => true, :allow_nil => true
  validates_date :birth, :allow_blank => true, :allow_nil => true

  # Relaciones
  has_many :services, :dependent => :destroy, :inverse_of => :pig,
    :order => "#{Service.table_name}.date ASC"

  accepts_nested_attributes_for :services, :allow_destroy => true,
    :reject_if => proc { |attributes| attributes['date'].blank? }
end
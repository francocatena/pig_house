class Pig < ActiveRecord::Base
  # Restricciones
  validates :tag, :presence => true, :uniqueness => true
  validates :tag, :genetics, :group, :location, :length => { :maximum => 255 },
    :allow_blank => true, :allow_nil => true
  validates_date :birth, :allow_blank => true, :allow_nil => true
end
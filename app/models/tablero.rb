class Tablero < ApplicationRecord
  serialize :casillas, Array
  belongs_to :quedada
end

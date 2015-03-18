class Treshold < ActiveRecord::Base
  belongs_to :party
  delegate :id, :nama_lengkap, to: :party, prefix: true
end

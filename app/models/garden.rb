class Garden < ApplicationRecord
  has_many :plots

  # def long_harvest
  #   Plant.joins(plots: [:garden])
  #     .where(plots: {:days_to_harvest > 100})
  #     .group(:days_to_harvest)
  #     .uniq
  # end
end

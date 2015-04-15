class Wine < ActiveRecord::Base

  belongs_to :user

  validates_presence_of :winery
  validates_presence_of :quantity, on: :create
  validates_presence_of :user

  after_save :delete_if_zero

  def delete_if_zero
    if quantity == 0
      self.destroy
    end
  end

end
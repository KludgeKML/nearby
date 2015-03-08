class Item < ActiveRecord::Base
  has_many :tags

  def initialize(params, owner)
    super
    self.owner = owner
    self.uuid = SecureRandom.uuid
  end

  private
  def item_params
    params.require(:item).permit(:latitude, :longitude)
  end
end

class Tag < ActiveRecord::Base
  belongs_to :item

  def initialize(params)
    super
  end

  private
  def item_params
    params.require(:tag).permit(:category, :value)
  end
end

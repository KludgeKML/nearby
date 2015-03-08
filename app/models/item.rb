require 'elasticsearch/model'

class Item < ActiveRecord::Base
  include Elasticsearch::Model

  has_many :tags

  def initialize(params, owner)
    super
    self.owner = owner
    self.uuid = SecureRandom.uuid
  end

  def add_to_index
    id = self.id
    Item.import(query: -> { where(id: id) }, transform: Item.transform)
  end

  def self.transform
    lambda do |i|
      tags = i.tags.all.collect { |t| "#{t.category}:#{t.value}" }.join
      { index: {_id: i.id, _tags: tags, _latitude: i.latitude, _longitude: i.latitude, _owner: i.owner } }
    end
  end

  private
  def item_params
    params.require(:item).permit(:latitude, :longitude)
  end
end

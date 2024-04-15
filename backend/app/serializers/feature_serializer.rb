# app/serializers/feature_serializer.rb
class FeatureSerializer < ActiveModel::Serializer
  attributes :id, :type, :external_id, :magnitude, :place, :time, :tsunami, :mag_type, :title, :coordinates, :url, :comments

  def type
    'feature'
  end

  def external_id
    object.id
  end

  def coordinates
    {
      longitude: object.longitude,
      latitude: object.latitude
    }
  end

  def url
    object.url
  end

  def links
    {
      external_url: object.url
    }
  end

  def tsunami
    object.tsunami || false
  end

  has_many :comments
end
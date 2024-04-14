# lib/tasks/fetch_seismic_data.rake
namespace :seismic do
  desc "Fetch seismic data from USGS and store it in the database"
  task fetch_data: :environment do
    require 'net/http'
    require 'json'

    url = URI('https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/all_month.geojson')
    response = Net::HTTP.get(url)
    data = JSON.parse(response)

    data['features'].each do |feature|
      properties = feature['properties']
      geometry = feature['geometry']

      next if properties['mag'].nil? || geometry['coordinates'].empty?

      magnitude = properties['mag'].to_f
      latitude = geometry['coordinates'][1].to_f
      longitude = geometry['coordinates'][0].to_f
      place = properties['place']
      time = Time.at(properties['time'] / 1000)
      url = properties['url']
      mag_type = properties['magType']
      title = properties['title']
      tsunami = properties['tsunami'].to_i == 1

      # Apply validations
      next unless magnitude.between?(-1.0, 10.0)
      next unless latitude.between?(-90.0, 90.0)
      next unless longitude.between?(-180.0, 180.0)
      next if place.blank? || url.blank? || mag_type.blank? || title.blank?

      # Avoid duplicate entries
      unless Feature.exists?(url: url)
        Feature.create(
          latitude: latitude,
          longitude: longitude,
          magnitude: magnitude,
          place: place,
          time: time,
          url: url,
          mag_type: mag_type,
          title: title,
          tsunami: tsunami
        )
      end
    end
  end
end
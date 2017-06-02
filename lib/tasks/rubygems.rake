require 'open-uri'
require 'json'

namespace :rubygems do
  task download: :environment do
    name = 'split'

    `mkdir #{Rails.root}/data/#{name}`

    # download versions from libraries.io api

    project = JSON.parse open("https://libraries.io/api/rubygems/#{name}").read

    project['versions'].each do |version|
      number = version['number']
      # download .gem file
      `wget -O #{Rails.root}/tmp/#{name}-#{number}.gem https://rubygems.org/downloads/#{name}-#{number}.gem`

      # mkdir for version
      `mkdir #{Rails.root}/data/#{name}/#{number}`

      # extract .gem file into it
      `tar -C #{Rails.root}/data/#{name}/#{number} -xvf #{Rails.root}/tmp/#{name}-#{number}.gem`
      `cd #{Rails.root}/data/#{name}/#{number} && tar -C . -zxvf data.tar.gz && rm -f data.tar.gz metadata.gz checksums.yaml.gz`
    end
  end
end

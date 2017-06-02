class BlobController < ApplicationController
  def show
    @name = 'split'
    @base = File.join(Rails.root, 'data', @name)
    @versions = Dir[@base + '/*'].reverse.map{|file| file.gsub(@base + '/', '') }
    @current_version = params[:version] || @versions.first
    @root = File.join(@base, @current_version)

    @path = params[:path].presence || '/'
    @full_path = File.join(@root, @path)
    if File.directory?(@full_path)
      # list files
      @files = Dir[@full_path + '/*']

      # show readme if present in that directory
      if @files.any?{|file| file.split('/').last.match(/^readme/i) }
        @file_path = @files.find{|file| file.split('/').last.match(/^readme/i) }
        @file = File.open(@file_path)
      end
    else
      # show file
      @file_path = @full_path
      @file = File.open(@full_path)
    end
  end
end

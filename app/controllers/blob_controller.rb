class BlobController < ApplicationController
  def show
    @path = params[:path].presence || '/'
    @root = File.join(Rails.root, 'files')
    @full_path = File.join(@root, @path)
    if File.directory?(@full_path)
      # list files
      @files = Dir[@full_path + '/*']
    else
      # show file
      @file = File.open(@full_path)
    end
  end
end

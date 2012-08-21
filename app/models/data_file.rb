class DataFile < ActiveRecord::Base
  # attr_accessible :title, :body
  def self.save(upload)
  	name = upload.original_filename
  	directory = 'public/data'
  	path = File.join(directory,name)
  	File.open(path, 'wb') {
  		|f| f.write(upload.read)
  	}
  end
end

class UploadController < ApplicationController
	def index
  	end

  	def uploadFile
  		binding.pry
  		DataFile.save(params[:upload])
  		redirect_to(dashboard_path, :notice => "File uploaded!")
  	end
end

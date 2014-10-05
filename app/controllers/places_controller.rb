class PlacesController < ApplicationController

	def index
		@places = Place.all
	end

	def search
		@places = Place.all
		@data = []
	end

	def search_result
		search_place = params[:search]
		# Search in database
		@places = Place.where("name like ? or address like ?", "%#{search_place}%", "%#{search_place}%")
		# Search with google maps API
		@data = search_geocoding search_place
		
		if @places.empty? && @data.results.empty?
			@place = Place.new
			@visit = Visit.new
			render :new
		elsif @places.count == 1 && @data.results.empty?
			# If only one result from existing place, show the place to create a visit
			@place = results[0]
			@visit = Visit.new
			render :show
		elsif @places.empty? && @data.results.count == 1
			# If one result from Google API, prefill data to create new place
			flash[:info] = "Here is a proposition for your place. Feel free to modify the information."
  			@place.name = search_place
  			@place.address = @data.results[0].formatted_address
  			@place.lat = @data.results[0].geometry.location.lat
  			@place.lng = @data.results[0].geometry.location.lng
  			@visit = Visit.new
  			render :new
		else
			# If several results, let the user choose which one
			render :index
		end
	end

	def new
		@place = Place.new
	end

	def create
		# TODO Get the latLong of the place with google map geocoding if not specify
		@place = Place.new(place_params)
		if @place.save
			flash[:success] = "Your place has been created."
			redirect_to places_path
		else
			render 'new'
		end
	end

	def edit
		@place = Place.find(params[:id])
	end
	
	def update
		# TODO Get the latLong of the place with google map geocoding if not specify
		@place = Place.find(params[:id])
		if @place.update place_params
			flash[:success] = "Your place has been updated."
			redirect_to places_path
		else
			render :edit
		end
	end

	def destroy
		@place = Place.find(params[:id])
		@place.destroy
		flash[:success] = "Your place has been deleted."
		redirect_to places_path
	end

	def show
		@place = Place.find(params[:id])
		@visit = Visit.new
	end

	private

	def place_params
		params.require(:place).permit(:name, :address, :gender, :price)
	end

	def search_geocoding(address)
		# data = Typhoeus.get("https://maps.googleapis.com/maps/api/geocode/json?address=" + address + "&key=AIzaSyBMjQW_pHVa_SJleQQX2BC51pJ4UyhVbK0")
		# JSON.parse(data.body)
		[]
	end

end

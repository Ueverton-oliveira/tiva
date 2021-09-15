module Api::V1
  class AdressesController < ApiController
    before_action :set_address, only: [:update, :destroy, :show]
    def index
      @adresses = Address.all
    end

    def create
      @adresses = Address.new
      @adresses.attributes = address_params
      save_address!
    end

    def show
    end

    def update
      @adresses.attributes = address_params
      save_address!
    end

    def destroy
      @adresses.destroy!
    rescue
      render_error(fields: @adresses.errors.messages)
    end

    private

    def set_address
      @professional = Category.find(params[:id])
    end

    def address_params
      return {} unless params.has_key?(:address)
      params.require(:address).permit(:zip_code, :state, :city, :district, :street, :house_number)
    end

    def save_address!
      @adresses.save!
      render :show
    rescue
      render_error(fields: @adresses.errors.messages)
    end
  end
end


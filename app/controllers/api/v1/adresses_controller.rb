module Api::V1
  class AdressesController < ApiController
    before_action :set_address, only: [:update, :destroy, :show]
    def index
      @adresses = Address.all
    end

    def create
      @address = Address.new
      @address.attributes = address_params
      save_address!
    end

    def show
    end

    def update
      @address.attributes = address_params
      save_address!
    end

    def destroy
      @address.destroy!
    rescue
      render_error(fields: @address.errors.messages)
    end

    private

    def set_address
      if params[:professional_id]
        @address = Professional.find(params[:contact_id]).address
        return @address
      end

      @address = Address.find(params[:id])
    end

    def address_params
      return {} unless params.has_key?(:address)
      params.require(:address).permit(:zip_code, :state, :city, :district, :street, :house_number)
    end

    def save_address!
      @address.save!
      render :show
    rescue
      render_error(fields: @address.errors.messages)
    end
  end
end


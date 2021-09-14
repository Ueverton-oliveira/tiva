class  Api::V1::AdressesController < ApplicationController
  include SimpleErrorRenderable

  def index
    @adresses = Address.all
  end

  def create
    @adresses = Address.new
    @adresses.attributes = address_params
    save_address!
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


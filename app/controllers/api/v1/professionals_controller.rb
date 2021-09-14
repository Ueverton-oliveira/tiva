class Api::V1::ProfessionalsController < ApplicationController
  def index
    @professionals = Professional.all
  end

  def create
    @professionals = Professional.new
    @professionals.attributes = professional_params
    save_professional!
  end

  def update
    @professionals.attributes = professional_params
    save_professional!
  end

  def destroy
    @professionals.destroy!
  rescue
    render_error(fields: @professionals.errors.messages)
  end

  private

  def professional_params
    return {} unless params.has_key?(:professional)
    params.require(:professional).permit(:name, :email, :description, :cell_phone)
  end

  def save_professional!
    @professionals.save!
    render :show
  rescue
    render_error(fields: @professionals.errors.messages)
  end
end
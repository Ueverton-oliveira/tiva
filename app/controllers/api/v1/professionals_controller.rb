module Api::V1
  class ProfessionalsController < ApiController
    before_action :set_professional, only: [:update, :destroy]

    include SimpleErrorRenderable

    def index
      @professionals = Professional.all
    end

    def show
    end

    def create
      @professional = Professional.new
      @professional.attributes = professional_params
      save_professional!
    end

    def update
      @professional.attributes = professional_params
      save_professional!
    end

    def destroy
      @professional.destroy!
    rescue
      render_error(fields: @professional.errors.messages)
    end

    private

    def set_professional
      @professional = Category.find(params[:id])
    end

    def professional_params
      return {} unless params.has_key?(:professional)
      params.require(:professional).permit(:name, :email, :description, :cell_phone)
    end

    def save_professional!
      @professional.save!
      render :show
    rescue
      render_error(fields: @professional.errors.messages)
    end
  end
end
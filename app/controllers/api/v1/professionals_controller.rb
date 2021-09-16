module Api::V1
  class ProfessionalsController < ApiController
    before_action :set_professional, only: [:show, :update, :destroy]

    def index
      @professionals = Professional.all

      render json: @professionals
    end

    def show
      render json: @professional, include: [:shedules, :address]
    end

    def create
      @professional = Professional.new(professional_params)
      if @professional.save
        render json: @professional, include: [:shedules, :address], status: :created, location: @professional
      else
        render json: @professional.errors, status: :unprocessable_entity
      end
    end

    def update
      if @professional.update(professional_params)
        render json: @professional, include: [:shedules, :address]
      else
        render json: @contact.errors, status: :unprocessable_entity
      end
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
      ActiveModelSerializers::Deserialization.jsonapi_parse(params)
    end
  end
end
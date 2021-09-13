class Schedule::V1::ProfessionalsController < ApplicationController
  def index
    @professionals = Professional.all
  end
end
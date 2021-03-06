require_dependency "hanuman/application_controller"

module Hanuman
  class ObservationsController < ApplicationController
    before_action :set_observation, only: [:destroy]

    # DELETE /observations/1
    def destroy
      s = @observation.survey
      s.observations.filtered_by_step_and_entry(@observation.step, @observation.entry).each{|o| o.destroy}
      redirect_to survey_path(s), notice: 'Entry was successfully destroyed.'
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_observation
        @observation = Observation.find(params[:id])
      end
  end
end

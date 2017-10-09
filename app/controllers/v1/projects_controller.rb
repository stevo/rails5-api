module V1
  class ProjectsController < ApplicationController
    def update
      if !authenticate
        render json: { errors: [{ status: 403, title: 'invalid api key' }] },
               status: 403
        return
      end
      project = Project.find_by(id: params[:data][:id])
      project&.update_attributes(project_params)
      if project.nil?
        render json: { errors: [{ status: 404, title: 'record not found' }] },
               status: 404
      elsif project.valid?
        head :ok
      elsif !project.valid?
        render json: { errors: [{ status: 400 }.merge(title: project.errors.messages[:name].join)] }.to_json,
               status: 400
      else
      end
    end

    private

    def authenticate
      ENV.fetch('API_KEY') == params[:api_key]
    end

    def project_params
      params.require(:data).require(:attributes).permit(:active, :name)
    end
  end
end

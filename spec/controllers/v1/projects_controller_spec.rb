require 'rails_helper'

describe V1::ProjectsController do
  describe 'PATCH #update' do
    context 'when api key is valid' do
      context 'when record exists' do
        context 'when data is valid' do
          it 'updates the record and returns 200' do
            project = create(:project, name: 'Sample name', active: true)
            allow(ENV).to receive(:fetch).with('API_KEY').and_return('1234')

            patch :update,
                  params: {
                    api_key: '1234',
                    id: project.id,
                    data: {
                      type: 'projects',
                      id: project.id,
                      attributes: {
                        name: 'Updated name',
                        active: false
                      }
                    }
                  }

            expect(response).to have_http_status(:ok)
            expect(project.reload).to have_attributes(
              name: 'Updated name',
              active: false
            )
          end
        end

        context 'when data is invalid' do
          it 'returns 400' do
            project = create(:project, name: 'Sample name', active: true)
            allow(ENV).to receive(:fetch).with('API_KEY').and_return('1234')

            patch :update,
                  params: {
                    id: project.id,
                    api_key: '1234',
                    data: {
                      type: 'projects',
                      id: project.id,
                      attributes: {
                        name: '',
                        active: true
                      }
                    }
                  }

            expect(response).to have_http_status(:bad_request)
            expect(project.reload).to have_attributes(
              name: 'Sample name',
              active: true
            )
            expect(JSON.parse(response.body)).to include(
              'errors' => [{'status' => 400, 'title' => "can't be blank"}]
            )
          end
        end
      end

      context 'when record does not exist' do
        it 'returns 404' do
          allow(ENV).to receive(:fetch).with('API_KEY').and_return('1234')

          patch :update,
                params: {
                  id: 1,
                  api_key: '1234',
                  data: {
                    type: 'projects',
                    id: 1,
                    attributes: {
                      name: 'Updated name',
                      active: false
                    }
                  }
                }

          expect(response).to have_http_status(:not_found)
          expect(JSON.parse(response.body)).to include(
            'errors' => [{'status' => 404, 'title' => 'record not found'}]
          )
        end
      end
    end

    context 'when api key is invalid' do
      it 'returns 403' do
        project = create(:project, name: 'Sample name', active: true)
        allow(ENV).to receive(:fetch).with('API_KEY').and_return('1234')

        patch :update,
              params: {
                id: 1,
                api_key: '5678',
                data: {
                  type: 'projects',
                  id: 1,
                  attributes: {
                    name: 'Updated name',
                    active: false
                  }
                }
              }

        expect(response).to have_http_status(:forbidden)
        expect(project.reload).to have_attributes(
          name: 'Sample name',
          active: true
        )
        expect(JSON.parse(response.body)).to include(
          'errors' => [{ 'status' => 403, 'title' => 'invalid api key' }]
        )
      end
    end
  end
end

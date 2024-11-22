require 'rails_helper'

RSpec.describe 'Notifications', type: :request do
  let(:valid_params) do
    {
      notification: {
        task_id: 1,
        event_type: 'task_created',
        details: 'Task created successfully.'
      }
    }
  end

  describe 'POST /notifications' do
    it 'creates a notification' do
      post '/notifications', params: {
        notification: {
          task_id: 1,
          event_type: 'scrape_completed',
          details: 'Scraping completed successfully'
        }
      }
  
      expect(response).to have_http_status(:created)
      json = JSON.parse(response.body)
      expect(json['message']).to eq('Notification saved successfully')
    end

    it 'returns an error for invalid params' do
      post '/notifications', params: { notification: { task_id: nil, event_type: nil, details: nil } }
    
      expect(response).to have_http_status(:unprocessable_entity)
      json = JSON.parse(response.body)
      expect(json['errors']).to include(
        "Task can't be blank",
        "Event type can't be blank",
        "Details can't be blank"
      )
    end

    it 'returns an error for invalid task_id' do
      post '/notifications', params: { notification: { task_id: 'abc', event_type: 'event', details: 'details' } }
    
      expect(response).to have_http_status(:unprocessable_entity)
      json = JSON.parse(response.body)
      expect(json['errors']).to include("Task must be an integer")
    end    
  end

  describe 'GET /notifications' do
    before do
      Notification.create(task_id: 1, event_type: 'task_created', details: 'Task created successfully.')
    end

    it 'returns notifications for a specific task' do
      get '/notifications', params: { task_id: 1 }
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body).size).to eq(1)
    end
  end
end

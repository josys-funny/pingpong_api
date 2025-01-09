# frozen_string_literal: true

require 'rails_helper'
require 'swagger_helper'

RSpec.describe('Users API', type: :request) do
  path '/users' do
    get 'List users' do
      tags 'Users'
      produces 'application/json'
      parameter name: :limit, in: :query, type: :integer
      parameter name: :offset, in: :query, type: :integer

      response '200', 'users found' do
        schema type: :array,
               items: {
                 properties: {
                   id: { type: :integer },
                   name: { type: :string },
                   elo: { type: :integer },
                   win_streak: { type: :integer },
                   total_match: { type: :integer },
                   total_win_match: { type: :integer },
                   team: { type: :string },
                   created_at: { type: :string, format: 'date-time' },
                   updated_at: { type: :string, format: 'date-time' },
                   style: { type: :string, enum: %w[forehand backhand] }
                 }
               }
        run_test!
      end

      response '500', 'server error' do
        schema '$ref' => '#/components/schemas/error'
        run_test!
      end
    end

    post 'Creates a user' do
      tags 'Users'
      consumes 'application/json'

      parameter name: :user, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string },
          style: { type: :string, enum: %w[forehand backhand] },
          team: { type: :string }
        },
        required: %w[name style team]
      }

      response '201', 'user created' do
        let(:user) { { name: 'John Doe', style: 'forehand', team: 'Team A' } }
        run_test!
      end

      response '422', 'unprocessable entity' do
        let(:user) { { name: '' } }
        run_test!
      end
    end
  end
end

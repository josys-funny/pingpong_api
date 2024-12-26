# frozen_string_literal: true

require 'test_helper'

class MatchHistoriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @match_history = match_histories(:one)
  end

  test 'should get index' do
    get match_histories_url, as: :json
    assert_response :success
  end

  test 'should create match_history' do
    assert_difference('MatchHistory.count') do
      post match_histories_url, params: { match_history: {} }, as: :json
    end

    assert_response :created
  end

  test 'should show match_history' do
    get match_history_url(@match_history), as: :json
    assert_response :success
  end

  test 'should update match_history' do
    patch match_history_url(@match_history), params: { match_history: {} }, as: :json
    assert_response :success
  end

  test 'should destroy match_history' do
    assert_difference('MatchHistory.count', -1) do
      delete match_history_url(@match_history), as: :json
    end

    assert_response :no_content
  end
end

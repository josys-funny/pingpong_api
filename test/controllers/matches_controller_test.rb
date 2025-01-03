# frozen_string_literal: true

require 'test_helper'

class MatchesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @match = matches(:one)
  end

  test 'should get index' do
    get matches_url, as: :json
    assert_response :success
  end

  test 'should create match' do
    assert_difference('Match.count') do
      post matches_url, params: { match: {} }, as: :json
    end

    assert_response :created
  end

  test 'should show match' do
    get match_url(@match), as: :json
    assert_response :success
  end

  test 'should update match' do
    patch match_url(@match), params: { match: {} }, as: :json
    assert_response :success
  end

  test 'should destroy match' do
    assert_difference('Match.count', -1) do
      delete match_url(@match), as: :json
    end

    assert_response :no_content
  end
end

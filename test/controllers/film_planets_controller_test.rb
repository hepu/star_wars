require "test_helper"

class FilmPlanetsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get film_planets_index_url
    assert_response :success
  end

  test "should get create" do
    get film_planets_create_url
    assert_response :success
  end

  test "should get show" do
    get film_planets_show_url
    assert_response :success
  end

  test "should get update" do
    get film_planets_update_url
    assert_response :success
  end

  test "should get destroy" do
    get film_planets_destroy_url
    assert_response :success
  end
end

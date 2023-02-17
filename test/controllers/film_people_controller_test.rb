require "test_helper"

class FilmPeopleControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get film_people_index_url
    assert_response :success
  end

  test "should get create" do
    get film_people_create_url
    assert_response :success
  end

  test "should get show" do
    get film_people_show_url
    assert_response :success
  end

  test "should get update" do
    get film_people_update_url
    assert_response :success
  end

  test "should get destroy" do
    get film_people_destroy_url
    assert_response :success
  end
end

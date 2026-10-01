require "test_helper"

class PagesControllerTest < ActionDispatch::IntegrationTest
  test "root renders the form" do
    get root_path
    assert_response :success
    assert_select "form[action=?] textarea[name=text]", count_path
  end

  test "count returns stats as a turbo stream" do
    post count_path, params: { text: "One two. Three!" }, as: :turbo_stream
    assert_response :success
    assert_select "turbo-stream[action=replace][target=results]"
    assert_includes response.body, "<dd>3</dd>"
    assert_includes response.body, "<dd>15</dd>"
    assert_includes response.body, "<dd>2</dd>"
  end

  test "count falls back to a full page without Turbo" do
    post count_path, params: { text: "Hello world" }
    assert_response :success
    assert_select "#results dd", "2"
  end
end

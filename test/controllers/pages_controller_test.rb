require "test_helper"

class PagesControllerTest < ActionDispatch::IntegrationTest
  test "shows the form" do
    get root_path
    assert_response :success
    assert_select "form textarea[name=text]"
  end

  test "shows the counts after submitting text" do
    post root_path, params: { text: "One two. Three!" }
    assert_response :success
    assert_select "textarea", "One two. Three!"
    assert_select "dd" do |counts|
      assert_equal [ "3", "15", "2" ], counts.map(&:text)
    end
  end
end

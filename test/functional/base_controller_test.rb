require 'test/test_helper'

class AdminData::BaseControllerTest < ActionController::TestCase


  should_have_before_filter :build_klasses
  should_have_before_filter :build_drop_down_for_klasses

  context 'testing private method extend_with_plugins_models' do
    setup do
      @controller = AdminData::DiagnosticController.new
    end

    should 'get woofer model filename from the car audio plugin' do
      model_names = @controller.send(:extend_with_plugins_models, [])
      assert model_names.any?
      assert model_names.include?("woofer.rb")
    end

    should 'extend only with the new model filename article.rb' do
      model_names = @controller.send(:extend_with_plugins_models, ["article.rb"])
      assert_equal 2, model_names.size
      assert_equal ["article.rb", "woofer.rb"], model_names
    end

    should 'extend only if exist new model filenames' do
      model_names = @controller.send(:extend_with_plugins_models, ["article.rb", "woofer.rb"])
      assert_equal 2, model_names.size
      assert_equal ["article.rb", "woofer.rb"], model_names
    end
  end

end

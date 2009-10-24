require 'test/test_helper'

class AdminData::BaseControllerTest < ActionController::TestCase

  context 'testing filter ensure_is_allowed_to_view' do
    setup do
      @filter = AdminData::BaseController.before_filter.detect do |filter|
        filter.kind_of?(ActionController::Filters::BeforeFilter) && filter.method == :ensure_is_allowed_to_view
      end
    end
    should 'have filter called ensure_is_allowed_to_view' do
      assert @filter
      assert @filter.options.blank?
    end
  end

  should_have_before_filter :ensure_is_allowed_to_view
  should_have_before_filter :build_klasses
  should_have_before_filter :build_drop_down_for_klasses

  context 'testing private method extend_with_plugins_models' do
    setup do
      @controller = AdminData::DiagnosticController.new
    end

    should 'get awesome model filename from the awesome plugin' do
      model_names = @controller.send(:extend_with_plugins_models, [])
      assert model_names.any?
      assert model_names.include?("awesome.rb")
    end

    should 'extend only with the new model filename config.rb' do
      model_names = @controller.send(:extend_with_plugins_models, ["config.rb"])
      assert_equal 2, model_names.size
      assert_equal ["config.rb", "awesome.rb"], model_names      
    end

    should 'extend only if exist new model filenames' do
      model_names = @controller.send(:extend_with_plugins_models, ["config.rb", "awesome.rb"])
      assert_equal 2, model_names.size
      assert_equal ["config.rb", "awesome.rb"], model_names
    end
  end

end

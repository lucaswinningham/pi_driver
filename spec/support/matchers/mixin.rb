# frozen_string_literal: true

RSpec::Matchers.define :mix_in do |*mixins|
  match do |object_under_test|
    klass = Class.new { include object_under_test }

    all_mixins = klass.ancestors.map(&:to_s).grep Regexp.new(object_under_test.to_s)

    identify_object_under_test = proc { |ancestor| ancestor == object_under_test.to_s }
    mixin_name_only = proc { |ancestor| ancestor.sub(/^.*::(.*)/, '\1') }
    included_mixins = all_mixins.reject(&identify_object_under_test).map(&mixin_name_only)

    expect(included_mixins).to contain_exactly(*mixins)
  end
end

module OhSheet
  class Engine < ::Rails::Engine
    isolate_namespace OhSheet

    config.generators do |g|
      g.test_framework :rspec
    end
  end
end

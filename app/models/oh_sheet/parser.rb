module OhSheet
  class Parser
    def initialize(attributes)
      @attributes = attributes.map { |k, v| [k.downcase, v] }.to_h
    end

    def attributes
      @attributes
    end
  end
end

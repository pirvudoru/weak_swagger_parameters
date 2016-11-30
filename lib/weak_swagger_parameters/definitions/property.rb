# frozen_string_literal: true
module WeakSwaggerParameters
  module Definitions
    class Property
      def initialize(type, name, description, options = {})
        @options = (options || {}).merge(name: name, type: type, description: description)
      end

      def apply_validations(parent_node)
        type = @options[:type]
        name = @options[:name]

        validation_options = WeakSwaggerParameters::Services::WeakParametersOptionsAdapter.adapt(@options)
        parent_node.instance_eval { send type, name, validation_options }
      end

      def apply_docs(parent_node)
        name = @options[:name]
        property_options = WeakSwaggerParameters::Services::SwaggerOptionsAdapter.adapt(@options.except(:name, :required))

        parent_node.instance_eval { property name, property_options }
      end
    end
  end
end

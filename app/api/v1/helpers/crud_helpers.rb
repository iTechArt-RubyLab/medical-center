module V1
  module Helpers
    module CrudHelpers
      def sorting(class_name, sort_by, default_sort)
        if sort_by[:column_name] && sort_by[:type]
          class_name.order("#{sort_by[:column_name]} #{sort_by[:type]}")
        else
          class_name.order("#{default_sort[:column_name]} #{default_sort[:type]}")
        end
      end
    end
  end
end

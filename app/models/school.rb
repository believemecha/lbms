class School < ApplicationRecord
    META_FIELDS = %i[abc def ghi]
    enum status: {
        live:0,
        hold:1,
        inactive: 2
    }

    META_FIELDS.each do |key|
        define_method("#{key}?") do
          meta[key.to_s].present? || meta[key].present?
        end
        define_method(key.to_s) do
          meta[key.to_s] || meta[key]
        end
        define_method("#{key}=") do |value = nil|
          meta[key] = value
        end
    end
end
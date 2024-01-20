class Blog < ApplicationRecord

    before_save :generate_code
    private

    def generate_code
        self.slug = title.parameterize
    end
end

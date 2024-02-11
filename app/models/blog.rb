class Blog < ApplicationRecord

    before_save :generate_code
    belongs_to :user
    private

    def generate_code
        self.slug = title.parameterize
    end
end

ActiveAdmin.register Product do
  # Other resource configurations

  index do
    column :name
    column :product_category
    column :description
    column :image_url
    column :max_price
    column :keywords
    column :type

    actions
  end


  show do
    attributes_table do
      row :name
      row :product_category
      row :description
      row :image_url
      row :max_price
      row :keywords
      row :type
    end
  end

  form do |f|
    f.inputs "Product Details" do
      f.input :name
      f.input :product_category_id
      f.input :description
      f.input :image_url
      f.input :max_price
      f.input :keywords, as: :string
      f.input :type, as: :select, collection: Product.types.keys
    end
    f.actions
  end
end

require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do

    before :each do
      @category = Category.create(name: 'Apparel')
      @product = @category.products.create({
        name:  'Hipster Hat',
        description: "Test",
        quantity: 10,
        price: 64.99
      })

    end

    context "Name:" do

      it "Product should have name" do
        expect(@product.name.present?).to eq(true)
      end

      it "Product without a name should log error" do
        @category = Category.create(name: 'Apparel')
        @product = @category.products.create({
          name:  nil,
          description: "Test",
          quantity: 10,
          price: 64.99
        })
        expect(@product.errors.full_messages.present?).to eq(true)
      end

    end

    context "Price:" do

      it "Product should have price" do
        expect(@product.price.present?).to eq(true)
      end

      it "Product without a price should log error" do
        @category = Category.create(name: 'Apparel')
        @product = @category.products.create({
          name:  'Hipster Hat',
          description: "Test",
          quantity: 10,
          price: nil
        })
        expect(@product.errors.full_messages.present?).to eq(true)
      end

    end

    context "Quantity:" do

      it "Product should have quantity" do
        expect(@product.quantity.present?).to eq(true)
      end

      it "Product without a quantity should log error" do
        @category = Category.create(name: 'Apparel')
        @product = @category.products.create({
          name:  'Hipster Hat',
          description: "Test",
          quantity: nil,
          price: 64.99
        })
        expect(@product.errors.full_messages.present?).to eq(true)
      end

    end

    context "Category:" do

      it "Product should have category" do
        expect(@product.category.present?).to eq(true)
      end

      it "Product without a category should log error" do
        @product = Product.create({
          name:  'Hipster Hat',
          description: "Test",
          quantity: nil,
          price: 64.99,
          category: nil
        })
        expect(@product.errors.full_messages.present?).to eq(true)
      end

    end

  end
end
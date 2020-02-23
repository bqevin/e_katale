defmodule EKatale.InventoryTest do
  use EKatale.DataCase

  alias EKatale.Inventory

  describe "categories" do
    alias EKatale.Inventory.Category

    @valid_attrs %{description: "some description", name: "some name"}
    @update_attrs %{description: "some updated description", name: "some updated name"}
    @invalid_attrs %{description: nil, name: nil}

    def category_fixture(attrs \\ %{}) do
      {:ok, category} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Inventory.create_category()

      category
    end

    test "list_categories/0 returns all categories" do
      category = category_fixture()
      assert Inventory.list_categories() == [category]
    end

    test "get_category!/1 returns the category with given id" do
      category = category_fixture()
      assert Inventory.get_category!(category.id) == category
    end

    test "create_category/1 with valid data creates a category" do
      assert {:ok, %Category{} = category} = Inventory.create_category(@valid_attrs)
      assert category.description == "some description"
      assert category.name == "some name"
    end

    test "create_category/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Inventory.create_category(@invalid_attrs)
    end

    test "update_category/2 with valid data updates the category" do
      category = category_fixture()
      assert {:ok, category} = Inventory.update_category(category, @update_attrs)
      assert %Category{} = category
      assert category.description == "some updated description"
      assert category.name == "some updated name"
    end

    test "update_category/2 with invalid data returns error changeset" do
      category = category_fixture()
      assert {:error, %Ecto.Changeset{}} = Inventory.update_category(category, @invalid_attrs)
      assert category == Inventory.get_category!(category.id)
    end

    test "delete_category/1 deletes the category" do
      category = category_fixture()
      assert {:ok, %Category{}} = Inventory.delete_category(category)
      assert_raise Ecto.NoResultsError, fn -> Inventory.get_category!(category.id) end
    end

    test "change_category/1 returns a category changeset" do
      category = category_fixture()
      assert %Ecto.Changeset{} = Inventory.change_category(category)
    end
  end

  describe "products" do
    alias EKatale.Inventory.Product

    @valid_attrs %{category_id: 42, description: "some description", image_url: "some image_url", name: "some name", quantity: 42, unit_price: 120.5}
    @update_attrs %{category_id: 43, description: "some updated description", image_url: "some updated image_url", name: "some updated name", quantity: 43, unit_price: 456.7}
    @invalid_attrs %{category_id: nil, description: nil, image_url: nil, name: nil, quantity: nil, unit_price: nil}

    def product_fixture(attrs \\ %{}) do
      {:ok, product} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Inventory.create_product()

      product
    end

    test "list_products/0 returns all products" do
      product = product_fixture()
      assert Inventory.list_products() == [product]
    end

    test "get_product!/1 returns the product with given id" do
      product = product_fixture()
      assert Inventory.get_product!(product.id) == product
    end

    test "create_product/1 with valid data creates a product" do
      assert {:ok, %Product{} = product} = Inventory.create_product(@valid_attrs)
      assert product.category_id == 42
      assert product.description == "some description"
      assert product.image_url == "some image_url"
      assert product.name == "some name"
      assert product.quantity == 42
      assert product.unit_price == 120.5
    end

    test "create_product/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Inventory.create_product(@invalid_attrs)
    end

    test "update_product/2 with valid data updates the product" do
      product = product_fixture()
      assert {:ok, product} = Inventory.update_product(product, @update_attrs)
      assert %Product{} = product
      assert product.category_id == 43
      assert product.description == "some updated description"
      assert product.image_url == "some updated image_url"
      assert product.name == "some updated name"
      assert product.quantity == 43
      assert product.unit_price == 456.7
    end

    test "update_product/2 with invalid data returns error changeset" do
      product = product_fixture()
      assert {:error, %Ecto.Changeset{}} = Inventory.update_product(product, @invalid_attrs)
      assert product == Inventory.get_product!(product.id)
    end

    test "delete_product/1 deletes the product" do
      product = product_fixture()
      assert {:ok, %Product{}} = Inventory.delete_product(product)
      assert_raise Ecto.NoResultsError, fn -> Inventory.get_product!(product.id) end
    end

    test "change_product/1 returns a product changeset" do
      product = product_fixture()
      assert %Ecto.Changeset{} = Inventory.change_product(product)
    end
  end
end

defmodule EKatale.Support.Factories.CategoryFactory do
    defmacro __using__(opts) do
        quote do
           def category_factory do
                %EKatale.Inventory.Category{
                    name: "Dresses",
                    description: "Ladies wear"
                }
           end 
        end
    end
end
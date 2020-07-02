defmodule EKatale.Support.Factories.UserFactory do
    defmacro __using__(opts) do
        quote do
            def user_factory do
                %EKatale.Users.User{
                    first_name: "Abra",
                    last_name: "Cadabra",
                    email: "test@gmail.com",
                    password: "password",
                    address: "Kampala"
                }
            end
        end
    end
end
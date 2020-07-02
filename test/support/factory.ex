defmodule EKatale.Factory do
    use ExMachina.Ecto, repo: EKatale.Repo

    use EKatale.Support.Factories.{
        CategoryFactory,
        UserFactory
    }
end
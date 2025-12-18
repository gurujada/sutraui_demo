defmodule SutrauiDemo.Repo do
  use Ecto.Repo,
    otp_app: :sutraui_demo,
    adapter: Ecto.Adapters.Postgres
end

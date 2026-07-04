defmodule SutrauiDemoWeb.NotFoundController do
  use SutrauiDemoWeb, :controller

  def not_found(conn, %{"path" => path}) do
    conn
    |> put_status(:not_found)
    |> put_view(html: SutrauiDemoWeb.NotFoundHTML)
    |> render(:not_found, path: "/" <> Enum.join(path, "/"))
  end
end

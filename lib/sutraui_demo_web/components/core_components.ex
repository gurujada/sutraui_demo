defmodule SutrauiDemoWeb.CoreComponents do
  @moduledoc """
  Provides core UI components for the Sutra UI demo site.

  This module is minimal as most components are provided by Sutra UI.
  """
  use Phoenix.Component

  @doc """
  Renders a Lucide Icon.

  Icons are extracted from the `deps/lucide_icons` directory and bundled within
  your compiled app.css by the plugin in `assets/vendor/lucide.js`.

  ## Examples

      <.icon name="lucide-x" />
      <.icon name="lucide-loader-2" class="ml-1 size-3 animate-spin" />
  """
  attr :name, :string, required: true
  attr :class, :any, default: "size-4"

  def icon(%{name: "lucide-" <> _} = assigns) do
    ~H"""
    <span class={[@name, @class]} />
    """
  end
end

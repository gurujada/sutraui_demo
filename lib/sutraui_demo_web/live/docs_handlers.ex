defmodule SutrauiDemoWeb.DocsHandlers do
  @moduledoc """
  Common event handlers for documentation pages.
  Add `on_mount SutrauiDemoWeb.DocsHandlers` to LiveViews that use component demos.
  """

  import Phoenix.LiveView

  def on_mount(:default, _params, _session, socket) do
    socket =
      attach_hook(socket, :docs_handlers, :handle_event, fn
        "show_toast", %{"variant" => variant, "title" => title} = params, socket ->
          kind = if variant == "destructive", do: :error, else: :info
          SutraUI.Toast.send(kind, Map.get(params, "description") || title, title: title)
          {:halt, socket}

        _event, _params, socket ->
          {:cont, socket}
      end)

    {:cont, socket}
  end
end

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
          {:halt,
           push_event(socket, "toast", %{
             variant: variant,
             title: title,
             description: Map.get(params, "description"),
             duration: 3000
           })}

        _event, _params, socket ->
          {:cont, socket}
      end)

    {:cont, socket}
  end
end

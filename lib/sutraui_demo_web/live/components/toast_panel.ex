defmodule SutrauiDemoWeb.Components.ToastPanel do
  @moduledoc "A LiveComponent that sends toasts: `SutraUI.Toast.send/3` works from any LiveComponent."
  use SutrauiDemoWeb, :live_component

  alias SutraUI.Toast

  def render(assigns) do
    ~H"""
    <div id={@id} class="flex flex-wrap items-center gap-3">
      <.button id="component-toast-button" variant="outline" phx-click="notify" phx-target={@myself}>
        Toast from a LiveComponent
      </.button>
      <span class="text-sm text-muted-foreground">Sent {@count} so far</span>
    </div>
    """
  end

  def mount(socket), do: {:ok, assign(socket, :count, 0)}

  def handle_event("notify", _params, socket) do
    count = socket.assigns.count + 1
    Toast.send(:info, "Sent from a LiveComponent (#{count})")
    {:noreply, assign(socket, :count, count)}
  end
end

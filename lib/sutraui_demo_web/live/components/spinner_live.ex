defmodule SutrauiDemoWeb.Components.SpinnerLive do
  use SutrauiDemoWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, assign(socket, page_title: "Spinner", loading: false)}
  end

  def render(assigns) do
    ~H"""
    <Layouts.docs flash={@flash} current_path="/docs/components/spinner">
      <.docs_header
        title="Spinner"
        description="A loading indicator that shows an indeterminate operation is in progress."
      />

      <.component_demo title="Default" code={~s|<.spinner />|}>
        <.spinner />
      </.component_demo>

      <.section_heading id="sizes">Sizes</.section_heading>
      <.prose>
        Use the
        <.inline_code>size</.inline_code>
        prop to change the spinner size.
      </.prose>

      <.component_demo title="Sizes" code={sizes_code()}>
        <div class="flex items-center gap-8">
          <div class="text-center space-y-2">
            <.spinner size="sm" />
            <span class="block text-xs" style="color: var(--fg-muted);">Small</span>
          </div>
          <div class="text-center space-y-2">
            <.spinner />
            <span class="block text-xs" style="color: var(--fg-muted);">Default</span>
          </div>
          <div class="text-center space-y-2">
            <.spinner size="lg" />
            <span class="block text-xs" style="color: var(--fg-muted);">Large</span>
          </div>
          <div class="text-center space-y-2">
            <.spinner size="xl" />
            <span class="block text-xs" style="color: var(--fg-muted);">Extra Large</span>
          </div>
        </div>
      </.component_demo>

      <.section_heading id="with-text">With Text</.section_heading>
      <.prose>
        Use the
        <.inline_code>:text</.inline_code>
        slot to add visible loading text next to the spinner.
      </.prose>

      <.component_demo title="With Text" code={text_code()}>
        <div class="space-y-4">
          <.spinner>
            <:text>Loading...</:text>
          </.spinner>
          <.spinner>
            <:text>Please wait</:text>
          </.spinner>
          <.spinner>
            <:text>Saving changes</:text>
          </.spinner>
        </div>
      </.component_demo>

      <.section_heading id="in-button">In Button</.section_heading>
      <.prose>
        Use
        <.inline_code>spinner_icon/1</.inline_code>
        for inline spinner icons, such as in buttons.
      </.prose>

      <.component_demo title="In Button" code={button_code()}>
        <div class="flex flex-wrap gap-4">
          <.button disabled={@loading} phx-click="toggle_loading">
            <%= if @loading do %>
              <.spinner_icon class="mr-2" /> Saving...
            <% else %>
              Save Changes
            <% end %>
          </.button>
          <.button variant="outline" disabled>
            <.spinner_icon class="mr-2" /> Processing
          </.button>
          <.button variant="secondary" disabled>
            <.spinner_icon class="mr-2" /> Loading
          </.button>
        </div>
        <p class="mt-4 text-sm" style="color: var(--fg-muted);">
          Click the first button to see the loading state.
        </p>
      </.component_demo>

      <.section_heading id="custom-label">Custom Accessibility Label</.section_heading>
      <.prose>
        Use the
        <.inline_code>label</.inline_code>
        prop to customize the screen reader text.
      </.prose>

      <.component_demo title="Custom Label" code={label_code()}>
        <.spinner label="Fetching data" />
      </.component_demo>

      <.section_heading id="centered">Centered Loading</.section_heading>
      <.prose>
        A common pattern for full-page or container loading states.
      </.prose>

      <.component_demo title="Centered" code={centered_code()}>
        <div
          class="flex items-center justify-center p-12 rounded-lg border"
          style="background: var(--bg-subtle); border-color: var(--border);"
        >
          <.spinner size="lg">
            <:text>Loading content...</:text>
          </.spinner>
        </div>
      </.component_demo>
    </Layouts.docs>
    """
  end

  def handle_event("toggle_loading", _params, socket) do
    if socket.assigns.loading do
      {:noreply, assign(socket, :loading, false)}
    else
      Process.send_after(self(), :stop_loading, 2000)
      {:noreply, assign(socket, :loading, true)}
    end
  end

  def handle_info(:stop_loading, socket) do
    {:noreply, assign(socket, :loading, false)}
  end

  defp sizes_code do
    """
    <.spinner size="sm" />
    <.spinner />
    <.spinner size="lg" />
    <.spinner size="xl" />\
    """
  end

  defp text_code do
    """
    <.spinner>
      <:text>Loading...</:text>
    </.spinner>\
    """
  end

  defp button_code do
    """
    <.button disabled={@loading} phx-click="toggle_loading">
      <%= if @loading do %>
        <.spinner_icon class="mr-2" /> Saving...
      <% else %>
        Save Changes
      <% end %>
    </.button>\
    """
  end

  defp label_code do
    """
    <.spinner label="Fetching data" />\
    """
  end

  defp centered_code do
    """
    <div class="flex items-center justify-center p-12">
      <.spinner size="lg">
        <:text>Loading content...</:text>
      </.spinner>
    </div>\
    """
  end
end

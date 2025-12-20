defmodule SutrauiDemoWeb.Components.EmptyLive do
  use SutrauiDemoWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, assign(socket, page_title: "Empty")}
  end

  def render(assigns) do
    ~H"""
    <Layouts.docs flash={@flash} current_path="/docs/components/empty">
      <.docs_header
        title="Empty"
        description="A placeholder component for empty states, such as when no data is available."
      />

      <.component_demo title="Default" code={default_code()}>
        <.empty>
          <:icon>
            <svg
              xmlns="http://www.w3.org/2000/svg"
              width="48"
              height="48"
              viewBox="0 0 24 24"
              fill="none"
              stroke="currentColor"
              stroke-width="1"
              stroke-linecap="round"
              stroke-linejoin="round"
            >
              <path d="M15 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V7Z" />
              <path d="M14 2v4a2 2 0 0 0 2 2h4" />
            </svg>
          </:icon>
          <:title>No documents</:title>
          <:description>You haven't created any documents yet.</:description>
        </.empty>
      </.component_demo>

      <.section_heading id="with-actions">With Actions</.section_heading>
      <.prose>
        Add action buttons using the
        <.inline_code>:actions</.inline_code>
        slot to help users take the next step.
      </.prose>

      <.component_demo title="With Actions" code={actions_code()}>
        <.empty>
          <:icon>
            <svg
              xmlns="http://www.w3.org/2000/svg"
              width="48"
              height="48"
              viewBox="0 0 24 24"
              fill="none"
              stroke="currentColor"
              stroke-width="1"
              stroke-linecap="round"
              stroke-linejoin="round"
            >
              <rect width="18" height="18" x="3" y="3" rx="2" /><path d="M12 8v8" /><path d="M8 12h8" />
            </svg>
          </:icon>
          <:title>No projects</:title>
          <:description>Get started by creating a new project.</:description>
          <:actions>
            <.button>
              <svg
                xmlns="http://www.w3.org/2000/svg"
                class="w-4 h-4 mr-2"
                viewBox="0 0 24 24"
                fill="none"
                stroke="currentColor"
                stroke-width="2"
              >
                <path d="M12 5v14" /><path d="M5 12h14" />
              </svg>
              New Project
            </.button>
          </:actions>
        </.empty>
      </.component_demo>

      <.section_heading id="outline">Outline Variant</.section_heading>
      <.prose>
        Use
        <.inline_code>variant="outline"</.inline_code>
        for a bordered appearance.
      </.prose>

      <.component_demo title="Outline" code={outline_code()}>
        <.empty variant="outline">
          <:icon>
            <svg
              xmlns="http://www.w3.org/2000/svg"
              width="48"
              height="48"
              viewBox="0 0 24 24"
              fill="none"
              stroke="currentColor"
              stroke-width="1"
              stroke-linecap="round"
              stroke-linejoin="round"
            >
              <path d="m21.44 11.05-9.19 9.19a6 6 0 0 1-8.49-8.49l8.57-8.57A4 4 0 1 1 18 8.84l-8.59 8.57a2 2 0 0 1-2.83-2.83l8.49-8.48" />
            </svg>
          </:icon>
          <:title>No attachments</:title>
          <:description>Drag and drop files here or click to browse.</:description>
          <:actions>
            <.button variant="outline">Browse Files</.button>
          </:actions>
        </.empty>
      </.component_demo>

      <.section_heading id="with-footer">With Footer</.section_heading>
      <.prose>
        Use the
        <.inline_code>:footer</.inline_code>
        slot for additional information or links.
      </.prose>

      <.component_demo title="With Footer" code={footer_code()}>
        <.empty>
          <:icon>
            <svg
              xmlns="http://www.w3.org/2000/svg"
              width="48"
              height="48"
              viewBox="0 0 24 24"
              fill="none"
              stroke="currentColor"
              stroke-width="1"
              stroke-linecap="round"
              stroke-linejoin="round"
            >
              <circle cx="11" cy="11" r="8" /><path d="m21 21-4.3-4.3" />
            </svg>
          </:icon>
          <:title>No results found</:title>
          <:description>Try adjusting your search or filters.</:description>
          <:footer>
            <a href="#" class="text-sm underline" style="color: var(--primary);">
              Clear all filters
            </a>
          </:footer>
        </.empty>
      </.component_demo>
    </Layouts.docs>
    """
  end

  defp default_code do
    """
    <.empty>
      <:icon>
        <svg xmlns="http://www.w3.org/2000/svg" width="48" height="48" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1">
          <path d="M15 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V7Z" />
          <path d="M14 2v4a2 2 0 0 0 2 2h4" />
        </svg>
      </:icon>
      <:title>No documents</:title>
      <:description>You haven't created any documents yet.</:description>
    </.empty>\
    """
  end

  defp actions_code do
    """
    <.empty>
      <:icon>...</:icon>
      <:title>No projects</:title>
      <:description>Get started by creating a new project.</:description>
      <:actions>
        <.button>New Project</.button>
      </:actions>
    </.empty>\
    """
  end

  defp outline_code do
    """
    <.empty variant="outline">
      <:icon>...</:icon>
      <:title>No attachments</:title>
      <:description>Drag and drop files here.</:description>
      <:actions>
        <.button variant="outline">Browse Files</.button>
      </:actions>
    </.empty>\
    """
  end

  defp footer_code do
    """
    <.empty>
      <:icon>...</:icon>
      <:title>No results found</:title>
      <:description>Try adjusting your search or filters.</:description>
      <:footer>
        <a href="#">Clear all filters</a>
      </:footer>
    </.empty>\
    """
  end
end

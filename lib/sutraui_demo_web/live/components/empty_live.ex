defmodule SutrauiDemoWeb.Components.EmptyLive do
  use SutrauiDemoWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, assign(socket, page_title: "Empty")}
  end

  def render(assigns) do
    ~H"""
    <Layouts.docs
      flash={@flash}
      sutra_commands={@sutra_commands}
      current_path="/docs/components/empty"
    >
      <.docs_header
        title="Empty"
        description="A placeholder component for empty states, such as when no data is available."
      />

      <.component_demo title="Default" code={default_code()}>
        <.empty>
          <:icon>
            <.icon name="lucide-file" class="size-12" />
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
            <.icon name="lucide-square-plus" class="size-12" />
          </:icon>
          <:title>No projects</:title>
          <:description>Get started by creating a new project.</:description>
          <:actions>
            <.button>
              <.icon name="lucide-plus" class="size-4 mr-2" /> New Project
            </.button>
          </:actions>
        </.empty>
      </.component_demo>

      <.section_heading id="inline">Inline</.section_heading>
      <.prose>
        <.inline_code>variant="inline"</.inline_code>
        is one quiet line for a small list or a table cell. The inner block is the one description line; an
        <.inline_code>action</.inline_code>
        slot (beside <.inline_code>actions</.inline_code>) holds a link or button. No description or action markup is rendered when none is given.
      </.prose>

      <.component_demo title="Inline" code={inline_code()}>
        <div id="empty-inline-demos" class="w-full max-w-md space-y-4">
          <.empty variant="inline">
            <:icon><.icon name="lucide-inbox" class="size-4" /></:icon>
            <:title>No replies yet</:title>
          </.empty>
          <.empty variant="inline">
            <:icon><.icon name="lucide-inbox" class="size-4" /></:icon>
            <:title>No replies yet</:title>
            Replies from your class show up here.
          </.empty>
          <.empty variant="inline">
            <:icon><.icon name="lucide-users" class="size-4" /></:icon>
            <:title>No learners</:title>
            Invite someone to get started.
            <:action>
              <.button size="sm" variant="outline">Invite</.button>
            </:action>
          </.empty>
        </div>
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
            <.icon name="lucide-paperclip" class="size-12" />
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
            <.icon name="lucide-search" class="size-12" />
          </:icon>
          <:title>No results found</:title>
          <:description>Try adjusting your search or filters.</:description>
          <:footer>
            <a href="#" class="text-sm underline sx-009cc8c">
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
        <.icon name="lucide-file" class="size-12" />
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

  defp inline_code do
    """
    <.empty variant="inline">
      <:icon><.icon name="lucide-users" class="size-4" /></:icon>
      <:title>No learners</:title>
      Invite someone to get started.
      <:action><.button size="sm" variant="outline">Invite</.button></:action>
    </.empty>\
    """
  end
end

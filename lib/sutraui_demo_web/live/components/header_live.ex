defmodule SutrauiDemoWeb.Components.HeaderLive do
  use SutrauiDemoWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, assign(socket, page_title: "Header")}
  end

  def render(assigns) do
    ~H"""
    <Layouts.docs flash={@flash} current_path="/docs/components/header">
      <.docs_header
        title="Header"
        description="A page header component for titles, subtitles, and action buttons."
      />

      <.component_demo title="Basic" code={basic_code()}>
        <.header>
          Dashboard
        </.header>
      </.component_demo>

      <.section_heading id="with-subtitle">With Subtitle</.section_heading>
      <.prose>
        Add context with the
        <.inline_code>:subtitle</.inline_code>
        slot for secondary information.
      </.prose>

      <.component_demo title="With Subtitle" code={subtitle_code()}>
        <.header>
          Settings
          <:subtitle>Manage your account preferences and application settings.</:subtitle>
        </.header>
      </.component_demo>

      <.section_heading id="with-actions">With Actions</.section_heading>
      <.prose>
        Use the
        <.inline_code>:actions</.inline_code>
        slot for buttons and controls aligned to the right.
      </.prose>

      <.component_demo title="With Actions" code={actions_code()}>
        <.header>
          Users
          <:actions>
            <.button>New User</.button>
          </:actions>
        </.header>
      </.component_demo>

      <.section_heading id="complete-example">Complete Example</.section_heading>
      <.prose>
        Combine all slots for a fully-featured page header.
      </.prose>

      <.component_demo title="Complete Example" code={complete_code()}>
        <.header>
          Team Members
          <:subtitle>Manage your team and their permissions.</:subtitle>
          <:actions>
            <.button variant="outline">Export</.button>
            <.button>Invite Member</.button>
          </:actions>
        </.header>
      </.component_demo>
    </Layouts.docs>
    """
  end

  defp basic_code do
    """
    <.header>
      Dashboard
    </.header>\
    """
  end

  defp subtitle_code do
    """
    <.header>
      Settings
      <:subtitle>Manage your account preferences and application settings.</:subtitle>
    </.header>\
    """
  end

  defp actions_code do
    """
    <.header>
      Users
      <:actions>
        <.button>New User</.button>
      </:actions>
    </.header>\
    """
  end

  defp complete_code do
    """
    <.header>
      Team Members
      <:subtitle>Manage your team and their permissions.</:subtitle>
      <:actions>
        <.button variant="outline">Export</.button>
        <.button>Invite Member</.button>
      </:actions>
    </.header>\
    """
  end
end

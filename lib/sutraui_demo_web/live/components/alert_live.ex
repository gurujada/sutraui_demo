defmodule SutrauiDemoWeb.Components.AlertLive do
  use SutrauiDemoWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, assign(socket, page_title: "Alert")}
  end

  def render(assigns) do
    ~H"""
    <Layouts.docs flash={@flash} current_path="/docs/components/alert">
      <.docs_header
        title="Alert"
        description="Displays a callout for important content, with semantic variants for different message types."
      />

      <.component_demo
        title="Default"
        code={
          ~s|<.alert>\n  <:title>Heads up!</:title>\n  <:description>You can add components to your app using the CLI.</:description>\n</.alert>|
        }
      >
        <.alert>
          <:title>Heads up!</:title>
          <:description>You can add components to your app using the CLI.</:description>
        </.alert>
      </.component_demo>

      <.section_heading id="destructive">Destructive</.section_heading>
      <.prose>
        Use the
        <.inline_code>variant="destructive"</.inline_code>
        for error or warning messages that require attention.
      </.prose>

      <.component_demo title="Destructive" code={destructive_code()}>
        <.alert variant="destructive">
          <:title>Error</:title>
          <:description>Your session has expired. Please log in again.</:description>
        </.alert>
      </.component_demo>

      <.section_heading id="with-icon">With Icon</.section_heading>
      <.prose>
        Add an icon using the
        <.inline_code>:icon</.inline_code>
        slot for additional visual context.
      </.prose>

      <.component_demo title="With Icon" code={icon_code()}>
        <div class="space-y-4">
          <.alert>
            <:icon>
              <svg
                xmlns="http://www.w3.org/2000/svg"
                width="16"
                height="16"
                viewBox="0 0 24 24"
                fill="none"
                stroke="currentColor"
                stroke-width="2"
                stroke-linecap="round"
                stroke-linejoin="round"
              >
                <circle cx="12" cy="12" r="10" /><path d="M12 16v-4" /><path d="M12 8h.01" />
              </svg>
            </:icon>
            <:title>Information</:title>
            <:description>This is an informational message for the user.</:description>
          </.alert>

          <.alert variant="destructive">
            <:icon>
              <svg
                xmlns="http://www.w3.org/2000/svg"
                width="16"
                height="16"
                viewBox="0 0 24 24"
                fill="none"
                stroke="currentColor"
                stroke-width="2"
                stroke-linecap="round"
                stroke-linejoin="round"
              >
                <circle cx="12" cy="12" r="10" /><path d="m15 9-6 6" /><path d="m9 9 6 6" />
              </svg>
            </:icon>
            <:title>Deletion Failed</:title>
            <:description>There was a problem deleting your file. Please try again.</:description>
          </.alert>
        </div>
      </.component_demo>

      <.section_heading id="title-only">Title Only</.section_heading>
      <.prose>
        The description slot is optional. Use title-only alerts for brief messages.
      </.prose>

      <.component_demo title="Title Only" code={title_only_code()}>
        <.alert>
          <:title>All systems operational.</:title>
        </.alert>
      </.component_demo>
    </Layouts.docs>
    """
  end

  defp destructive_code do
    """
    <.alert variant="destructive">
      <:title>Error</:title>
      <:description>Your session has expired. Please log in again.</:description>
    </.alert>\
    """
  end

  defp icon_code do
    """
    <.alert>
      <:icon>
        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
          <circle cx="12" cy="12" r="10" /><path d="M12 16v-4" /><path d="M12 8h.01" />
        </svg>
      </:icon>
      <:title>Information</:title>
      <:description>This is an informational message.</:description>
    </.alert>\
    """
  end

  defp title_only_code do
    """
    <.alert>
      <:title>All systems operational.</:title>
    </.alert>\
    """
  end
end

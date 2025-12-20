defmodule SutrauiDemoWeb.Components.FlashLive do
  use SutrauiDemoWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, assign(socket, page_title: "Flash")}
  end

  def render(assigns) do
    ~H"""
    <Layouts.docs flash={@flash} current_path="/docs/components/flash">
      <.docs_header
        title="Flash"
        description="Flash notifications for displaying temporary feedback messages after actions."
      />

      <.section_heading id="info">Info Flash</.section_heading>
      <.prose>
        Use
        <.inline_code>kind={:info}</.inline_code>
        for success messages, confirmations, and general information.
      </.prose>

      <.component_demo title="Info" code={info_code()}>
        <.flash kind={:info}>
          Your changes have been saved successfully.
        </.flash>
      </.component_demo>

      <.section_heading id="error">Error Flash</.section_heading>
      <.prose>
        Use
        <.inline_code>kind={:error}</.inline_code>
        for error messages and validation failures.
      </.prose>

      <.component_demo title="Error" code={error_code()}>
        <.flash kind={:error}>
          There was a problem processing your request.
        </.flash>
      </.component_demo>

      <.section_heading id="with-title">With Title</.section_heading>
      <.prose>
        Add a title for additional context using the
        <.inline_code>title</.inline_code>
        prop.
      </.prose>

      <.component_demo title="With Title" code={title_code()}>
        <div class="space-y-4">
          <.flash kind={:info} title="Success">
            Your profile has been updated.
          </.flash>

          <.flash kind={:error} title="Connection Error">
            Unable to reach the server. Please check your connection.
          </.flash>
        </div>
      </.component_demo>

      <.section_heading id="with-formatting">With Formatting</.section_heading>
      <.prose>
        The inner block supports HTML for rich content.
      </.prose>

      <.component_demo title="With Formatting" code={formatting_code()}>
        <.flash kind={:info} title="File Uploaded">
          Your file <strong>report.pdf</strong> has been uploaded successfully.
        </.flash>
      </.component_demo>

      <.section_heading id="usage">Usage with LiveView</.section_heading>
      <.prose>
        In LiveView, use
        <.inline_code>put_flash/3</.inline_code>
        to set flash messages that will be displayed automatically.
      </.prose>

      <.code_block language="elixir" code={usage_code()} />
    </Layouts.docs>
    """
  end

  defp info_code do
    """
    <.flash kind={:info}>
      Your changes have been saved successfully.
    </.flash>\
    """
  end

  defp error_code do
    """
    <.flash kind={:error}>
      There was a problem processing your request.
    </.flash>\
    """
  end

  defp title_code do
    """
    <.flash kind={:info} title="Success">
      Your profile has been updated.
    </.flash>

    <.flash kind={:error} title="Connection Error">
      Unable to reach the server.
    </.flash>\
    """
  end

  defp formatting_code do
    """
    <.flash kind={:info} title="File Uploaded">
      Your file <strong>report.pdf</strong> has been uploaded.
    </.flash>\
    """
  end

  defp usage_code do
    """
    def handle_event("save", params, socket) do
      case save_data(params) do
        {:ok, _} ->
          {:noreply, put_flash(socket, :info, "Changes saved!")}
        {:error, _} ->
          {:noreply, put_flash(socket, :error, "Failed to save")}
      end
    end\
    """
  end
end

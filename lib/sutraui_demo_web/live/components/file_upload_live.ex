defmodule SutrauiDemoWeb.Components.FileUploadLive do
  use SutrauiDemoWeb, :live_view

  def mount(_params, _session, socket) do
    socket =
      allow_upload(socket, :documents,
        accept: ~w(.pdf .png .jpg .jpeg),
        max_entries: 3,
        max_file_size: 5_000_000
      )

    {:ok, assign(socket, page_title: "File Upload")}
  end

  def render(assigns) do
    ~H"""
    <Layouts.docs flash={@flash} current_path="/docs/components/file-upload">
      <.docs_header
        title="File Upload"
        description="A styled LiveView upload dropzone built on Phoenix allow_upload/3."
      />

      <.component_demo title="Default" code={default_code()}>
        <form phx-change="validate-upload" phx-submit="save-upload" class="w-full">
          <.file_upload
            upload={@uploads.documents}
            label="Upload documents"
            description="PDF, PNG, or JPG up to 5 MB"
          >
            <:entry
              :for={entry <- @uploads.documents.entries}
              name={entry.client_name}
              progress={entry.progress}
              status={if entry.done?, do: "Ready", else: "Uploading"}
            />
          </.file_upload>
        </form>
      </.component_demo>

      <.section_heading id="static-state">Static State</.section_heading>
      <.component_demo title="Progress Rows" code={progress_code()}>
        <.file_upload label="Upload assets" description="Drag files here or browse">
          <:entry name="brand-guidelines.pdf" progress={72} status="Uploading" />
          <:entry name="avatar.png" progress={100} status="Ready" />
        </.file_upload>
      </.component_demo>
    </Layouts.docs>
    """
  end

  def handle_event("validate-upload", _params, socket), do: {:noreply, socket}
  def handle_event("save-upload", _params, socket), do: {:noreply, socket}

  defp default_code do
    """
    # mount/3
    allow_upload(socket, :documents, accept: ~w(.pdf .png .jpg), max_entries: 3)

    # render/1
    <.file_upload upload={@uploads.documents} label="Upload documents" />\
    """
  end

  defp progress_code do
    """
    <.file_upload label="Upload assets">
      <:entry name="brand-guidelines.pdf" progress={72} status="Uploading" />
    </.file_upload>\
    """
  end
end
